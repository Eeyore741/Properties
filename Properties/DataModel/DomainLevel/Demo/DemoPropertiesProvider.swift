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

// MARK: `PropertiesProvider` conformance.
extension DemoPropertiesProvider: PropertiesProvider {
    
    func getList() async -> Result<[Property], PropertiesProviderError> {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
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
    
    func getPropertyWithID(_ propertyID: String) async -> Result<Property, PropertiesProviderError> {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
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
}
