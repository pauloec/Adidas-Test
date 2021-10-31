//
//  ReviewCoordinator.swift
//  Review
//
//  Created by Paulo Correa on 10/5/2564 BE.
//

import Core
import RxCocoa
import RxSwift

public class ReviewCoordinator: CoordinatorType {
    public var navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    private let callBack: (() -> Void)

    public init(navigationController: UINavigationController, callBack: @escaping ( () -> Void)) {
        self.navigationController = navigationController
        self.callBack = callBack
    }

    public func start() {
        let viewModel = ReviewViewModel()
        let rootViewController = ReviewViewController()
        rootViewController.configViewModel(viewModel: viewModel)
        viewModel
            .output
            .onNext
            .subscribe(onNext: { [weak self] in
                self?.callBack()
            })
            .disposed(by: disposeBag)
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
}
