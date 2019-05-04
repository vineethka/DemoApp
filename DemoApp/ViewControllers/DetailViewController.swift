//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    
    @IBOutlet weak var logo: UIImageView!
    var controller: DetailController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        controller.start()
    }
    

    func initBinding() {
        controller.viewModel.addObserver({ [weak self](model) in
            self?.title = model.author
            self?.logo.kf.setImage(with: model.downLoadUrl)
        })
    }
    

}
