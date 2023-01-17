//
//  Model.swift
//  YouTube_Project
//
//  Created by Admin on 17.01.2023.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos:[VideoModel])
}



class Model {
    
    var delegate: ModelDelegate?
    
    func getVideos() {
        
        //create a URL object
        
        let url =  URL(string: Constans.API_URL)
        
        guard url != nil else {return}
        
        // get a URLSession object
        // TODO: ALOMAFİRE PROJEYİ HIZLANDIRIR, ONUNLA ÇALIŞMAK DAHA İYİ OLUR.
        let session = URLSession.shared
        
        // get a data task from the URLSession object
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
             
            // check if there were any errors
            
            if error != nil || data == nil {
                return
            }
            
            do{
                
                // parsing the data into video objects
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // ISO8601 standard format is used to convert date format that way
                // if it wasnt able to parse it it would throw error
                let response = try decoder.decode(JsonDataResponse.self, from: data!)
                
                if response.items != nil {
                    
                    DispatchQueue.main.async {
                        // Call the "videosFetched" method of the delegate
                        // videos will be forwarded after the json is parsed
                        self.delegate?.videosFetched(response.items!)
                    }
                    
                }
                dump(response)
                
            } catch {
                
            }
         
        }
    
        // start the task
        
        dataTask.resume()
    }
}
