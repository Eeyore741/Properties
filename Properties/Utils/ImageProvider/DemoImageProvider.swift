//
//  DemoImageProvider.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-26.
//

import UIKit

/// Type fulfilling `ImageProvider` protocol requirements used for demo & preview purposes.
final class DemoImageProvider: ImageProvider {
    
    var mode: DemoImageProvider.Mode
    
    var fetchTimeoutInSec: Double = 1.5
    
    init(mode: DemoImageProvider.Mode) {
        self.mode = mode
    }
    
    func getImageWithURL(_ imageURL: URL) async -> UIImage? {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
        switch self.mode {
        case .success(let image):
            return image
        case .failure:
            return nil
        }
    }
}

extension DemoImageProvider {
    
    /// Type toggling behaviour of `DemoImageProvider`.
    enum Mode {
        
        /// Successful result with associated `UIImage` value.
        case success(UIImage)
        
        /// Failure result mode.
        case failure
    }
}
