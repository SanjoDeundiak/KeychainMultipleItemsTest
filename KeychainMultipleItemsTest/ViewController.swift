//
//  ViewController.swift
//  KeychainMultipleItemsTest
//
//  Created by Oleksandr Deundiak on 9/6/17.
//  Copyright © 2017 Oleksandr Deundiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        KeychainWrapper().addOneItem()
        KeychainWrapper().addTwoItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

