//
//  SignUpPresenter.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

class SignUpPresenter: SignUpPresentable {
    var delegate: SignUpPresenterDelegate?
    
    func closeButtonTapped() {
        delegate?.didTappCloseButton()
    }
}
