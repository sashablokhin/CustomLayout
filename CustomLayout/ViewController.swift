//
//  ViewController.swift
//  CustomLayout
//
//  Created by Alexander Blokhin on 01.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - UICollectionViewDataSource
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let imageName = "img_\(imageIndex(indexPath.row))"
        
        cell.imageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    // MARK: - Supporting functions
    
    func imageIndex(var index: Int) -> Int {
        if index > 5 {
            index -= 6
            
            return imageIndex(index)
        }
        
        return index
    }
}

