//
//  PasswordViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.04.2024.
//

import UIKit

final class PasswordViewController: UIViewController {
    private lazy var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 23)
        label.textColor = .black
        label.text = "Смена пароля"
        return label
    }()
    
    private lazy var oldPasswordField: UITextField = {
        let textField = CustomTextFieldView(image: Constants.Images.security ?? UIImage(), padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Введите старый пароль"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var newPasswordField: UITextField = {
        let textField = CustomTextFieldView(image: Constants.Images.security ?? UIImage(), padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Введите новый пароль"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var confirmPasswordField: UITextField = {
        let textField = CustomTextFieldView(image: Constants.Images.security ?? UIImage(), padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Подтвердите новый пароль"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var fieldsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [oldPasswordField, newPasswordField, confirmPasswordField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: PasswordPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc
    private func saveButtonTapped() {
        guard newPasswordField.text?.isEmpty != true,
              oldPasswordField.text?.isEmpty != true,
              confirmPasswordField.text?.isEmpty != true
        else {
            return
        }
        
        if newPasswordField.text! != confirmPasswordField.text! {
            return
        }
        
        presenter?.fetchData(with: confirmPasswordField.text!, value: oldPasswordField.text!)
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}

extension PasswordViewController {
    private func insertViews() {
        view.addSubview(generalLabel)
        view.addSubview(fieldsVStackView)
        view.addSubview(saveButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        createCustomTabBarLeftButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideTextField))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func layoutViews() {
        generalLabel.pinTop(to: self.view.topAnchor, 100)
        generalLabel.pinLeft(to: self.view.leadingAnchor, 15)
        
        fieldsVStackView.pinTop(to: generalLabel.bottomAnchor, 34.0)
        fieldsVStackView.pinLeft(to: self.view, 22)
        fieldsVStackView.pinRight(to: self.view, 22)
        
        saveButton.pinBottom(to: self.view, 180)
        saveButton.pinLeft(to: self.view, 22)
        saveButton.pinRight(to: self.view, 22)
        saveButton.setHeight(48)
    }
}

extension PasswordViewController {
    func showSomeError() {
        
    }
}
