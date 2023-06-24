//
//  Counter.swift
//  SwiftUIStates
//
//  Created by Paige Sun on 2023-06-23.
//
import SwiftUI

class Counter: ObservableObject {
    @Published var current: Int {
        didSet {
            print("didSet Counter: \(current) ")
        }
    }
    
    init(_ current: Int = 0) {
        self.current = current
    }
}

class StringCounter: ObservableObject {
    @Published var current: String {
        didSet {
            print("didSet StringCounter: \(current) ")
        }
    }
    
    init(_ current: Int = 0) {
        self.current = "\(current)"
    }
}
