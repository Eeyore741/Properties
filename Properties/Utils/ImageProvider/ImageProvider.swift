//
//  ImageProvider.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-25.
//

import UIKit

/// Protocol defined to fullfil requirements of imge provider.
protocol ImageProvider {
    
    /// Async call returns image in case of successful request.
    /// - Parameter imageURL: Resource URL.
    /// - Returns: Image in case of resource was found.
    func getImageWithURL(_ imageURL: URL) async -> UIImage?
}
