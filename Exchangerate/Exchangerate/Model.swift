//
//  Model.swift
//  Exchangerate
//
//  Created by Edgar Sargsyan on 26.08.23.
//

import Foundation

struct Model: Codable {
    let success: Bool?
    let base, date: String?
    let rates: [String: Double]?
}
