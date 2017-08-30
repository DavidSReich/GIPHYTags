//
//  MainViewController.swift
//  GIPHYTags
//
//  Created by David S Reich on 7/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imagesTableView: UITableView!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!

    fileprivate let selectorSegueID = "SelectorPopoverSegue"
    fileprivate let mainViewSegueID = "MainViewControllerSegue"
    fileprivate let settingsSegueID = "SettingsViewControllerSegue"

    fileprivate let dataManager = DataManager()
    private var viewManager: ViewManager?

    fileprivate var viewControllerLevel = 0
    fileprivate var imageTags = UserDefaultsManager.getInitialTags()
    fileprivate var selectedTags = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        viewManager = ViewManager(dataManagerDelegate: dataManager)
        imagesTableView.dataSource = viewManager
        imagesTableView.delegate = viewManager

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        imagesTableView.refreshControl = refreshControl

        updateControls()
        loadEverything()
    }

    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        loadEverything()
        refreshControl.endRefreshing()
    }

    @IBAction func backButtonTouched(_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    fileprivate func setState(viewControllerLevel: Int, imageTags: String) {
        self.viewControllerLevel = viewControllerLevel
        self.imageTags = imageTags
        updateControls()
    }

    private func updateControls() {
        if viewControllerLevel == 0 {
            titleLabel.text = "Starting Images"
            backButton.title = "Settings"
            rightButton.title = "Pick tags"
        } else if viewControllerLevel < UserDefaultsManager.getMaxNumberOfLevels() {
            titleLabel.text = imageTags
            backButton.title = "Back"
            rightButton.title = "Pick tags"
        } else {
            titleLabel.text = imageTags
            backButton.title = "Back"
            rightButton.title = "Start"
        }
    }

    fileprivate func loadEverything() {
        //clear and then reloadData with empty in case populateDataSource fails - if it fails it won't call any of the completion callbacks.
        dataManager.clearDataSource()
        imagesTableView.reloadData()
        dataManager.populateDataSource(tagsString: imageTags) {
            self.imagesTableView.reloadData()
        }
    }
}

//seguesSeguesSegues
extension MainViewController {

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == selectorSegueID {
            //RIGHT NAV BUTTON
            //if the user tapped the Start button then we want to go back to the top AND not segue.
            //we cannot use an unwind segue to skip to the root (unless we create it at run-time)
            //because in the storyboard there's only one MainViewController
            //This isn't that complicated.  There isn't enough code here to be complicated or tricky.
            if rightButton.title == "Start" {
                if let navController = self.navigationController {
                    navController.popToRootViewController(animated: true)
                }

                return false
            }
        } else if identifier == settingsSegueID {
            //LEFT NAV BUTTON
            //If the user tapped the Back button then don't segue, instead just pop back one level
            //If the user tapped the Settings button then we do want to segue to the Settings VC.
            //This isn't that complicated either.  There isn't enough code here to be complicated or tricky.
            if backButton.title == "Back" {
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
                return false
            }
        }

        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == selectorSegueID {
            //the selector VC needs a list of tags to display.
            if let selectorViewController = segue.destination as? SelectorViewController {
                let names = dataManager.getTagsArray()
                selectorViewController.setupSelectorView(titleStr: "Pick a tag or two!", pickerData: names, selectedTags: selectedTags, delegate: self)
            }
        } else if segue.identifier == mainViewSegueID {
            //Here's where we're going forward to another instance of the MainVC.
            //We need to give it the next state and whatever's been selected in the selector VC(s)
            if let MainViewController = segue.destination as? MainViewController {
                MainViewController.setState(viewControllerLevel: self.viewControllerLevel + 1, imageTags: selectedTags)
            }
        }
    }

    @IBAction func unwindFromSelectorToMainView(segue: UIStoryboardSegue) {
        if let selectorViewController = segue.source as? SelectorViewController {
            //Coming back from the Selector VC - get whatever was selected
            let selectedTags = selectorViewController.getSelectionPicked()
            self.selectedTags = selectedTags.joined(separator: UserDefaultsManager.tagsSeparator)
        }
    }

    @IBAction func unwindFromSettingsToMainView(segue: UIStoryboardSegue) {
        if segue.source is SettingsViewController {
            //Coming back from Apply in Settings
            imageTags = UserDefaultsManager.getInitialTags()
            loadEverything()
        }
    }
}

extension MainViewController: SelectorViewDelegate {
    //AFTER the Selector VC unwind segue is done (see above)
    //The Selector VC then needs to tell this VC to go to the next VC
    //and filter by the selection(s)
    func gotToSelection() {
        performSegue(withIdentifier: mainViewSegueID, sender: nil)
    }
}

