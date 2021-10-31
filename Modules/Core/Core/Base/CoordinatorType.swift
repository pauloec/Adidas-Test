//
//  CoordinatorType.swift
//  Core
//
//  Created by Paulo Correa on 2021/07/11.
//

import UIKit

public protocol CoordinatorType {
    var navigationController: UINavigationController { get set }
    func start()
}
