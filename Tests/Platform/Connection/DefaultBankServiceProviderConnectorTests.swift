//
//  DefaultBankServiceProviderConnectorTests.swift
//  OBankingConnector
//
//  Created by Kai Takac on 16.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import XCTest
import RxBlocking
@testable import OBankingConnector

class DefaultBankServiceProviderConnectorTests: XCTestCase {

    private class BankServiceConnectionInformationMock: BankServiceConnectionInformation {
    }

    var sut: DefaultBankServiceProviderConnector!

    override func setUp() {
        super.setUp()
        sut = DefaultBankServiceProviderConnector()
    }

    func test_Connect_ErrorForUnknown() {
        do {
            _ = try sut.connectToBankService(using: BankServiceConnectionInformationMock()).toBlocking().first()
            XCTFail("Should fail")
        } catch let error {
            guard let error = error as? BankServiceProviderConnectorError else {
                XCTFail("Invalid error type")
                return
            }
            XCTAssertEqual(error, .unsupportedConnectionInformation)
        }
    }

    func test_Connect_WorksForOAuth2() {
        do {
            let oAuth2ConnectionInformation = OAuth2BankServiceConnectionInformation(
                accessToken: "asdf",
                tokenType: "bearer"
            )

            let result = try sut.connectToBankService(using: oAuth2ConnectionInformation).toBlocking().first()

            XCTAssertTrue(result is ConnectedOAuth2BankServiceProvider)
        } catch let error {
            XCTFail(String(describing: error))
        }
    }

}
