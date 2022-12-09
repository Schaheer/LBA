//
//  Observable.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 10/03/2022.
//

import Foundation
import UIKit

//class Observable<T> {
//
//    var value: T {
//        didSet {
//            listener?(value)
//        }
//    }
//
//    private var listener: ((T) -> Void)?
//
//    init(_ value: T) {
//        self.value = value
//    }
//
//    func bind(_ closure: @escaping (T) -> Void) {
//        closure(value)
//        listener = closure
//    }
//}

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
