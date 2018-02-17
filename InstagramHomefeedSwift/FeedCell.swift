//
//  FeedCell.swift
//  InstagramHomefeedSwift
//
//  Created by Vamshi Krishna on 16/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var usernameBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var picImg: UIImageView!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var uuidLbl: UILabel!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var titleLbl: KILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.setTitleColor(UIColor.clear, for: UIControlState())
        
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likeTap.numberOfTapsRequired = 2
        picImg.isUserInteractionEnabled = true
        picImg.addGestureRecognizer(likeTap)
        picImg.layer.masksToBounds = true
        
        avaImg.layer.cornerRadius = avaImg.frame.size.height/2
        avaImg.layer.masksToBounds = true
    }
    
    @objc func likeTapped(){
        
        let likePic = UIImageView(image: UIImage(named: "unlike.png"))
        likePic.frame.size.width = picImg.frame.size.width / 1.5
        likePic.frame.size.height = picImg.frame.size.width / 1.5
        likePic.center = picImg.center
        likePic.alpha = 0.8
        self.addSubview(likePic)
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            likePic.alpha = 0
            likePic.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        })
        
    }
}
