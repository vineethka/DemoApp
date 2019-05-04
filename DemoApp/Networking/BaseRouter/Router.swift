//
//  Router.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation
import DataCache


public enum APIServiceError: Error {
    case apiError
    case invalidResponse
    case noData
    case decodeError
}

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    var jsonDecoder:JSONDecoder {get set}
    func request<T: Decodable>(_ route: EndPoint, completion: @escaping (Result<T, APIServiceError>) -> Void)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private (set) var _jsonDecoder: JSONDecoder = JSONDecoder()
    var jsonDecoder: JSONDecoder {
        get {
            return _jsonDecoder
        }set (newValue) {
            return _jsonDecoder = newValue
        }
    }
    
    private var task: URLSessionTask?
    
    func request<T: Decodable>(_ route: EndPoint, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        let session = URLSession.shared
    
        //Read from cache
        if let data = DataCache.instance.readData(forKey: route.getFullUrl().absoluteString) {
            self.decodeAndSendData(data: data, completion: completion)
            return
        }
        
        let request = self.buildRequest(from: route)
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.apiError))
                return
            }
            
            guard let unwrappedData = data else {
                completion(.failure(.noData))
                return
            }
            DataCache.instance.write(data: unwrappedData, forKey: route.getFullUrl().absoluteString)
            self.decodeAndSendData(data: unwrappedData, completion: completion)
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func decodeAndSendData<T: Decodable>(data:Data, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        do {
            let values = try self._jsonDecoder.decode(T.self, from: data)
            completion(.success(values))
        }catch let error {
            print(error.localizedDescription)
            completion(.failure(.decodeError))
            
        }
    }
    fileprivate func buildRequest(from route: EndPoint) -> URLRequest {
        
        var request = URLRequest(url: route.getFullUrl(),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
        
    }
}

extension EndPointType {
    func getFullUrl() -> URL {
        return self.baseURL.appendingPathComponent(self.path)
    }
}
