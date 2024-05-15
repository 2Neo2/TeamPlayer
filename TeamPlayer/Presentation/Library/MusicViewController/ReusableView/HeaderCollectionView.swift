//
//  HeaderCollectionView.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.04.2024.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    static let reuseID = String(describing: HeaderCollectionView.self)
    
    private lazy var titleLabelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Музыка"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var gridFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(buttonGridTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.filterGridListButton
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    var gridAction: (() -> Void)?
    var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func insertViews() {
        addSubview(gridFilterButton)
        addSubview(titleLabelView)
        gridFilterButton.addSubview(filterImageView)
    }
    
    private func setupViews() {
        backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabelView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            titleLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            
            gridFilterButton.topAnchor.constraint(equalTo: topAnchor, constant: -4.0),
            gridFilterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            gridFilterButton.heightAnchor.constraint(equalToConstant: 62.0),
            gridFilterButton.widthAnchor.constraint(equalToConstant: 62.0),
            
            filterImageView.heightAnchor.constraint(equalToConstant: 24.0),
            filterImageView.widthAnchor.constraint(equalToConstant: 24.0),
            filterImageView.centerXAnchor.constraint(equalTo: gridFilterButton.centerXAnchor),
            filterImageView.centerYAnchor.constraint(equalTo: gridFilterButton.centerYAnchor),
        ])
    }
    
    @objc
    private func buttonGridTapped() {
        gridAction?()
    }
}
