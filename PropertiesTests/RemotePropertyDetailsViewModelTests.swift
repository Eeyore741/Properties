//
//  RemotePropertyDetailsViewModelTests.swift
//  PropertiesTests
//
//  Created by Vitalii Kuznetsov on 2024-05-28.
//

import XCTest
@testable import Properties

final class RemotePropertyDetailsViewModelTests: XCTestCase {
    
    func testInit() {
        let propertyID = "propertyID"
        let propertiesProvider = MockPropertiesProvider()
        let imageProvider = MockImageProvider()
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        
        XCTAssertNoThrow(
            RemotePropertyDetailsViewModel(
                propertyID: propertyID,
                propertiesProvider: propertiesProvider,
                imageProvider: imageProvider,
                placeholderImage: placeholderImage,
                errorImage: errorImage
            )
        )
    }
    
    func testState() async {
        let propertyID = "propertyID"
        let imageProvider = MockImageProvider()
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        let propertiesProvider = MockPropertiesProvider()
        propertiesProvider.onGetListResult = .failure(.faultyURL)
        
        let sut = RemotePropertyDetailsViewModel(
            propertyID: propertyID,
            propertiesProvider: propertiesProvider,
            imageProvider: imageProvider,
            placeholderImage: placeholderImage,
            errorImage: errorImage
        )
        
        XCTAssertEqual(sut.state, .loading)
        await sut.fetchProperty()
        XCTAssertEqual(sut.state, .error)
    }
    
    func testFetchFailure() async {
        let propertyID = "propertyID"
        let imageProvider = MockImageProvider()
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        let propertiesProvider = MockPropertiesProvider()
        propertiesProvider.onGetPropertyWithID = { url in
            return .failure(.faultyURL)
        }
        
        let sut = RemotePropertyDetailsViewModel(
            propertyID: propertyID,
            propertiesProvider: propertiesProvider,
            imageProvider: imageProvider,
            placeholderImage: placeholderImage,
            errorImage: errorImage
        )
        
        XCTAssertEqual(sut.state, .loading)
        await sut.fetchProperty()
        XCTAssertEqual(sut.state, .error)
    }
    
    func testFetchSuccess() async {
        let propertyID = "propertyID"
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        let imageProvider = MockImageProvider()
        imageProvider.onGetImageWithURL = { _ in
            UIImage.demoProperty
        }
        let propertiesProvider = MockPropertiesProvider()
        propertiesProvider.onGetPropertyWithID = { url in
                .success(Self.dummyProperty)
        }
        
        let sut = RemotePropertyDetailsViewModel(
            propertyID: propertyID,
            propertiesProvider: propertiesProvider,
            imageProvider: imageProvider,
            placeholderImage: placeholderImage,
            errorImage: errorImage
        )
        
        await sut.fetchProperty()
        
        XCTAssertEqual(sut.state, .presenting)
        XCTAssertEqual(sut.image, UIImage.demoProperty)
        XCTAssertEqual(sut.streetAddress, "streetAddress")
        XCTAssertEqual(sut.municipalityArea, "area, municipality")
        XCTAssertEqual(sut.askingPrice, "1 SEK")
        XCTAssertEqual(sut.description, "description")
        XCTAssertEqual(sut.localizedLivingAreaHeader, "Living area:")
        XCTAssertEqual(sut.livingAreaValue, "4 m²")
        XCTAssertEqual(sut.localizedNumberOfRoomsHeader, "Number of rooms: ")
        XCTAssertEqual(sut.numberOfRoomsValue, "5")
        XCTAssertEqual(sut.localizedPatioHeader, "Patio: ")
        XCTAssertEqual(sut.patioValue, "YES")
        XCTAssertEqual(sut.localizedDaysSincePublishHeader, "Days since publish: ")
        XCTAssertEqual(sut.daysSincePublishValue, "3")
        XCTAssertEqual(sut.localizedErrorMessage, "Loading error")
    }
}

private extension RemotePropertyDetailsViewModelTests {
    
    static let dummyProperty: Property = {
        Property(id: "id", type: .area, askingPrice: 1, monthlyFee: 2, municipality: "municipality", area: "area", daysSincePublish: 3, livingArea: 4, numberOfRooms: 5, streetAddress: "streetAddress", imageURL: URL(string: "some://url")!, ratingFormatted: "4/5", averagePrice: 6, description: "description", patio: "YES")
    }()
}
