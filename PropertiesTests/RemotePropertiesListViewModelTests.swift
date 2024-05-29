//
//  RemotePropertiesListViewModelTests.swift
//  PropertiesTests
//
//  Created by Vitalii Kuznetsov on 2024-05-28.
//

import XCTest
@testable import Properties

final class RemotePropertiesListViewModelTests: XCTestCase {
    
    func testInit() {
        let propertiesProvider = MockPropertiesProvider()
        let imageProvider = MockImageProvider()
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        
        XCTAssertNoThrow(
            RemotePropertiesListViewModel(
                propertiesProvider: propertiesProvider,
                imageProvider: imageProvider,
                placeholderImage: placeholderImage,
                errorImage: errorImage
            )
        )
    }
    
    func testInterface() {
        let propertiesProvider = MockPropertiesProvider()
        let imageProvider = MockImageProvider()
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        
        let sut = RemotePropertiesListViewModel(
            propertiesProvider: propertiesProvider,
            imageProvider: imageProvider,
            placeholderImage: placeholderImage,
            errorImage: errorImage
        )
        
        XCTAssertEqual(sut.state, .loading)
        XCTAssertEqual(sut.localizedNavigationTitle, "Properties")
        XCTAssertEqual(sut.localizedErrorMessage, "Properties list error")
        XCTAssertTrue(sut.items.isEmpty)
    }
    
    func testState() async {
        let imageProvider = MockImageProvider()
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        let propertiesProvider = MockPropertiesProvider()
        propertiesProvider.onGetListResult = .failure(.faultyURL)
        
        let sut = RemotePropertiesListViewModel(
            propertiesProvider: propertiesProvider,
            imageProvider: imageProvider,
            placeholderImage: placeholderImage,
            errorImage: errorImage
        )
        
        XCTAssertEqual(sut.state, .loading)
        await sut.fetchList()
        XCTAssertEqual(sut.state, .error)
    }
    
    func testItems() async {
        let imageProvider = MockImageProvider()
        let placeholderImage = UIImage.demoPlaceholder
        let errorImage = UIImage.demoError
        let propertiesProvider = DemoPropertiesProvider()
        
        let sut = RemotePropertiesListViewModel(
            propertiesProvider: propertiesProvider,
            imageProvider: imageProvider,
            placeholderImage: placeholderImage,
            errorImage: errorImage
        )
        
        await sut.fetchList()
        XCTAssertFalse(sut.items.isEmpty)
    }
}
