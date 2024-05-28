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
                    ForEach(viewModel.items) { item in
                        switch item.type {
                        case .plain:
                            PlainPropertyView(viewModel: item).background(
                                NavigationLink(String(), destination: PropertyDetailsView(viewModel: self.viewModel.makeItemDetailViewModelForItem(item)))
                                    .opacity(0)
                            )
                        case .highlighted:
                            HighlightedPropertyView(viewModel: item).background(
                                NavigationLink(String(), destination: PropertyDetailsView(viewModel: self.viewModel.makeItemDetailViewModelForItem(item)))
                                    .opacity(0)
                            )
                        case .area:
                            AreaPropertyView(viewModel: item).background(

                                NavigationLink(String(), destination: PropertyDetailsView(viewModel: self.viewModel.makeItemDetailViewModelForItem(item)))
                                    .opacity(0)
                            )
                        }
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

#Preview {
    PropertiesListView(viewModel: DemoPropertiesListViewModel())
}
