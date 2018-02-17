//
//  FeedController.swift
//  InstagramHomefeedSwift
//
//  Created by Vamshi Krishna on 16/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit
import Parse

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var refresher = UIRefreshControl()
    var usernameArray = [String]()
    var avaArray = [PFFile]()
    var dateArray = [Date?]()
    var picArray = [PFFile]()
    var titleArray = [String]()
    var uuidArray = [String]()
    
    var followArray = [String]()
    
    var page : Int = 12
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "FEED"
        refresher.addTarget(self, action: #selector(refreshCollectionViewFeed), for: UIControlEvents.valueChanged)
        collectionView?.addSubview(refresher)
        
        loadPosts(posts: page)
    }
    
    @objc func postUploaded(notification:NSNotification){
        loadPosts(posts: page)
    }
    
    @objc func postLiked(notification:NSNotification){
        collectionView?.reloadData()
    }
    
    @objc func refreshCollectionViewFeed(){
        loadPosts(posts: page)
        refresher.endRefreshing()
    }
    
    
    func loadPosts(posts:Int) {
        
        let followQuery = PFQuery(className: "follow")
        followQuery.whereKey("follower", equalTo: "dhoni7")
        followQuery.findObjectsInBackground (block: { (objects, error) -> Void in
            if error == nil {
                self.followArray.removeAll(keepingCapacity: false)
                for object in objects! {
                    self.followArray.append(object.object(forKey: "following") as! String)
                }
                self.followArray.append("dhoni7")
                
                let query = PFQuery(className: "posts")
                query.whereKey("username", containedIn: self.followArray)
                query.limit = self.page
                query.addDescendingOrder("createdAt")
                query.findObjectsInBackground(block: { (objects, error) -> Void in
                    if error == nil {
                        
                        self.usernameArray.removeAll(keepingCapacity: false)
                        self.avaArray.removeAll(keepingCapacity: false)
                        self.dateArray.removeAll(keepingCapacity: false)
                        self.picArray.removeAll(keepingCapacity: false)
                        self.titleArray.removeAll(keepingCapacity: false)
                        self.uuidArray.removeAll(keepingCapacity: false)
                        
                        for object in objects! {
                            self.usernameArray.append(object.object(forKey: "username") as! String)
                            self.avaArray.append(object.object(forKey: "avatar") as! PFFile)
                            self.dateArray.append(object.createdAt)
                            self.picArray.append(object.object(forKey: "pic") as! PFFile)
                            self.titleArray.append(object.object(forKey: "title") as! String)
                            self.uuidArray.append(object.object(forKey: "uuid") as! String)
                        }
                        
                        self.collectionView?.reloadData()
                        
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - self.view.frame.size.height{
            loadMore()
        }
    }
    
    func loadMore() {
        if page <= picArray.count {
            page = page + 12
            loadPosts(posts: page)
        }
        
    }
    
    //MARK: -Suggestions
    func prepareDataForSuggestion() -> [SuggestionModel]{
        var model = [SuggestionModel]()
        model.append(SuggestionModel(userName: "Dhoni", userImageName: "Dhoni.jpeg"))
        model.append(SuggestionModel(userName: "Dravid", userImageName: "Dravid.jpeg"))
        model.append(SuggestionModel(userName: "Yuvraj", userImageName: "Yuvraj.jpeg"))
        model.append(SuggestionModel(userName: "Sachin", userImageName: "Sachin.jpeg"))
        model.append(SuggestionModel(userName: "Pandya", userImageName: "Pandya.jpeg"))
        model.append(SuggestionModel(userName: "Bumrah", userImageName: "Bumrah.jpeg"))
        model.append(SuggestionModel(userName: "Gambhir", userImageName: "Gambhir.jpg"))
        model.append(SuggestionModel(userName: "Rohit", userImageName: "Rohit.jpeg"))
        model.append(SuggestionModel(userName: "Jadeja", userImageName: "Jadeja.jpg"))
        model.append(SuggestionModel(userName: "Dhawan", userImageName: "Dhawan.jpg"))
        return model
    }
    
    //MARK: -CollectionView
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FeedHeader", for: indexPath) as! FeedHeaderView
        headerView.suggestionModel = prepareDataForSuggestion()
        return headerView
    }
    
  

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let rect = NSString(string: titleArray[indexPath.item]).boundingRect(with: CGSize(width:UIScreen.main.bounds.size.width - 16, height: 500), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)], context: nil)
        return CGSize(width:UIScreen.main.bounds.size.width - 16, height:rect.height+300)
       
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.usernameBtn.setTitle(usernameArray[indexPath.row], for: UIControlState())
        cell.usernameBtn.sizeToFit()
        cell.uuidLbl.text = uuidArray[indexPath.row]
        cell.titleLbl.text = titleArray[indexPath.row]
        cell.titleLbl.sizeToFit()
        
        avaArray[indexPath.row].getDataInBackground { (data, error) -> Void in
            cell.avaImg.image = UIImage(data: data!)
        }
        
        picArray[indexPath.row].getDataInBackground { (data, error) -> Void in
            cell.picImg.image = UIImage(data: data!)
            cell.picImg.contentMode = .scaleToFill
            cell.picImg.layer.masksToBounds = true
        }
        
        let from = dateArray[indexPath.row]
        let now = Date()
        let components : NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfMonth]
        let difference = (Calendar.current as NSCalendar).components(components, from: from!, to: now, options: [])
        
        if difference.second! <= 0 {
            cell.dateLbl.text = "now"
        }
        if difference.second! > 0 && difference.minute! == 0 {
            cell.dateLbl.text = "\(String(describing: difference.second!))s."
        }
        if difference.minute! > 0 && difference.hour! == 0 {
            cell.dateLbl.text = "\(String(describing: difference.minute!))m."
        }
        if difference.hour! > 0 && difference.day! == 0 {
            cell.dateLbl.text = "\(String(describing: difference.hour!))h."
        }
        if difference.day! > 0 && difference.weekOfMonth! == 0 {
            cell.dateLbl.text = "\(String(describing: difference.day!))d."
        }
        if difference.weekOfMonth! > 0 {
            cell.dateLbl.text = "\(String(describing: difference.weekOfMonth!))w."
        }
        
        let didLike = PFQuery(className: "likes")
        didLike.whereKey("by", equalTo: "dhoni7")
        didLike.whereKey("to", equalTo: cell.uuidLbl.text!)
        didLike.countObjectsInBackground { (count, error) -> Void in
            
            if count == 0 {
                cell.likeBtn.setTitle("unlike", for: UIControlState())
                cell.likeBtn.setBackgroundImage(UIImage(named: "unlike.png"), for: UIControlState())
            } else {
                cell.likeBtn.setTitle("like", for: UIControlState())
                cell.likeBtn.setBackgroundImage(UIImage(named: "like.png"), for: UIControlState())
            }
        }
        
        let countLikes = PFQuery(className: "likes")
        countLikes.whereKey("to", equalTo: cell.uuidLbl.text!)
        countLikes.countObjectsInBackground { (count, error) -> Void in
            cell.likeLbl.text = "\(count)"
        }
        return cell
    }
    
}
