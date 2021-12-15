//
//  HStackView.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

// MARK: - Horizontal Stack View
/// A helper class to create horizontal stackview with a single line of code
class HStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.distribution = .fillEqually
        self.axis = .horizontal
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
