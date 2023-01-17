//
//  NavigationBarView.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import Foundation
import UIKit

class NavigationBarView: UIView {
    
    private var titleLabel = UILabel()
    

    init(frame : CGRect,name: String, font: UIFont, color: UIColor){
        self.titleLabel = UILabel(frame: frame)
        self.titleLabel.text = name
        self.titleLabel.font = font
        self.titleLabel.textColor = color
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

