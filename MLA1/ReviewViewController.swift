//
//  ReviewViewController.swift
//  MLA1
//
//  Created by Reem Al-Zahrani on 15/12/2017.
//  Copyright © 2017 njoool . All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ReviewViewController: UIViewController, UITextViewDelegate ,UITextFieldDelegate{
    
    var id=Int() //movie id??
    var databaseRef = Database.database().reference()
    var currentUser: AnyObject?
    var username: String?
    @IBOutlet weak var reviewTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUser = Auth.auth().currentUser
        
        //fake placeholder for the textview
        reviewTextView.textContainerInset = UIEdgeInsetsMake(30, 20, 20, 20)
        reviewTextView.text = "What do you think about the movie?"
        reviewTextView.textColor = UIColor.lightGray
        
        //get current username
        self.databaseRef.child("Users").child(self.currentUser!.uid).observe(.value, with: { (snapshot) in
            let snapshot = snapshot.value as! [String: AnyObject]
            if(snapshot["Username"] !== nil)
            {
                self.username = snapshot["Username"] as? String
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapCancel(_ sender: AnyObject) {
        dismiss(animated: true
            , completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if(reviewTextView.textColor == UIColor.lightGray)
        {
            reviewTextView.text = ""
            reviewTextView.textColor = UIColor.white
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textfield:UITextField)->Bool{
        textfield.resignFirstResponder()
        return true}
    
    @IBAction func addReview(_ sender: Any) {
        if(reviewTextView.text.count>0 && reviewTextView.textColor != UIColor.lightGray){
            let key = self.databaseRef.child("Reviews").childByAutoId().key
            //path is Reviews/Movies/\(id)/
            let childUpdates = ["/Reviews/Movies/\(id)/\(key)/text":reviewTextView.text,
                                "/Reviews/Movies/\(id)/\(key)/username":self.username!,
                                "/Reviews/Movies/\(id)/\(key)/timestamp":"\(Date().timeIntervalSince1970)"] as [String : Any]
            
            self.databaseRef.updateChildValues(childUpdates)
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! MoviePageViewController
        controller.id = self.id
    }
    //reviews.append(reviewTextView.text)
    //self.databaseRef.child("Reviews/Movies/\(self.id)").child(self.currentUser!.uid).setValue(reviewTextView.text)
    //reviewTextView.text = ""
}
