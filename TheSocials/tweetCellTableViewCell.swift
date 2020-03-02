//
//  tweetCellTableViewCell.swift
//  TheSocials
//
//  Created by Sylvia Sesay on 2/29/20.
//  Copyright © 2020 Sylvia Sesay. All rights reserved.
//
import UIKit
import TwitterKit

class tweetCellTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
