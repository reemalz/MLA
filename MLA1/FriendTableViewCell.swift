//
//  FriendTableViewCell.swift
//  MLA1
//
//  Created by user2 on ٢٨ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var UserNameLable: UILabel!
    
    @IBOutlet weak var UserImg: UIImageView!
    var id=Int()
   /* override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cell(Username:string , Uimg:String) {
        self.UserNameLable.text = UserName
        
       self.UserNameLable.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.black
        
    }*/
}
