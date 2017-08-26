//
//  SettingsViewController.swift
//  GIPHYTags
//
//  Created by David S Reich on 11/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let unwindFromSettingsID = "unwindFromSettingsToMainView"

    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var apiURLTextView: UITextView!
    @IBOutlet weak var numberOfImagesStepper: UIStepper!
    @IBOutlet weak var numberOfImagesLabel: UILabel!
    @IBOutlet weak var numberOfLevelsStepper: UIStepper!
    @IBOutlet weak var numberOfLevelsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadSettings()
    }

    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    @IBAction func numberOfImagesStepperChanged(_ sender: UIStepper) {
        numberOfImagesLabel.text = String(Int(numberOfImagesStepper.value))
    }

    @IBAction func numberOfLevelsStepperChanged(_ sender: UIStepper) {
        numberOfLevelsLabel.text = String(Int(numberOfLevelsStepper.value))
    }

    private func updateControls() {
        self.navigationItem.title = "Settings"
        apiURLTextView.layer.borderWidth = 1
        apiURLTextView.layer.borderColor = UIColor.darkGray.cgColor
        apiURLTextView.layer.cornerRadius = 2
    }

    private func loadSettings() {
        tagsTextField.text = UserDefaultsManager.getInitialTags()
        apiURLTextView.text = UserDefaultsManager.getAPIURL()
        numberOfImagesStepper.value = Double(UserDefaultsManager.getMaxNumberOfImages())
        numberOfImagesLabel.text = String(Int(numberOfImagesStepper.value))
        numberOfLevelsStepper.value = Double(UserDefaultsManager.getMaxNumberOfLevels())
        numberOfLevelsLabel.text = String(Int(numberOfLevelsStepper.value))
    }

    private func saveSettings() {
        UserDefaultsManager.setInitialTags(initialTags: tagsTextField.text)
        UserDefaultsManager.setAPIURL(apiUrl: apiURLTextView.text)
        UserDefaultsManager.setMaxNumberOfImages(maxNumber: Int(numberOfImagesStepper.value))
        UserDefaultsManager.setMaxNumberOfLevels(maxNumber: Int(numberOfLevelsStepper.value))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == unwindFromSettingsID {
            //this means Apply was pressed - we don't want to save on Cancel or Back
            saveSettings()
        }
    }

}
