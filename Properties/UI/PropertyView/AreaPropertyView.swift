//
//  AreaPropertyView.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-26.
//

import SwiftUI

struct AreaPropertyView<ViewModel>: View where ViewModel: PropertyViewModel {
    
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringResource(stringLiteral: "area"))
                .font(.title)
                .fontWeight(.bold)
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .clipped()
            Text(viewModel.area)
                .font(.callout)
                .fontWeight(.bold)
            Text(viewModel.ratingFormatted)
                .font(.subheadline)
            Text(viewModel.averagePrice)
                .font(.subheadline)
        }
        .padding()
        .task {
            await self.viewModel.fetchImage()
        }
    }
}

#Preview {
    List {
        let viewModel = RemotePropertyViewModel(
            property: DemoPropertiesProvider().getLocalPropertyWithType(.area),
            placeholderImage: .demoPlaceholder,
            errorImage: .demoError,
            imageProvider: DemoImageProvider(mode: .successBundled)
        )
        AreaPropertyView(viewModel: viewModel)
    }
    .listStyle(PlainListStyle())
}
