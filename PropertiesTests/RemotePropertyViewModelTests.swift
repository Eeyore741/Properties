//
//  RemotePropertyViewModelTests.swift
//  PropertiesTests
//
//  Created by Vitalii Kuznetsov on 2024-05-28.
//

import XCTest
@testable import Properties

final class RemotePropertyViewModelTests: XCTestCase {
    
    func testInterface() {
        let sut = RemotePropertyViewModel(
            property: Self.dummyProperty,
            placeholderImage: UIImage.demoPlaceholder,
            errorImage: UIImage.demoError,
            imageProvider: MockImageProvider()
        )
        
        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.type, PropertyType.area)
        XCTAssertEqual(sut.askingPrice, "1 SEK")
        XCTAssertEqual(sut.municipalityArea, "area, municipality")
        XCTAssertEqual(sut.area, "area")
        XCTAssertEqual(sut.rooms.key, "%lld rooms")
        XCTAssertEqual(sut.streetAddress, "streetAddress")
        XCTAssertEqual(sut.ratingFormatted.key, "%@ rating")
        XCTAssertEqual(sut.averagePrice.key, "%@ average price")
        XCTAssertEqual(sut.image, UIImage.demoPlaceholder)
    }
    
    func testFetchImageURL() async {
        let mockImageProvider = MockImageProvider()
        mockImageProvider.onGetImageWithURL = { url in
            XCTAssertEqual(url, URL(string: "some://url")!)
            return nil
        }
        
        let sut = RemotePropertyViewModel(
            property: Self.dummyProperty,
            placeholderImage: UIImage.demoPlaceholder,
            errorImage: UIImage.demoError,
            imageProvider: mockImageProvider
        )
        await sut.fetchImage()
    }
    
    func testFetchImageError() async {
        let mockImageProvider = MockImageProvider()
        mockImageProvider.onGetImageWithURL = { _ in
            return nil
        }
        
        let sut = RemotePropertyViewModel(
            property: Self.dummyProperty,
            placeholderImage: UIImage.demoPlaceholder,
            errorImage: UIImage.demoError,
            imageProvider: mockImageProvider
        )
        
        await sut.fetchImage()
        XCTAssertEqual(sut.image, UIImage.demoError)
    }
    
    func testFetchImageSuccess() async {
        let mockImageProvider = MockImageProvider()
        mockImageProvider.onGetImageWithURL = { _ in
            return UIImage.demoProperty1
        }
        
        let sut = RemotePropertyViewModel(
            property: Self.dummyProperty,
            placeholderImage: UIImage.demoPlaceholder,
            errorImage: UIImage.demoError,
            imageProvider: mockImageProvider
        )
        
        await sut.fetchImage()
        XCTAssertEqual(sut.image, UIImage.demoProperty1)
    }
}

private extension RemotePropertyViewModelTests {
    
    static let dummyProperty: Property = {
        Property(id: "id", type: .area, askingPrice: 1, monthlyFee: 2, municipality: "municipality", area: "area", daysSincePublish: 3, livingArea: 4, numberOfRooms: 5, streetAddress: "streetAddress", imageURL: URL(string: "some://url")!, ratingFormatted: "4/5", averagePrice: 6, description: "description", patio: "YES")
    }()
}
