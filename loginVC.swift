//
//  loginVC.swift
//  tigerHacks
//
//  Created by Brett Young on 10/13/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class loginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pawprint.font = font!
        password.font = font!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser{
            self.performSegue(withIdentifier: "loginSeg", sender: self)
        }
        

    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: pawprint.text!, password: password.text!, completion: {(user,error) in
            
            if error == nil{
                self.performSegue(withIdentifier: "loginSeg", sender: self)
            }else{
               
                
                let alert = UIAlertController(title: "whoah", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
    
                self.present(alert, animated: true, completion: nil)

            }
            
            
        }
        )
        
        
        
    }
    
    @IBOutlet weak var login: UIButton!

    @IBOutlet weak var pawprint: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
 

}
