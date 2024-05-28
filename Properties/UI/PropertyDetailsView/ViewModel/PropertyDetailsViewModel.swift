//
//  PropertyDetailsViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-27.
//

import UIKit

/// Protocol specified to fulfill requirements of `PropertyDetailsView`.
protocol PropertyDetailsViewModel: ObservableObject {
    
    var state: PropertyDetailsViewModelState { get }
    
    /// Value defines current state of view model.
    var image: UIImage { get }
    
    /// Formatted street address.
    var streetAddress: String { get }
    
    /// Formatted municipality and area.
    var municipalityArea: String { get }
    
    /// Formatted asking price.
    var askingPrice: String { get }
    
    /// Description.
    var description: String { get }
    
    /// Living area static header, usually to be localized.
    var localizedLivingAreaHeader: String { get }
    
    /// Living area value.
    var livingAreaValue: String { get }
    
    /// Number of rooms static header, usually to be localized.
    var localizedNumberOfRoomsHeader: String { get }
    
    /// Number of rooms value.
    var numberOfRoomsValue: String { get }
    
    /// Patio access static header, usually to be localized.
    var localizedPatioHeader: String { get }
    
    /// Patio access value.
    var patioValue: String { get }
    
    /// Days since property was published static header, usually to be localized.
    var localizedDaysSincePublishHeader: String { get }
    
    /// Days since property was published value.
    var daysSincePublishValue: String { get }
    
    /// Displayed error message on fetch error.
    var localizedErrorMessage: String { get }
    
    /// Function expected to be called on UI display.
    func fetchProperty() async
}

/// Type describes possible UI states for `PropertyDetailsViewModel`
enum PropertyDetailsViewModelState {
    
    /// `Property` being displayed
    case presenting
    
    /// `Property` being fetched
    case loading
    
    /// `Property` fetch finished with error
    case error
}
