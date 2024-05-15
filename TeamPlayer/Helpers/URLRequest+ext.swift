//
//  URLRequest+ext.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import Foundation

extension URLRequest {
    
    static func makeHttpRequest(path: String, httpMethod: String, body: Data? = nil, token: String? = nil, rote: String? = nil) -> URLRequest {
        
        var duration = ""
        
        if let rote = rote {
            duration = rote + path
        } else {
            duration = Constants.Network.defaultVaporBaseURL + path
        }
        
        var request = URLRequest(url: URL(string: duration)!)
        if let body = body {
            request.httpBody = body
        }
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = httpMethod
        return request
    }
}
