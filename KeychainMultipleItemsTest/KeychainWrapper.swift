//
//  KeychainWrapper.swift
//  KeychainMultipleItemsTest
//
//  Created by Oleksandr Deundiak on 9/6/17.
//  Copyright © 2017 Oleksandr Deundiak. All rights reserved.
//

import Foundation

class KeychainWrapper {
    private func generatePrivateKeyAttributesDictionary(name: String) -> [NSString : AnyObject] {
        // Just generate some random data instead of private key
        var privateKey = Data(count: 16)
        privateKey.withUnsafeMutableBytes({
            NSUUID().getBytes($0)
        })
        
        let attributes: [NSString : AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            kSecAttrApplicationLabel: name as NSString,
            kSecAttrApplicationTag: name.data(using: .utf8)! as NSData
        ]
        
        return attributes
    }
    
    private func generatePrivateKeyQueryDictionary(name: String) -> [NSString : AnyObject] {
        let query: [NSString : AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            kSecAttrApplicationLabel: name as NSString,
            kSecAttrApplicationTag: name.data(using: .utf8)! as NSData
        ]
        
        return query
    }
    
    func addAndCheckOneItem() {
        let name = UUID().uuidString
        
        let attributes = self.generatePrivateKeyAttributesDictionary(name: name)
    
        let status = SecItemAdd(attributes as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Added one key successfully")
        }
        else {
            print("Error while adding one key: \(status)")
        }
        
        let query = self.generatePrivateKeyQueryDictionary(name: name)
        
        let status1 = SecItemCopyMatching(query as CFDictionary, nil)
        
        if status1 == errSecSuccess {
            print("Obtained one key successfully")
        }
        else {
            print("Error while obtaining one key: \(status)")
        }
    }
    
    func addAndCheckTwoItems() {
        let name1 = UUID().uuidString
        let name2 = UUID().uuidString
        
        let attributes1 = self.generatePrivateKeyAttributesDictionary(name: name1)
        let attributes2 = self.generatePrivateKeyAttributesDictionary(name: name2)
        
        let attributesArray = [attributes1, attributes2] as NSArray
        
        let attributes: [NSString : AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            kSecUseItemList: attributesArray,
        ]
        
        let status = SecItemAdd(attributes as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Added two keys successfully")
        }
        else {
            print("Error while adding two keys: \(status)")
        }
        
        let query1 = self.generatePrivateKeyQueryDictionary(name: name1)
        
        let status1 = SecItemCopyMatching(query1 as CFDictionary, nil)
        
        if status1 == errSecSuccess {
            print("Obtained first of two keys successfully")
        }
        else {
            print("Error while obtaining first of two keys: \(status1)")
        }
        
        let query2 = self.generatePrivateKeyQueryDictionary(name: name2)
        
        let status2 = SecItemCopyMatching(query2 as CFDictionary, nil)
        
        if status2 == errSecSuccess {
            print("Obtained second of two keys successfully")
        }
        else {
            print("Error while obtaining second of two keys: \(status2)")
        }
    }
}
