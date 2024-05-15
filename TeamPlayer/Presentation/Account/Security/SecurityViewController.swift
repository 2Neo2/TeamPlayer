//
//  SecurityViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

final class SecurityViewController: UIViewController {
    private lazy var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 23)
        label.textColor = .black
        label.text = "Безопасность"
        return label
    }()
    
    private lazy var emailButton: CustomButtonSecurity = {
        let button = CustomButtonSecurity()
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.general?.cgColor
        button.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var passwordButton: UIButton = {
        let button = CustomButtonSecurity(text: "Смена пароля")
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.general?.cgColor
        button.addTarget(self, action: #selector(passwordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            emailButton, passwordButton
        ])
        stack.axis = .vertical
        stack.spacing = 17.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = CustomButtonSecurity(text: "Выйти", image: Constants.Images.logoutImage)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: SecurityPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.fetchData()
    }
    
    @objc
    private func emailButtonTapped() {
        presenter?.openEmailFlow()
    }
    
    @objc
    private func passwordButtonTapped() {
        presenter?.openPasswordFlow()
    }
    
    @objc
    private func logoutButtonTapped() {
        presenter?.logoutFlow()
    }
}

extension SecurityViewController {
    private func insertViews() {
        view.addSubview(generalLabel)
        view.addSubview(buttonsStackView)
        view.addSubview(logoutButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        generalLabel.pinTop(to: self.view, 100)
        generalLabel.pinLeft(to: self.view, 15)
        
        buttonsStackView.pinLeft(to: self.view, 22)
        buttonsStackView.pinRight(to: self.view, 22)
        buttonsStackView.pinTop(to: generalLabel.bottomAnchor, 39)
        
        logoutButton.pinBottom(to: self.view, 180)
        logoutButton.pinLeft(to: self.view, 22)
        logoutButton.pinRight(to: self.view, 22)
    }
}

extension SecurityViewController {
    func updateData(with model: UserViewModel) {
        UIView.animate(withDuration: 0.3) {
            self.emailButton.setCustomTitile(with: model.email)
        }
    }
    
    func showSomeError() {
        
    }
}
