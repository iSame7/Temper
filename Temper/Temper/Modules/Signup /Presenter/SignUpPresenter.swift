//
//  SignUpPresenter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

class SignUpPresenter: SignUpPresentable {
    // MARK: - Properties
    
    var delegate: SignUpPresenterDelegate?
    
    // MARK: - SignUpPresentable
    
    func closeButtonTapped() {
        delegate?.didTappCloseButton()
    }
}
