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
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let textStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let reviewScrollview: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private let reviewStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let addReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Review", for: .normal)
        return button
    }()

    private var viewModel: ProductDetailViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViews()
        viewModel.input.onDidLoad.onNext(())
    }
}

extension ProductDetailViewController: ControllerType {
    typealias ViewModelType = ProductDetailViewModel

    func configViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    func bindViewModel() {
        let output = viewModel.output
        disposeBag.insert(
            output.display.bind(to: Binder(self) { target, value in
                target.setupDisplay(display: value)
            })
        )
    }

    func setupViews() {
        view.backgroundColor = .white

        [productImageView, textStack, reviewScrollview, addReviewButton].forEach {
            view.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstraint.ProductImage.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstraint.ProductImage.trailing)
            $0.height.equalTo(productImageView.snp.width)
        }

        textStack.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(LayoutConstraint.TextStack.top)
            $0.leading.equalToSuperview().offset(LayoutConstraint.TextStack.leading)
            $0.trailing.equalToSuperview().offset(LayoutConstraint.TextStack.trailing)
        }

        [nameLabel, priceLabel, descriptionLabel].forEach {
            textStack.addArrangedSubview($0)
        }

        reviewScrollview.snp.makeConstraints {
            $0.top.equalTo(textStack.snp.bottom).offset(LayoutConstraint.ReviewScrolliew.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(addReviewButton.snp.top).offset(LayoutConstraint.ReviewScrolliew.bottom)
        }

        [reviewStack].forEach {
            reviewScrollview.addSubview($0)
        }

        reviewStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(LayoutConstraint.ReviewStack.leading)
            $0.trailing.equalToSuperview().offset(LayoutConstraint.ReviewStack.trailing)
        }

        addReviewButton.snp.makeConstraints {
            $0.height.equalTo(LayoutConstraint.AddReviewButton.height)
            $0.leading.equalToSuperview().offset(LayoutConstraint.AddReviewButton.leading)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstraint.AddReviewButton.bottom)
        }
    }

    func setupDisplay(display: ProductDetailDisplayModel) {
        title = display.title
        nameLabel.text = display.name
        priceLabel.text = display.price
        descriptionLabel.text = display.description

        for review in display.reviews {
            let label = UILabel()
            label.text = review
            reviewStack.addArrangedSubview(label)
        }

        display.image
            .bind(to: productImageView.rx.image)
            .disposed(by: disposeBag)
    }
}

extension ProductDetailViewController {
    struct LayoutConstraint {
        struct ProductImage {
            static let top = 20
            static let trailing = -20
        }
        struct TextStack {
            static let top = 20
            static let leading = 20
            static let trailing = -20
        }
        struct ReviewScrolliew {
            static let top = 20
            static let bottom = -20
        }
        struct ReviewStack {
            static let leading = 20
            static let trailing = -20
        }
        struct AddReviewButton {
            static let height = 50
            static let bottom = -20
            static let leading = 20
        }
    }
}
