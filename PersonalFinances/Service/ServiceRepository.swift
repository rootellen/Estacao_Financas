//
//  ServiceRepository.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 27/12/21.
//

import Foundation

final class ServiceRepository {
    
    static let shared = ServiceRepository()
    
    private init() { }
    
    var basePath = "http://localhost:8080/api/v1"
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        
        return URLSession(configuration: config)
    }()

    
}
