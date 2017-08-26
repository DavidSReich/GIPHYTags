//
//  SelectorViewController.swift
//  GIPHYTags
//
//  Created by David S Reich on 11/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

protocol SelectorViewDelegate {
    func gotToSelection()
}

class SelectorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    //point one of the spacer controls to the unwind segue so that it is created and we can programmatically invoke it!!

    private let unwindToMainViewSegue = "unwindFromSelectorToMainView"
    fileprivate let selectableTableViewCellID = "SelectableTableViewCell"
    fileprivate var pickerData = [(String, Bool)]()
    private var delegate: SelectorViewDelegate?
    private var titleStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        titleLabel.text = titleStr
    }

    @IBAction func goButtonTouched(_ sender: UIBarButtonItem) {
        //do this programmatically here because we need to call goToSelection AFTER performSegue returns.
        performSegue(withIdentifier: unwindToMainViewSegue, sender: nil)
        if delegate != nil {
            delegate?.gotToSelection()
        }
    }

    @IBAction func cancelButtonTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func setupSelectorView(titleStr: String, pickerData: [String], selectedTags: String, delegate: SelectorViewDelegate) {
        self.titleStr = titleStr
        self.pickerData = pickerData.map {($0, selectedTags.contains($0))}
        self.delegate = delegate
    }

    func getSelectionPicked() -> [String] {
        var selectedTags = [String]()

        for (tagString, selected) in pickerData {
            if selected {
                selectedTags.append(tagString)
            }
        }

        return selectedTags
    }

}

//keep all this code in here ... this is just a picker.  It should be self-contained.
extension SelectorViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: selectableTableViewCellID) as? SelectableTableViewCell else {
            return UITableViewCell()
        }

        guard indexPath.row < pickerData.count else { return cell }
        let (titleStr, isSelected) = pickerData[indexPath.row]
        cell.setupCell(title: titleStr, selected: isSelected)

        if isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pick some tags!"
    }
}

extension SelectorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < pickerData.count else { return }
        pickerData[indexPath.row].1 = true
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard indexPath.row < pickerData.count else { return }
        pickerData[indexPath.row].1 = false
    }

//    func setSelected(_ tableView: UITableView, changeRowAt indexPath: IndexPath, selected: Bool) {
//        guard indexPath.row < pickerData.count else { return }
//        pickerData[indexPath.row].1 = selected
//        if selected {
//            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//        } else {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//    }
}

