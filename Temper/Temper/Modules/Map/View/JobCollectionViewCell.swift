//
//  VenueCollectionViewCell.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit
import Nuke

class JobCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    struct ViewModel {
        let imageName: String?
        let title: String
        let subtitle: String
        let description: String
    }
    
    func configure(viewModel: ViewModel) {
        if let imagePath = viewModel.imageName, let imageURL = URL(string: imagePath) {
            Nuke.loadImage(with: imageURL, into: image, progress: nil, completion: nil)
        }
        
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description
    }
}
