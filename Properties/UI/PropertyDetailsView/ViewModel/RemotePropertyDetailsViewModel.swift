//
//  RemotePropertyDetailsViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-27.
//

import UIKit

/// Type designed to conform to `PropertyDetailsViewModel` for production purposes.
final class RemotePropertyDetailsViewModel {
    
    @Published
    var state: PropertyDetailsViewModelState = .loading
    
    @Published
    var image: UIImage
    
    // DI
    private let propertiesProvider: PropertiesProvider
    private let imageProvider: ImageProvider
    private let placeholderImage: UIImage
    private let errorImage: UIImage
    private let propertyID: String
    private var property: Property? = nil
    
    init(propertyID: String, propertiesProvider: PropertiesProvider, imageProvider: ImageProvider, placeholderImage: UIImage, errorImage: UIImage) {
        self.propertyID = propertyID
        self.propertiesProvider = propertiesProvider
        self.imageProvider = imageProvider
        self.placeholderImage = placeholderImage
        self.errorImage = errorImage
        self.image = placeholderImage
    }
}

// MARK: Private accessories
private extension RemotePropertyDetailsViewModel {
    
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
    
    @MainActor
    func fetchImage() async {
        guard let property = self.property else { return self.image = self.placeholderImage}
        
        if let image = await self.imageProvider.getImageWithURL(property.imageURL) {
            self.image = image
        } else {
            self.image = self.errorImage
        }
    }
}

// MARK: `PropertyDetailsViewModel` conformance
extension RemotePropertyDetailsViewModel: PropertyDetailsViewModel {
    
    var streetAddress: String { self.property?.streetAddress ?? String() }
    
    var municipalityArea: String {
        guard let area = self.property?.area else { return String() }
        
        switch self.property?.municipality {
        case .some(let municipality):
            return "\(area), \(municipality)"
        case .none:
            return area
        }
    }
    
    var askingPrice: String {
        guard let askingPrice = self.property?.askingPrice else { return String() }
        
        let number = NSNumber(value: askingPrice)
        return Self.currencyFormatter.string(from: number) ?? String()
    }
    
    var description: String { self.property?.description ?? String() }
    
    var localizedLivingAreaHeader: String { "Living area:" }
    
    var livingAreaValue: String {
        guard let property = self.property else { return String() }
        
        switch property.livingArea {
        case .some(let area):
            let measurement = Measurement(value: area, unit: UnitArea.squareMeters)
            return Self.livingAreaFormatter.string(from: measurement)
        case .none:
            return String()
        }
    }
    
    var localizedNumberOfRoomsHeader: String { "Number of rooms: " }
    
    var numberOfRoomsValue: String {
        guard let property = self.property else { return String() }
        
        switch property.numberOfRooms {
        case .some(let numberOfRooms):
            let number = NSNumber(value: numberOfRooms)
            let formattedNumber = Self.roomsFormatter.string(from: number) ?? String()
            return formattedNumber
        case .none:
            return String()
        }
    }
    
    var localizedPatioHeader: String { "Patio: " }
    
    var patioValue: String { self.property?.patio ?? String() }
    
    var localizedDaysSincePublishHeader: String { "Days since publish: " }
    
    var daysSincePublishValue: String { "\(self.property?.daysSincePublish ?? 0)"  }
    
    var localizedErrorMessage: String { "Loading error" }
    
    @MainActor
    func fetchProperty() async {
        let result = await self.propertiesProvider.getPropertyWithID(self.propertyID)
        
        switch result {
        case .success(let property):
            self.property = property
            self.state = .presenting
            await self.fetchImage()
        case .failure(_):
            self.property = nil
            self.state = .error
        }
    }
}
