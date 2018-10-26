//
//  MarbleCollectionViewCell.swift
//  MarbleSolitaire
//
//  Created by Raique Pereira on 10/12/18.
//  Copyright © 2018 Raique Pereira. All rights reserved.
//

import UIKit

class MarbleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Marble: MarbleView!
    
    
    public func changeToEmpty() {
        Marble.fillColor = UIColor.white
    }


    
    
}
