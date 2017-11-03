//
//  ViewController.swift
//  LocalizeExample
//
//  Created by Sacha DSO on 03/11/2017.
//  Copyright © 2017 freshos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here simulates their usage in code
        let _ = NSLocalizedString("UntranslatedKey", comment: "")
        let _ = NSLocalizedString("IgnoredUntranslatedKey", comment: "")
        let _ = NSLocalizedString("MissingKey", comment: "")
    }
}

