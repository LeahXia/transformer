//
//  TransformerListCollectionViewCell.swift
//  Transformer
//
//  Created by Leah Xia on 2018-12-26.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit

/// Display information of a Transformer
final class TransformerListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImageView: UIImageView!

    @IBOutlet weak var transformerNameLabel: UILabel!
    
    @IBOutlet weak var strengthValueLabel: UILabel!
    
    @IBOutlet weak var intelligenceValueLabel: UILabel!
    
    @IBOutlet weak var speedValueLabel: UILabel!
    
    @IBOutlet weak var enduranceValueLabel: UILabel!
    
    @IBOutlet weak var rankValueLabel: UILabel!

    @IBOutlet weak var courageValueLabel: UILabel!

    @IBOutlet weak var firepowerValueLabel: UILabel!

    @IBOutlet weak var skillValueLabel: UILabel!

    @IBOutlet weak var deleteButton: UIButton!
    
    
}
