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
    var animationType: AnimationType = .none
    var duration: CGFloat = 0
    var direction: AnimationDirection?
    
    init(animationType: AnimationType, duration: CGFloat, direction: AnimationDirection? = nil) {
        self.animationType = animationType
        self.duration = duration
        self.direction = direction
    }
    
    init(inAnimation: SHTipAnimationElement) {
        animationType = AnimationType(rawValue: inAnimation.inType.rawValue) ?? .none
        duration = inAnimation.inDuration
        direction = AnimationDirection(rawValue: inAnimation.inDirection.rawValue)
    }
    
    init(outAnimation: SHTipAnimationElement) {
        animationType = AnimationType(rawValue: outAnimation.outType.rawValue) ?? .none
        duration = outAnimation.outDuration
        direction = AnimationDirection(rawValue: outAnimation.outDirection.rawValue)
    }
}

enum AnimationDirection: UInt32 {
    case top = 2
    case bottom = 4
    case left = 1
    case right = 3
}

enum AnimationType: UInt32 {
    
    // https://docs.contextu.al/sdks/ios/reference/guideblocks/ctxbaseguidecontroller/guidepayload/animationElement/#animation-type
    // Appear and disappear animation are none.
    case none = 0
    case slide = 2
    case fade = 1
    case explode = 3
    case compress = 4
}

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
        
        toView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toView.topAnchor.constraint(equalTo: containerView.topAnchor),
            toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            toView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        let type = animationModel.animationType
        
        switch type {
        case .none:
            transitionContext.completeTransition(true)
        case .slide:
                        
            if let direction = animationModel.direction {
                var initialFrame = toView.frame
                switch direction {
                case .top:
                    initialFrame.origin.y = -containerView.frame.height
                case .bottom:
                    initialFrame.origin.y = containerView.frame.height
                case .left:
                    initialFrame.origin.x = -containerView.frame.width
                case .right:
                    initialFrame.origin.x = containerView.frame.width
                }
                toView.frame = initialFrame
                
                // Animate toView to slide in from specified direction
                UIView.animate(withDuration: animationModel.duration, animations: {
                    toView.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
                }) { _ in
                    transitionContext.completeTransition(true)
                }
            }
            
        case .fade:
            
            toView.alpha = 0.0
            
            UIView.animate(withDuration: animationModel.duration, animations: {
                toView.alpha = 1.0
            }) { _ in
                transitionContext.completeTransition(true)
            }
            
        case .explode:
            toView.alpha = 0.0
            toView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: animationModel.duration, animations: {
                toView.alpha = 1.0
                toView.transform = .identity
            }) { _ in
                transitionContext.completeTransition(true)
            }
        case .compress:
            transitionContext.completeTransition(true)
        }
        
    }
    
    func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let type = animationModel.animationType
        switch type {
        case .none:
            transitionContext.completeTransition(true)
            
        case .slide:
            
            var finalFrame = fromView.frame
            if let direction = animationModel.direction {
                switch direction {
                case .top:
                    finalFrame.origin.y = -containerView.frame.height
                case .bottom:
                    finalFrame.origin.y = containerView.frame.height
                case .left:
                    finalFrame.origin.x = -containerView.frame.width
                case .right:
                    finalFrame.origin.x = containerView.frame.width
                }
                
                // Animate fromView to slide out to specified direction
                UIView.animate(withDuration: animationModel.duration, animations: {
                    fromView.frame = finalFrame
                }) { _ in
                    transitionContext.completeTransition(true)
                }
            }
                  
            
        case .fade:
            UIView.animate(withDuration: animationModel.duration, animations: {
                fromView.alpha = 0.0
            }) { _ in
                transitionContext.completeTransition(true)
            }
        case .explode:
            
            UIView.animate(withDuration: animationModel.duration, animations: {
                fromView.alpha = 0.0
                fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { _ in
                transitionContext.completeTransition(true)
            }
        case .compress:
            //transitionContext.completeTransition(true)
            UIView.animate(withDuration: animationModel.duration, animations: {
                fromView.alpha = 0.0
                fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                fromView.center = containerView.center
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
    }
}
