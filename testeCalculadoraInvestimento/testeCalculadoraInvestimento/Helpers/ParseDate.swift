//
//  ParseDate.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 16/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

class ParseDate: NSObject {
    class func convertDateGet(_ date: String) -> String {
        let dtSplit = date.split(separator: "/")
        return "\(dtSplit[2])-\(dtSplit[1])-\(dtSplit[0])"
    }
}
