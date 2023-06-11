//
//  NetworkProtocol.swift
//  Foozy
//
//  Created by Jeff Deng on 5/24/23.
//

import Foundation

protocol NetworkProtocol {
    func performRestRequest(with url: String, with card: Card)
    func parseJson(with data: Data) -> [Card]?
}
