//
//  RowViewModel.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation

class RowViewModel {
    let author:String
    let downloadUrl: URL?
    let id:String
    
    init(author:String, url:String, id:String) {
        self.author = author
        self.downloadUrl = URL(string: url)
        self.id = id
    }
}
