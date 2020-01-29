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
    
    func checkLogin(for username: String, with password: String, completion: @escaping (User?) -> Void) {
        let loginURL = baseURL.appendingPathComponent("login/basic")
        
        var request = URLRequest(url: loginURL)

        request.httpMethod = "GET"
        
        let loginString = String(format: "\(username):\(password)")
        guard let loginData = loginString.data(using: .utf8) else {
            print(#line, #function, "Can't encode login string to data using utf8")
            return completion(nil)
        }
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(#line, #function, "Couldn't get data")
                return completion(nil)
            }
            
            let jsonDecoder = JSONDecoder()
            guard let user = try? jsonDecoder.decode(User.self, from: data) else {
                print(#line, #function, "Can't decode data from \(data)")
                return completion(nil)
            }
        
            completion(user)
        }
        
        task.resume()
    }
    
    func fetchUsers(completion: @escaping ([User]?) -> Void) {
        
    }
}
