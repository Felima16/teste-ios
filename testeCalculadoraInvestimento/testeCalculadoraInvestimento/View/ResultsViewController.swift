//
//  ResultsViewController.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 15/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    //IBOutlet
    @IBOutlet weak var resultValueLabel: UILabel!
    @IBOutlet weak var initValueLabel: UILabel!
    @IBOutlet weak var netProfitLabel: UILabel!
    @IBOutlet weak var grossValueLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var netValueLabel: UILabel!
    @IBOutlet weak var taxesValueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var monthlyGrossLabel: UILabel!
    @IBOutlet weak var porcentValueLabel: UILabel!
    @IBOutlet weak var annualGrossLabel: UILabel!
    @IBOutlet weak var rateProfitLabel: UILabel!
    @IBOutlet weak var simulateButton: UIButton!
    @IBAction func againActionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var viewModel: ResultViewModel = ResultViewModel()
    private func bindViewModel() {
        resultValueLabel?.text = "R$\(viewModel.resultsItem.grossAmount)"
        initValueLabel?.text = "R$\(viewModel.resultsItem.investmentParameter.investedAmount )"
        netProfitLabel?.text = "R$\(viewModel.resultsItem.netAmount )"
        grossValueLabel?.text = "R$\(viewModel.resultsItem.grossAmount )"
        valueLabel?.text = "R$\(viewModel.resultsItem.netAmount )"
        netValueLabel?.text = "R$\(viewModel.resultsItem.grossAmount )"
        taxesValueLabel?.text = "R$\(viewModel.resultsItem.taxesAmount) (\(viewModel.resultsItem.taxesRate)%)"
        let date = viewModel.resultsItem.investmentParameter.maturityDate.split(separator: "T")
        let dtm = date[0].split(separator: "-")
        dateLabel?.text = "\(dtm[2])/\(dtm[1])/\(dtm[0])"
        daysLabel?.text = "\(viewModel.resultsItem.investmentParameter.maturityTotalDays )"
        monthlyGrossLabel?.text = "\(viewModel.resultsItem.monthlyGrossRateProfit )%"
        porcentValueLabel?.text = "\(viewModel.resultsItem.investmentParameter.rate )%"
        annualGrossLabel?.text = "\(viewModel.resultsItem.annualNetRateProfit )%"
        rateProfitLabel?.text = "\(viewModel.resultsItem.rateProfit )%"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        simulateButton.layer.cornerRadius = min(simulateButton.frame.width, simulateButton.frame.height) / 2
    }
}
