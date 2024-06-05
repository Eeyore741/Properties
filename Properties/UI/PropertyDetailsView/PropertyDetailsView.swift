//
//  PropertyDetailsView.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-27.
//

import Foundation

import SwiftUI

/// View displaying detailed Property.
struct PropertyDetailsView<ViewModel>: View where ViewModel: PropertyDetailsViewModel {
    
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            switch self.viewModel.state {
            case .loading:
                ProgressView()
                    .task {
                        await self.viewModel.fetchProperty()
                    }
            case .presenting:
                ScrollView() {
                    VStack(alignment: .leading, spacing: 6) {
                        Image(uiImage: viewModel.image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 500)
                            .clipped()
                        Text(viewModel.streetAddress)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Text(viewModel.municipalityArea)
                            .font(.headline)
                            .foregroundStyle(.gray)
                        Text(viewModel.askingPrice)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer(minLength: 24)
                        Text(viewModel.description)
                        Spacer(minLength: 24)
                        HStack {
                            Text(viewModel.localizedLivingAreaHeader).fontWeight(.semibold)
                            Text(viewModel.livingAreaValue)
                        }
                        HStack {
                            Text(viewModel.localizedNumberOfRoomsHeader).fontWeight(.semibold)
                            Text(viewModel.numberOfRoomsValue)
                        }
                        HStack {
                            Text(viewModel.localizedPatioHeader).fontWeight(.semibold)
                            Text(viewModel.patioValue)
                        }
                        HStack {
                            Text(viewModel.localizedDaysSincePublishHeader).fontWeight(.semibold)
                            Text(viewModel.daysSincePublishValue)
                        }
                    }
                }
            case .error:
                Text(self.viewModel.localizedErrorMessage)
            }
        }
        .tint(.green)
        .padding()
        .navigationBarTitle(Text(self.viewModel.streetAddress), displayMode: .inline)
    }
}

#Preview {
    let property = DemoPropertiesProvider().getLocalPropertyWithType(.plain)
    let viewModel = RemotePropertyDetailsViewModel(
        propertyID: property.id,
        propertiesProvider: DemoPropertiesProvider(),
        imageProvider: DemoImageProvider(mode: .successBundled),
        placeholderImage: .demoPlaceholder,
        errorImage: .demoError
    )
    return PropertyDetailsView(viewModel: viewModel)
}
