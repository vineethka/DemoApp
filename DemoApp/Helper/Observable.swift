//
//  Observable.swift
//  DemoApp
//
//  Created by Vineeth Aravindan on 05/03/19.
//  Copyright © 2019 vineeth. All rights reserved.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    private var valueChanged: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    /// Add closure as an observer and trigger the closure imeediately if fireNow = true
    func addObserver(_ onChange: ((T) -> Void)?) {
        valueChanged = onChange
    }
    
    func removeObserver() {
        valueChanged = nil
    }
}


extension String {
    
    static var emptyString : String {
        get {
            return ""
        }
    }
    
    var localized:String {
        get {
            return NSLocalizedString(self, comment: .emptyString)
        }
    }
}
