//
//  FSQAuthClient.swift
//  GymTracker
//
//  Created by Kyle Wiltshire on 3/6/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import Foundation
import UIKit

protocol FSQAuthClientDelegate {
    func FSQAuthClientDidSucceed(accessToken: String)
    func FSQAuthClientDidFail(error: Error)
}

class FoursquareAuthClient {

    var clientId: String
    var callback: String
    var delegate: FSQAuthClientDelegate
    
    init(clientId: String, callback: String, delegate: FSQAuthClientDelegate) {
        self.clientId = clientId
        self.callback = callback
        self.delegate = delegate
    }

    func authorize(_ controller: UIViewController) {
        let viewController = FSQAuthViewController(clientId: clientId, callback: callback)
        viewController.delegate = self

        let naviController = UINavigationController(rootViewController: viewController)
        controller.present(naviController, animated: true, completion: nil)
    }
}

// MARK: - FoursquareAuthViewControllerDelegate
extension FoursquareAuthClient: FSQAuthViewControllerDelegate {
    func FSQAuthViewControllerDidSucceed(accessToken: String) {
        delegate.FSQAuthClientDidSucceed(accessToken: accessToken)
    }
    
    func FSQAuthViewControllerDidFail(error: Error) {
        delegate.FSQAuthClientDidFail(error: error)
    }
}
