//
//  REST.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 24/11/21.
//

import Foundation

enum FinanceError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson(erro: NSError)
    case emptyData
}

class Rest {
    private static let basePath = "http://localhost:8080/api/v1"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    //escaping significa que o metodo retem os parametros para uso posterior dentro das closures
    class func loadFinances(onComplete: @escaping (FinancaResponse) -> Void, onError: @escaping (FinanceError) -> Void) {
        guard let url = URL(string: basePath + "/financial") else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    if data.isEmpty {
                        onError(.emptyData)
                        return
                    }
                    do {
                        let finances = try JSONDecoder().decode(FinancaResponse.self, from: data)
                        onComplete(finances)
                    } catch let jsonError as NSError {
                        onError(.invalidJson(erro: jsonError))
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        
        dataTask.resume()
    }
    
    class func addFinance(finance: Financa, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: basePath + "/financial") else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let json = try? JSONEncoder().encode(finance) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }
    
    class func login(_ user: String, _ pass: String, onComplete: @escaping (Bool) -> Void) {
        guard var components = URLComponents(string: basePath + "/user/authenticate") else {
            onComplete(false)
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "user", value: user),
            URLQueryItem(name: "pass", value: pass)
        ]
        
        let url = URLRequest(url: components.url!)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        
        dataTask.resume()
    }
}
