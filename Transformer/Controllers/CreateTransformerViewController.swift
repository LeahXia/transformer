//
//  CreateTransformerViewController.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-03.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import UIKit
import KWStepper

/// Handle creating or editing a Transformer
class CreateTransformerViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var autobotsButton: UIButton!
    
    @IBOutlet weak var decepticonsButton: UIButton!
    
    @IBOutlet weak var autobotsLabel: UILabel!
    
    @IBOutlet weak var decepticonsLabel: UILabel!
    
    @IBOutlet weak var transformerNameTextField: UITextField!
    
    @IBOutlet weak var attributePointsLabel: UILabel!
    
    var strengthStepper: KWStepper!

    // MARK: - Variables
    var transformer: Transformer?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Actions
    @IBAction func autobotsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func decepticonsButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
    
}
