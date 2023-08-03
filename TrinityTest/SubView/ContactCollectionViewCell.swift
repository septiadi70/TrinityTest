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
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8.0
    }

    func config(_ viewModel: ContactViewModel) {
        imageView.backgroundColor = .orange
        nameLabel.text = viewModel.name
    }
}
