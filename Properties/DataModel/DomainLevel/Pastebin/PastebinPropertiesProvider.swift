//
//  PastebinPropertiesProvider.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import Foundation

/// Type defined as provider of values from predefined static URLs.
final class PastebinPropertiesProvider {
    
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        let urlSession = URLSession(configuration: configuration)
        
        return urlSession
    }()
    
    func getPastebinPropertiesList() async -> Result<[PastebinPropertyItem], PropertiesProviderError> {
        guard let url = URL(string: Self.listUrl) else { return .failure(.faultyURL) }
        
        var response: (Data, URLResponse)
        do {
            let request = URLRequest(url: url)
            response = try await urlSession.data(for: request)
        } catch {
            return .failure(PropertiesProviderError.remoteError)
        }
        
        var propertiesList: PastebinPropertyItemList
        do {
            let jsonDecoder = JSONDecoder()
            propertiesList = try jsonDecoder.decode(PastebinPropertyItemList.self, from: response.0)
        } catch {
            return .failure(PropertiesProviderError.decodingFailure)
        }
        
        return .success(propertiesList.items)
    }
    
    func getPastebinProperty() async -> Result<PastebinPropertyItem, PropertiesProviderError> {
        guard let url = URL(string: Self.itemUrl) else { return .failure(.faultyURL) }
        
        var response: (Data, URLResponse)
        do {
            let request = URLRequest(url: url)
            response = try await urlSession.data(for: request)
        } catch {
            return .failure(.remoteError)
        }
        var item: PastebinPropertyItem
        do {
            item = try JSONDecoder().decode(PastebinPropertyItem.self, from: response.0)
        } catch {
            return .failure(.decodingFailure)
        }
        
        return .success(item)
    }
}

// MARK: Private accessories
private extension PastebinPropertiesProvider {
    
    static let listUrl = "https://pastebin.com/raw/nH5NinBi"
    
    static let itemUrl = "https://pastebin.com/raw/uj6vtukE"
    
    static let valiedPropertyID = "1234567890"
}

// MARK: `PropertiesProvider` conformance
extension PastebinPropertiesProvider: PropertiesProvider {
    
    func getList() async -> Result<[Property], PropertiesProviderError> {
        let result = await getPastebinPropertiesList()
        
        switch result {
        case .success(let items):
            let properties: [Property] = items.compactMap { Property(from: $0) }
            return .success(properties)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getPropertyWithID(_ propertyID: String) async -> Result<Property, PropertiesProviderError> {
        // Early exit on unexpected property ID.
        guard propertyID == Self.valiedPropertyID else { return .failure(.remoteError) }
        
        let result = await getPastebinProperty()
        
        switch result {
        case .success(let item):
            guard let property = Property(from: item) else { return .failure(.decodingFailure) }
            
            return .success(property)
        case .failure(let error):
            return .failure(error)
        }
    }
}
