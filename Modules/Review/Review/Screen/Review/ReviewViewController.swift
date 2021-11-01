//
//  ReviewViewController.swift
//  Review
//
//  Created by Paulo Correa on 10/5/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa
import Core
import SnapKit

class ReviewViewController: UIViewController {
    private var viewModel: ReviewViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViews()
        viewModel.input.onLoading.onNext(())
    }
}

extension ReviewViewController: ControllerType {
    typealias ViewModelType = ReviewViewModel
    
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
        label.text = "Review"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupDisplay(display: ReviewDisplayModel) {
        title = display.title
    }
}
