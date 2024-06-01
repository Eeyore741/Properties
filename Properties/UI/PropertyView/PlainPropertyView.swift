//
//  PlainPropertyView.swift
//  Properties
//
//  Created by Vitalii Kuznetsov on 2024-05-19.
//

import SwiftUI

struct PlainPropertyView<ViewModel>: View where ViewModel: PropertyViewModel {
    
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .aspectRatio(contentMode: .fit)
                .clipped()
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
    return PlainPropertyView(viewModel: viewModel)
}
