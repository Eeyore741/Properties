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
        ))
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
    
    func testFetch() async {
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
}
