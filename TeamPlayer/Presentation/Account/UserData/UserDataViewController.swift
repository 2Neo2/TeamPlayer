//
//  UserDataViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

final class UserDataViewController: UIViewController {
    private lazy var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 23)
        label.textColor = .black
        label.text = "Личные данные"
        return label
    }()
    
    private lazy var newNameField: UITextField = {
        let textField = CustomTextFieldView(image: nil, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Введите имя"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var newSurnameField: UITextField = {
        let textField = CustomTextFieldView(image: nil, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0))
        textField.textColor = Constants.Colors.textGray
        textField.placeholder = "Введите фамилию"
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var fieldsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newNameField, newSurnameField])
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
    
    var presenter: UserDataPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.updateDataOnView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.updateDataOnView()
    }
    
    @objc
    private func saveButtonTapped() {
        guard newNameField.text?.isEmpty != true,
              newSurnameField.text?.isEmpty != true
        else {
            return
        }
        
        presenter?.fetchData(with: "\(newNameField.text!) \(newSurnameField.text!)")
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}

extension UserDataViewController {
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

extension UserDataViewController {
    func showSomeError() {
        
    }
    
    func updateDataOnView(with name: String) {
        let values = name.split(separator: " ")
        let firstName = String(values[0])
        let secondName = String(values[1])
        
        UIView.animate(withDuration: 0.3) {
            self.newNameField.placeholder = firstName
            self.newSurnameField.placeholder = secondName
        }
    }
}

