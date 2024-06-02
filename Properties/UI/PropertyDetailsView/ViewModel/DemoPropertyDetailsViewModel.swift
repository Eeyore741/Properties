//
//  DemoPropertyDetailsViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-27.
//

import UIKit

/// Demo type designed to conform to `PropertyDetailsViewModel` for demo & preview purposes.
final class DemoPropertyDetailsViewModel: PropertyDetailsViewModel {
    
    @Published
    var state: PropertyDetailsViewModelState = .loading
    
    @Published
    var image: UIImage = UIImage.demoPlaceholder
    
    var streetAddress: String { "Mockvägen 1" }
    
    var municipalityArea: String { "Heden, Gällivare kommun" }
    
    var askingPrice: String { "2 650 000 SEK" }
    
    var description: String { "The living room can be furnished according to your own wishes and tastes, here the whole family can gather and enjoy each other's company. From the living room you reach the terrace overlooking the lush courtyard which is located in undisturbed and secluded location." }
    
    var localizedLivingAreaHeader: String { "Living area:" }
    
    var livingAreaValue: String { "120m2" }
    
    var localizedNumberOfRoomsHeader: String { "Number of rooms: " }
    
    var numberOfRoomsValue: String { "5" }
    
    var localizedPatioHeader: String { "Patio: " }
    
    var patioValue: String { "Yes" }
    
    var localizedDaysSincePublishHeader: String { "Days since publish: " }
    
    var daysSincePublishValue: String { "1" }
    
    var localizedErrorMessage: String { "Loading error" }
    
    @MainActor
    func fetchProperty() async {
        try? await Task.sleep(for: .seconds(2))
        
        self.state = .presenting
        await self.fetchImage()
    }
}

// MARK: Private accessories.
private extension DemoPropertyDetailsViewModel {
    
    @MainActor
    func fetchImage() async {
        try? await Task.sleep(for: .seconds(2))
        
        self.image = UIImage.demoProperty
    }
}
