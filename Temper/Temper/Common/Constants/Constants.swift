//
//  Constants.swift
//  Temper
//
//  Created by Sameh Mabrouk on 17/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

struct Constants {
    static let baseURL = Config.string(for: .baseURL)
    
    enum CardAnimation {
        static let cardHighlightedFactor: CGFloat = 0.96
        static let statusBarAnimationDuration: TimeInterval = 0.4
        static let cardCornerRadius: CGFloat = 16
        static let dismissalAnimationDuration = 0.6

        static let cardVerticalExpandingStyle: CardVerticalExpandingStyle = .fromTop


        /// Without this, there'll be weird offset (probably from scrollView) that obscures the card content view of the cardDetailView.
        static let isEnabledWeirdTopInsetsFix = true

        /// If true, will draw borders on animating views.
        static let isEnabledDebugAnimatingViews = false

        /// If true, this will add a 'reverse' additional top safe area insets to make the final top safe area insets zero.
        static let isEnabledTopSafeAreaInsetsFixOnCardDetailViewController = false

        /// If true, will always allow user to scroll while it's animated.
        static let isEnabledAllowsUserInteractionWhileHighlightingCard = true

        static let isEnabledDebugShowTimeTouch = true
    }
}

extension Constants.CardAnimation {
    enum CardVerticalExpandingStyle {
        /// Expanding card pinning at the top of animatingContainerView
        case fromTop

        /// Expanding card pinning at the center of animatingContainerView
        case fromCenter
    }
}
