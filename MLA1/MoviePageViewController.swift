//
//  MoviePageViewController.swift
//  MLA1
//
//  Created by user2 on ٩ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit

class MoviePageViewController: UIViewController {
    
   
    @IBOutlet var RatingStars: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RateMovie(_ sender: UIButton) {
        var rate = NSInteger()
         rate = sender.tag
        
        for star in RatingStars {
            if star.tag<=rate{
                star .setTitle("★", for: UIControlState.normal )}
            else{
                star .setTitle("☆", for: UIControlState.normal )}
        }
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


