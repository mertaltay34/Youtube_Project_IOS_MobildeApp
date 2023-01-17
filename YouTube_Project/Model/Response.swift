//
//  Response.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import Foundation

// MARK: all json data will be decoded
struct JsonDataResponse: Decodable {
    
    var items: [VideoModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) // whole container accessed
        
        self.items = try container.decode([VideoModel].self, forKey: .items) // json array is requested to be decoded
    }
    
}
