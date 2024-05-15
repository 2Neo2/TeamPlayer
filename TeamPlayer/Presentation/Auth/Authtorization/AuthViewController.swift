//
//  AuthViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.04.2024.
//

import UIKit

class AuthViewController: UIViewController {
    // MARK: - UIViews.
    private lazy var mainIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.authIcon
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вход"
        label.font = Constants.Font.getFont(name: "ExtraBold", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(image: nil, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Введите почту"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(image: Constants.Images.security ?? UIImage(), padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Введите пароль"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var forgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль ?", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 16)
        button.setTitleColor(Constants.Colors.general, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
    
        let rightAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: Constants.Colors.general!,
            NSAttributedString.Key.font: Constants.Font.getFont(name: "Bold", size: 16),
        ]
        
        let leftAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: Constants.Font.getFont(name: "Light", size: 16)
        ]
        
        let attributedString = NSMutableAttributedString(string: "Нет аккаунта?", attributes: leftAttributes)
        attributedString.append(NSAttributedString(string: " Регистрация", attributes: rightAttributes))

        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Variables.
    var presenter: AuthPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertView()
        setupView()
        layoutViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideTextField))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Button Actions
    @objc
    private func signInButtonTapped() {
        guard
              emailTextField.text?.isEmpty != true,
              passwordTextField.text?.isEmpty != true
        else {
            SnackBar.make(in: self.view, message: "Заполните все поля!", duration: .lengthLong).show()
            return
        }
        
        let model = UserAuthModel(email: emailTextField.text!, password: passwordTextField.text!)
        presenter?.fetchUser(with: model)
    }
    
    @objc
    private func authButtonTapped() {
        presenter?.openRegFlow()
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}


extension AuthViewController {
    func setupView() {
        self.view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    func insertView() {
        view.addSubview(mainIconView)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotButton)
        view.addSubview(signInButton)
        view.addSubview(authButton)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            mainIconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            mainIconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17.0),
            mainIconView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17.0),
            
            titleLabel.topAnchor.constraint(equalTo: mainIconView.bottomAnchor, constant: 20.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20.0),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4.0),
            forgotButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            signInButton.heightAnchor.constraint(equalToConstant: 56.0),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 176.0),
            
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            authButton.heightAnchor.constraint(equalToConstant: 56.0),
            authButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16.0),
        ])
    }
}

extension AuthViewController {
    func showSomeError(with text: String) {
        SnackBar.make(in: self.view, message: text, duration: .lengthLong).show()
    }
}
