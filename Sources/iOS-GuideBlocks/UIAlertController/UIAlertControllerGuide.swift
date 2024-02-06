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
    
    private var hostingController: UIHostingController<UIAlertControllerGuideView>?
    
    public override func presentGuideBlock(contextualContainer: ContextualContainer,
                                           viewController controller: UIViewController?,
                                           success: @escaping ((CTXIGuidePayload) -> ()),
                                           failure: @escaping ((CTXIGuidePayload) -> ())) {

        guard let controller = controller else {
            failure(contextualContainer.guidePayload) // SDK will move to next guide in the feed if the step can't be shown
            return
        }
            
        let dismissGuide = {
            self.hostingController?.willMove(toParent: nil)
            self.hostingController?.view.removeFromSuperview()
            self.hostingController?.removeFromParent()
            self.dismissGuide()
        }
        
        let view = UIAlertControllerGuideView(
            title: contextualContainer.guidePayload.guide.title.text,
            message: contextualContainer.guidePayload.guide.content.text,
            nextlabel: contextualContainer.guidePayload.guide.next.buttonText ?? "next",
            nextbgcolor: contextualContainer.guidePayload.guide.next.backgroundColor ?? UIColor(Color.green),
            nextButtonTapped: {
                    self.nextStepOfGuide() // SDK is being told "success" and progress to the next step (if any) in the Guide
                    dismissGuide()
            },
            prevlabel: contextualContainer.guidePayload.guide.prev.buttonText ?? "back",
            prevbgcolor: contextualContainer.guidePayload.guide.prev.backgroundColor ?? UIColor(Color.red),
            prevButtonTapped: {
                self.previousStepOfGuide() // SDK is being told "fail" and go back to the last step (if any) in the Guide
                dismissGuide()
            }
        )

        self.hostingController = UIHostingController(rootView: view)
        
        guard let hostingController = self.hostingController else {
            failure(contextualContainer.guidePayload) // // SDK will move to next guide in the feed if the step can't be shown
            return
        }
        
        controller.addChild(self.hostingController!)
        controller.view.addSubview(self.hostingController!.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor)
        ])
        
        hostingController.didMove(toParent: controller)

        success(contextualContainer.guidePayload)
    }
    
    override public func isDismissingGuide() {
        // Ensure that the custom guide is removed when the SDK needs to dismiss the guide
        self.hostingController?.willMove(toParent: nil)
        self.hostingController?.view.removeFromSuperview()
        self.hostingController?.removeFromParent()

        // Anything else you want to implement during the dismissal of this GuideBlock step
    }
}
