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
    @IBOutlet weak var winningTeamLabel: UILabel!
    
    @IBOutlet weak var battleNumberView: UIView!
    
    @IBOutlet weak var autobotsBattleNumberLabel: UILabel!
    
    @IBOutlet weak var decepticonsBattleNumberLabel: UILabel!
    
    @IBOutlet weak var battleCollectionView: UICollectionView!
    
    // MARK: - Variables
    let fightCellId = "fightCellId"
    var teams: [Team]?

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
}


extension FightViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fightCellId, for: indexPath)
        return cell
    }
    
    
}
