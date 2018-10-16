//
//  SimulatorViewModel.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 15/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation

class SimulatorViewModel {
    var investment: String? {
        didSet {
            validateInput()
        }
    }
    var date: String? {
        didSet {
            validateInput()
        }
    }
    var porcent: String? {
        didSet {
            validateInput()
        }
    }
    var updateSimulateButtonState: ((Bool) -> Void)?
    var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
    var onShowResu: (() -> Void)?
    var showLoadingHud: Bindable = Bindable(false)
    var results: Bindable<ResultViewModel>
    private var validInputData: Bool = false {
        didSet {
            if oldValue != validInputData {
                updateSimulateButtonState?(validInputData)
            }
        }
    }
    init() {
        let reModel = ResultViewModel()
        self.results = Bindable(reModel)
    }
    func getResults(_ parame: String) {
        showLoadingHud.value = true
        API.get(Results.self, endpoint: .simulate(parame), success: { [weak self] (result) in
            print("getresult: \(result)")
            let resultsModel = ResultViewModel()
            resultsModel.resultsItem = result
            self?.results.value = resultsModel
            DispatchQueue.main.async {
                self?.onShowResu!()
            }
        }) { [weak self] (error) in
            let okAlert = SingleButtonAlert(
                title: error.localizedDescription,
                message: "Could not simulate.",
                action: AlertAction(buttonTitle: "OK", handler: { print("Ok pressed!") })
            )
            self?.onShowError?(okAlert)
        }
    }
    func validateInput() {
        let validData = [investment, date, porcent].filter {
            ($0?.count ?? 0) < 1
        }
        validInputData = validData.isEmpty ? true : false
    }
}
