//
//  CustomMembersButton.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 17.04.2024.
//

import UIKit

final class CustomMembersButton: UIButton {
    private lazy var titleInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Constants.Font.getFont(name: "Black", size: 12)
        label.textColor = .white
        return label
    }()
    
    private lazy var imageButtonView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.arrowDown
        imageView.tintColor = .white
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        insertViews()
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
   }
}

extension CustomMembersButton {
    private func insertViews() {
        self.addSubview(titleInfoLabel)
        self.addSubview(imageButtonView)
    }
    
    private func setupViews() {
        self.backgroundColor = Constants.Colors.generalLight
        self.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        titleInfoLabel.pinTop(to: self, 5)
        titleInfoLabel.pinLeft(to: self, 20)
        titleInfoLabel.pinBottom(to: self, 5)
        
        imageButtonView.pinTop(to: self, 11)
        imageButtonView.pinRight(to: self, 20)
        imageButtonView.pinBottom(to: self, 11)
        imageButtonView.pinLeft(to: titleInfoLabel.trailingAnchor, 10)
    }
}

extension CustomMembersButton {
    func setCustomTitle(with title: String) {
        titleInfoLabel.text = title
    }
}
