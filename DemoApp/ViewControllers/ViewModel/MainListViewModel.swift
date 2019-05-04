//
//  MainListViewModel.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation

class MainListViewModel {
    let isLoading = Observable<Bool>(value: false)
    let rowViewModel = Observable<[RowViewModel]>(value: [])
    let error = Observable<String>(value: "")
    let title =  Observable<String>(value: "")
}
