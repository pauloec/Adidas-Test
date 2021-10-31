//
//  ControllerType.swift
//  Core
//
//  Created by Paulo Correa on 2021/07/11.
//

import Foundation

public protocol ControllerType {
    associatedtype ViewModelType
    func configViewModel(viewModel: ViewModelType)
    func bindViewModel()
    func setupViews()
}
