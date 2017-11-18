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

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var applyButton: UIBarButtonItem!
    @IBOutlet weak var getGIPHYKeyButton: UIButton!

    @IBOutlet weak var giphyAPIKeyTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var numberOfImagesStepper: UIStepper!
    @IBOutlet weak var numberOfImagesLabel: UILabel!
    @IBOutlet weak var numberOfLevelsStepper: UIStepper!
    @IBOutlet weak var numberOfLevelsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadSettings()
    }

    @IBAction func backButtonTouched(_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    @IBAction func getGIPHYKeyButtonTouched(_ sender: UIButton) {
    }

    @IBAction func numberOfImagesStepperChanged(_ sender: UIStepper) {
        numberOfImagesLabel.text = String(Int(numberOfImagesStepper.value))
    }

    @IBAction func numberOfLevelsStepperChanged(_ sender: UIStepper) {
        numberOfLevelsLabel.text = String(Int(numberOfLevelsStepper.value))
    }

    @IBAction func giphyAPIKeyTextFieldChanged(_ sender: UITextField) {
        applyButton.isEnabled = !getGiphyAPIKeyString().isEmpty
    }

//    @IBAction func gotoGIPHY(_ sender: UIButton) {
//giphy.com/login
//        guard let url = URL(string: "http://www.google.com") else {
//            return
//        }
//
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    }

    private func updateControls() {
        self.navigationItem.title = "Settings"
        backButton.isEnabled = !UserDefaultsManager.GIPHYApiKey.isEmpty
        applyButton.isEnabled = !getGiphyAPIKeyString().isEmpty
    }

    private func loadSettings() {
        giphyAPIKeyTextField.text = UserDefaultsManager.GIPHYApiKey
        tagsTextField.text = UserDefaultsManager.getInitialTags()
        numberOfImagesStepper.value = Double(UserDefaultsManager.getMaxNumberOfImages())
        numberOfImagesLabel.text = String(Int(numberOfImagesStepper.value))
        numberOfLevelsStepper.value = Double(UserDefaultsManager.getMaxNumberOfLevels())
        numberOfLevelsLabel.text = String(Int(numberOfLevelsStepper.value))
    }

    private func getGiphyAPIKeyString() -> String {
        guard let giphyApiKey = giphyAPIKeyTextField.text else {
            return ""
        }

        return giphyApiKey
    }

    private func saveSettings() -> Bool {
        let giphyApiKey = getGiphyAPIKeyString()
        guard !giphyApiKey.isEmpty else {
            return false
        }

        UserDefaultsManager.GIPHYApiKey = giphyApiKey
        UserDefaultsManager.setInitialTags(initialTags: tagsTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
        UserDefaultsManager.setMaxNumberOfImages(maxNumber: Int(numberOfImagesStepper.value))
        UserDefaultsManager.setMaxNumberOfLevels(maxNumber: Int(numberOfLevelsStepper.value))

        return true
    }

}

//seguesSeguesSegues
extension SettingsViewController {

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == unwindFromSettingsID {
            //this means Apply was pressed - so save - we don't want to save if Back was pressed
            return saveSettings()
        }

        return true
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == unwindFromSettingsID {
//            //this means Apply was pressed - so save - we don't want to save if Back was pressed
//            saveSettings()
//        }
//    }
}

