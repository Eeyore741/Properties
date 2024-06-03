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
    
    private var fetchedImage: UIImage? {
        didSet {
            if let fetchedImage {
                self.image = fetchedImage
            } else {
                self.image = self.errorImage
            }
        }
    }
    
    init(property: Property, placeholderImage: UIImage, errorImage: UIImage, imageProvider: ImageProvider) {
        self.property = property
        self.placeholderImage = placeholderImage
        self.errorImage = errorImage
        self.imageProvider = imageProvider
        self.image = placeholderImage
    }
}

// MARK: Private accessories.
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
}

// MARK: `PropertyViewModel` conformance.
extension RemotePropertyViewModel: PropertyViewModel {
    
    var id: String { self.property.id }
    var type: PropertyType { self.property.type }
    var area: String { self.property.area }
    var streetAddress: String { self.property.streetAddress ?? String() }
    
    var rooms: LocalizedStringResource {
        switch self.property.numberOfRooms {
        case .some(let numberOfRooms):
            let number = NSNumber(value: numberOfRooms)
            
            return LocalizedStringResource("\(number.intValue) rooms")
        case .none:
            
            return LocalizedStringResource(stringLiteral: String())
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
    
    var averagePrice: LocalizedStringResource {
        guard let averagePrice = self.property.averagePrice else { return LocalizedStringResource(stringLiteral: String()) }
        let number = NSNumber(value: averagePrice)
        let price = Self.currencyFormatter.string(from: number) ?? String()
        
        return LocalizedStringResource("\(price) average price")
    }
    
    var ratingFormatted: LocalizedStringResource {
        LocalizedStringResource("\(self.property.ratingFormatted ?? String()) rating")
    }
    
    @MainActor
    func fetchImage() async {
        guard case .none = self.fetchedImage else { return }
        
        let image = await self.imageProvider.getImageWithURL(self.property.imageURL)
        self.fetchedImage = image
    }
}
