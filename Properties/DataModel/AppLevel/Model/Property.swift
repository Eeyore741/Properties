//
//  Property.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import Foundation

/// Type wrapping property attributes.
struct Property {
    let id: String
    let type: PropertyType
    let askingPrice: UInt?
    let monthlyFee: UInt?
    let municipality: String?
    let area: String
    let daysSincePublish: UInt?
    let livingArea: Double?
    let numberOfRooms: Double?
    let streetAddress: String?
    let imageURL: URL
    let ratingFormatted: String?
    let averagePrice: Double?
    let description: String?
    let patio: String?
}

extension Property: Decodable { }
