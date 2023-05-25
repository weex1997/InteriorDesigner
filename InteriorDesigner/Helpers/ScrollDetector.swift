//
//  ScrollDetector.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 24/05/2023.
//

import SwiftUI

struct ScrollDetector: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator (parent: self)
    }
    
    var onScroll: (CGFloat) -> ()

    var onDraggingEnd: (CGFloat, CGFloat) -> ()
    
    func makeUIView (context: Context) -> UIView {
        return UIView()
    }
    func updateUIView(_ uiview: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollview = uiview.superview? .superview? .superview as? UIScrollView ,!context.coordinator.isDelegateAdded {
                
                scrollview.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
    
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollDetector
        
        init (parent: ScrollDetector) {
            self.parent = parent
        }
  
    var isDelegateAdded: Bool = false
        func scrollviewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll (scrollView.contentOffset.y)
        }
        
            func scrollViewwillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContent0ffset: UnsafeMutablePointer<CGPoint>) {
                parent.onDraggingEnd(targetContent0ffset.pointee.y, velocity.y)
            }
        }
}
