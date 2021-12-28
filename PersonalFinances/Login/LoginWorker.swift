//
//  LoginWorker.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 15/12/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginWorkerLogic {
    func requestLogin(request: Login.Logar.Request, completion: @escaping (Bool) -> Void)
}

class LoginWorker: LoginWorkerLogic {
    
    func requestLogin(request: Login.Logar.Request, completion: @escaping (Bool) -> Void) {
        
        let basePath = ServiceRepository.shared.basePath
        let session = ServiceRepository.shared.session
        
        guard var components = URLComponents(string: basePath + "/user/authenticate") else {
            completion(false)
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "user", value: request.user),
            URLQueryItem(name: "pass", value: request.pass)
        ]
        
        let url = URLRequest(url: components.url!)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    completion(false)
                    return
                }
                completion(true)
            } else {
                completion(false)
            }
        }
        
        dataTask.resume()
    }
    
}