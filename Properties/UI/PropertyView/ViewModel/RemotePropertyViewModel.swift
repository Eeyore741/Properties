//
//  RemotePropertyViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-26.
//

import UIKit

/// Type designed to conform to `PropertyViewModel` for production purposes.
final class RemotePropertyViewModel {
    
    @Published
    var image: UIImage
    
    // DI
    private let property: Property
    private let imageProvider: ImageProvider
    private let placeholderImage: UIImage
    private let errorImage: UIImage
    
    init(property: Property, placeholderImage: UIImage, errorImage: UIImage, imageProvider: ImageProvider) {
        self.property = property
        self.placeholderImage = placeholderImage
        self.errorImage = errorImage
        self.imageProvider = imageProvider
        self.image = placeholderImage
    }
}

// MARK: Private accessories
private extension RemotePropertyViewModel {
    
    static let currencyFormatter: NumberFormatter = {
        // Formatting here being setup customly only to satisfy appearnce required in task.
        // Sure `currencyCode` better be provided within data model and `locale` being set according to device code runs on.
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .init(identifier: "de_BE")
        formatter.maximumFractionDigits = 0
        formatter.currencyGroupingSeparator = " "
        formatter.currencyCode = "SEK"
        
        return formatter
    }()
    
    static let livingAreaFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        
        return formatter
    }()
    
    static let roomsFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
}

// MARK: `PropertyViewModel` conformance
extension RemotePropertyViewModel: PropertyViewModel {
    
    var id: String { self.property.id }
    var type: PropertyType { self.property.type }
    var area: String { self.property.area }
    var streetAddress: String { self.property.streetAddress ?? String() }
    
    var rooms: String {
        switch self.property.numberOfRooms {
        case .some(let numberOfRooms):
            let number = NSNumber(value: numberOfRooms)
            let formattedNumber = Self.roomsFormatter.string(from: number) ?? String()
            return formattedNumber + " rooms"
        case .none:
            return String()
        }
    }
    
    var livingArea: String {
        switch self.property.livingArea {
        case .some(let area):
            let measurement = Measurement(value: area, unit: UnitArea.squareMeters)
            return Self.livingAreaFormatter.string(from: measurement)
        case .none:
            return String()
        }
    }
    
    var municipalityArea: String {
        switch self.property.municipality {
        case .some(let municipality):
            return "\(self.property.area), \(municipality)"
        case .none:
            return self.property.area
        }
    }
    
    var askingPrice: String {
        guard let askingPrice = self.property.askingPrice else { return String() }
        
        let number = NSNumber(value: askingPrice)
        return Self.currencyFormatter.string(from: number) ?? String()
    }
    
    var averagePrice: String {
        guard let averagePrice = self.property.averagePrice else { return String() }
        
        let number = NSNumber(value: averagePrice)
        return "Average price: \(Self.currencyFormatter.string(from: number) ?? String())"
    }
    
    var ratingFormatted: String {
        "Rating: \(self.property.ratingFormatted ?? String())"
    }
    
    @MainActor
    func fetchImage() async {
        let image = await self.imageProvider.getImageWithURL(self.property.imageURL)
        
        self.image = image ?? self.errorImage
    }
}
