//
//  MockImageProvider.swift
//  PropertiesTests
//
//  Created by Vitalii Kuznetsov on 2024-05-28.
//

import UIKit
@testable import Properties

final class MockImageProvider: ImageProvider {
    
    var onGetImageWithURL: ((URL) -> UIImage?)? = nil
    
    func getImageWithURL(_ imageURL: URL) async -> UIImage? {
        self.onGetImageWithURL?(imageURL)
    }
}
