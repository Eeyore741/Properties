//
//  DemoPropertiesProvider.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-25.
//

import Foundation

/// Demo type designed to conform `PropertiesProvider` using local resources.
final class DemoPropertiesProvider {
    
    var mode: DemoPropertiesProvider.Mode = .success
    
    var fetchTimeoutInSec: Double = 2
    
    func getLocalList() -> Result<[Property], PropertiesProviderError> {
        if case let .failure(error) = self.mode { return .failure(error) }
        
        guard let url = Bundle.main.url(forResource: "demoItemsList", withExtension: "json") else {
            return .failure(.faultyURL)
        }
        
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            
            return .failure(.resourceUnavailable)
        }
        do {
            let decoder = JSONDecoder()
            let list = try decoder.decode([Property].self, from: data)
            
            return .success(list)
        } catch {
            
            return .failure(.decodingFailure)
        }
    }
    
    func getLocalPropertyWithID(_ propertyID: String) -> Result<Property, PropertiesProviderError> {
        if case let .failure(error) = self.mode { return .failure(error) }
        guard
            case let .success(list) = self.getLocalList(),
            let property = (list.first { $0.id == propertyID }) else { return .failure(.resourceUnavailable) }
        
        return .success(property)
    }
    
    func getLocalPropertyWithType(_ type: PropertyType) -> Property {
        guard case let .success(list) = self.getLocalList() else { fatalError("Local data corrupted") }
        guard let property = (list.first { $0.type == type }) else { fatalError("Local data not found") }
        
        return property
    }
}

extension DemoPropertiesProvider {
    
    /// Type wrapping possible `DemoPropertiesProvider` bahaviour cases.
    enum Mode {
        
        /// Case of success result
        case success
        
        /// Case of failure result.
        case failure(PropertiesProviderError)
    }
}

// MARK: `PropertiesProvider` conformance.
extension DemoPropertiesProvider: PropertiesProvider {
    
    func getList() async -> Result<[Property], PropertiesProviderError> {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
        return self.getLocalList()
    }
    
    func getPropertyWithID(_ propertyID: String) async -> Result<Property, PropertiesProviderError> {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
        return self.getLocalPropertyWithID(propertyID)
    }
}
