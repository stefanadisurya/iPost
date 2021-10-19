//
//  PhotoCollectionViewCell.swift
//  iPost
//
//  Created by Stefan Adisurya on 18/10/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    var userId: Int?
    
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
