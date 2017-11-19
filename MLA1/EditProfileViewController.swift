//
//  EditProfileViewController.swift
//  MLA1
//
//  Created by user2 on ٢٩ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate , BEMCheckBoxDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var ActionBox: BEMCheckBox!
    @IBOutlet weak var DramaBox: BEMCheckBox!
    @IBOutlet weak var HorrorBox: BEMCheckBox!
    @IBOutlet weak var MysteryBox: BEMCheckBox!
    @IBOutlet weak var DocumentaryBox: BEMCheckBox!
    @IBOutlet weak var AdventureBox: BEMCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
ActionBox.delegate = self
        DramaBox.delegate = self
        HorrorBox.delegate = self
        MysteryBox.delegate = self
        DocumentaryBox.delegate = self
        AdventureBox.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    func didTap(_ checkBox: BEMCheckBox) {
    
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
        
        
       imgSource.addAction(UIAlertAction(title: "Cacel", style: .default, handler:nil ))
        self.present(imgSource , animated: true , completion: nil)
    }
    
   

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            profileImg.image = image
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
