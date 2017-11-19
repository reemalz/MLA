//
//  RegisterViewController.swift
//  MLA1
//
//  Created by Reem Al-Zahrani on 18/10/2017.
//  Copyright © 2017 njoool . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textfield:UITextField)->Bool{
        textfield.resignFirstResponder()
        return true}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func createAccountAction(_ sender: Any) {
        
        // variable to reference our database from firebase
        let ref : DatabaseReference!
        ref = Database.database().reference()
        
        if emailTextField.text == "" || usernameTextField.text! == "" {
            //error message: fields empty
            let alertController = UIAlertController(title: "Error", message: "Please enter your username, email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        } else {
            ref.child("Users").queryOrdered(byChild: "Username").queryEqual(toValue: usernameTextField.text!).observeSingleEvent(of: .value , with: { snapshot in
                if !snapshot.exists() {
                    // Update database with a unique username.
                    
                    Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                        if error == nil {
                            print("You have successfully signed up")
                            // add user to the users tree
                            //and set value of email property to the value taken from textfield
                            //later on we will add more properties... e.g. username.. profile pic.. bio..
                            ref.child("Users").child(user!.uid).setValue(["Username": self.usernameTextField.text!,"Email": self.emailTextField.text!,"UID": user!.uid]
                            )
                            // redirect to login page
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                            self.present(vc!, animated: true, completion: nil)
                        } else {
                            //error message: signup failed
                            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    
                }
                else {
                    //error message: username already exists
                    let alertController = UIAlertController(title: "Uh oh!", message: "\(self.usernameTextField.text!) is not available. Try another username.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }) {error in print(error.localizedDescription)}
            
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
}
