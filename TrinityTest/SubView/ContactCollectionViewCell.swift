//
//  ContactCollectionViewCell.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }

}
