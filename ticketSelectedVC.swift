//
//  ticketSelectedVC.swift
//  tigerHacks
//
//  Created by Brett Young on 10/14/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ticketSelectedVC: UIViewController {
    
    
    var teamNames = ["Uconn": 0, "Idaho": 1, "Arkansas": 2, "Florida": 3, "Tennessee": 4, "Vanderbilt": 5]
    
    var opponents: [UIImage] = [UIImage(named: "uconn 2.png")!,UIImage(named: "idaho 2.png")!, UIImage(named: "pigs 2.png")!,UIImage(named: "floridaPic 2.png")!,UIImage(named: "tennessee 2.png")!,UIImage(named: "vandy 2.png")!]
    

    var timer = Timer()
    
    func initTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var timeLeft: UILabel!
    var seconds = Int()
    
    func update(){
        
        if self.seconds > 0 {
        
      self.seconds -= 1
            
            
            if seconds>60 && seconds<3600 {
        timeLeft.text = "\(Int((self.seconds)/60)) Mins"
        
            }
            if seconds<=60{
                
                  timeLeft.text = "\(Int(self.seconds))) Secs"
            }
            
            if seconds>=3600{
                  timeLeft.text = "\(Int(((self.seconds)/3600))) Hours"
            }
        }
        else{
            btn6.isEnabled = false
        }
      
    }
    
    
    @IBOutlet weak var opponentImg: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    
    
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var stripe: UIView!
    
    @IBOutlet weak var btn6: UIButton!
    var formatter: DateFormatter!
    
    @IBOutlet weak var highestBidder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        if selectedTicket.date != ""{
           
            formatter = DateFormatter()
            
            
            formatter.dateFormat = "MM.dd.yyyy hh:mm:ss a"
            
            var date = formatter.date(from: selectedTicket.date!)
            
            self.seconds = Int((date?.timeIntervalSinceNow)!)
            
            
            self.initTimer()
            
            
    Database.database().reference().child("tickets").child(selectedTicket.uid!).observe(.value, with: { (snapshot) in
            
        
        if let dict = snapshot.value as? [String:String]{
            
            self.price.text = dict["price"]
            
            
            
            if selectedTicket.highestBidder != "" {
            Database.database().reference().child("userInfo").child(selectedTicket.highestBidder!).observeSingleEvent(of: .value, with: {(snapshot) in
            
                if let dict = snapshot.value as? [String:String]
                {
            self.highestBidder.text = "Highest Bidder is \(dict["name"]!)"
                    
                }
                
            
            })
            }
            
            
            
            
        }
            
            
            
            
            })
            
            
        } else{
            self.bid = nil
            self.timeLeft.text = "Buy it Now"
           //self.btn6.titleLabel = ""
            self.btn6.isEnabled = false
         
            
            
        }
        
        userImg.cacheImage(url: selectedTicket.img!, uid: "hi")
        userImg.clipsToBounds = true
        userImg.layer.cornerRadius = userImg.frame.size.width/2
        
        opponentImg.image = opponents[teamNames[selectedTicket.game!]!]
        price.clipsToBounds = true
        price.layer.cornerRadius = 10
        
        price.text = "\(selectedTicket.price!)"
        name.text = selectedTicket.name!
        phone.text = selectedTicket.phone!
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var bid: UITextField!
    
    @IBAction func placeBid(_ sender: UIButton) {
        
        
        if bid.text == "" {
        
        return
        }
        
        if Int(self.price.text!)! < Int(bid.text!)!{
            
            
            selectedTicket.price = bid.text
            
            Database.database().reference().child("tickets").child(selectedTicket.uid!).updateChildValues(["price":bid.text!, "highestBidder":Auth.auth().currentUser!.uid])
            
            self.highestBidder.text = "You are the Highest Bidder"
            
            Database.database().reference().child("myBids").child(Auth.auth().currentUser!.uid).child(selectedTicket.uid!).setValue(selectedTicket.uid!)
            
            

            
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
           
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reload"), object: nil)
            
            
                
                
                
        }
    }
    
        
        
        
        



 
}
