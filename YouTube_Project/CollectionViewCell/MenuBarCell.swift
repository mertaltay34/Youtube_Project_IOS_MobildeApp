//
//  BarCollectionViewCell.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    static let identifier = "MenuBarCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    // seçilen pencere basılı tutulduğu sürece highlighted oluyor
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    //  pencere seçilince highlighted oluyor
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(28)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
