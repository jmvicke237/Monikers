//
//  MonikersCardView.swift
//  Monikers
//
//  Created by Justin Vickers on 7/6/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class MonikersCardView: UIView {
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.height * 0.06)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
}





//extension MonikersCardView {
//    private struct SizeRatio {
//        static let fontSizeToBoundsHeight: CGFloat = 0.33
//        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
//        static let cornerOffsetToCornerRadius: CGFloat = 0.33
//        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
//    }
//    private var cornerRadius: CGFloat {
//        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
//    }
//    private var cornerOffset: CGFloat {
//        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
//    }
//}
//
//extension CGRect {
//    var leftHalf: CGRect {
//        return CGRect(x: minX, y: minY, width: width/2, height: height)
//    }
//    var rightHalf: CGRect {
//        return CGRect(x: midX, y: minY, width: width/2, height: height)
//    }
//    func inset(by size: CGSize) -> CGRect {
//        return insetBy(dx: size.width, dy: size.height)
//    }
//    func sized(to size: CGSize) -> CGRect {
//        return CGRect(origin: origin, size: size)
//    }
//    func zoom(by scale: CGFloat) -> CGRect {
//        let newWidth = width * scale
//        let newHeight = height * scale
//        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
//    }
//}
//
//extension CGPoint {
//    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
//        return CGPoint(x: x+dx, y: y+dy)
//    }
//}
//
//extension CGFloat {
//    var arc4random: CGFloat {
//        return self * (CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max))
//    }
//}
