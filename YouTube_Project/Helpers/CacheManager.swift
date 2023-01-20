//
//  CacheManager.swift
//  YouTube_Project
//
//  Created by Admin on 19.01.2023.
//

import Foundation

// prevents downloading of the same images

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        
        // store the image data and use the url as key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        
        // try to get the data for the specified url
        return cache[url]
    }
}
