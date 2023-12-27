//
//  NewsCollectionViewCell.swift
//  AccessibleNews
//
//  Created by Ani's Mac on 27.12.23.
//

import UIKit

final class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 5
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var titleTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - CellLifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoImageView.image = nil
        titleLabel.text = nil
        textLabel.text = nil
    }
    
    // MARK: - Private Methods
    private func addSubview() {
        contentView.addSubview(infoImageView)
        contentView.addSubview(titleTextStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoImageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            titleTextStackView.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 8),
            titleTextStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleTextStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configureAccessibility() {
        isAccessibilityElement = true
        accessibilityLabel = "Title: \(titleLabel.text ?? ""), Description: \(textLabel.text ?? "")"
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        textLabel.text = article.description
        configureAccessibility()
        
        setImage(from: article.urlToImage ?? "placeholder")
    }
    
    private func setImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.infoImageView.image = image
            }
        }
    }
}
