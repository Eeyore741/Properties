//
//  RemoteResourceProviderError.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-27.
//

import Foundation

/// Type defines erorr cases of `RemoteResourceProvider`
enum RemoteResourceProviderError: Error {
    
    /// Request got non http response
    case nonHttpResponse
    
    /// Request encountered session error
    case session(error: Error)
    
    /// Request received failed response code
    case response(code: Int)
}
