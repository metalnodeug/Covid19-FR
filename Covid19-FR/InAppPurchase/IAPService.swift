//
//  IAPService.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 02/08/2020.
//

import Foundation
import StoreKit

class IAPService: NSObject {

    private override init() {}
    static let shared = IAPService()

    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()

    func getProducts() {
        let products: Set = [IAPProduct.nonconsumable.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }

    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)

    }

    func restorePurchases() {
        paymentQueue.restoreCompletedTransactions()
    }

}

extension IAPService: SKProductsRequestDelegate, SKPaymentTransactionObserver {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                case .purchasing:
                    break

                default:
                    queue.finishTransaction(transaction)
                    paymentQueue.remove(self)
            }
        }
    }

}
