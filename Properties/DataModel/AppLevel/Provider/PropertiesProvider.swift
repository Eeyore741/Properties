//
//  PropertiesProvider.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import Foundation

/// Protocol defines specific app requirements for display if list of properties and property details.
protocol PropertiesProvider {
    
    /// Call returns list of properties.
    /// - Returns: Result containing list of properties or error.
    func getList() async -> Result<[Property], PropertiesProviderError>
    
    /// Call returns details for particular property
    /// - Parameter propertyID: Particular property ID to fetch details for.
    /// - Returns: Result containing detailed property or error.
    func getPropertyWithID(_ propertyID: String) async -> Result<Property, PropertiesProviderError>
}
