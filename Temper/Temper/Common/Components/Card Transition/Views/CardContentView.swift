//
//  CardContentView.swift
//  Temper
//
//  Created by Sameh Mabrouk on 18/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit
import Nuke

@IBDesignable class CardContentView: UIView, NibLoadable {

    // MARK: - IBOutlets

    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var imageToTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToLeadingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToTrailingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToBottomAnchor: NSLayoutConstraint!

    @IBInspectable var backgroundImage: UIImage? {
        get {
            return self.imageView.image
        }

        set(image) {
            self.imageView.image = image
        }
    }
    
    // MARK: - Properties
    
    var viewModel: CardContentViewModel? {
        didSet {
            primaryLabel.text = viewModel?.primary
            secondaryLabel.text = viewModel?.secondary
            detailLabel.text = viewModel?.description
            if let imageStringURL = viewModel?.image, let imageURL = URL(string: imageStringURL) {
                Nuke.loadImage(with: imageURL, options: ImageLoadingOptions(contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFill, placeholder: .scaleAspectFill)), into: imageView)
            }
        }
    }

    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        commonSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        commonSetup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }

    private func commonSetup() {
        // Make the background image stays still at the center while we animationg,
        // else the image will get resized during animation.
        imageView.contentMode = .center
    }

    /// This "connects" highlighted (pressedDown) font's sizes with the destination card's font sizes
    /// in case we want to customize font size after before and after view is higlighted.
    func setFontState(isHighlighted: Bool) {}
}
