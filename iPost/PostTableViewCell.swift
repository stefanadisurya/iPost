//
//  PostTableViewCell.swift
//  iPost
//
//  Created by Stefan Adisurya on 16/10/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTile: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var userNameAndCompany: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
