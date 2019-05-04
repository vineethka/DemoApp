//
//  MainListHelper.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation
import DataCache
import Kingfisher

class MainListController {
    
    lazy var apiManager:PhotosApiManager = {PhotosApiManager()}()
    lazy var viewModel:MainListViewModel = {MainListViewModel()}()
    
    var photos:[Photo]?
    
    func start() {
        self.viewModel.title.value = "view_heading".localized
        self.fetchData()
    }
    
    func refreshData() {
        apiManager.clearCache()
        self.fetchData()
    }
    
    private func fetchData() {
        self.viewModel.isLoading.value = true
        apiManager.getPhotos { [weak self](result) in
            self?.viewModel.isLoading.value = false
            switch result {
            case .success(let response):
                self?.buildViewModels(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func buildViewModels(response: [Photo]) {
        self.viewModel.rowViewModel.value = response.map({RowViewModel(author: $0.author, url: $0.downloadUrl, id: $0.id)})
        self.photos = response
        
    }
    
    func getPhotosFrom(row: RowViewModel) -> Photo? {
        return photos?.filter({$0.id == row.id}).first
    }
}
