//
//  FloatingView.swift
//  Temper
//
//  Created by Sameh Mabrouk on 19/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class FloatingView: UIView, NibLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var filtersButton: UIButton!
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        commonSetup()
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        commonSetup()
    }
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }
    
    // MARK: - IBActions
    
    @IBAction func mapButtonTapped(_ sender: Any) {
    }
    
    @IBAction func filtersButtonTapped(_ sender: Any) {
    }
}

// MARK: - Helpers

private extension FloatingView {
    private func commonSetup() {
        backgroundView.layer.cornerRadius = 25
    }
}
