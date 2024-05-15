//
//  TitleHeaderCollectionReusableView.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.05.2024.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private lazy var infoSectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        infoSectionTitleLabel.text = title
    }
}

extension TitleHeaderCollectionReusableView {
    private func insertViews() {
        addSubview(infoSectionTitleLabel)
    }
    
    private func setupViews() {
        backgroundColor = .clear
    }
    
    private func layoutViews() {
        infoSectionTitleLabel.pin(to: self)
    }
}
