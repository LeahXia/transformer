//
//  TransformerListViewController.swift
//  Transformer
//
//  Created by Leah Xia on 2018-12-25.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit

private enum Constants: CGFloat {
    case navBar = 44
    case stackTopMargin = 12
    case stackSpaceInBetween = 10
    case fightButtonHeight = 66
    case fightButtonMargin = 20
    case stackHorizontalMargin = 40
}

/// Containts 2 CollectionViews to display Transformers from 2 different teams
final class TransformerListViewController: UIViewController {
    
    @IBOutlet weak var autobotsCollectionView: UICollectionView!
    
    @IBOutlet weak var decepticonsCollectionView: UICollectionView!
    
    @IBOutlet weak var fightButton: UIButton!
    
    @IBOutlet weak var autobotsPageControll: UIPageControl!
    
    @IBOutlet weak var decepticonsPageControll: UIPageControl!
    
    // MARK: - Variables
    let transformerListCellId = "transformerListCellId"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let totalVerticalMargin = Constants.navBar.rawValue + Constants.stackTopMargin.rawValue + Constants.stackSpaceInBetween.rawValue + Constants.fightButtonHeight.rawValue + Constants.fightButtonMargin.rawValue

        setLayout(for: autobotsCollectionView, totalVerticalMargin: totalVerticalMargin)
        setLayout(for: decepticonsCollectionView, totalVerticalMargin: totalVerticalMargin)
        
    }
    
    func setLayout(for collectionView: UICollectionView, totalVerticalMargin: CGFloat) {
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            // Set scrollDirection
            layout.scrollDirection = .horizontal
            
            // Set itemSize
            let viewWidth = view.bounds.width
            let viewHeight = view.bounds.height

            if  viewWidth < viewHeight {
                
                let height = (viewHeight - totalVerticalMargin) / 2

                layout.itemSize = CGSize(width: viewWidth - Constants.stackHorizontalMargin.rawValue, height: height)
            } else {
                
                let width = (viewWidth - Constants.stackHorizontalMargin.rawValue - Constants.stackSpaceInBetween.rawValue) / 2
                
                let height = viewHeight - totalVerticalMargin + 20
                
                layout.itemSize = CGSize(width: width, height: height)
            }
            
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        scrollToItemAfterRotation(index: autobotsPageControll.currentPage, colletionView: autobotsCollectionView)
        scrollToItemAfterRotation(index: decepticonsPageControll.currentPage, colletionView: decepticonsCollectionView)
        
    }
    
    func scrollToItemAfterRotation(index: Int, colletionView: UICollectionView) {
        let indexPath = IndexPath(item: index, section: 0)
        
        DispatchQueue.main.async {
            colletionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func setupStyle() {
        fightButton.layer.cornerRadius = CornerRadius.button.rawValue
    }

    // MARK: - Actions
    @IBAction func didFightButtonTapped(_ sender: UIButton) {
    }
    
}

// MARK: - CollectionView Delegate & DataSource
extension TransformerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: transformerListCellId, for: indexPath) as! TransformerListCollectionViewCell
        
        config(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func config(cell: TransformerListCollectionViewCell, indexPath: IndexPath) {
        cell.layer.cornerRadius = CornerRadius.cell.rawValue
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == autobotsCollectionView {
            autobotsPageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        } else {
            decepticonsPageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }
    
}
