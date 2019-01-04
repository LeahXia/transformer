//
//  TransformerListViewController.swift
//  Transformer
//
//  Created by Leah Xia on 2018-12-25.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

private enum segueIdentifier: String {
    case listVCToCreateVCSegue = "listVCToCreateVCSegue"
    case listVCToFightVCSegue = "listVCToFightVCSegue"
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
    var selectedTransformer: Transformer?
    var shouldEdit = false
    
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
        
        view.layoutIfNeeded()

        setLayout(for: autobotsCollectionView)
        setLayout(for: decepticonsCollectionView)
        
    }
    
    func setLayout(for collectionView: UICollectionView) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = autobotsCollectionView.frame.size
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
   
    deinit {
        print("List VC deinit")
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
        cell.transformerListCellDelegate = self
        
        let teamIndex = setTeamIndexAccordingTo(collectionView: collectionView)
        
        if let image = viewModel.teams[teamIndex].teamIcon {
            cell.teamImageView.image = image
        }

        guard let member = viewModel.memberForItem(at: indexPath, teamIndex: teamIndex) else {
            setTransformerInfoLabelsTextToQuestionMark(cell: cell)
            return
        }
        
        cell.setupCell(transformer: member)
    
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
    
    // Helper
    func setTransformerInfoLabelsTextToQuestionMark(cell: TransformerListCollectionViewCell) {
        let demoTransformerText = "?"
        cell.transformerNameLabel.text = demoTransformerText
        cell.strengthValueLabel.text = demoTransformerText
        cell.intelligenceValueLabel.text = demoTransformerText
        cell.speedValueLabel.text = demoTransformerText
        cell.rankValueLabel.text = demoTransformerText
        cell.enduranceValueLabel.text = demoTransformerText
        cell.courageValueLabel.text = demoTransformerText
        cell.firepowerValueLabel.text = demoTransformerText
        cell.skillValueLabel.text = demoTransformerText
        cell.deleteButton.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamIndex = setTeamIndexAccordingTo(collectionView: collectionView)
        self.selectedTransformer = viewModel.memberForItem(at: indexPath, teamIndex: teamIndex)
        self.shouldEdit = true
        performSegue(withIdentifier: segueIdentifier.listVCToCreateVCSegue.rawValue, sender: self)
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

// MARK: - Delegate
extension TransformerListViewController: TransformerListCellDelegate {
    func didDeleteButtonTapped(buttonTag: Int, transformer: Transformer?) {
        
        guard let transformer = transformer, let token = self.accessToken else {
            showAlert(title: "Oops!", message: "Cannot delete this demo Transformer")
            return
        }
        
        let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (action) in
            self?.handleDeletion(id: transformer.id, token: token, teamIndex: buttonTag)
        })
        
        alert.addAction(deleteAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleDeletion(id: String, token: String, teamIndex: Int) {
        viewModel.deleteTransformerBy(id: id, token: token, teamIndex: teamIndex) { [weak self] (errorMessage, transformerIndex) in
            
            if let errorMessage = errorMessage {
                self?.showAlert(title: "Oops!", message: "Cannot delete this Transformer due to \(errorMessage)")
            } else if let transformerIndex = transformerIndex {
                let collectionView = teamIndex == 0 ? self?.autobotsCollectionView : self?.decepticonsCollectionView
                if let hasMember = self?.viewModel.hasMember(teamIndex), hasMember {
                    collectionView?.deleteItems(at: [IndexPath(item: transformerIndex, section: 0)])
                }
                
                collectionView?.reloadData()
            }
        }
    }

}

// MARK: - Segues
extension TransformerListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueIdentifier.listVCToCreateVCSegue.rawValue:
            handleToCreateVCSegue(segue: segue)
            break
        case segueIdentifier.listVCToFightVCSegue.rawValue:
            
            break
        default:
            break
        }
    }
    
    // Helper
    func handleToCreateVCSegue(segue: UIStoryboardSegue) {
        if selectedTransformer == nil, shouldEdit {
            showAlert(title: "Oops", message: "No Transformer is selected")
        } else {
            let createVC = segue.destination as? CreateTransformerViewController
            createVC?.transformer = selectedTransformer
        }
    }
    
    func handleToFightVCSegue(segue: UIStoryboardSegue) {
    
        let fightVC = segue.destination as? FightViewController
        fightVC?.teams = viewModel.teams
        
    }
    
}
