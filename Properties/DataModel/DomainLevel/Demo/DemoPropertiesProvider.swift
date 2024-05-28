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
        if case let .fail(error) = self.mode { return .failure(error) }
        
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
    
    func getLocalProperty() -> Result<Property, PropertiesProviderError> {
        if case let .fail(error) = self.mode { return .failure(error) }
        
        guard let url = Bundle.main.url(forResource: "demoItemDetails", withExtension: "json") else {
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
            let item = try decoder.decode(Property.self, from: data)
            
            return .success(item)
        } catch {
            return .failure(.decodingFailure)
        }
    }
    
    func getLocalPropertyWithType(_ type: PropertyType) -> Property {
        let result = self.getLocalList()
        guard case let .success(list) = result,
              let property = list.first(where: { $0.type == type }) else { fatalError("Local data missing property with type: \(type.rawValue)") }
        
        return property
    }
}

extension DemoPropertiesProvider {
    
    /// Type wrapping possible `DemoPropertiesProvider` bahaviour cases.
    enum Mode {
        
        /// Case of success result
        case success
        
        /// Case of failure result.
        case fail(PropertiesProviderError)
    }
}

/// MARK: `PropertiesProvider` conformance.
extension DemoPropertiesProvider: PropertiesProvider {
    
    func getList() async -> Result<[Property], PropertiesProviderError> {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
        return self.getLocalList()
    }
    
    func getPropertyWithID(_ propertyID: String) async -> Result<Property, PropertiesProviderError> {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
        return self.getLocalProperty()
    }
}
