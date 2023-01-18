//
//  YouTubeModel.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import Foundation


// MARK: represent information of each of the videos that get from API
struct VideoModel : Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    // TODO: small ve medium caseler alınacak thumbnail için
    var thumbnail = ""
    var published = Date()

    
    // specify the set of keys
    // match json key, no need to match words that are the same
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        
        case videoId
        case title
        case description
        case thumbnail = "url" // it is enough to get the url of the thumbnail you want to show
        case published = "publishedAt"
    }
    
    init(from decoder: Decoder) throws { // it takes the json data and tell us what data type try to decode
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // nested containers are parsed
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        // parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        // parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        // parse publish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // parse thumbnails ; at that point, there are nested containers in the snippet container
        
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        // Another container nested in thumbnails
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail) // high url assigned
        
        // Parse nested container in snipper container
        
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
    
    }
    
}
