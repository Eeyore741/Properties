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
                let viewModel = DemoPropertiesListViewModel()
                PropertiesListView(viewModel: viewModel)
            } else {
                let propertiesProvider = PastebinPropertiesProvider()
                let imageProvider = RemoteImageProvider()
                let placeholderImage = UIImage.demoPlaceholder
                let errorImage = UIImage.demoError
                let viewModel = RemotePropertiesListViewModel(
                    propertiesProvider: propertiesProvider,
                    imageProvider: imageProvider,
                    placeholderImage: placeholderImage,
                    errorImage: errorImage
                )
                PropertiesListView(viewModel: viewModel)
            }
        }
    }
}
