//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berat Yavuz on 27.03.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var yorumTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
               view.addGestureRecognizer(gestureRecognaizer)
        
        imageView.isUserInteractionEnabled = true
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(imageGestureRecognizer)
//        uploadButton.isEnabled = false
   
    }
    @objc func klavyeyiKapat(){
           view.endEditing(true)
       }
    
    @objc func gorselSec(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info [.editedImage] as? UIImage
//        uploadButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func uploadButtonTiklandi(_ sender: Any) {
        let storage = Storage.storage()
        
        let storageReferance = storage.reference()
        
        // referasn ile child dosyalar oluşturabiliriz
        //ref ile bir media klasoru oluşturalım
        
        let mediaFolder = storageReferance.child("media")
        
        //imagei sıkıştırıp data yaptık
        if let data =  imageView.image?.jpegData(compressionQuality: 0.5){
            //kayıt edilen her fotonun ayrı ismi olması için uuid kullanıcaz
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            
            imageReferance.putData(data, metadata: nil) { storagemetadat, error in
                if error != nil{
                    self.hataMesajiGonder(title: "Hata", message: error?.localizedDescription ?? "Hata")
                }
                else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                        
                            
                            if let imageUrl = imageUrl{
                                
                                //alınan veriyi yorunu tarihi falan firestoreye kaydedicez
                                
                                let firestoreDatabase = Firestore.firestore()
                           
                                let firestorePost = ["imageurl":imageUrl,"yorum":self.yorumTextField.text!,"mail":Auth.auth().currentUser?.email,"tarih":FieldValue.serverTimestamp()] as [String:Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { (error) in
                                    if error != nil {
                                        self.hataMesajiGonder(title: "hata", message: error?.localizedDescription ?? "Hatalı")
                                        
                                    }
                                    else{
                                        self.imageView.image = UIImage(named: "photo")
                                        self.yorumTextField.text = ""
                                        // feed sayfasına dönmek için
                                        self.tabBarController?.selectedIndex = 0
                                        
                                        
                                    }
                                }
                              
                            
                            
                            
                            }
                            
                            
                            
                            
                           
                            
                          
                            
                            
                            
                            
                            
                            
                        }
                    }
                }
                
            }
            
            
        }
    
      
        
    
    
    }
    func hataMesajiGonder(title:String,message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }

}
