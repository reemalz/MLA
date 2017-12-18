//
//  ReviewTableViewCell.swift
//  MLA1
//
//  Created by Reem Al-Zahrani on 16/12/2017.
//  Copyright © 2017 njoool . All rights reserved.
//

import UIKit

public class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var review: UITextView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(review:String, username:String){
        self.review.text = "\"" + review + "\""
        self.username.setTitle(("- "+username), for: .normal)
    }

}
