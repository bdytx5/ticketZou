//
//  signUp.swift
//  tigerHacks
//
//  Created by Brett Young on 10/13/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

let font = UIFont(name: "Courier-BoldOblique", size: 16)

class signUp: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func unwindLogout(segue: UIStoryboardSegue){ }
    
         var darkcolor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.3)

    var picker: UIImagePickerController!
    
    @IBOutlet weak var pawprint: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      photoBtn.titleLabel?.textColor = UIColor.black
        photoBtn.clipsToBounds = true
        photoBtn.layer.cornerRadius = photoBtn.frame.size.width/2
        picker = UIImagePickerController()
        picker.delegate = self
        self.profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        
        self.password.font = font!
        self.pawprint.font = font!
        self.name.font = font!
        self.phoneNumber.font = font!
        
        pawprint.backgroundColor = color
        password.backgroundColor = color
        name.backgroundColor = color
        phoneNumber.backgroundColor = color
        
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        btn.backgroundColor = UIColor.clear
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func presentImagePicker(_ sender: UIButton) {
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            self.profileImage.image = selectedImage
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var photoBtn: UIButton!

    
    
    @IBAction func signUp(_ sender: UIButton) {
        
        if let email = pawprint.text, let pass = password.text, let name = name.text, let phone = phoneNumber.text{
            
            if profileImage.image != nil {
            print("hey")
            
            Auth.auth().createUser(withEmail: email, password: pass, completion: {(user,error) in
                
                
                if error == nil {
                    
                    
                if let profilePic = self.profileImage.image{
  
                    
                    if let imgPng = UIImagePNGRepresentation(profilePic){
                        // child to userUID
                        
                        Storage.storage().reference().child(user!.uid).putData(imgPng, metadata: nil, completion: {(metadata,error) in
                            
                            if error == nil {
                                
                                let url = metadata?.downloadURL()?.absoluteString
                                
                                
                                var userInfo = [String:String]()
                                
                                userInfo = ["name": name, "phone":phone, "uid": user!.uid, "img": url!]
                                
                                
                                
                                Database.database().reference().child("userInfo").child(user!.uid).setValue(userInfo)
                                
                               
                                
                            }
                            
                        })}
                        
      
                    }
                 self.dismiss(animated: true, completion: nil)
                
                }else{
                    let alert = UIAlertController(title: "whoah", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
}})}}
                    
    
    
    
    
    }
    
    
    
    
    @IBOutlet weak var profileImage: UIImageView!



}
