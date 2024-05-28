//
//  PropertyType.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-25.
//

import Foundation

/// Type wrapping possible cases of `Property` type.
enum PropertyType: String {
    
    /// Plaint property.
    case plain
    
    /// Highlighted property.
    case highlighted
    
    /// Area property.
    case area
}

extension PropertyType: Decodable { }
