//
//  NetworkManager.swift
//  ARClient
//
//  Created by Георгий Кашин on 25.01.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    let baseURL = URL(string: "http://localhost:8080")!
    
    func checkLogin(for username: String, with password: String, completion: @escaping (String?, Bool?) -> Void) {
        let loginURL = baseURL.appendingPathComponent("login")
        
        var request = URLRequest(url: loginURL)

        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let data: Data? = "username=\(username)&password=\(password)".data(using: .utf8) ?? nil
        
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(#line, #function, "Couldn't get data")
                return completion(nil, nil)
            }
    
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print(#line, #function, "Couldn't deserialize data from \(data)")
                return completion(nil, nil)
            }
            
            let status = jsonDictionary["status"] as? String
            let isAdmin = jsonDictionary["isAdmin"] as? Bool
            completion(status, isAdmin)
        }
        
        task.resume()
    }
}
