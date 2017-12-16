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


class ProfilePageViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var FriendTable: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var WantedUser = NSDictionary()
    var CurrentUser = NSDictionary()
    let ref : DatabaseReference! = Database.database().reference()
    var userID=String()
    let CurrentuserID = Auth.auth().currentUser?.uid
    var dbHandle:DatabaseHandle!
    var dbHandle2:DatabaseHandle!
    var Followers=[NSDictionary]()
    var Following=[NSDictionary]()
    @IBOutlet weak var Followbtn: UIButton!
    @IBOutlet weak var Pic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Bio: UILabel!
    @IBOutlet weak var interests: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendTable.delegate=self
        FriendTable.dataSource=self
        self.userID=WantedUser["UID"] as! String
        self.userName.text = WantedUser["Username"] as? String
        self.Bio.text = WantedUser["Bio"] as? String
        self.interests.text = WantedUser["Interests"] as? String
        if let m=WantedUser["Pic"] as? String{
            let url=URL(string:m)
            self.Pic.setImageWith(url!)
        }
        self.FriendTable.backgroundColor = UIColor.black
        /////// need to add DBhandller for the user data
        dbHandle = ref?.child("Users/\(CurrentuserID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:String]{
            self.CurrentUser=data as! NSDictionary}
            })
        
        dbHandle2 = ref?.child("Following/Users/\(CurrentuserID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]{
                for (_,value) in data{
                    if let user=value as? NSDictionary{
                        if user["Username"] as! String == self.WantedUser["Username"] as!String{
                            self.Followbtn.backgroundColor=UIColor.lightGray
                            self.Followbtn.setTitle("Unfollow", for: .normal)}}}}})
        //////////////following list////////////////
        dbHandle2 = ref?.child("Following/Users/\(userID)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]{
                for (_,value) in data{
                    if let user=value as? NSDictionary{
                        self.Following.append(user)}
                }}})
        /////////////followers
           dbHandle = ref?.child("Followers/Users/\(userID)").observe(.value, with: { (snapshot) in
         if let data = snapshot.value as? [String:Any]
         {
            for (_,value) in data{
                if let user=value as? NSDictionary{
                    self.Followers.append(user)}}
            }})
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.FriendTable.reloadData()
    }
    
    
    
    //////////Segment action/////////////
  
    @IBAction func SwitchSegment(_ sender: UISegmentedControl) {
        DispatchQueue.main.async{self.FriendTable.reloadData()}
    }
    
    @IBAction func action(_ sender: UIButton) {
        let CurrentUID=self.CurrentUser["UID"] as! String
        if(self.Followbtn.titleLabel?.text=="Follow"){
            self.ref.child("Following").child("Users").child(CurrentUID).child(userID).setValue(self.WantedUser)
            self.ref.child("Followers").child("Users").child(userID).child(CurrentUID).setValue(self.CurrentUser)
            self.Followbtn.backgroundColor=UIColor.lightGray
            self.Followbtn.setTitle("Unfollow", for: .normal)
        }
        else{
            
            self.ref.child("Following").child("Users").child(CurrentUID).child(userID).removeValue()
            self.ref.child("Followers").child("Users").child(userID).child(CurrentUID).removeValue()
            self.Followbtn.backgroundColor=UIColor(red: 0.149, green: 0.549, blue: 0.6392, alpha: 1.0)
            self.Followbtn.setTitle("Follow", for: .normal)
        }
        
    }

    /////////////Tabel view method///////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch (segmentControl.selectedSegmentIndex) {
        case 0: return Followers.count
        case 1: return Following.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FriendTableViewCell=FriendTable.dequeueReusableCell(withIdentifier:"cell1", for: indexPath) as! FriendTableViewCell
        switch (segmentControl.selectedSegmentIndex) {
        case 0:
            let user=self.Followers[indexPath.row]
            cell.UserNameLable.text=user["Username"] as! String
            cell.index=indexPath.row
            if let pic=user["Pic"] as? String{
               let url=URL(string:pic)
                cell.UserImg.setImageWith(url!)
            }
            break
        case 1:
            let user=self.Following[indexPath.row]
            cell.UserNameLable.text=user["Username"] as! String
            cell.index=indexPath.row
            if let pic=user["Pic"] as? String{
                let url=URL(string:pic)
                cell.UserImg.setImageWith(url!)
            }
        break
        default: return cell}
        return cell
    }
    

    
    /////////////Go to friends whatchList///////////////
    @IBAction func WatchListB(_ sender: Any) {
        performSegue(withIdentifier: "WatchF", sender: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="profile"{
            let page=segue.destination as! ProfilePageViewController
            let cell=sender as! FriendTableViewCell
            if segmentControl.selectedSegmentIndex==0{
            page.WantedUser=self.Followers[cell.index]}
            else{page.WantedUser=self.Following[cell.index]}
        }
        else{
        let controller = segue.destination as? FriendWatchListViewController
            controller?.WantedUser = WantedUser}
        }
    
}


