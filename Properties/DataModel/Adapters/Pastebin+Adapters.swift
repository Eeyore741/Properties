//
//  Pastebin+Adapters.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-20.
//

import Foundation

/// Adapter extension binding App models with Pastebin domain models.
extension Property {
    
    init?(from item: PastebinPropertyItem) {
        guard let imageURL = URL(string: item.image) else { return nil }
        self.id = item.id
        self.type = .init(from: item.type)
        self.imageURL = imageURL
        self.area = item.area
        self.askingPrice = item.askingPrice
        self.monthlyFee = item.monthlyFee
        self.municipality = item.municipality
        self.daysSincePublish = item.daysSincePublish
        self.livingArea = item.livingArea
        self.numberOfRooms = item.numberOfRooms
        self.streetAddress = item.streetAddress
        self.ratingFormatted = item.ratingFormatted
        self.averagePrice = item.averagePrice
        self.description = item.description
        self.patio = item.patio
    }
}

extension PropertyType {
    
    init(from pastebinPropertyType: PastebinPropertyItemType) {
        switch pastebinPropertyType {
        case .Property:
            self = .plain
        case .HighlightedProperty:
            self = .highlighted
        case .Area:
            self = .area
        }
    }
}
