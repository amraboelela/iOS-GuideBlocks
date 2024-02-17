//
//  OpenCarouselGuid.swift
//
//
//  Created by Aamir on 10/02/24.
//

import SwiftUI
import ContextualSDK


/// A guide controller for displaying a circle video view.
public class OpenCarouselGuid: CTXBaseGuideController {
    
    private var hostingController: UIHostingController<OpenCarouselGuidView>?
    
    /// Presents the guide block.
    ///
    /// - Parameters:
    ///   - contextualContainer: The contextual container.
    ///   - controller: The view controller to present the guide block on.
    ///   - success: The closure to be called when the guide block is successfully presented.
    ///   - failure: The closure to be called when there is a failure in presenting the guide block.
    public override func presentGuideBlock(contextualContainer: ContextualContainer,
                                           viewController controller: UIViewController?,
                                           success: @escaping ((CTXIGuidePayload) -> ()),
                                           failure: @escaping ((CTXIGuidePayload) -> ())) {

        guard let controller = controller else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        /* Example GuideBlock JSON for Dashboard
         {
           "guideBlockKey": "OpenCarousel"
         }
         */
        
        print("RECEIVED NEW PAYLOAD \(contextualContainer.guidePayload.guide.carousel)")
        let view = OpenCarouselGuidView(guide: contextualContainer.guidePayload.guide) {
            self.hostingController?.dismiss(animated: true)
            self.dismissGuide()
        }
        
        //TODO: uncomment after setting view to Open Carousel Guid View
        self.hostingController = UIHostingController(rootView: view)
        
        guard let hostingController = self.hostingController else {
            failure(contextualContainer.guidePayload)
            return
        }
        
        hostingController.modalPresentationStyle = .overFullScreen
        controller.present(hostingController, animated: true)
        
        success(contextualContainer.guidePayload)
    }
    
    /// Called when the app or framework dismisses the guide block, do cleanup to remove it.
    override public func isDismissingGuide() {
        self.hostingController?.dismiss(animated: true)
    }
}
