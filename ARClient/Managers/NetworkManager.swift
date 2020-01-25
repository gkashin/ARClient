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
    
    let baseURL = URL(string: "https://localhost:8080")!
    
    func checkLogin(for username: String, with password: String, completion: @escaping (String?) -> Void) {
        let loginURL = baseURL.appendingPathComponent("login")
        print(loginURL)
        var request = URLRequest(url: loginURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data: [String: String] = [username: password]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let token = try? jsonDecoder.decode(Token.self, from: data) {
                completion(token.status)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
