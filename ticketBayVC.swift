//
//  ticketBayVC.swift
//  tigerHacks
//
//  Created by Brett Young on 10/14/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


var ticketArray = [ticketPost]()
var selectedTicket = ticketPost()



class ticketBayVC: UITableViewController {
    
    
    
    func reloadData(notification: NSNotification){
        self.tableView.reloadData()
        
        print("reloaded")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
   
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        

   
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.reloadData()
        
        var seats = UIImage(named: "tigerWin 2.png")
    
        tableView.backgroundView = UIImageView(image: seats!)
        tableView.backgroundView?.contentMode = .center
        
        tableView.backgroundColor = color.withAlphaComponent(0.99)
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    


    var teamNames = ["Uconn": 0, "Idaho": 1, "Arkansas": 2, "Florida": 3, "Tennessee": 4, "Vanderbilt": 5]
  
    var opponents: [UIImage] = [UIImage(named: "uconn 2.png")!,UIImage(named: "idaho 2.png")!, UIImage(named: "pigs 2.png")!,UIImage(named: "floridaPic 2.png")!,UIImage(named: "tennessee 2.png")!,UIImage(named: "vandy 2.png")!]
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTicket = ticketArray[indexPath.row]
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name.init(rawValue: "reload"), object: nil)
        
        
        self.performSegue(withIdentifier: "ticketSelectedSeg", sender: self)
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! ticketCell
        
        
        
        
        let post = ticketArray[indexPath.row]
        
        print("name", post.name)
        
        
        
        cell.name.text = post.name!
        cell.opponent.text = post.game!
        cell.price.text = "$\(post.price!)"
        cell.opponent.adjustsFontSizeToFitWidth = true
    
        
        cell.opponentImg.image = opponents[teamNames[post.game!]!]
        
        cell.userImg.cacheImage(url: post.img!, uid: "hey")
        cell.userImg.layer.cornerRadius = cell.userImg.frame.size.width/2
        cell.userImg.clipsToBounds = true
        cell.opponent.adjustsFontSizeToFitWidth = true
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        return cell
        
    }
    
    

    
    
    


}

