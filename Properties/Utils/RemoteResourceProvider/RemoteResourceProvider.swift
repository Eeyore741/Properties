//
//  RemoteResourceProvider.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-25.
//

import Foundation

/// Remote resources provider with persistent and in-memory storage.
class RemoteResourceProvider {
    
    private let cache: URLCache
    private let session: URLSession
    
    init() {
        self.cache = URLCache(memoryCapacity: 1_024*1_024*400, diskCapacity: 1_024*1_024*400)
        self.session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    }
    
    func getRemoteResourceWithUrl(_ resourceUrl: URL) async -> Result<Data, RemoteResourceProviderError> {
        let request = URLRequest(url: resourceUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        let data: Data? = await self.getCachedDataFromRequest(request)
        
        if case let .some(data) = data {
            return .success(data)
        }
        
        do {
            let response = try await session.data(from: resourceUrl)
            
            guard let httpUrlResponse = response.1 as? HTTPURLResponse else { return .failure(.nonHttpResponse) }
            guard (200..<300).contains(httpUrlResponse.statusCode) else { return .failure(.response(code: httpUrlResponse.statusCode)) }
            
            self.saveCachedResponse(response.1, withData: response.0, andRequest: request)
            
            return .success(response.0)
        } catch {
            
            return .failure(.session(error: error))
        }
    }
}

// MARK: Private accessories.
private extension RemoteResourceProvider {
    
    func saveCachedResponse(_ response: URLResponse, withData data: Data, andRequest request: URLRequest) {
        let cachedResponse = CachedURLResponse(response: response, data: data, storagePolicy: .allowed)
        self.cache.storeCachedResponse(cachedResponse, for: request)
    }
    
    func getCachedDataFromRequest(_ request: URLRequest) async -> Data? {
        let data: Data? = await withCheckedContinuation { continuation in
            let task = self.session.dataTask(with: request)
            
            self.cache.getCachedResponse(for: task) { response in
                switch response {
                case .some(let cachedResponse):
                    continuation.resume(returning: cachedResponse.data)
                case .none:
                    continuation.resume(returning: nil)
                }
            }
        }
        
        return data
    }
}
