//
//  OBankingConnector.swift
//  OBankingConnector
//
//  Created by Kai Takac on 12.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

public final class OBankingConnector {

    private let configuration: Configuration
    private let deepLinkService: DeepLinkService
    private let externalWebBrowserLauncher: ExternalWebBrowserLauncher
    private let webClient: WebClient

    init(configuration: Configuration) {
        self.configuration = configuration

        // Initialize Dependencies
        self.deepLinkService = DefaultDeepLinkService()
        self.externalWebBrowserLauncher = PlatformDependingExternalWebBrowserLauncher()
        self.webClient = AlamofireWebClient()
    }

    func makeBankServiceProviderAuthenticationProvider() -> BankServiceProviderAuthenticationProvider {
        let oAuth2Processors = DefaultOAuth2BankServiceAuthenticationRequestProcessorFactory()
            .makeProcessor(
                externalWebBrowserLauncher: externalWebBrowserLauncher,
                deepLinkProvider: deepLinkService,
                webClient: webClient
            )

        return DefaultBankServiceProviderAuthenticationProvider(
            supportedBankServiceProviderMap: [:],
            bankServiceProviderRequestProcessors: [
                oAuth2Processors
            ]
        )
    }

    func makeBankServiceProviderConnector() -> BankServiceProviderConnector {
        fatalError("Not implemented yet")
    }

    func makeDeepLinkHandler() -> DeepLinkHandler {
        return self.deepLinkService
    }
}
