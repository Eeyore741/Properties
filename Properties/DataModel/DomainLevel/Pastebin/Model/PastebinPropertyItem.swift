//
//  PastebinPropertyItem.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import Foundation

/// Type wrapping property attributes provided by Pastebin source.
struct PastebinPropertyItem {
    let type: PastebinPropertyItemType
    let id: String
    let askingPrice: UInt?
    let monthlyFee: UInt?
    let municipality: String?
    let area: String
    let ratingFormatted: String?
    let averagePrice: Double?
    let daysSincePublish: UInt?
    let livingArea: Double?
    let numberOfRooms: Double?
    let streetAddress: String?
    let image: String
    let description: String?
    let patio: String?
}

extension PastebinPropertyItem: Decodable { }
