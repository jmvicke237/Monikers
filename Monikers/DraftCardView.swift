//
//  DraftCardView.swift
//  Monikers
//
//  Created by Justin Vickers on 7/27/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class DraftCardView: UIView {

    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.height * 0.06)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
}
