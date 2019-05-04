//
//  PhotosApiManager.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation
import DataCache
import Kingfisher

struct PhotosApiManager {
    let router = Router<PhotosApi>()
    
    func getPhotos(completion:@escaping (Swift.Result<[Photo], APIServiceError>) -> Void) {
        router.request(.listPhotos) { (result) in
            completion(result)
        }
    
    }

    func clearCache() {
        DataCache.instance.cleanAll()
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }
}
