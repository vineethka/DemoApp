//
//  DetailController.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation

class DetailController {
    var viewModel = Observable<DetailViewModel>(value: DetailViewModel())
    var photo:Photo?
    
    func start() {
        guard let photo = self.photo else { return }
        self.viewModel.value = DetailViewModel(photo: photo)
    }
}
