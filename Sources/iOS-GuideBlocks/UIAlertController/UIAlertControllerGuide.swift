//
//  UIAlertControllerGuide.swift
//  airbnb-main
//
//  Created by David Jones on 6/02/2024.
//  Copyright © 2024 Contextual. All rights reserved.
//

import SwiftUI
import ContextualSDK

public class UIAlertControllerGuide: CTXBaseGuideController {
    var controller: UIViewController?
    public override func presentGuideBlock(contextualContainer: ContextualContainer,
                                           viewController controller: UIViewController?,
                                           success: @escaping ((CTXIGuidePayload) -> ()),
                                           failure: @escaping ((CTXIGuidePayload) -> ())) {

    guard let controller = controller else {
        failure(contextualContainer.guidePayload) // SDK will move to next guide in the feed if the step can't be shown
        return
    }
    self.controller=controller

    var myAlertStyle: UIAlertController.Style = .alert // default style of UIAlertController
            
    if let customAlertStyle = contextualContainer.guidePayload.guide.extraJson["MyAlertStyle"] as? String {
        switch customAlertStyle.lowercased() {
        case "actionsheet":
            myAlertStyle = .actionSheet
        default:
            myAlertStyle = .alert
        }
    }
    let alert = UIAlertController(title: contextualContainer.guidePayload.guide.title.text,
                                  message: contextualContainer.guidePayload.guide.content.text,
                                  preferredStyle: myAlertStyle)

    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
        self.previousStepOfGuide()
    }))
    alert.addAction(UIAlertAction(title: "OK", style:.default, handler: { action in
        self.nextStepOfGuide()
    }))
    controller.present(alert, animated: true, completion: nil)

        
    // will be something like contextualContainer.operations.submitGuideDisplay for feedack
    success(contextualContainer.guidePayload) // sends FeedAck, tells SDK it is now displaying
    }
    
    override public func isDismissingGuide() {
        self.controller?.dismiss(animated: true)
        // anything else you want to implement during the dismissal of this GuideBlock step
    }
}
