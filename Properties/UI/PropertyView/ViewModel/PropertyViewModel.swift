//
//  PropertyViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-21.
//

import UIKit

/// Protocol specified to fulfill requirements of `PropertyView`.
protocol PropertyViewModel: ObservableObject, Identifiable {
    
    /// Instance ID.
    var id: String { get }
    
    /// Type of the property.
    var type: PropertyType { get }
    
    /// Formatted asking price for property.
    var askingPrice: String { get }
    
    /// Formatted municipality and area.
    var municipalityArea: String { get }
    
    /// Formatted area.
    var area: String { get }
    
    /// Formatted living area.
    var livingArea: String { get }
    
    /// Formatted number of rooms.
    var rooms: String { get }
    
    /// Formatted street address.
    var streetAddress: String { get }
    
    /// Fromatted rating.
    var ratingFormatted: String { get }
    
    /// Formatted average price.
    var averagePrice: String { get }
    
    /// Property image.
    var image: UIImage { get }
    
    /// Call to fetch property image.
    func fetchImage() async
}
