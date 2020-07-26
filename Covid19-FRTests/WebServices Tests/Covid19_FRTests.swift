//
//  Covid19_FRTests.swift
//  Covid19-FRTests
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import XCTest
@testable import Covid19_FR

class Covid19_FRTests: XCTestCase {

    func testGetFoodShouldPostFailedCallBackIfError() {
        // Given
        let getService = NetworkManager(
            networkManagerSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)
        )
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        getService.getCovDeptInformation(for: "Bas-Rhin") { result in
            switch result {
                case .success(let covData):
                    XCTAssertNil(covData)
                case .failure(_):
                    break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFoodShouldPostFailedCallBackIfNoData() {
        // Given
        let getService = NetworkManager(
            networkManagerSession: URLSessionFake(data: FakeResponseData.checkerFridgeIncorrectData, response: nil, error: FakeResponseData.error)
        )
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        getService.getCovDeptInformation(for: "Bas-Rhin") { result in
            // Then
            switch result {
                case .success(let checkerFridgeData):
                    XCTAssertNil(checkerFridgeData)
                case .failure(_):
                    break
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFoodShouldPostFailedCallBackIfincorrectResponse() {
        // Given
        let getService = NetworkManager(
            networkManagerSession: URLSessionFake(data: FakeResponseData.GetRequest.correctData, response: FakeResponseData.responseKO, error: nil)
        )
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        getService.getCovDeptInformation(for: "Bas-Rhin") { result in
            // Then
            switch result {
                case .success(let checkerFridgeData):
                    XCTAssertNil(checkerFridgeData)
                case .failure(_):
                    break
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipleShouldPostFailedCallBackIfincorrectData() {
        // Given
        let getService = NetworkManager(
            networkManagerSession: URLSessionFake(data: FakeResponseData.checkerFridgeIncorrectData, response: FakeResponseData.responseOK, error: nil)
        )
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        getService.getCovDeptInformation(for: "Bas-Rhin") { result in
            // Then
            switch result {
                case .success(let checkerFridgeData):
                    XCTAssertNil(checkerFridgeData)
                case .failure(_):
                    break
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFoodShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        let getService = NetworkManager(
            networkManagerSession: URLSessionFake(data: FakeResponseData.GetRequest.correctData, response: FakeResponseData.responseOK, error: nil)
        )
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        getService.getCovDeptInformation(for: "Bas-Rhin") { result in
            // Then
            switch result {
                case .success(let checkerFridgeData):
                    XCTAssertNotNil(checkerFridgeData)
                case .failure(_):
                    break
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFoodShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        // Given
        let getService = NetworkManager(
            networkManagerSession: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil)
        )
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        getService.getCovDeptInformation(for: "Bas-Rhin") { result in
            // Then
            switch result {
                case .success(let checkerFridgeData):
                    XCTAssertNil(checkerFridgeData)
                case .failure(_):
                    break
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}
