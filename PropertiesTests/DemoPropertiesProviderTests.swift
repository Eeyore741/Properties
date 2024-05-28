//
//  DemoPropertiesProviderTests.swift
//  PropertiesTests
//
//  Created by Vitalii Kuznetsov on 2024-05-25.
//

import XCTest
@testable import Properties

final class DemoPropertiesProviderTests: XCTestCase {
    
    func testGetListSuccess() async {
        let sut0 = DemoPropertiesProvider()
        
        let result = await sut0.getList()
        
        switch result {
        case .success(let list):
            XCTAssertFalse(list.isEmpty)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetListFailure() async {
        let sut0 = DemoPropertiesProvider()
        
        sut0.mode = .fail(.decodingFailure)
        var result = await sut0.getList()
        
        guard 
            case let .failure(error) = result,
            error == .decodingFailure
        else {
            return XCTFail()
        }
        
        sut0.mode = .fail(.faultyURL)
        result = await sut0.getList()
        
        guard
            case let .failure(error) = result,
            error == .faultyURL
        else {
            return XCTFail()
        }
        
        sut0.mode = .fail(.remoteError)
        result = await sut0.getList()
        
        guard
            case let .failure(error) = result,
            error == .remoteError
        else {
            return XCTFail()
        }
        
        sut0.mode = .fail(.resourceUnavailable)
        result = await sut0.getList()
        
        guard
            case let .failure(error) = result,
            error == .resourceUnavailable
        else {
            return XCTFail()
        }
    }
    
    func testGetPropertySuccess() async {
        let sut0 = DemoPropertiesProvider()
        
        let result = await sut0.getPropertyWithID("any")
        
        switch result {
        case .success(let property):
            XCTAssertTrue(property.id == "1234567890")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetPropertyFailure() async {
        let sut0 = DemoPropertiesProvider()
        
        sut0.mode = .fail(.decodingFailure)
        var result = await sut0.getPropertyWithID("any")
        
        guard
            case let .failure(error) = result,
            error == .decodingFailure
        else {
            return XCTFail()
        }
        
        sut0.mode = .fail(.faultyURL)
        result = await sut0.getPropertyWithID("any")
        
        guard
            case let .failure(error) = result,
            error == .faultyURL
        else {
            return XCTFail()
        }
        
        sut0.mode = .fail(.remoteError)
        result = await sut0.getPropertyWithID("any")
        
        guard
            case let .failure(error) = result,
            error == .remoteError
        else {
            return XCTFail()
        }
        
        sut0.mode = .fail(.resourceUnavailable)
        result = await sut0.getPropertyWithID("any")
        
        guard
            case let .failure(error) = result,
            error == .resourceUnavailable
        else {
            return XCTFail()
        }
    }
}
