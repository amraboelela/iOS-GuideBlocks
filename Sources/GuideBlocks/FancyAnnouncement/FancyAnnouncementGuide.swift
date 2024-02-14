//
//  FancyAnnouncementGuide.swift
//  iOS-GuideBlocks
//
//  Created by Marc Stroebel on 2023/11/7.
//  Copyright © 2023 Contextual.
//

import SwiftUI
import ContextualSDK

public class FancyAnnouncementGuide: CTXBaseGuideController {
    
    private var hostingController: UIHostingController<FancyAnnouncementGuideView>?
    
    public override func presentGuideBlock(
        contextualContainer: ContextualContainer,
        viewController controller: UIViewController?,
        success: @escaping ((CTXIGuidePayload) -> ()),
        failure: @escaping ((CTXIGuidePayload) -> ())
    ) {
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
            title: guide.title,
            message: guide.content,
            leftButton: guide.prev,
            rightButton: guide.next,
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
        
        controller.addChild(hostingController)
        controller.view.addSubview(hostingController.view)
        
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
