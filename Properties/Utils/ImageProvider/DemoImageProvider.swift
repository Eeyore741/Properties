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
    
    var fetchTimeoutInSec: Double = 2
    
    init(mode: DemoImageProvider.Mode) {
        self.mode = mode
    }
    
    func getImageWithURL(_ imageURL: URL) async -> UIImage? {
        try? await Task.sleep(for: .seconds(self.fetchTimeoutInSec))
        
        switch self.mode {
        case .successProvided(let image):
            return image
        case .successBundled:
            return UIImage(named: imageURL.lastPathComponent)
        case .failure:
            return nil
        }
    }
}

extension DemoImageProvider {
    
    /// Type toggling behaviour of `DemoImageProvider`.
    enum Mode {
        
        /// Successful result with associated `UIImage` value.
        case successProvided(UIImage)
        
        /// Successful result with associated name of bundled image.
        case successBundled
        
        /// Failure result mode.
        case failure
    }
}
