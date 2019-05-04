//
//  PhotosApiManager.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation

struct PhotosApiManager {
    let router = Router<PhotosApi>()
    
    func getStates(completion:@escaping (Result<[Photo], APIServiceError>) -> Void) {
        router.request(.listPhotos) { (result) in
            completion(result)
        }
    
    }

}
