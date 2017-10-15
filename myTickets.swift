//
//  myTickets.swift
//  tigerHacks
//
//  Created by Brett Young on 10/14/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class myTickets: UIViewController {

    @IBOutlet weak var highestBiddersPhone: UILabel!
    @IBOutlet weak var sellingFormat: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    
  
    @IBOutlet weak var opp: UIImageView!
    
    var teamNames = ["Uconn": 0, "Idaho": 1, "Arkansas": 2, "Florida": 3, "Tennessee": 4, "Vanderbilt": 5]
    
    var opponents: [UIImage] = [UIImage(named: "uconn 2.png")!,UIImage(named: "idaho 2.png")!, UIImage(named: "pigs 2.png")!,UIImage(named: "floridaPic 2.png")!,UIImage(named: "tennessee 2.png")!,UIImage(named: "vandy 2.png")!]
    
    
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var opponentName: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        opponentName.text = game
        
       
        self.opp.image = opponents[teamNames[game]!]
        
        self.price.text = "$\(cost)"
        
        if date == ""{
            sellingFormat.text = "Buy it Now"
            highman.text = ""
            highestBiddersPhone.text = ""
        }else{
            sellingFormat.text = "Auction, ending \(date)"
            
            
            
            if highestBidder.characters.count > 1{
            
                Database.database().reference().child("userInfo").child(highestBidder).observeSingleEvent(of: .value, with: {(snapshot) in
                    
                    if let dict = snapshot.value as? [String:String]
                    {
                        self.highman.text = "highest bidder is \(dict["name"]!)"
                        
                        self.highestBiddersPhone.text = "Bidders Phone # = \(dict["phone"]!)"
                        
                    }
                    
                    
                })
            }
            
        }
        
    
        
        
        sellingFormat.adjustsFontSizeToFitWidth = true
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var highman: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
