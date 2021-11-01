//
//  ProductListCell.swift
//  ProductList
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

import UIKit
import SnapKit
import Core
import RxSwift

class ProductListCell: UITableViewCell, ControllerType {
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

    typealias ViewModelType = ProductListCellViewModel
    private weak var viewModel: ViewModelType!
    private var disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupViews()
    }

    func configViewModel(viewModel: ProductListCellViewModel) {
        self.viewModel = viewModel
        bindViewModel()
    }

    func bindViewModel() {
        let output = viewModel.output
        disposeBag.insert(
            output.name
                .bind(to: nameLabel.rx.text),
            output.price
                .bind(to: priceLabel.rx.text),
            output.description
                .bind(to: descriptionLabel.rx.text),
            output.image 
                .bind(to: productImageView.rx.image)
        )
    }

    func setupViews() {
        [productImageView, textStack].forEach {
            contentView.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(LayoutConstraint.ProductImage.top)
            $0.height.width.equalTo(LayoutConstraint.ProductImage.height)
            $0.bottom.equalToSuperview()
        }

        textStack.snp.makeConstraints {
            $0.top.equalTo(productImageView)
            $0.leading.equalTo(productImageView.snp.trailing).offset(LayoutConstraint.TextStack.leading)
            $0.trailing.equalToSuperview().offset(LayoutConstraint.TextStack.trailing)
        }

        [nameLabel, descriptionLabel, priceLabel].forEach {
            textStack.addArrangedSubview($0)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension ProductListCell {
    struct LayoutConstraint {
        struct ProductImage {
            static let top = 20
            static let height = 100
        }
        struct TextStack {
            static let leading = 10
            static let trailing = -20
        }
    }
}
