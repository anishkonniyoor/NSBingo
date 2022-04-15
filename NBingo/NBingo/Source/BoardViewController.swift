//
//  BoardViewController.swift
//  NBingo
//
//  Created by Anish on 3/26/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    @IBOutlet private weak var itemCollectionView: UICollectionView!
        
    var boardItems = [BingoBoardModel]()
}


extension BoardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        boardItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard boardItems.count > section else { return 0}
        return boardItems[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardItemCell.reuseIdentifier, for: indexPath) as? BoardItemCell else {
            return UICollectionViewCell()
        }
        let colors: [UIColor] = [.green, .lightGray, .yellow, .cyan, .red]

        cell.itemLabel.text = boardItems[indexPath.section].items[indexPath.row].displayText
        cell.backgroundColor = colors[indexPath.section % colors.count]
        
        return cell
    }
}
