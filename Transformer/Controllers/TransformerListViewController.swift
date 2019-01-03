//
//  TransformerListViewController.swift
//  Transformer
//
//  Created by Leah Xia on 2018-12-25.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

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
    
    @IBOutlet weak var viewModel: TransformerListViewModel!

    
    // MARK: - Variables
    let transformerListCellId = "transformerListCellId"
    
    private var accessToken: String? {
        get { return KeychainWrapper.standard.string(forKey: "accessToken") }
        set { KeychainWrapper.standard.set(newValue!, forKey: "accessToken") }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchAllTransformers(with: self.accessToken) { [weak self] (errorMessage, token) in
            
            guard errorMessage == nil, let token = token else {
                self?.showAlert(title: "Access Error", message: errorMessage ?? "No token found. Please contact our support team.")
                return
            }
            
            self?.accessToken = token
            
            self?.reloadDataAndUpdatePageControl()
        }
    }
    
    // Helper
    func reloadDataAndUpdatePageControl() {
        autobotsCollectionView.reloadData()
        decepticonsCollectionView.reloadData()
        setPageControllsAfterFetchingData(pageControll: autobotsPageControll, teamIndex: 0)
        setPageControllsAfterFetchingData(pageControll: decepticonsPageControll, teamIndex: 1)
    }
    
    func setPageControllsAfterFetchingData(pageControll: UIPageControl?, teamIndex: Int) {
        let memberCount = self.viewModel.numberOfMembers(teamIndex: teamIndex)
        pageControll?.numberOfPages = memberCount == 0 ? 1 : memberCount
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
            
            // Portrait
            if  viewWidth < viewHeight {
                
                let height = (viewHeight - totalVerticalMargin) / 2

                layout.itemSize = CGSize(width: viewWidth - Constants.stackHorizontalMargin.rawValue, height: height)
            } else {
                // Landscape
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
    
    // Helper
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
        let teamIndex = setTeamIndexAccordingTo(collectionView: collectionView)
        let memberCount = viewModel.numberOfMembers(teamIndex: teamIndex)
        return memberCount == 0 ? 1 : memberCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: transformerListCellId, for: indexPath) as! TransformerListCollectionViewCell
        
        config(cell: cell, indexPath: indexPath, collectionView: collectionView)
        
        return cell
    }
    
    func config(cell: TransformerListCollectionViewCell, indexPath: IndexPath, collectionView: UICollectionView) {
        cell.layer.cornerRadius = CornerRadius.cell.rawValue
        
        let teamIndex = setTeamIndexAccordingTo(collectionView: collectionView)
        
        if let image = viewModel.teams[teamIndex].teamIcon {
            cell.teamImageView.image = image
        }

        guard let member = viewModel.memberForItem(at: indexPath, teamIndex: teamIndex) else {
            return
        }
        
        cell.transformerNameLabel.text = member.name
        cell.strengthValueLabel.text = "\(member.strength)"
        cell.intelligenceValueLabel.text = "\(member.intelligence)"
        cell.speedValueLabel.text = "\(member.speed)"
        cell.rankValueLabel.text = "\(member.rank)"
        cell.enduranceValueLabel.text = "\(member.endurance)"
        cell.courageValueLabel.text = "\(member.courage)"
        cell.firepowerValueLabel.text = "\(member.firepower)"
        cell.skillValueLabel.text = "\(member.skill)"
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == autobotsCollectionView {
            autobotsPageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        } else {
            decepticonsPageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }
    
    // Helper
    func setTeamIndexAccordingTo(collectionView: UICollectionView) -> Int {
        return collectionView == autobotsCollectionView ? 0 : 1
    }
    
}
