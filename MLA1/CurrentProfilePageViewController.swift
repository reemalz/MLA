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

class CurrentPageViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    
    @IBOutlet weak var FriendTable: UITableView!
    var currentUser = Auth.auth().currentUser
    var menu:Int!
    let ref : DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var profileID=String()
    var dbHandle:DatabaseHandle!
    var dbHandle2:DatabaseHandle!
    var Followers=[String:Any]()
    var Following=[String:Any]()
    var followersKeys=[String]()
    var followingsKeys=[String]()
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        menu=1;
        super.viewDidLoad()
        self.ref.child("Users").child(self.userID!).observe(.value, with: { (snapshot) in
            let snapshot = snapshot.value as! [String: AnyObject]
            self.username.text=snapshot["Username"] as! String
            //initially the user will not have a bio data
            if(snapshot["Bio"] !== nil)
            {
                self.bio.text = snapshot["Bio"] as? String
            }
            if(snapshot["Pic"] !== nil)
            {
                // print()
                let databaseProfilePic = snapshot["Pic"] as! String
                let url=URL(string:databaseProfilePic)
                self.profilePicture.setImageWith(url!)
                //let data = try? Data(contentsOf: URL(string: databaseProfilePic)!)
                //self.setProfilePicture(self.profilePicture,imageToSet:UIImage(data:data!)!)
            }
        })
        let nip = UINib(nibName: "FriendTableViewCell", bundle: nil)
        FriendTable.register(nip, forCellReuseIdentifier: "cell")
        FriendTable.delegate = self
        FriendTable.dataSource = self
        self.FriendTable.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
        dbHandle = ref?.child("Followers/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]
            {self.Followers=data
                // var i:Int=0;
            }})
        dbHandle2 = ref?.child("Following/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]
            {self.Following=data
                // var i:Int=0;
            }})
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      //   Dispose of any resources that can be recreated.
    }
    
    /////////////////SegmentPage/////////////
    @IBAction func SwitchSegment(_ sender: UISegmentedControl) {
        menu=sender.selectedSegmentIndex
        print(menu,"ssddww!!")
        FriendTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 //   if menu==0{return Followers.count}
   //    else{return Following.count}
   return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FriendTableViewCell=FriendTable.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! FriendTableViewCell
      if menu==0{
        cell.id=""
        }
      else{}
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    let cell = tableView.cellForRow(at: indexPath) as! FriendTableViewCell
      //  self.profileID=cell.id
        //performSegue(withIdentifier:"profile", sender: (Any).self)
    }
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let profile=segue.destination as! ProfilePageViewController
     profile.CurrentUserID=self.profileID
     }*/
    
    
    internal func setProfilePicture(imageView: UIImageView, imageToSet: UIImage){}
}


