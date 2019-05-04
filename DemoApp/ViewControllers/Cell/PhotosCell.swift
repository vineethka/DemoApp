//
//  PhotosCell.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 03/05/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import UIKit
import Kingfisher
class PhotosCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var authorsLabel: UILabel!
}

extension PhotosCell: CellConfigurable {
    func setup(viewModel: RowViewModel) {
    
        self.authorsLabel.text = viewModel.author
        self.iconImageView.kf.indicatorType = .activity
        let processor = DownsamplingImageProcessor(size: CGSize(width: 60, height: 60))
        self.iconImageView.kf.setImage(with: viewModel.downloadUrl, placeholder: UIImage(named: "PlaceHolder"), options: [.processor(processor)])
    }
}

public extension UITableViewCell {
    /// Generated cell identifier derived from class name
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
