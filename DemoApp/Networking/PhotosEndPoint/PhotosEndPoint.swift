//
//  PhotosEndPoint.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation

public enum PhotosApi {
    case listPhotos
}

extension PhotosApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://picsum.photos/v2") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .listPhotos:
            return "/list"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


