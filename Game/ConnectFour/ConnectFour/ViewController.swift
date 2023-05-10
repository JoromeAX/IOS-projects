//
//  ViewController.swift
//  ConnectFour
//
//  Created by Roman Khancha on 24.03.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var turmImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        setCellWidthHeight()
    }
    
    var redScore = 0
    var yellowScore = 0
    
    func setCellWidthHeight() {
        let width = collectionView.frame.size.width / 9
        let height = collectionView.frame.size.height / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func numberOfSections(in cv: UICollectionView) -> Int {
        return board.count
    }
    
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
        
        let boardItem = getBoardIItem(indexPath)
        cell.image.tintColor = boardItem.tileColor()
        
        return cell
    }
    
    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        if var boardItem = getLowetEmptyBoardItem(column) {
            if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? BoardCell {
                cell.image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTil()
                updateBoardWithBoardItem(boardItem)
                
                if victoryAchieved() {
                    if yellowTurn() {
                        yellowScore += 1
                    }
                    if redTurn() {
                        redScore += 1
                    }
                    resultAlert(currentTurnVictoryMessage())
                }
                
                if boardIsFull() {
                    resultAlert("Draw")
                }
                
                toggleTurn(turmImage)
            }
        }
    }
    
    func resultAlert(_ title: String) {
        let message = "\nRed: \(redScore) \nYellow: \(yellowScore)"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {
            [self] (_) in
            resetBoard()
            self.resetCells()
        }))
        self.present(ac, animated: true)
    }
    func resetCells() {
        for cell in collectionView.visibleCells as! [BoardCell] {
            cell.image.tintColor = .white
        }
    }
}
