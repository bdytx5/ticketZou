//
//  forumVC.swift
//  tigerHacks
//
//  Created by Brett Young on 10/13/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


       var color = UIColor(red:0.90, green:0.84, blue:0.15, alpha:0.92)

var forumPosts = [forumPost]()

class forumVC: UITableViewController, UITextViewDelegate {
    

   // navigationItem.titleView = UIImageView(image: tiger)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        var tiger = UIImage(named: "tigerWin75.png")
        navigationItem.titleView = UIImageView(image: tiger)
        
        var seats = UIImage(named: "tigerWin 2.png")
        
        tableView.backgroundView = UIImageView(image: seats!)
        tableView.backgroundView?.contentMode = .center
        
        tableView.backgroundColor = color.withAlphaComponent(0.99)

       
        
        tableView.delegate = self

  tableView.dataSource = self
        
        
        
    }
    

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forumCell", for: indexPath) as! forumCell
        
        
        
    
        let post = forumPosts[indexPath.row]
        
           print("name", post.name)
        
        cell.postContent.delegate = self
        cell.name.text = post.name!
        cell.postContent.text = post.posts!
        
        cell.userImg.cacheImage(url: post.img!, uid: "we will win")
        
        cell.userImg.clipsToBounds = true
        cell.userImg.layer.cornerRadius = cell.userImg.frame.width/2
        cell.postContent.font = font!
  
    
    cell.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        cell.postContent.backgroundColor = UIColor.clear
        
        
        
        return cell
        
    }
    

}
