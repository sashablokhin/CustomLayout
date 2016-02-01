//
//  ImageCollectionViewCell.swift
//  CustomLayout
//
//  Created by Alexander Blokhin on 01.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
