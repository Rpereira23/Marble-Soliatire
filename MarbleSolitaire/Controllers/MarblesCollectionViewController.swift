//
//  MarblesCollectionViewController.swift
//  MarbleSolitaire
//
//  Created by Raique Pereira on 10/10/18.
//  Copyright © 2018 Raique Pereira. All rights reserved.
//

import UIKit


class MarblesCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "MarbleCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionViewLayout as! MarbleCollectionViewLayout
        layout.delegate = self
    }
}

// MARK: UICollectionViewDataSource
extension MarblesCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= 1 || section >= 5 {
            return 3
        } else {
            return 7
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)
            as? MarbleCollectionViewCell   {
            cell.changeToEmpty()
        }
        

    }
    
    

    
}


extension MarblesCollectionViewController : MarbleCollectionLayoutDelegate {
    
    //The height of each marble
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    
}







/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




// MARK: UICollectionViewDelegate

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
 
 }
 */
