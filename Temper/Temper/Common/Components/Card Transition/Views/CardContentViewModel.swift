//
//  CardContentViewModel.swift
//  Temper
//
//  Created by Sameh Mabrouk on 18/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

struct CardContentViewModel {
    let primary: String
    let secondary: String
    let description: String
    let image: String

    func highlightedImage() -> CardContentViewModel {
//        let scaledImage = image.resize(toWidth: image.size.width * Constants.CardAnimation.cardHighlightedFactor)
        return CardContentViewModel(primary: primary,
                                    secondary: secondary,
                                    description: description,
                                    image: image)
    }
}
