//
//  PropertiesListViewModel.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import Foundation

/// Protocol specified to fulfill requirements of `PropertiesListView`.
protocol PropertiesListViewModel: ObservableObject {
    
    /// Binding on particular type, conforming to `PropertyViewModel`.
    associatedtype ItemViewModel: PropertyViewModel
    
    /// Binding on particular type, conforming to `PropertyDetailsViewModel`.
    associatedtype ItemDetailViewModel: PropertyDetailsViewModel
    
    /// Value defines current state of view model.
    var state: PropertyDetailsViewModelState { get }
    
    /// Title to be displayed on top navigation stack, usually to be localized.
    var localizedNavigationTitle: String { get }
    
    /// Displayed error message on fetch error.
    var localizedErrorMessage: String { get }
    
    /// List of `ItemViewModel` to be displayed.
    var items: [ItemViewModel] { get }
    
    /// Func to be called after UI display.
    func fetchList() async
    
    /// Destination `View` provider to proceed after `ItemViewModel` selection.
    func makeItemDetailViewModelForItem(_ itemViewModel: ItemViewModel) -> ItemDetailViewModel
}

/// Type describes possible UI states for `PropertiesListViewModel`.
enum PropertiesListViewModelState {
    
    /// List of `ItemViewModel` being displayed.
    case presenting
    
    /// List of `ItemViewModel` being fetched.
    case loading
    
    /// List of `ItemViewModel` fetch finished with error.
    case error
}
