//
//  DetailViewModel.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import UIKit

class DetailViewModel {

    let author:String
    let downLoadUrl:URL?
    
    init(photo: Photo) {
        self.author = photo.author
        self.downLoadUrl = URL(string: photo.downloadUrl)
    }
    
    init() {
        self.author = .emptyString
        self.downLoadUrl = URL(string: "")
    }
}
