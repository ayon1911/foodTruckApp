//
//  AuthService.swift
//  api-client-iphone
//
//  Created by Khaled Rahman-Ayon on 31/01/17.
//  Copyright © 2017 Khaled Rahman-Ayon. All rights reserved.
//

import Foundation

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    var isRegistered: Bool? {
        get {
            return defaults.bool(forKey: DEFAULT_REGESTERED) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULT_REGESTERED)
        }
    }
    
    var isAuthenticated: Bool? {
        get {
            return defaults.bool(forKey: DEFAULT_AUTHENTICATED) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULT_AUTHENTICATED)
        }
    }
    
    var email: String? {
        get {
            return defaults.value(forKey: DEFAULT_EMAIL) as? String
        }
        set {
            defaults.set(newValue, forKey: DEFAULT_EMAIL)
        }
    }
    
    var authToken: String? {
        get {
            return defaults.value(forKey: DEFAULT_TOKEN) as? String
        }
        set {
            defaults.set(newValue, forKey: DEFAULT_TOKEN)
        }
    }
    
    func registerUser(email username: String, password: String, completion: @escaping callback ) {
        
        let json = ["email": username, "password": password ]
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: POST_LOGIN_ACCT) else {
            isRegistered = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if (error == nil) {
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL session task succeeded: HTTP\(statusCode)")
                    
                    //Check for status 200 or 409
                    
                    if statusCode != 200 && statusCode != 409 {
                        self.isRegistered = false
                        completion(false)
                    } else {
                        self.isRegistered = true
                        completion(true)
                    }
                } else {
                    //Failure
                    print("URL session task failed: \(error?.localizedDescription)")
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            self.isRegistered = false
            completion(false)
            print(err)
        }
    }
    
    func logIn(email username: String, password: String, completion: @escaping callback) {
        
        let json = ["email": username, "password": password]
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: POST_LOGIN_ACCT) else {
            isAuthenticated = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if (error == nil) {
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL Session TAsk Suceeded: HTTP\(statusCode)")
                    if statusCode != 200 {
                        //Failed
                        completion(false)
                        return
                    } else {
                        guard let data = data else {
                            completion(false)
                            return
                        }
                        
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject>
                            if result != nil {
                                if let email = result?["user"] as? String {
                                    if let token = result?["token"] as? String {
                                        //Succeccfully authenticated and have a token
                                        self.email = email
                                        self.authToken = token
                                        self.isRegistered = true
                                        self.isAuthenticated = true
                                        completion(true)
                                        
                                    } else {
                                        completion(false)
                                    
                                    }
                                } else {
                                    completion(false)
                                }
                            } else {
                                completion(false)
                            }
                            
                        } catch let err {
                            completion(false)
                            print(err)
                        }
                    }
                } else {
                    // Failure
                    print("URL Session Task Failed: \(error?.localizedDescription)")
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            completion(false)
            print(err)
        }

    }
    
}
