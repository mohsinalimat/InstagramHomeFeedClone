//
//  SuggestionModel.swift
//  InstagramHomefeedSwift
//
//  Created by Vamshi Krishna on 16/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import Foundation

class SuggestionModel:NSObject{
    
    var userName:String?
    var userImageName:String?
    
    init(userName:String, userImageName:String){
        self.userName = userName
        self.userImageName = userImageName
    }
}


extension UIView{
    func addConstraintsWithFormat(format:String, views: UIView...){
        
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
            
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
