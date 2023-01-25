//
//  SettingCell.swift
//  YouTube_Project
//
//  Created by Admin on 20.01.2023.
//

import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .blue : .white
        }
    }
    
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    static let identifier = "SettingCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.text = "Settings"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setIconImageView() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    func setNameLabel() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    func setupView() {
        addSubview(iconImageView)
        setIconImageView()
        
        addSubview(nameLabel)
        setNameLabel()
        
    }
}

