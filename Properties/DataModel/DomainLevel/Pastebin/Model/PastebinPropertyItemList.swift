//
//  PastebinPropertyItemList.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-19.
//

import Foundation

/// Type wrapping  list of properties provided by Pastebin source.
struct PastebinPropertyItemList {
    let items: [PastebinPropertyItem]
}

extension PastebinPropertyItemList: Decodable { }
