//
//  KeychainWrapper.swift
//  KeychainMultipleItemsTest
//
//  Created by Oleksandr Deundiak on 9/6/17.
//  Copyright © 2017 Oleksandr Deundiak. All rights reserved.
//

import Foundation

class KeychainWrapper {
    private func generatePrivateKeyAttributesDictionary() -> [NSString : AnyObject] {
        // Just generate some random data instead of private key
        var privateKey = Data(count: 16)
        privateKey.withUnsafeMutableBytes({
            NSUUID().getBytes($0)
        })
        
        let privateKeyName = UUID().uuidString
        
        let attributes: [NSString : AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            kSecAttrApplicationLabel: privateKeyName as NSString,
            kSecAttrApplicationTag: privateKeyName.data(using: .utf8)! as NSData
        ]
        
        return attributes
    }
    
    func addOneItem() {
        let attributes = self.generatePrivateKeyAttributesDictionary()
    
        let status = SecItemAdd(attributes as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Added one key successfully")
        }
        else {
            print("Error while adding one key: \(status)")
        }
    }
    
    func addTwoItems() {
        let attributes1 = self.generatePrivateKeyAttributesDictionary()
        let attributes2 = self.generatePrivateKeyAttributesDictionary()
        
        let attributesArray = [attributes1, attributes2] as NSArray
        
        let attributes: [NSString : AnyObject] = [
            kSecUseItemList: attributesArray
        ]
        
        let status = SecItemAdd(attributes as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Added two keys successfully")
        }
        else {
            print("Error while adding two keys: \(status)")
        }
    }
}
