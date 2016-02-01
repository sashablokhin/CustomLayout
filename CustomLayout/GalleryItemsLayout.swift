//
//  GalleryItemsLayout.swift
//  CustomLayout
//
//  Created by Alexander Blokhin on 01.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class GalleryItemsLayout: UICollectionViewLayout {
    var horizontalInset: CGFloat = 0.0
    var verticalInset: CGFloat = 0.0
    
    var minimumItemWidth: CGFloat = 0.0
    var maximumItemWidth: CGFloat = 0.0
    var itemHeight: CGFloat = 0.0
    
    var _layoutAttributes = Dictionary<String, UICollectionViewLayoutAttributes>()
    var _contentSize = CGSizeZero
    
    override func prepareLayout() {
        super.prepareLayout()
        
        _layoutAttributes = Dictionary<String, UICollectionViewLayoutAttributes>()
        
        let path = NSIndexPath(forItem: 0, inSection: 0)
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withIndexPath: path)
        
        let headerHeight = CGFloat(self.itemHeight / 4)
        attributes.frame = CGRectMake(0, 0, self.collectionView!.frame.size.width, headerHeight)
        
        let headerKey = layoutKeyForHeaderAtIndexPath(path)
        _layoutAttributes[headerKey] = attributes 
        
        let numberOfSections = self.collectionView!.numberOfSections()
        
        var yOffset = headerHeight
        
        for var section = 0; section < numberOfSections; section++ {
            
            let numberOfItems = self.collectionView!.numberOfItemsInSection(section)
            
            var xOffset = self.horizontalInset
            
            for var item = 0; item < numberOfItems; item++ {
                
                let indexPath = NSIndexPath(forItem: item, inSection: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                
                var itemSize = CGSizeZero
                var increaseRow = false
                
                if self.collectionView!.frame.size.width - xOffset > self.maximumItemWidth * 1.5 {
                    itemSize = randomItemSize()
                } else {
                    itemSize.width = self.collectionView!.frame.size.width - xOffset - self.horizontalInset
                    itemSize.height = self.itemHeight
                    increaseRow = true
                }
                
                attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height))
                let key = layoutKeyForIndexPath(indexPath)
                _layoutAttributes[key] = attributes
                
                xOffset += itemSize.width
                xOffset += self.horizontalInset
                
                if increaseRow
                    && !(item == numberOfItems - 1 && section == numberOfSections - 1) {
                        
                        yOffset += self.verticalInset
                        yOffset += self.itemHeight
                        xOffset = self.horizontalInset
                }
            }
            
        }
        
        yOffset += self.itemHeight
        
        _contentSize = CGSizeMake(self.collectionView!.frame.size.width, yOffset + self.verticalInset)
    }

    
    override func collectionViewContentSize() -> CGSize {
        return _contentSize
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let headerKey = layoutKeyForIndexPath(indexPath)
        return _layoutAttributes[headerKey]
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    
        let key = layoutKeyForIndexPath(indexPath)
        return _layoutAttributes[key]
    }
    


    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
        let predicate = NSPredicate {  [unowned self] (evaluatedObject, bindings) -> Bool in
            let layoutAttribute = self._layoutAttributes[evaluatedObject as! String]
            return CGRectIntersectsRect(rect, layoutAttribute!.frame)
        }
    
        let dict = _layoutAttributes as NSDictionary
        let keys = dict.allKeys as NSArray
        let matchingKeys = keys.filteredArrayUsingPredicate(predicate)
    
        return dict.objectsForKeys(matchingKeys, notFoundMarker: NSNull()) as? [UICollectionViewLayoutAttributes]
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return !CGSizeEqualToSize(newBounds.size, self.collectionView!.frame.size)
    }

    
    // MARK: - Supporting functions
    
    func randomItemSize() -> CGSize {
        return CGSizeMake(getRandomWidth(), self.itemHeight)
    }
    
    func getRandomWidth() -> CGFloat {
        let range = UInt32(self.maximumItemWidth - self.minimumItemWidth + 1)
        let random = Float(arc4random_uniform(range))
        return CGFloat(self.minimumItemWidth) + CGFloat(random)
    }
    
    func layoutKeyForIndexPath(indexPath : NSIndexPath) -> String {
        return "\(indexPath.section)_\(indexPath.row)"
    }
    
    func layoutKeyForHeaderAtIndexPath(indexPath : NSIndexPath) -> String {
        return "s_\(indexPath.section)_\(indexPath.row)"
    }
}
