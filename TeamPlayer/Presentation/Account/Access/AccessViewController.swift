//
//  AccessViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

final class AccessViewController: UIViewController {
    private lazy var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 23)
        label.textColor = .black
        label.text = "Доступ"
        return label
    }()
    
    private lazy var changeTariffButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сменить тариф", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(changeTariffButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: AccessPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc
    private func changeTariffButtonTapped() {
        
    }
}

extension AccessViewController {
    private func insertViews() {
        view.addSubview(generalLabel)
        view.addSubview(changeTariffButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        generalLabel.pinTop(to: self.view.topAnchor, 100)
        generalLabel.pinLeft(to: self.view.leadingAnchor, 15)
        
        changeTariffButton.pinBottom(to: self.view, 180)
        changeTariffButton.pinLeft(to: self.view, 22)
        changeTariffButton.pinRight(to: self.view, 22)
        changeTariffButton.setHeight(48)
    }
}

