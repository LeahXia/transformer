//
//  FightViewController.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-04.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import UIKit

class FightViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var viewModel: FightViewModel!

    @IBOutlet weak var winningTeamLabel: UILabel!
    
    @IBOutlet weak var battleNumberView: UIView!
    
    @IBOutlet weak var autobotsBattleNumberLabel: UILabel!
    
    @IBOutlet weak var decepticonsBattleNumberLabel: UILabel!
    
    @IBOutlet weak var battleCollectionView: UICollectionView!
    
    // MARK: - Variables
    let fightCellId = "fightCellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        displayWinningTeam()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let layout = battleCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 170)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("Fight VC deinit")
    }
    
}

extension FightViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.battles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fightCellId, for: indexPath) as! FightCollectionViewCell
        config(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func config(cell: FightCollectionViewCell, indexPath: IndexPath) {
        
       
        guard let battle = viewModel.battleForItem(at: indexPath) else {
            return
        }
        let fights = battle.getFighters()

        cell.autobotsName.text = fights[0]?.name
        cell.decepticonsName.text = fights[1]?.name

        guard let battleResult = battle.battleResult else {
            return
        }
        switch battleResult {
        case .tie:
            cell.battleResultLabel.text = "Tie"
            grayOutLosingTransformer(cell: cell, team: .Autobots)
            grayOutLosingTransformer(cell: cell, team: .Decepticons)
            break
        case .morePowerful(let loser):
            cell.battleResultLabel.text = "More Powerful"
            grayOutLosingTransformer(cell: cell, team: loser)
            break
        case .higherOverall(let loser, let autoRating, let deceRating):
            cell.battleResultLabel.text = "\(autoRating) VS \(deceRating)"
            grayOutLosingTransformer(cell: cell, team: loser)
        case .moreSkillful(let loser):
            cell.battleResultLabel.text = "More Skillful"
            grayOutLosingTransformer(cell: cell, team: loser)

        case .runAway(let loser):
            cell.battleResultLabel.text = "Ran Away"
            grayOutLosingTransformer(cell: cell, team: loser)
        case .noBattle:
            cell.battleResultLabel.text = ""
            if fights[0]?.name == nil { cell.autobotsImageView.isHidden = true }
            if fights[1]?.name == nil { cell.decepticonsImageView.isHidden = true }
        }

    }
    
    func grayOutLosingTransformer(cell: FightCollectionViewCell, team: TeamInitial) {

        if team == .Autobots {
            cell.autobotsImageView.backgroundColor = Colors.unselectedGrayColor
            cell.autobotsName.textColor = Colors.unselectedGrayColor
        } else {
            cell.decepticonsImageView.backgroundColor = Colors.unselectedGrayColor
            cell.decepticonsName.textColor = Colors.unselectedGrayColor
        }
    }
}

// MARK: - Helper
extension FightViewController {
    func displayWinningTeam() {
        viewModel.setWinningTeam()
        winningTeamLabel.text = viewModel.winningTeamText
        autobotsBattleNumberLabel.text = "\(viewModel.autobotsWinningText)"
        decepticonsBattleNumberLabel.text = "\(viewModel.decepticonsWinningText)"
    }
}
