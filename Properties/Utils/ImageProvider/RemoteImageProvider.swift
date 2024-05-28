//
//  RemoteImageProvider.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-25.
//

import UIKit

/// Type fulfilling `ImageProvider` protocol requirements using inherited functionality of parent `RemoteResourceProvider`.
final class RemoteImageProvider: RemoteResourceProvider { }

extension RemoteImageProvider: ImageProvider {
    
    func getImageWithURL(_ imageURL: URL) async -> UIImage? {
        let result = await self.getRemoteResourceWithUrl(imageURL)
        
        switch result {
        case .success(let data):
            return UIImage(data: data)
        case .failure(_):
            return nil
        }
    }
}
