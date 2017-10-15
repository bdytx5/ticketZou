//
//  sellTicketsVC.swift
//  tigerHacks
//
//  Created by Brett Young on 10/14/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class sellTicketsVC: UIViewController, UIPickerViewDelegate {

    
    @IBOutlet weak var segment: UISegmentedControl!

    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        var darkcolor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.3)

        
        price.backgroundColor = darkcolor
  

        
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        
        //price.backgroundColor = UIColor.yellow.withAlphaComponent(0.85)
        opponentPicker.delegate = self
        opponentPicker.showsSelectionIndicator = false
        postBtn.titleLabel?.textColor = UIColor.black
        postBtn.clipsToBounds = true
        postBtn.layer.cornerRadius = 10
        
        price.font = font!
        
        

        // Do any additional setup after loading the view.
    }
    var opponents: [UIImage] = [UIImage(named: "uconn 2.png")!,UIImage(named: "idaho 2.png")!, UIImage(named: "pigs 2.png")!,UIImage(named: "floridaPic 2.png")!,UIImage(named: "tennessee 2.png")!,UIImage(named: "vandy 2.png")!]
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var postBtn: UIButton!
  
    @IBOutlet weak var opponentPicker: UIPickerView!
    
    var opponent: String = "Uconn"
    
    var teamNames = ["Uconn", "Idaho", "Arkansas", "Florida", "Tennessee", "Vanderbilt"]
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 65
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return opponents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIImageView(image: opponents[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        opponent = teamNames[row]
    }
    
    @IBOutlet weak var price: UITextField!
    
    @IBAction func submitPost(_ sender: UIButton) {
        
        if price.text != ""{
   
        Database.database().reference().child("userInfo").child(Auth.auth().currentUser!.uid).observe(.value, with: {(snaoshot) in
            
            var userInfo = snaoshot.value as! [String:String]
            
            userInfo["game"] = self.opponent
            userInfo["price"] = self.price.text!
            

      var result = ""
                 userInfo["highestBidder"] = ""
        
          userInfo["date"] = result

            if self.segment.selectedSegmentIndex == 1{

          
                var date = Date()
                
                date.addTimeInterval(172800/2)
                
                let formatter = DateFormatter()
                
                
                formatter.dateFormat = "MM.dd.yyyy hh:mm:ss a"
                
                
                 result = formatter.string(from: date)
                      userInfo["date"] = result
                print(result)
            }
        
       
        
            
            Database.database().reference().child("tickets").child(Auth.auth().currentUser!.uid).setValue(userInfo)
            
     
            
            let alert = UIAlertController(title: "whoah", message: "You tickets have been listed.", preferredStyle: UIAlertControllerStyle.alert)
            
            
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: { (alert: UIAlertAction!) in self.donePosting()}
            
            
            
            ))
            
            self.present(alert, animated: true, completion: nil)

        })
        
        
        }else{
            

            
            
            
            let alert = UIAlertController(title: "whoah", message: "You need to add a Price.", preferredStyle: UIAlertControllerStyle.alert)
           
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
                

        
 
    }
    
        
    
    
    
    
    func donePosting(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
 
    
    
    

}
