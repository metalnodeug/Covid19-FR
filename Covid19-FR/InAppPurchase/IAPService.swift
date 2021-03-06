//
//  IAPService.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 02/08/2020.
//

import Foundation
import StoreKit

protocol IAPServiceDelegate: class {
    func didFinishRestored()
}

class IAPService: NSObject {

    private override init() {}
    static let shared = IAPService()

    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()

    weak var delegate: IAPServiceDelegate!

    func getProducts() {
        let products: Set = [IAPProduct.nonconsumable.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }

    func purchase(product: IAPProduct, completionBlock: () -> Void) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }

        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: productToPurchase)
            paymentQueue.add(self)
            paymentQueue.add(payment)
            completionBlock()
        }
    }

    func restorePurchases() {
        paymentQueue.add(self)
        paymentQueue.restoreCompletedTransactions()
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        UserDefaults.standard.set(true, forKey: "ads_removed")
        delegate.didFinishRestored()
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

                case .restored, .purchased:
                    print("Payment Restored or purchased")
                    UserDefaults.standard.set(true, forKey: "ads_removed")
                    queue.finishTransaction(transaction)
                    paymentQueue.remove(self)

                default:
                    print("Payment failed or cancel")
                    queue.finishTransaction(transaction)
                    paymentQueue.remove(self)
            }
        }
    }

}
