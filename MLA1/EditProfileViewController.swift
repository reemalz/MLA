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
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var currentUser = Auth.auth().currentUser
    var imagePicker = UIImagePickerController()
    
    /* @IBOutlet weak var ActionBox: BEMCheckBox!
     @IBOutlet weak var DramaBox: BEMCheckBox!
     @IBOutlet weak var HorrorBox: BEMCheckBox!
     @IBOutlet weak var MysteryBox: BEMCheckBox!
     @IBOutlet weak var DocumentaryBox: BEMCheckBox!
     @IBOutlet weak var AdventureBox: BEMCheckBox!*/
    
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
        /*  ActionBox.delegate = self
         DramaBox.delegate = self
         HorrorBox.delegate = self
         MysteryBox.delegate = self
         DocumentaryBox.delegate = self
         AdventureBox.delegate = self*/
        
        //profilePicture.layer.cornerRadius = 80;
        //profilePicture.layer.masksToBounds=true
        // Do any additional setup after loading the view.
        
        
    }//end didload
    
    /*
     internal func setProfilePicture(_ imageView:UIImageView,imageToSet:UIImage)
     {
     imageView.layer.cornerRadius = 80.0 //was 10
     imageView.layer.borderColor = UIColor.white.cgColor
     imageView.layer.masksToBounds = true
     imageView.image = imageToSet
     }*/
    
    /*
     @IBAction func cancelButtonClicked(_ sender: Any) {
     performSegue(withIdentifier: "ReturnToCurrent", sender: "")
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let controller = segue.destination as? CurrentPageViewController
     controller?.currentUser = currentUser
     }*/
    
    //update database with new data (bio, picture, interests)
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        self.databaseRef.child("Users").child(self.loggedInUser!.uid).observe(.value, with: { (snapshot) in
            let snapshot = snapshot.value as! [String: AnyObject]
            
            //if(snapshot["Bio"]?.isEqual(self.bioTextView.text) == false)
            //{
            //if bio in database != bio in textview then
            // Update database with new bio
            self.databaseRef.child("Users").child(self.loggedInUser!.uid).child("Bio").setValue(self.bioTextView.text)
            //}
        })
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
                    
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrentUserProfile")
                     self.present(vc!, animated: true, completion: nil)
                }
                else
                {
                    print(error!.localizedDescription)
                }
            }
        }
        
        
    }
    
    
    
    
    
    
    /*func didTap(_ checkBox: BEMCheckBox) {
     print(checkBox.tag)
     }*/
    
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


