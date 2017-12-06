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
    var UserN=String()
    @IBOutlet weak var Followbtn: UIButton!
    @IBOutlet weak var Pic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Bio: UILabel!
    @IBOutlet weak var interests: UILabel!
    var CurrentUserID=String()
    
    override func viewDidLoad() {
        self.userName.text = WantedUser["Username"] as? String
        self.Bio.text = WantedUser["Bio"] as? String
        self.interests.text = WantedUser["Interests"] as? String
        if let m=WantedUser["Pic"] as? String{
            var url=URL(string:m)
            self.Pic.setImageWith(url!)
        }
        menu=0;
        super.viewDidLoad()
        let nip = UINib(nibName: "FriendTableViewCell", bundle: nil)
        FriendTable.register(nip, forCellReuseIdentifier: "cell")
        FriendTable.delegate = self
        FriendTable.dataSource = self
        self.FriendTable.backgroundColor = UIColor.black
        /////// need to add DBhandller for the user data
        dbHandle = ref?.child("Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:String]
            {
                self.UserN=data["Username"]!
                // print(" USERRRR!!!!!$$$$$\(self.UserN)")
            }})
        dbHandle2 = ref?.child("Following/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]{
                var found:Bool=false
                print(data)
                for (_,value) in data{
                    if let user=value as? NSArray{
                        
                        if user[0] as? String==self.WantedUser["Username"]as? String{
                            print("@@£!!!U@@\(user[0])")
                            self.Followbtn.backgroundColor=UIColor.lightGray
                            self.Followbtn.setTitle("Unfollow", for: .normal)
                        }
                        else{print("OOOOoooopss!!!")}
                        break
                    }
                    
                }
                
            }})
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
    
    @IBAction func action(_ sender: UIButton) {
        let UID=self.WantedUser["UID"] as! String
        if(self.Followbtn.titleLabel?.text=="Follow"){
            self.ref.child("Following").child("Users").child(userID!).child(UID).setValue([self.WantedUser["Username"]])
            self.ref.child("Followers").child("Users").child(UID).child(userID!).setValue([self.UserN])
            self.Followbtn.backgroundColor=UIColor.lightGray
            self.Followbtn.setTitle("Unfollow", for: .normal)
        }
        else{
            
            self.ref.child("Following").child("Users").child(userID!).child(UID).removeValue()
            self.ref.child("Followers").child("Users").child(UID).child(userID!).removeValue()
            self.Followbtn.backgroundColor=UIColor(red: 0.149, green: 0.549, blue: 0.6392, alpha: 1.0)
            self.Followbtn.setTitle("Follow", for: .normal)
        }
        
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
    

    
    /////////////Go to friends whatchList///////////////
    @IBAction func WatchListB(_ sender: Any) {
        performSegue(withIdentifier: "WatchF", sender: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let controller = segue.destination as? FriendWatchListViewController
        controller?.WantedUser = WantedUser
        }
    
}


