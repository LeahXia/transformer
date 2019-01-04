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
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var autobotsButton: UIButton!
    
    @IBOutlet weak var decepticonsButton: UIButton!
    
    @IBOutlet weak var autobotsLabel: UILabel!
    
    @IBOutlet weak var decepticonsLabel: UILabel!
    
    @IBOutlet weak var transformerNameTextField: UITextField!
    
    @IBOutlet weak var viewModel: CreateTransformerViewModel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Spec views
    var steppers = [KWStepper]()
    var specNumberLabels = [UILabel]()
    var progressViews = [UIProgressView]()

    @IBOutlet weak var strengthNumberLabel: UILabel!
    
    @IBOutlet weak var strengthProgressView: UIProgressView!
    
    @IBOutlet weak var strengthIncreaseButton: UIButton!
    
    @IBOutlet weak var strengthDecreaseButton: UIButton!
    
    
    @IBOutlet weak var intelligenceNumberLabel: UILabel!
    
    @IBOutlet weak var intelligenceProgressView: UIProgressView!
    
    @IBOutlet weak var intelligenceIncreaseButton: UIButton!
    
    @IBOutlet weak var intelligenceDecreaseButton: UIButton!
    
    
    @IBOutlet weak var speedNumberLabel: UILabel!
    
    @IBOutlet weak var speedProgressView: UIProgressView!
    
    @IBOutlet weak var speedIncreaseButton: UIButton!
    
    @IBOutlet weak var speedDecreaseButton: UIButton!
    
    
    @IBOutlet weak var enduranceNumberLabel: UILabel!
    
    @IBOutlet weak var enduranceProgressView: UIProgressView!
    
    @IBOutlet weak var enduranceIncreaseButton: UIButton!
    
    @IBOutlet weak var enduranceDecreaseButton: UIButton!
    
    
    @IBOutlet weak var rankNumberLabel: UILabel!
    
    @IBOutlet weak var rankProgressView: UIProgressView!
    
    @IBOutlet weak var rankIncreaseButton: UIButton!
    
    @IBOutlet weak var rankDecreaseButton: UIButton!
    
    
    @IBOutlet weak var courageNumberLabel: UILabel!
    
    @IBOutlet weak var courageProgressView: UIProgressView!
    
    @IBOutlet weak var courageIncreaseButton: UIButton!
    
    @IBOutlet weak var courageDecreaseButton: UIButton!
    
    
    @IBOutlet weak var firepowerNumberLabel: UILabel!
    
    @IBOutlet weak var firepowerProgressView: UIProgressView!
    
    @IBOutlet weak var firepowerIncreaseButton: UIButton!
    
    @IBOutlet weak var firepowerDecreaseButton: UIButton!
    
    
    @IBOutlet weak var skillNumberLabel: UILabel!
    
    @IBOutlet weak var skillProgressView: UIProgressView!
    
    @IBOutlet weak var skillIncreaseButton: UIButton!
    
    @IBOutlet weak var skillDecreaseButton: UIButton!
    
    
    // MARK: - Variables
    var selectedTeamInitial: TeamInitial?

    var transformer: Transformer?
 
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFiledDelegate()
        setupSteppers()
        addKeyboardObserver()
        setTransformerInfoToView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - Actions
    @IBAction func autobotsButtonTapped(_ sender: Any) {
        changeSelectedTeam(to: .Autobots)
    }
    
    @IBAction func decepticonsButtonTapped(_ sender: Any) {
        changeSelectedTeam(to: .Decepticons)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        activityIndicator.startAnimating()
        // Editing
        if let transformer = transformer {
            viewModel.sendEditTransformerRequest(transformer: transformer, name: transformerNameTextField.text, teamInitial: selectedTeamInitial, specLabels: specNumberLabels) { [weak self] (errorMessage)  in
                self?.showErrorAlertOrDismissVCAfterSaving(errorMessage: errorMessage)
            }
        } else {
            // Creating
            viewModel.createTransformerAndSendRequest(name: transformerNameTextField.text, teamInitial: selectedTeamInitial, specLabels: specNumberLabels) { [weak self] (errorMessage) in
                self?.showErrorAlertOrDismissVCAfterSaving(errorMessage: errorMessage)
            }
        }
    }
    
    deinit {
        print("create vc deinit")
    }
    
}

// MARK: - TextField Delegate
extension CreateTransformerViewController: UITextFieldDelegate {
    func setupTextFiledDelegate() {
        transformerNameTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateTransformerName(name: string)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Handle Keyboard
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let textFieldTop = transformerNameTextField.frame.origin.y
        scrollView.contentOffset = CGPoint(x: 0, y: textFieldTop - 50)
    }
    
}


// MARK: - Helper
extension CreateTransformerViewController {

    func setupSteppers() {
        let decrementButtons = [strengthDecreaseButton, intelligenceDecreaseButton, speedDecreaseButton, enduranceDecreaseButton, rankDecreaseButton, courageDecreaseButton, firepowerDecreaseButton, skillDecreaseButton]
        let incrementButtons = [strengthIncreaseButton, intelligenceIncreaseButton, speedIncreaseButton, enduranceIncreaseButton, rankIncreaseButton, courageIncreaseButton, firepowerIncreaseButton, skillIncreaseButton]
        specNumberLabels = [strengthNumberLabel, intelligenceNumberLabel, speedNumberLabel, enduranceNumberLabel, rankNumberLabel, courageNumberLabel, firepowerNumberLabel, skillNumberLabel]
        progressViews = [strengthProgressView, intelligenceProgressView, speedProgressView, enduranceProgressView, rankProgressView, courageProgressView, firepowerProgressView, skillProgressView]
        
        let min = Double(TransformerSpecRange.min.rawValue)
        let max = Double(TransformerSpecRange.max.rawValue)
        
        for i in (0...decrementButtons.count - 1) {
            
            guard let decrementButton = decrementButtons[i], let incrementButton = incrementButtons[i] else {return}
            let stepper = KWStepper(decrementButton: decrementButton, incrementButton: incrementButton)
            
            steppers.append(stepper)
            
            stepper
                .wraps(false)
                .autoRepeat(false)
                .value(min)
                .minimumValue(min)
                .maximumValue(max)
                .stepValue(1)
                .valueChanged { [weak self] stepper in
                    self?.specNumberLabels[i].text = "\(Int(stepper.value))"
                    self?.progressViews[i].progress = Float(stepper.value / 10)
            }
        }
    }
    
    func changeSelectedTeam(to teamInitial: TeamInitial) {
        guard selectedTeamInitial != teamInitial else {return}
        
        selectedTeamInitial = teamInitial
        navigationItem.title = "\(teamInitial)"
        let unselectedColor = Colors.unselectedGrayColor
        
        switch teamInitial {
        case .Autobots:
            autobotsButton.tintColor = Colors.autobotsColor
            autobotsLabel.textColor = Colors.autobotsColor
            
            decepticonsButton.tintColor = unselectedColor
            decepticonsLabel.textColor = unselectedColor
            break
        case .Decepticons:
            decepticonsButton.tintColor = Colors.decepticonsColor
            decepticonsLabel.textColor = Colors.decepticonsColor
            
            autobotsButton.tintColor = unselectedColor
            autobotsLabel.textColor = unselectedColor
            break
        }
        
    }
    
    func validateTransformerName(name: String) {
        guard !name.isAlphanumericOrWhiteSpace() else {
            transformerNameTextField.layer.borderWidth = 0
            transformerNameTextField.layer.borderColor = UIColor.gray.cgColor
            return
        }
        transformerNameTextField.layer.borderWidth = 0.5
        transformerNameTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    func showErrorAlertOrDismissVCAfterSaving(errorMessage: String?) {
        activityIndicator.stopAnimating()
        guard errorMessage == nil else {
            showAlert(title: "Oops", message: errorMessage!)
            return
        }
        navigationController?.popViewController(animated: true)
    }
    
//    func handleSaveTransformer() {
//
//        do {
//            let transformer = try viewModel.createTransformer(name: transformerNameTextField.text, teamInitial: selectedTeamInitial, specLabels: specNumberLabels)
//
//            viewModel.sendCreateTransformerRequest(transformer: transformer) { [weak self] (errorMessage) in
//
//                guard errorMessage == nil else {
//                    self?.showAlert(title: "Oops", message: errorMessage!)
//                    return
//                }
//                self?.navigationController?.popViewController(animated: true)
//            }
//
//        } catch validationError.save (let (title, message)) {
//            showAlert(title: title, message: message)
//        } catch {
//            showAlert(title: "Oops", message: "\(error.localizedDescription)")
//        }
//    }
    
    // MARK: - Editing
    func setTransformerInfoToView() {
        guard let transformer = self.transformer else {return}
        // Team
        let initial = transformer.teamInitial == TeamInitial.Autobots.rawValue ? TeamInitial.Autobots : TeamInitial.Decepticons
        changeSelectedTeam(to: initial)
        self.selectedTeamInitial = initial
        // Name
        self.transformerNameTextField.text = transformer.name
        // Specs
        updateSpecViews()
    }
    
    func updateSpecViews() {
        guard let transformer = self.transformer else {return}
        let specNumArray = transformer.getSpecNumberArray()
        for (index, stepper) in steppers.enumerated() {
            let specInt = specNumArray[index]
            specNumberLabels[index].text = "\(specInt)"
            progressViews[index].progress = Float(specInt / 10)
            stepper.value = Double(specInt)
        }
 
    }
    
}
