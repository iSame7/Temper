//
//  SignupOrLoginView.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class SignupOrLoginView: UIView, NibLoadable {
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
    
    // MARKS: - IBActions
    
    @IBAction func signupButtonTapped(_ sender: Any) {
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
}

// MARK: - Helpers

private extension SignupOrLoginView {
    private func commonSetup() {
    }
}

