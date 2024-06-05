//
//  RemotePropertiesListViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-27.
//

import UIKit

/// Type designed to conform to `PropertiesListViewModel` for production purposes.
final class RemotePropertiesListViewModel: PropertiesListViewModel {
    
    typealias ItemViewModel = RemotePropertyViewModel
    typealias ItemDetailViewModel = RemotePropertyDetailsViewModel
    
    var localizedNavigationTitle: LocalizedStringResource { "PropertiesListHeader" }
    var localizedErrorMessage: LocalizedStringResource { "LoadingError" }
    
    // DI
    private let propertiesProvider: any PropertiesProvider
    private let imageProvider: any ImageProvider
    private let placeholderImage: UIImage
    private let errorImage: UIImage
    
    @Published
    var state: PropertyDetailsViewModelState = .loading
    
    @Published
    var items: [ItemViewModel] = []
    
    @MainActor
    func fetchList() async {
        self.state = .loading
        let result = await propertiesProvider.getList()
        
        switch result {
        case .success(let properties):
            items = properties.map {
                ItemViewModel(
                    property: $0,
                    placeholderImage: self.placeholderImage,
                    errorImage: self.errorImage,
                    imageProvider: self.imageProvider
                )
            }
            self.state = .presenting
        case .failure(_):
            self.state = .error
        }
    }
    
    func makeItemDetailViewModelForItem(_ itemViewModel: ItemViewModel) -> ItemDetailViewModel {
        let viewModel = ItemDetailViewModel(
            propertyID: itemViewModel.id,
            propertiesProvider: self.propertiesProvider,
            imageProvider: self.imageProvider,
            placeholderImage: self.placeholderImage,
            errorImage: self.errorImage
        )
        
        return viewModel
    }
    
    init(propertiesProvider: any PropertiesProvider, imageProvider: any ImageProvider, placeholderImage: UIImage, errorImage: UIImage) {
        self.propertiesProvider = propertiesProvider
        self.imageProvider = imageProvider
        self.placeholderImage = placeholderImage
        self.errorImage = errorImage
    }
}
