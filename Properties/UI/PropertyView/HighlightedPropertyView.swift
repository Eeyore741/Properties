//
//  HighlightedPropertyView.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-26.
//

import SwiftUI

struct HighlightedPropertyView<ViewModel>: View where ViewModel: PropertyViewModel {
    
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 360)
                .aspectRatio(contentMode: .fit)
                .clipped()
                .border(.yellow, width: 4)
            Text(viewModel.streetAddress)
                .font(.title3)
                .fontWeight(.bold)
            Text(viewModel.municipalityArea)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .fontWeight(.medium)
            HStack {
                Text(viewModel.askingPrice)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.livingArea)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.rooms)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .font(.footnote)
            .fontWeight(.bold)
        }
        .padding()
        .task {
            await self.viewModel.fetchImage()
        }
    }
}


#Preview {
    let viewModel = DemoPropertyViewModel()
    return HighlightedPropertyView(viewModel: viewModel)
}
