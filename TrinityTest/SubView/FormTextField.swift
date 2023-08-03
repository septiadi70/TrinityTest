//
//  FormTextField.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import UIKit

class FormTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
