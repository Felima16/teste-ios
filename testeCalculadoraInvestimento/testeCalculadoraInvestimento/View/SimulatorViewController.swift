//
//  ViewController.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 10/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit
import PKHUD

class SimulatorViewController: UIViewController {
    //IBOutlets
    @IBOutlet weak var investmentTextField: UITextField! {
        didSet {
            investmentTextField.delegate = self
            investmentTextField.addTarget(self, action: #selector(investmentTextFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var dateTextField: UITextField! {
        didSet {
            dateTextField.delegate = self
            dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var porcentTextField: UITextField! {
        didSet {
            porcentTextField.delegate = self
            porcentTextField.addTarget(self, action: #selector(porcentTextFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var simulateButton: UIButton!
    @IBAction func simulateActionButton(_ sender: Any) {
        bindViewModel()
        let date = ParseDate.convertDateGet(dateTextField.text!)
        let inv = investmentTextField.text!.replacingOccurrences(of: "R$", with: "")
        let por = porcentTextField.text!.replacingOccurrences(of: "%", with: "")
        let param = "investedAmount=\(inv)&index=CDI&rate=\(por)&isTaxFree=false&maturityDate=\(date)"
        viewModel.getResults(param)
    }
    var viewModel: SimulatorViewModel = SimulatorViewModel()
    fileprivate var activeTextField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        simulateButton.layer.cornerRadius = min(simulateButton.frame.width, simulateButton.frame.height) / 2
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.showLoadingHud.value = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard activeTextField != nil else { return }
        activeTextField?.resignFirstResponder()
        activeTextField = nil
    }
    //(MARK) text field masking
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //(MARK) If Delete button click
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if isBackSpace == -92 {
            textField.text!.removeLast()
            return false
        }
        if textField == investmentTextField {
            if (textField.text?.count)! == 0 {
                textField.text = "R$\(string)"
                return false
            }
        }
        if textField == dateTextField {
            if ((textField.text?.count)! == 2) || ((textField.text?.count)! == 5) {
                textField.text = "\(textField.text!)/\(string)"
                return false
            } else if (textField.text?.count)! > 9 {
                return false
            }
        }
        if textField == porcentTextField {
            if (textField.text?.count)! > 0 {
                let txt = textField.text?.split(separator: "%")
                textField.text = "\(txt![0])\(string)%"
                return false
            }
        }
        return true
    }
    @objc
    func investmentTextFieldDidChange(textField: UITextField) {
        viewModel.investment = textField.text ?? ""
        verifyButton()
    }
    @objc
    func dateTextFieldDidChange(textField: UITextField) {
        viewModel.date = textField.text ?? ""
        verifyButton()
    }
    @objc
    func porcentTextFieldDidChange(textField: UITextField) {
        viewModel.porcent = textField.text ?? ""
        verifyButton()
    }
    func bindViewModel() {
        viewModel.onShowResu = { [weak self] in
            let resultsVC = self?.storyboard?.instantiateViewController(withIdentifier: "ResultsViewControllerID")
            if let resultsVC = resultsVC as? ResultsViewController {
                resultsVC.viewModel = (self?.viewModel.results.value)!
                self?.present(resultsVC, animated: true, completion: nil)
            }
        }
        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        viewModel.showLoadingHud.bind { [weak self] visible in
            if let `self` = self {
                PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
            }
        }
    }
    func verifyButton() {
        viewModel.updateSimulateButtonState = { [weak self] state in
            self?.simulateButton.isEnabled = state
            self?.simulateButton.backgroundColor = state ? UIColor.green : UIColor.gray
        }
    }
}
// MARK: - UITextFieldDelegate
extension SimulatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
extension SimulatorViewController: SingleButtonDialogPresenter { }
