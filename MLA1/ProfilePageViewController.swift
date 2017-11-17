//
//  UserProfilePageViewController.swift
//  MLA1
//
//  Created by user2 on ٢٨ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var FriendTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nip = UINib(nipName : "FriendTableViewCell" , Bundle: nil)
FriendTable.register(nip, forCellReuseIdentifier: "FriendTableViewCell")
        
        FriendTable.delegate = self
        FriendTable.dataSource = self
        self.FriendTable.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchFriends(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{//followers
          
          //view code
            
        }
        
        if sender.selectedSegmentIndex == 1{//following
            
        //view code
    }
}
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


