//
//  TitleSearchCollectionReusableView.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.05.2024.
//

import UIKit

class TitleSearchCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleSearchCollectionReusableView"
    
    private lazy var infoSectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .white
        label.text = "Недавно искали"
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
}

extension TitleSearchCollectionReusableView {
    private func insertViews() {
        addSubview(infoSectionTitleLabel)
    }
    
    private func setupViews() {
        backgroundColor = .clear
    }
    
    private func layoutViews() {
        infoSectionTitleLabel.pinTop(to: self, 7)
        infoSectionTitleLabel.pinLeft(to: self, 10)
    }
}

