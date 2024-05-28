//
//  MockPropertiesProvider.swift
//  PropertiesTests
//
//  Created by Vitalii Kuznetsov on 2024-05-28.
//

import Foundation
@testable import Properties

final class MockPropertiesProvider: PropertiesProvider {
    
    var onGetListResult: Result<[Properties.Property], Properties.PropertiesProviderError> = .failure(.faultyURL)
    
    var onGetPropertyWithID: (String) -> Result<Properties.Property, Properties.PropertiesProviderError> = { _ in .failure(.faultyURL)}
    
    func getList() async -> Result<[Properties.Property], Properties.PropertiesProviderError> {
        self.onGetListResult
    }
    
    func getPropertyWithID(_ propertyID: String) async -> Result<Properties.Property, Properties.PropertiesProviderError> {
        self.onGetPropertyWithID(propertyID)
    }
}
