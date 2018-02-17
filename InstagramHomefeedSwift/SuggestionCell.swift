//
//  SuggestionCell.swift
//  InstagramHomefeedSwift
//
//  Created by Vamshi Krishna on 16/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit

class SuggestionCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    var suggestionCellData:SuggestionModel?{
        didSet{
            if let data = suggestionCellData{
                nameLabel.text = data.userName
                avatarImageView.image = UIImage(named: (data.userImageName)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
        avatarImageView.layer.masksToBounds = true
        followButton.layer.cornerRadius = 6
        followButton.layer.masksToBounds = true
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.black.cgColor
        
        closeButton.layer.cornerRadius = closeButton.frame.size.height/2
        closeButton.layer.masksToBounds = true
    }
}
