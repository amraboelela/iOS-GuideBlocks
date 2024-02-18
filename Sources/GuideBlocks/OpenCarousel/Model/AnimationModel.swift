//
//  AnimationModel.swift
//
//
//  Created by Aamir on 19/02/24.
//

import Foundation
import ContextualSDK
import UIKit

struct AnimationModel {
    var animationType: AnimationType = .appear
    var duration: CGFloat = 0
    var direction: AnimationDirection?
    
    init(animationType: AnimationType, duration: CGFloat, direction: AnimationDirection? = nil) {
        self.animationType = animationType
        self.duration = duration
        self.direction = direction
    }
    
    init(inAnimation: SHTipAnimationElement) {
        animationType = AnimationType(rawValue: inAnimation.inType.rawValue) ?? .appear
        duration = inAnimation.inDuration
        direction = AnimationDirection(rawValue: inAnimation.inDirection.rawValue)
    }
    
    init(outAnimation: SHTipAnimationElement) {
        animationType = AnimationType(rawValue: outAnimation.outType.rawValue) ?? .fade
        duration = outAnimation.outDuration
        direction = AnimationDirection(rawValue: outAnimation.outDirection.rawValue)
    }
}

//struct OutAnimationModel {
//    var animationType: OutAnimation
//    var duration: CGFloat
//    var direction: AnimationDirection?
//
//    init(animationType: OutAnimation, duration: CGFloat, direction: AnimationDirection? = nil) {
//        self.animationType = animationType
//        self.duration = duration
//        self.direction = direction
//    }
//    init(animation: SHTipAnimationElement) {
//        animationType = OutAnimation(rawValue: animation.outType.rawValue) ?? .disappear
//        duration = animation.outDuration
//        direction = AnimationDirection(rawValue: animation.outDirection.rawValue)
//    }
//}


enum AnimationDirection: UInt32 {
    case top = 2
    case bottom = 4
    case left = 1
    case right = 3
}

enum AnimationType: UInt32 {
    case appear = 0
    case slide = 2
    case fade = 1
    case explode = 3
    case compress = 4
}

//enum OutAnimation: UInt32 {
//    case disappear = 0
//    case slide = 2
//    case fade = 1
//    case compress = 4
//}

//TODO: below code should be moved to new file.
class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var animationModel: AnimationModel!
    var isPresenting: Bool
    
    init(isPresenting: Bool, animationModel: AnimationModel!) {
        self.animationModel = animationModel
        self.isPresenting = isPresenting
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationModel.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
                  animatePresentation(using: transitionContext)
              } else {
                  animateDismissal(using: transitionContext)
              }
    }
    
    func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        // Start the toView offscreen at the top
        toView.frame = CGRect(x: 0, y: -containerView.frame.height, width: containerView.frame.width, height: containerView.frame.height)
        
        UIView.animate(withDuration: animationModel.duration, animations: {
            // Slide the toView into position from the top
            toView.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        UIView.animate(withDuration: animationModel.duration, animations: {
            // Slide the fromView offscreen to the top
            fromView.frame = CGRect(x: 0, y: -containerView.frame.height, width: containerView.frame.width, height: containerView.frame.height)
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
