//
//  FeedHeaderView.swift
//  InstagramHomefeedSwift
//
//  Created by Vamshi Krishna on 16/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit

class FeedHeaderView: UICollectionReusableView , UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    
    var suggestionModel : [SuggestionModel]?
    override func awakeFromNib() {
        super.awakeFromNib()
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.delegate = self
        suggestionCollectionView.register(SuggestionCell.self, forCellWithReuseIdentifier: "SuggesionCell")

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (suggestionModel?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = suggestionCollectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCell
        cell.suggestionCellData = suggestionModel?[indexPath.item]
        cell.layer.cornerRadius = 6
        cell.layer.masksToBounds = true
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
}
