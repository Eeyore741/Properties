//
//  PropertiesAppRunOptions.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-20.
//

import Foundation

extension PropertiesApp {
    
    /// Type to provide running options and env variables.
    enum RunOptions {
        
        static var isDemo: Bool { ProcessInfo.processInfo.arguments.contains(#function) }
    }
}
