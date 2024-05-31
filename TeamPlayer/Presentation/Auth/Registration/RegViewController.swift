//
//  RegViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.04.2024.
//

import UIKit

class RegViewController: UIViewController {
    // MARK: - UIViews.
    private lazy var mainIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.regIcon
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Регистрация"
        label.font = Constants.Font.getFont(name: "ExtraBold", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var userNameTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(image: nil, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Введите имя и фамилию"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
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
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var confirmTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(image: Constants.Images.security ?? UIImage(), padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Повторите пароль"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создать Аккаунт", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var regButton: UIButton = {
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
        
        let attributedString = NSMutableAttributedString(string: "Уже есть аккаунт?", attributes: leftAttributes)
        attributedString.append(NSAttributedString(string: " Войти", attributes: rightAttributes))
        
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(self, action: #selector(regButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Variables.
    var presenter: RegPresenter?
    
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
    private func createButtonTapped() {
        guard userNameTextField.text?.isEmpty != true,
              emailTextField.text?.isEmpty != true,
              passwordTextField.text?.isEmpty != true,
              confirmTextField.text?.isEmpty != true
        else {
            SnackBar.make(in: self.view, message: "Заполните все поля!", duration: .lengthLong).show()
            return
        }
        
        if passwordTextField.text != confirmTextField.text {
            SnackBar.make(in: self.view, message: "Пароли не совпадают!", duration: .lengthLong).show()
            return
        }
        let model = UserViewModel(name: userNameTextField.text!, email: emailTextField.text!, plan: "basic", imageData: "", password: passwordTextField.text!)
        
        presenter?.fetchUser(with: model)
    }
    
    @objc
    private func regButtonTapped() {
        presenter?.openAuthFlow()
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}


extension RegViewController {
    func setupView() {
        self.view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    func insertView() {
        view.addSubview(mainIconView)
        view.addSubview(titleLabel)
        view.addSubview(userNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmTextField)
        view.addSubview(createButton)
        view.addSubview(regButton)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            mainIconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            mainIconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17.0),
            mainIconView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17.0),
            mainIconView.heightAnchor.constraint(equalToConstant: 270),
            
            titleLabel.topAnchor.constraint(equalTo: mainIconView.bottomAnchor, constant: 20.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            
            userNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            userNameTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 16.0),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20.0),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            confirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20.0),
            confirmTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            confirmTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            confirmTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            createButton.heightAnchor.constraint(equalToConstant: 56.0),
            createButton.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 54.0),
            
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            regButton.heightAnchor.constraint(equalToConstant: 56.0),
            regButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 16.0),
        ])
    }
}

extension RegViewController {
    func showSomeError(with text: String) {
        SnackBar.make(in: self.view, message: text, duration: .lengthLong).show()
    }
}
