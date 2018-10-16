//
//  API.swift
//  testeCalculadoraInvestimento
//
//  Created by Fernanda de Lima on 15/10/18.
//  Copyright © 2018 FeLima. All rights reserved.
//

import Foundation

enum Endpoint {
    case simulate(String)
    func pathEndpoint() -> String {
        switch self {
        case .simulate(let parameters):
            return parameters
        }
    }
}

class API {
    static let baseUrl = "https://api-simulator-calc.easynvest.com.br/calculator/simulate?"
    static func get <T: Any>
        (_ type: T.Type,
         endpoint: Endpoint,
         success:@escaping (_ item: T) -> Void,
         fail:@escaping (_ error: Error) -> Void) where T: Decodable {
        let url = "\(baseUrl)\(endpoint.pathEndpoint())"
        print("===>url: \(url)")
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //create session to connection
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                //verify response
                if let httpResponse = response as? HTTPURLResponse {
                    print("===>code response: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 { //it's ok
                        //verify if have response data
                        if let data = data {
                            let jsonDecoder = JSONDecoder()
                            let jsonArray = try jsonDecoder.decode(type.self, from: data)
                            success(jsonArray)
                        }
                    }
                }
            } catch {
                fail(error)
            }
        })
        task.resume()
    }
}
