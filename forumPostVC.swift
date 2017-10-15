//
//  forumPostVC.swift
//  tigerHacks
//
//  Created by Brett Young on 10/13/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class forumPostVC: UIViewController, UITextViewDelegate{
 
    var ref: DatabaseReference!
    
    @IBOutlet weak var postText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        postText.backgroundColor = UIColor.white.withAlphaComponent(0.5)
postText.clipsToBounds = true
        postText.layer.cornerRadius = 10
        postText.font = font!
        
        ref = Database.database().reference()
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var background: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var post: UITextView!
    
    
    
    
    @IBAction func cancel(_ sender: UIButton) {
        
        
        self.dismiss(animated: true, completion: nil)
  
        
    }
    
    
    
    

    
    @IBAction func post(_ sender: Any) {
        
        if post.text != nil {
            
            
            Database.database().reference().child("userInfo").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: {(snapshot) in
                
               var userDict = snapshot.value as? [String:String]
                    
                    print(userDict)
                    
                    userDict?["posts"] = self.post.text
                    
                    self.ref.child("posts").child(Auth.auth().currentUser!.uid).setValue(userDict)
            
                    
            self.dismiss(animated: true, completion: nil)
                
                
            })
        
            
            
            
        }
        
        
    }
    
    
    


}
