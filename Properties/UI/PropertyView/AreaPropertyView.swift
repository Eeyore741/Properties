//
//  AreaPropertyView.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-26.
//

import SwiftUI

struct AreaPropertyView<ViewModel>: View where ViewModel: PropertyViewModel {
    
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.type.rawValue.capitalized)
                .font(.title)
                .fontWeight(.bold)
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .aspectRatio(contentMode: .fit)
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
    let viewModel = DemoPropertyViewModel()
    return AreaPropertyView(viewModel: viewModel)
}

