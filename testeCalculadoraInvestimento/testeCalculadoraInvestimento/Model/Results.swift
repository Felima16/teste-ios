//
//  Results.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 15/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation

struct Results: Codable {
    var investmentParameter: InvestimentParamenter = InvestimentParamenter()
    var grossAmount: Double = 0.0
    var taxesAmount: Double = 0.0
    var netAmount: Double = 0.0
    var grossAmountProfit: Double = 0.0
    var netAmountProfit: Double = 0.0
    var annualGrossRateProfit: Double = 0.0
    var monthlyGrossRateProfit: Double = 0.0
    var dailyGrossRateProfit: Double = 0.0
    var taxesRate: Double = 0.0
    var rateProfit: Double = 0.0
    var annualNetRateProfit: Double = 0.0
}

struct InvestimentParamenter: Codable {
    var investedAmount: Double = 0.0
    var yearlyInterestRate: Double = 0.0
    var maturityTotalDays: Int = 0
    var maturityBusinessDays: Int = 0
    var maturityDate: String = ""
    var rate: Double = 0.0
    var isTaxFree: Bool = false
}
