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

class CurrentPageViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var FriendTable: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    let ref : DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var profileID=String()
    var dbHandle:DatabaseHandle!
    var dbHandle2:DatabaseHandle!
    var Followers=[NSDictionary]()
    var Following=[NSDictionary]()
   // var followersKeys=[String]()
   // var followingsKeys=[String]()
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var interests: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendTable.delegate = self
        FriendTable.dataSource = self
        self.FriendTable.backgroundColor = UIColor.black
        self.ref.child("Users").child(self.userID!).observe(.value, with: { (snapshot) in
            let snapshot = snapshot.value as! [String: AnyObject]
            self.username.text=snapshot["Username"] as! String
            //initially the user will not have a bio data
            if(snapshot["Bio"] !== nil)
            {self.bio.text = snapshot["Bio"] as? String}
            if(snapshot["Interests"] !== nil)
            {self.interests.text = snapshot["Interests"] as? String}
            if(snapshot["Pic"] !== nil)
            {
                let databaseProfilePic = snapshot["Pic"] as! String
                let url=URL(string:databaseProfilePic)
                self.profilePicture.setImageWith(url!)}})
         ///////////follwoers list/////////
        dbHandle = ref?.child("Followers/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]
            { var user=NSDictionary()
                for (_,value) in data{
                user=value as! NSDictionary
                self.Followers.append(user)}}})
        /////////follwoing list//////////////////
        dbHandle2 = ref?.child("Following/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]
            {
                for (_,value) in data{
                    if let user=value as? NSDictionary{
                        self.Following.append(user)}}
            }})
        
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.FriendTable.reloadData()}
    }

    /////////////////SegmentPage/////////////
    @IBAction func SwitchSegment(_ sender: UISegmentedControl) {
       DispatchQueue.main.async{
        self.FriendTable.reloadData()}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(segmentControl.selectedSegmentIndex){
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
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier=="profile"){
            let cell=sender as! FriendTableViewCell
     let profile=segue.destination as! ProfilePageViewController
            switch(segmentControl.selectedSegmentIndex){
            case 0:
                let user=self.Followers[cell.index]
                profile.WantedUser=user
                break
            case 1:
                //let cell=sender as! FriendTableViewCell
                let user=self.Following[cell.index]
                profile.WantedUser=user
                break
            default:print("!!!")}
            }
     }
}


