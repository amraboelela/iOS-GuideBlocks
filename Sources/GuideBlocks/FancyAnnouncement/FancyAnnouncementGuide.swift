//
//  FancyAnnouncementGuide.swift
//  airbnb-main
//
//  Created by Marc Stroebel on 7/11/2023.
//  Copyright © 2023 Contextual. All rights reserved.
//

import SwiftUI
import ContextualSDK

public class FancyAnnouncementGuide: CTXBaseGuideController {
    
    private var hostingController: UIHostingController<FancyAnnouncementGuideView>?
    
    public override func presentGuideBlock(contextualContainer: ContextualContainer,
                                           viewController controller: UIViewController?,
                                           success: @escaping ((CTXIGuidePayload) -> ()),
                                           failure: @escaping ((CTXIGuidePayload) -> ())) {
        let guide = contextualContainer.guidePayload.guide
        
        guard let controller = controller else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        let dismissGuide = {
            self.hostingController?.willMove(toParent: nil)
            self.hostingController?.view.removeFromSuperview()
            self.hostingController?.removeFromParent()
            self.dismissGuide()
        }
        
        let view = FancyAnnouncementGuideView(
            titleElement: guide.title,
            messageElement: guide.content,
            leftButtonElement: guide.prev,
            rightButtonElement: guide.next,
            imageUrl: guide.arrayImages?.first?.resource,
            closeButtonTapped: {
                dismissGuide()
            },
            leftButtonTapped: {
                self.previousStepOfGuide()
            },
            rightButtonTapped: {
                self.nextStepOfGuide()
            }
        )
        
        self.hostingController = UIHostingController(rootView: view)
        
        guard let hostingController = self.hostingController else {
            failure(contextualContainer.guidePayload)
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
        self.hostingController?.willMove(toParent: nil)
        self.hostingController?.view.removeFromSuperview()
        self.hostingController?.removeFromParent()
    }
}
