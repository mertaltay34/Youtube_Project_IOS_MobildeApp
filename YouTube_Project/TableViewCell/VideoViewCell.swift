//
//  VideoViewCell.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import UIKit
import SnapKit

class VideoViewCell: UITableViewCell {

    static let identifier = "VideoViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
   /* let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    */
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22 // userprofileimage in width ve heightin in yarısı olmalı
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let subTitleTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4 , bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    
    func setImageView() {
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            //make.bottom.equalToSuperview().offset((frame.height/12)-20) alttan ayarlamaya çalışıyorum
            make.height.equalToSuperview().offset((frame.height/4)-100)
            
        }
        
    }

    func setUserProfileImageView() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.leading.equalTo(thumbnailImageView.snp.leading)
            make.height.width.equalTo(44)
            
        }
    }
    
    func setTitleLabel() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileImageView.snp.top)
            make.leading.equalTo(userProfileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(thumbnailImageView.snp.trailing)
            make.height.equalTo(20)
        }
    }
    
    func setSubTitleTextView() {
        
        subTitleTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(thumbnailImageView.snp.trailing)
            make.height.equalTo(30)
        }
    }

    func setupView(){
        //addSubview
        addSubview(thumbnailImageView)
        setImageView()
        
        addSubview(userProfileImageView)
        setUserProfileImageView()
        
        addSubview(titleLabel)
        setTitleLabel()
        
        addSubview(subTitleTextView)
        setSubTitleTextView()
    }
    
    //MARK: DATALARI EŞİTLİYORUZ
    
    var video: VideoModel?


    func setCell(_ v:VideoModel) {
        
        self.video = v
        
        // ensure that you have a video
        guard self.video != nil else {
            return
        }
        
        // set the title and date label
        
        self.titleLabel.text = video?.title
        
        
          let df = DateFormatter() // df means date formatter
         df.dateFormat = "MM/dd/yyyy" // formats can be obtained from http://nsdateformatter.com
         
         self.subTitleTextView.text = df.string(from: video!.published)
        
        // set the thumbnail
        
        guard self.video!.thumbnail != "" else {
            return
        }
        
        // if there is a thumbnail, download the thumbnail data
        
        let url = URL(string: self.video!.thumbnail)
        
        // get the shared url session object
        
        let session = URLSession.shared
        
        // create a data task
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                if url!.absoluteString != self.video?.thumbnail {
                    // video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    return
                }
                
                // create the image object
                let image = UIImage(data: data!)
                
                // set the imageview
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                    self.userProfileImageView.image = image
                }
            }
        }
        // start data task
        dataTask.resume()
    }
    
}

