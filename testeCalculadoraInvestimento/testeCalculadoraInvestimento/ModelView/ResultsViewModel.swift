//
//  ResultsViewModel.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 15/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

protocol ResultsViewModel {
    var resultsItem: Results { get }
}
final class ResultViewModel: ResultsViewModel {
    var resultsItem: Results = Results()
}
