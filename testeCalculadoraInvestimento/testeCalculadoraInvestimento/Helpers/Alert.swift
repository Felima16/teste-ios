//
//  Alert.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 15/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//
import UIKit

struct AlertAction {
    let buttonTitle: String
    let handler: (() -> Void)?
}

struct SingleButtonAlert {
    let title: String
    let message: String?
    let action: AlertAction
}
