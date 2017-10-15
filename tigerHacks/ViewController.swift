//
//  ViewController.swift
//  tigerHacks
//
//  Created by Brett Young on 10/13/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var game = String()
var cost = String()
var date = String()
var highestBidder = String()
var theBids = [String]()

var myBidsTickets = [ticketPost]()

class ViewController: UIViewController {
    
    @IBAction func logout(_ sender: UIButton) {
        
        let auth = Auth.auth()
        
        do{
            try auth.signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch let error as NSError{
            print("failed oh well")
            
        }
        
    }
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!

    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var ticketZou: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//stacked.spacing = 20
        
        
        
        
        
        
        var tiger = UIImage(named: "tigerWin75.png")
        navigationItem.titleView = UIImageView(image: tiger)
    logBtn.clipsToBounds = true
        logBtn.layer.cornerRadius = logBtn.frame.size.width/2
        
        btn1.clipsToBounds = true
        btn1.layer.cornerRadius = 15
        
        btn2.clipsToBounds = true
        btn2.layer.cornerRadius = 15
        
        btn3.clipsToBounds = true
        btn3.layer.cornerRadius = 15
        
//        btn1.titleLabel?.font = font!
//         btn2.titleLabel?.font = font!
//         btn3.titleLabel?.font = font!
        label.font = font
        
        btn1.layer.borderColor = UIColor.black.cgColor
        btn1.layer.borderWidth = CGFloat(3)
        btn4.layer.borderColor = UIColor.black.cgColor
        btn4.layer.borderWidth = CGFloat(3)
        btn5.layer.borderColor = UIColor.black.cgColor
        btn5.layer.borderWidth = CGFloat(3)
        btn2.layer.borderColor = UIColor.black.cgColor
        btn2.layer.borderWidth = CGFloat(3)
        btn3.layer.borderColor = UIColor.black.cgColor
        btn3.layer.borderWidth = CGFloat(3)
        
   //     btn3.backgroundColor = UIColor.dar
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func forumBtn(_ sender: Any) {
        
        self.fetchPosts()
    }
    @IBOutlet weak var stacked: UIStackView!
    
    @IBAction func fetchTickets(_ sender: UIButton) {
        
        self.fetchTickets()
    }
    @IBOutlet weak var logBtn: UIButton!
    
    func fetchPosts(){
        
        forumPosts.removeAll()
        Database.database().reference().child("posts").observe(.value, with: {(snapshot) in
            
            
            for child in snapshot.children{
                
                let user = child as! DataSnapshot
                let userDictionary = user.value as! [String:AnyObject]
                let post = forumPost()
                
                post.setValuesForKeys(userDictionary)
                
                forumPosts.append(post)
                
              
                
            }
            
            
            
            self.performSegue(withIdentifier: "goToForumSeg", sender: self)
        })
    
    }
    
    @IBAction func myTickets(_ sender: Any) {
        
        Database.database().reference().child("tickets").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: {(snap) in
        
            if let dict = snap.value as? [String:String]{
            
                game = dict["game"]!
                cost = dict["price"]!
                date = dict["date"]!
                highestBidder = dict["highestBidder"]!
                self.performSegue(withIdentifier: "myTicketsSeg", sender: self)
                
               
            }
                else{
                
                let alert = UIAlertController(title: "whoah", message: "you havent listed any tickets!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)

                
           
            }
            
            
        
        
        })
        
        
        
        
    }
    
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    
    
    
    @IBAction func myBids(_ sender: UIButton) {
        
        theBids.removeAll()
        ticketArray.removeAll() 
        
        
        Database.database().reference().child("myBids").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children{
                if let user = child as? DataSnapshot{
                    
                    let bid = user.value as! String
                    
                            theBids.append(bid)
                    
                    continue
                    
                    
                    
                    
                }
            }
        
        Database.database().reference().child("tickets").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("the bids", theBids)
            
            ticketArray.removeAll()
            
            for child in snapshot.children{
                
                if let info = child as? DataSnapshot{
                    
                    let dict = info.value as! [String:AnyObject]
                    
                    let user = ticketPost()
                    
                    
                    user.setValuesForKeys(dict)
                    
                  
                    if theBids.contains(dict["uid"] as! String){
                        
                        user.setValuesForKeys(dict)
                        
                        if user.date != "" {

                        let date = user.date!
                        
                        var formatter = DateFormatter()
                        
                        
                        formatter.dateFormat = "MM.dd.yyyy hh:mm:ss a"
                        
                        
                        var date2 = formatter.date(from: date)
                        
                        
                        var seconds = Int((date2?.timeIntervalSinceNow)!)
                        
                        
                        if seconds > 0 {
                            
                            ticketArray.append(user)
                            
                            
                        }
                        

                        
                      //  ticketArray.append(user)
                        
                        
                        }else{
                            
                            ticketArray.append(user)
                        }
                        
                    }
                    
                    

                    
                    
                }
                
                
                
                
                
                             self.performSegue(withIdentifier: "myBidsSeg", sender: self)
                

            
                
            }
            
            })
        
        })
        
        
        
    }
    
    
    
    
    func fetchTickets(){
    
        
        
        
        
        
        Database.database().reference().child("tickets").observe( .value, with: {(snapshot) in
            
                ticketArray.removeAll()
            
            print("updated")
            for child in snapshot.children{
                
                let user = child as! DataSnapshot
                let userDictionary = user.value as! [String:AnyObject]
                let post = ticketPost()
                
                
                post.setValuesForKeys(userDictionary)
                
                if post.date != "" {
                
                let date = post.date!
                
               var formatter = DateFormatter()
                
                
                formatter.dateFormat = "MM.dd.yyyy hh:mm:ss a"
                
                
                var date2 = formatter.date(from: date)

                
                var seconds = Int((date2?.timeIntervalSinceNow)!)
                
                
                if seconds > 0 {
                
                ticketArray.append(post)
                
          
                }
                }else{
                       ticketArray.append(post)
                }
                
                
            }
            
            
            
            self.performSegue(withIdentifier: "ticketBaySeg", sender: self)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var overlay: UIView!


}

