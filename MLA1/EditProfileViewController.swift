//
//  EditProfileViewController.swift
//  MLA1
//
//  Created by user2 on ٢٩ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import AFNetworking

class EditProfileViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var bioTextView: UITextView!
    var loggedInUser:AnyObject?
    @IBOutlet var interestsArray: [UIButton]!
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var currentUser = Auth.auth().currentUser
    var imagePicker = UIImagePickerController()
    var interestsString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loggedInUser = Auth.auth().currentUser
        self.databaseRef.child("Users").child(self.loggedInUser!.uid).observe(.value, with: { (snapshot) in
            let snapshot = snapshot.value as! [String: AnyObject]
            
            //initially the user will not have a bio data
            if(snapshot["Bio"] !== nil)
            {
                self.bioTextView.text = snapshot["Bio"] as? String
            }
            
            if(snapshot["Interests"] !== nil)
            {
                let interestStr = snapshot["Interests"] as? String
                let interestStrArray = interestStr?.components(separatedBy: " ")
                for title in interestStrArray! {
                    for interest in self.interestsArray {
                        if(title == interest.currentTitle){
                            interest.backgroundColor = UIColor.white
                        }
                    }
                }
            }
            
            if(snapshot["Pic"] !== nil)
            {
                let databaseProfilePic = snapshot["Pic"] as! String
                let url=URL(string:databaseProfilePic)
                self.profilePicture.setImageWith(url!)
            }
        })
    }//end didload
    
    ///////////////change intersts buttons colors////////////////
    @IBAction func interestSelected(_ sender: UIButton) {
        let interestTag = sender.tag
        switch interestTag {
        case 1, 2, 3, 4, 5, 6:
            if(sender.backgroundColor ==  UIColor.white){
                sender.backgroundColor = UIColor.black
            } else {sender.backgroundColor = UIColor.white}
        default:
            print("This is default")
        }
    }
    
    //update database with new data (bio, picture, interests)
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        self.interestsString = ""
        for interest in self.interestsArray {
            if interest.backgroundColor == UIColor.white {
                self.interestsString = self.interestsString + interest.currentTitle! + " " }
        }
        
        //self.databaseRef.child("Users").child(self.loggedInUser!.uid).observe(.value, with: { (snapshot) in
          //  let snapshot = snapshot.value as! [String: AnyObject]
            
            // Update database with new bio and interests
            self.databaseRef.child("Users").child(self.loggedInUser!.uid).child("Bio").setValue(self.bioTextView.text)
            self.databaseRef.child("Users").child(self.loggedInUser!.uid).child("Interests").setValue(self.interestsString)
       // })
        
        // if image in database != profile image then
        if let imageData: Data = UIImagePNGRepresentation(self.profilePicture.image!)!
        {
            let profilePicStorageRef = self.storageRef.child("Users/\(self.loggedInUser!.uid)/Pic")
            let uploadTask = profilePicStorageRef.putData(imageData, metadata: nil)
            {metadata,error in
                if(error == nil)
                {
                    let downloadUrl = metadata!.downloadURL()
                    self.databaseRef.child("Users").child(self.loggedInUser!.uid).child("Pic").setValue(String(describing:downloadUrl!))
                }
                else {print(error!.localizedDescription)}
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ImportImg(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        let imgSource = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        imgSource.addAction(UIAlertAction(title: "Camera", style: .default, handler: { ( ACTION: UIAlertAction) in image.sourceType = .camera
            self.present(image, animated: true , completion: nil)
        }))
        
        
        imgSource.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { ( ACTION: UIAlertAction) in image.sourceType = .photoLibrary
            self.present(image, animated: true , completion: nil)
        }))
        
        
        imgSource.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil ))
        self.present(imgSource , animated: true , completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            profilePicture.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*  let controller = segue.destination as? CurrentPageViewController
         controller?.currentUser = currentUser*/
        if segue.identifier=="cancelSegue"{
            let page=segue.destination as! UITabBarController
            page.selectedIndex = 3
            
        }
        if segue.identifier=="SaveSegue"{
            let page=segue.destination as! UITabBarController
            page.selectedIndex = 3
            
        }
    }
}


