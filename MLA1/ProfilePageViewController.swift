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
import UserNotifications



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
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Bio: UILabel!
    var CurrentUserID=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu=0;
        //fill page
        self.userName.text = WantedUser["Username"] as? String
        self.Bio.text = WantedUser["Bio"] as? String
        
        let nip = UINib(nibName: "FriendTableViewCell", bundle: nil)
        FriendTable.register(nip, forCellReuseIdentifier: "cell")
        FriendTable.delegate = self
        FriendTable.dataSource = self
        self.FriendTable.backgroundColor = UIColor.black
        /////// need to add DBhandller for the user data
        dbHandle = ref?.child("Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:String]
                //self user name
            {self.UserN=data["Username"]!}})
        
        dbHandle2 = ref?.child("Following/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]{
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
        /////////////Followers notfications/////////////
        dbHandle3 = ref?.child("Followers/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]{
                for (_,value) in data{
                    print("@£@££$£@\(value)")}
                let content=UNMutableNotificationContent()
                content.title="you have new follower"
                content.badge=1
                let trigger=UNTimeIntervalNotificationTrigger.init(timeInterval:5, repeats: false)
                let request=UNNotificationRequest.init(identifier:"wte", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler:nil)
            }})
        
    }
    
    
    
    
    //////////Segment action/////////////
    
    @IBAction func SwitchSegment(_ sender: UISegmentedControl) {
        print("hellllo !!!!!!!!!!!!!!!!!!!!!")
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
            print(Following,"$$$$$$$$$$$$$$$$$$$$$")
                    print(Followers,"%%%%%%%%%%%%%%%%%%%%")
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


