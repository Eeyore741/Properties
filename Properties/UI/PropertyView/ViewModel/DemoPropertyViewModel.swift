//
//  DemoPropertyViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-25.
//

import UIKit

/// Demo type designed to conform to `PropertyViewModel` for demo & preview purposes.
final class DemoPropertyViewModel: PropertyViewModel {
    
    var id: String { "demo" }
    var type: PropertyType { .plain }
    var area: String { "Stockholm" }
    var askingPrice: String { "2 650 000 SEK" }
    var municipalityArea: String { "Heden, Gallvare kommun" }
    var livingArea: String { "120 m²" }
    var rooms: String { "5 rooms" }
    var streetAddress: String { "Mockvagen 1" }
    var averagePrice: String { "50 100 SEK" }
    var ratingFormatted: String { "4.5/5" }
    
    @Published
    var image: UIImage
    
    private let fetchTimeoutInSec: Double
    
    @MainActor
    func fetchImage() async {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
        self.image = UIImage.demoProperty
    }
    
    init(fetchTimeoutInSec: Double = 1.5) {
        self.image = UIImage.demoPlaceholder
        self.fetchTimeoutInSec = fetchTimeoutInSec
    }
}
