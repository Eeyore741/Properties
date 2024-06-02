//
//  DemoPropertiesListViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-27.
//

import SwiftUI

/// Demo type designed to conform to `PropertiesListViewModel` for demo & preview purposes.
final class DemoPropertiesListViewModel: PropertiesListViewModel {
    
    typealias ItemViewModel = DemoPropertyViewModel
    typealias ItemDetailViewModel = DemoPropertyDetailsViewModel
    
    var localizedNavigationTitle: String { "Properties" }
    var localizedErrorMessage: String { "Properties list error" }
    
    private let demoPropertiesProvider = DemoPropertiesProvider()
    
    @Published
    var state: PropertyDetailsViewModelState = .loading
    
    @Published
    var items: [ItemViewModel] = []
    
    @MainActor
    func fetchList() async {
        self.state = .loading
        let result = await demoPropertiesProvider.getList()
        
        switch result {
        case .success(let properties):
            items = properties.map { _ in ItemViewModel() }
            self.state = .presenting
        case .failure(_):
            items = []
            self.state = .error
        }
    }
    
    func makeItemDetailViewModelForItem(_ itemViewModel: ItemViewModel) -> ItemDetailViewModel {
        DemoPropertyDetailsViewModel()
    }
}
