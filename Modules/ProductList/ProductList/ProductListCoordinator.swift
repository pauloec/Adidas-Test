//
//  ProductListCoordinator.swift
//  ProductList
//
//  Created by Paulo Correa on 10/5/2564 BE.
//

import Core
import RxCocoa
import RxSwift

public class ProductListCoordinator: CoordinatorType {
    public var navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    private let callBack: ((String) -> Void)

    public init(navigationController: UINavigationController, callBack: @escaping ( (String) -> Void)) {
        self.navigationController = navigationController
        self.callBack = callBack
    }

    public func start() {
        let viewModel = ProductListViewModel()
        let rootViewController = ProductListViewController()
        rootViewController.configViewModel(viewModel: viewModel)
        viewModel
            .output
            .onNext
            .subscribe(onNext: { [weak self] productId in
                self?.navigateToProductDetail(productId: productId)
            })
            .disposed(by: disposeBag)

        self.navigationController.pushViewController(rootViewController, animated: true)
    }

    private func navigateToProductDetail(productId: String) {
        let viewModel = ProductDetailViewModel()
        let rootViewController = ProductDetailViewController()
        rootViewController.configViewModel(viewModel: viewModel)
        viewModel
            .output
            .onNext
            .subscribe(onNext: { [weak self] productId in
                self?.callBack(productId)
            })
            .disposed(by: disposeBag)
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
}
