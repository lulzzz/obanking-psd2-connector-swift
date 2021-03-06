//
//  BankAccount.swift
//  OBankingConnector
//
//  Created by Kai Takac on 10.12.17.
//  Copyright © 2017 Kai Takac. All rights reserved.
//

import Foundation

public struct BankAccountDetails {

    public let balance: Amount
    public let type: BankAccountType
    public let disposeableBalance: Amount?
    public let alias: String?
}
