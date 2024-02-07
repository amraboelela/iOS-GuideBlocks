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
        
        let guide = contextualContainer.guidePayload.guide
        let guideId = guide.campaignid ?? "<no_guide_id>"
        let stepOfGuide = guide.suid ?? "0"
        let actiontagkey = "\(guideId)_\(stepOfGuide)_action"
        let view = UIAlertControllerGuideView(
            title: guide.title,
            message: guide.content,
            actiontagvalue: contextualContainer.tagManager.getTagValue(key: actiontagkey),
            nextButton: guide.next,
            nextFG: Color(guide.next.textColor),
            nextBG: Color(guide.next.backgroundColor),
            prevButton: guide.prev,
            prevFG: Color(guide.prev.textColor),
            prevBG: Color(guide.prev.backgroundColor),
            nextButtonTapped: {
                // Save a tag based on the user's action on this step of the guide
                let value = contextualContainer.guidePayload.guide.next.buttonText ?? "next"
                contextualContainer.tagManager.saveTag(key: actiontagkey, value: value, success: nil, failure: nil)
                self.nextStepOfGuide() // SDK is being told "success" and progress to the next step (if any) in the Guide
                dismissGuide()
            },
            prevButtonTapped: {
                // Save a tag based on the user's action on this step of the guide
                let value = contextualContainer.guidePayload.guide.prev.buttonText ?? "back"
                contextualContainer.tagManager.saveTag(key: actiontagkey, value: value, success: nil, failure: nil)
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
