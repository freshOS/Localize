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
        _ = NSLocalizedString("UntranslatedKey", comment: "")
        _ = NSLocalizedString("IgnoredUntranslatedKey", comment: "")
        _ = NSLocalizedString("MissingKey", comment: "")
    }
}
