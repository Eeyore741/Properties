//
//  PropertiesApp.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import SwiftUI

@main
struct PropertiesApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            if Self.RunOptions.isDemo {
                let viewModel = RemotePropertiesListViewModel(
                    propertiesProvider: DemoPropertiesProvider(),
                    imageProvider: DemoImageProvider(mode: .successBundled),
                    placeholderImage: .demoPlaceholder,
                    errorImage: .demoError
                )
                PropertiesListView(viewModel: viewModel)
            } else {
                let viewModel = RemotePropertiesListViewModel(
                    propertiesProvider: PastebinPropertiesProvider(),
                    imageProvider: RemoteImageProvider(),
                    placeholderImage: .demoPlaceholder,
                    errorImage: .demoError
                )
                PropertiesListView(viewModel: viewModel)
            }
        }
    }
}
