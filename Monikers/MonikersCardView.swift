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
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
    }
}
