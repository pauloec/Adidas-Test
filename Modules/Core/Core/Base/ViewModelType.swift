//
//  ViewModelType.swift
//  Core
//
//  Created by Paulo Correa on 2020/10/27.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
}
