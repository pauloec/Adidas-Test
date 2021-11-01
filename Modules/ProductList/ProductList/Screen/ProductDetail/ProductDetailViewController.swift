//
//  ProductDetailViewController.swift
//  Core
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Core

class ProductDetailViewController: UIViewController {
    private var viewModel: ProductDetailViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViews()
        viewModel.input.onLoad.onNext(())
    }
}

extension ProductDetailViewController: ControllerType {
    typealias ViewModelType = ProductDetailViewModel

    func configViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    func bindViewModel() {
        let output = viewModel.output
        disposeBag.insert([
            output.display.bind(to: Binder(self) { target, value in
                target.setupDisplay(display: value)
            }),
            output.loading.subscribe(onNext: { [weak self] loading in
                if loading {
                    //
                } else {
                    //
                }
            }),
            output.error.subscribe(onNext: { [weak self] error in
                print(error.localizedDescription)
            })
        ])
    }

    func setupViews() {
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "ProductDetail"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupDisplay(display: ProductDetailDisplayModel) {
        title = display.title
    }
}
