//
//  PropertiesListView.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-18.
//

import SwiftUI

/// View type displayin list of properties.
struct PropertiesListView<ViewModel>: View where ViewModel: PropertiesListViewModel{

    @ObservedObject 
    var viewModel: ViewModel
    
    var body: some View {
        switch self.viewModel.state {
        case .presenting:
            NavigationStack {
                List {
                    ForEach(viewModel.items) {
                        self.makeViewWithItem($0)
                            .background(
                                NavigationLink(
                                    $0.streetAddress,
                                    destination: PropertyDetailsView(viewModel: self.viewModel.makeItemDetailViewModelForItem($0))
                                )
                                .opacity(0)
                            )
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle(self.viewModel.localizedNavigationTitle)
            }
            .tint(.green)
        case .loading:
            ProgressView()
                .task {
                    await self.viewModel.fetchList()
                }
        case .error:
            Text(self.viewModel.localizedErrorMessage)
        }
    }
}

// MARK: Private accessories.
private extension PropertiesListView {
    
    @ViewBuilder
    func makeViewWithItem(_ item: ViewModel.ItemViewModel) -> some View {
        switch item.type {
        case .plain:
            PlainPropertyView(viewModel: item)
        case .highlighted:
            HighlightedPropertyView(viewModel: item)
        case .area:
            AreaPropertyView(viewModel: item)
        }
    }
}

#Preview {
    PropertiesListView(viewModel: DemoPropertiesListViewModel())
}
