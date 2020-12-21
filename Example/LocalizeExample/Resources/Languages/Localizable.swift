//
//  Localizable.swift
//  LocalizeExample
//
//  Created by Kaiser Abliz on 12/21/20.
//  Copyright © 2020 freshos. All rights reserved.
//

import Foundation

enum Localizable: String {
    
    case title_test
    
    var localized: String {
        return self.rawValue.localized
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
