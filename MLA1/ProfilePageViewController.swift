//
//  UserProfilePageViewController.swift
//  MLA1
//
//  Created by user2 on ٢٨ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class ProfilePageViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    
    @IBOutlet weak var FriendTable: UITableView!
    var menu:Int!
    var WantedUser = NSDictionary()
    let ref : DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var dbHandle:DatabaseHandle!
    var dbHandle2:DatabaseHandle!
    var dbHandle3:DatabaseHandle!
    var Followers=[NSDictionary]()
    var Following=[NSDictionary]()
    var followersKeys=[String]()
    var followingsKeys=[String]()
    @IBOutlet weak var Followbtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Bio: UILabel!
    var CurrentUserID=String()
    
    override func viewDidLoad() {
        self.userName.text = WantedUser["Username"] as? String
        self.Bio.text = WantedUser["Bio"] as? String
        menu=0;
        super.viewDidLoad()
        let nip = UINib(nibName: "FriendTableViewCell", bundle: nil)
        FriendTable.register(nip, forCellReuseIdentifier: "cell")
        FriendTable.delegate = self
        FriendTable.dataSource = self
        self.FriendTable.backgroundColor = UIColor.black
        /////// need to add DBhandller for the user data
        dbHandle = ref?.child("Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]
            {
            }})
        dbHandle2 = ref?.child("Following/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]{
                var found:Bool=false
                var user = NSDictionary()
                for (_,value) in data{
                    user=value as! NSDictionary
                    if (user[self.WantedUser]) != nil{
                        found=true}
                    if(found){
                        self.Followbtn.backgroundColor=UIColor.lightGray
                        self.Followbtn.setTitle("Unfollow", for: .normal)}
                        self.Following.append(user)}}})
     /*   dbHandle = ref?.child("Followers/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]
            {
                var user=NSDictionary()
                for (_,value) in data{
                    user=value as! NSDictionary
                    self.Followers.append(user)
                }
            }})*/
    }
    
    

    
   //////////Segment action/////////////

    @IBAction func SwitchSegment(_ sender: UISegmentedControl) {
        menu=sender.selectedSegmentIndex
        FriendTable.reloadData()
    }
    ////////// notification//////
    
    @IBAction func Notifi(_ sender: UIButton) {
    }
    /////////////Tabel view method///////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menu==0{return Followers.count}
        else{return Following.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FriendTableViewCell=FriendTable.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! FriendTableViewCell
        if menu==0{
        }
        else{}
        return cell
    }
    
    
}


