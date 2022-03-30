//
//  ViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berat Yavuz on 26.03.2022.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapTiklandi(_ sender: Any) {
        if (emailTextField.text != "" && sifreTextField.text != "") {
            //user sign in
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil{
                    
                    self.hataMesaji(tittleInput: "Hata", messageInput: error?.localizedDescription ?? "Mail ve şifreniz eşleşmiyor")
                    
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
        
        else{
            self.hataMesaji(tittleInput: "Hata", messageInput: "Mail ve şifreniz uyuşmuyor")
            
        }
        
        
    }
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        if (emailTextField.text != "" && sifreTextField.text != "") {
            //user sign up
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error !=  nil{
                    self.hataMesaji(tittleInput: "Hata", messageInput: error?.localizedDescription ?? "Mail ve şifrenizi hatasız giriniz ")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            
        }
        else{
            hataMesaji(tittleInput: "Hata", messageInput: "Mail Ve Şifre Giriniz")
        }
    }
    
    
    
    func hataMesaji(tittleInput:String,messageInput:String){
        
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}

