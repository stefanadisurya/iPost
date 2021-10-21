//
//  ConsumeAPI.swift
//  iPost
//
//  Created by Stefan Adisurya on 18/10/21.
//

import Foundation

struct Constants {
    static let userUrl = URL(string: "https://jsonplaceholder.typicode.com/users")
    static let postUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
    static let albumUrl = URL(string: "https://jsonplaceholder.typicode.com/albums")
}

class ConsumeAPI {
    
    static let session = URLSession.shared
    
    static func loadData(from url: String, code: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                code(data, response, error)
            }
        })
        
        dataTask.resume()
    }
    
}
