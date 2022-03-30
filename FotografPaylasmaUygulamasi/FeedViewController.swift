//
//  FeedViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berat Yavuz on 27.03.2022.
//

import UIKit
import Firebase
import SDWebImage
class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var postDizisi = [Post]()
//var yorumDizisi = [String]()
//var mailDizisi = [String]()
//    var gorselDizisi = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
     firebaseVerileriAL()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.mailTextField.text = postDizisi[indexPath.row].mail
        cell.yorumTextField.text = postDizisi[indexPath.row].yorum
        cell.postImageView.sd_setImage(with: URL(string: self.postDizisi[indexPath.row].gorselUrl))
//        cell.mailTextField.text = mailDizisi[indexPath.row]
//        cell.postImageView.sd_setImage(with: URL(string: self.gorselDizisi[indexPath.row]))
//        cell.yorumTextField.text = yorumDizisi[indexPath.row]
        
        return cell
    }
    
    func firebaseVerileriAL(){
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "tarih", descending: true).addSnapshotListener { (snapshot, error) in
            if (error != nil){
                self.hataMesajiOlustur(title: "hata", message: error?.localizedDescription ?? "Hata var")
     
            }
            else{ if snapshot?.isEmpty != true && snapshot != nil {
             self.postDizisi.removeAll(keepingCapacity: false)
                for document in snapshot!.documents{
                  
                  
                    if let gorselUrl = document.get("imageurl") as? String{
                    
                        if let mail = document.get("mail") as? String{
                            
                            if let yorum = document.get("yorum") as? String{
                              
                                
                                let post = Post(mail: mail, yorum: yorum, gorseUrl: gorselUrl)
                                self.postDizisi.append(post)
                              
        }
     }
      }
                    
                    
                    
                }
                self.tableView.reloadData()
            }
            
        
        }

    }
    }
    
    func hataMesajiOlustur(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
    }

}
