//
//  MarbleCollectionViewLayout.swift
//  MarbleSolitaire
//
//  Created by Raique Pereira on 10/12/18.
//  Copyright © 2018 Raique Pereira. All rights reserved.
//

import UIKit

protocol MarbleCollectionLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class MarbleCollectionViewLayout: UICollectionViewLayout {
    
    var delegate: MarbleCollectionLayoutDelegate!
    var numberOfColumns = 7
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            return collectionView!.bounds.width
        }
        
    }
    override var collectionViewContentSize : CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    
    override func prepare() {
        collectionView!.contentInset = UIEdgeInsets(top: collectionView!.center.y / 2,
                                                    left: collectionView!.center.x / 8,
                                                    bottom: collectionView!.center.y / 2,
                                                    right: collectionView!.center.x / 8)
        
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var yOffsets = [CGFloat](repeating: 50, count : numberOfColumns)
            var column = 0

            for section in 0..<collectionView!.numberOfSections {
                var row = getStartingX(section: section)
                for item in 0..<collectionView!.numberOfItems(inSection: section){
                    let indexPath = IndexPath(item: item, section: section)
                    let nsIndexPath = NSIndexPath(item: item, section: section)
                    let height = delegate.collectionView(collectionView: collectionView!,
                                                         heightForItemAtIndexPath: nsIndexPath)
                    let frame = CGRect(x: CGFloat(row), y: yOffsets[column],
                                       width: columnWidth, height: height)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = frame
                    cache.append(attributes)
                    contentHeight = max(contentHeight, frame.maxY)
                    row = row + 50
                    
                    column = column >=  (collectionView!.numberOfItems(inSection: section) - 1) ? 0 : (column + 1)
                }
                let currentOffset = yOffsets[0] + 50
                yOffsets = [CGFloat](repeating: currentOffset, count: numberOfColumns)
                
            }
            
        }
    }
    
    private func getStartingX(section: Int) -> Int{
        if (section <= 1 || section >= 5) {
            return 100
        } else {
            return 0
        }
    
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
            
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print(indexPath)
        
        return super.layoutAttributesForItem(at: indexPath)
        
    }


}


