//
//  PropertiesProviderError.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import Foundation

/// Type describing possible cases of error returned by `PropertiesProvider` type instance.
enum PropertiesProviderError: Error {
    
    /// Error in case of unavailable resource.
    case resourceUnavailable
    
    /// Error in case of faulty URL.
    case faultyURL
    
    /// Error in case of decoding error.
    case decodingFailure
    
    /// Error in case of remote connection error.
    case remoteError
}
