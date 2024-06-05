//
//  PastebinPropertyItemType.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import Foundation

/// Type wrapping possible cases of `PastebinPropertyItem` type.
enum PastebinPropertyItemType: String {
    
    case HighlightedProperty
    
    case Property
    
    case Area
}

extension PastebinPropertyItemType: Decodable { }
