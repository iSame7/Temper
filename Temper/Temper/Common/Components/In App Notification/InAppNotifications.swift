//
//  InAppNotifications.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class InAppNotifications {
    static let success: InAppNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatGreen, image: UIImage(named: "success", in: Bundle(for: InAppNotifications.self), compatibleWith: nil))
    static let error: InAppNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatRed, image: UIImage(named: "error", in: Bundle(for: InAppNotifications.self), compatibleWith: nil))
    static let info: InAppNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatGray, image: UIImage(named: "info", in: Bundle(for: InAppNotifications.self), compatibleWith: nil))
    
    
    // MARK: - Init
    
    public init(){}
    
    
    // MARK: - Helpers
    
    @discardableResult
    static func showNotification(textColor: UIColor, backgroundColor: UIColor, image: UIImage?, title: String, message: String, dismissDelay: TimeInterval, completion: @escaping () -> () = {}) -> InAppNotification? {
        let notificationDefinition = CRNotificationTypeDefinition(textColor: textColor, backgroundColor: backgroundColor, image: image)
        return showNotification(type: notificationDefinition, title: title, message: message, dismissDelay: dismissDelay, completion: completion)
    }
    

    @discardableResult
    static func showNotification(type: InAppNotificationType, title: String, message: String, dismissDelay: TimeInterval, completion: @escaping () -> () = {}) -> InAppNotification? {
        let view = NotificationView()
        
        view.setBackgroundColor(color: type.backgroundColor)
        view.setTextColor(color: type.textColor)
        view.setImage(image: type.image)
        view.setTitle(title: title)
        view.setMessage(message: message)
        view.setDismisTimer(delay: dismissDelay)
        view.setCompletionBlock(completion)
        
        let firstKeyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        
        guard let window = firstKeyWindow  else {
            print("Failed to show in app notification.")
            return nil
        }
        
        window.addSubview(view)
        view.showNotification()
        
        return view
    }
}

private struct CRNotificationTypeDefinition: InAppNotificationType {
    var textColor: UIColor
    var backgroundColor: UIColor
    var image: UIImage?
}
