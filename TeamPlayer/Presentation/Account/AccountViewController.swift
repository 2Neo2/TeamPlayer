//
//  AccountViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit
import Kingfisher

final class AccountViewController: UIViewController {
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = Constants.Colors.general
        return label
    }()
    
    private lazy var accountIconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = Constants.Images.plusButton
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    private lazy var accountIconButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.general
        button.layer.cornerRadius = 60
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var userDataButton: UIButton = {
        let button = UIButton()
        button.setTitle("Личные данные", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 20)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(userDataButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var securityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Безопасность", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 20)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(securityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var accessButton: UIButton = {
        let button = UIButton()
        button.setTitle("Доступ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 20)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(accessButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Помощь", for: .normal)
        button.setTitleColor(Constants.Colors.boldGray, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 20)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(helpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30.0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var presenter: AccountPresenter?
    
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
    private func securityButtonTapped() {
        presenter?.openSecurityFlow()
    }
    
    @objc
    private func userDataButtonTapped() {
        presenter?.openUserDataFlow()
    }
    
    @objc
    private func accessButtonTapped() {
        presenter?.openAccessFlow()
    }
    
    @objc
    private func helpButtonTapped() {
        presenter?.opeHelpFlow()
    }
    
    @objc
    private func accountButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

extension AccountViewController {
    private func insertViews() {
        [userDataButton, securityButton, accessButton, helpButton].forEach { button in
            buttonsStackView.addArrangedSubview(button)
        }
        accountIconButton.addSubview(accountIconView)
        view.addSubview(accountIconButton)
        view.addSubview(usernameLabel)
        view.addSubview(buttonsStackView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            accountIconButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            accountIconButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountIconButton.widthAnchor.constraint(equalToConstant: 150),
            accountIconButton.heightAnchor.constraint(equalToConstant: 150),
            
            accountIconView.centerXAnchor.constraint(equalTo: accountIconButton.centerXAnchor),
            accountIconView.centerYAnchor.constraint(equalTo: accountIconButton.centerYAnchor),
            accountIconView.heightAnchor.constraint(equalToConstant: 60),
            accountIconView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: accountIconButton.bottomAnchor, constant: 7.0),
            
            buttonsStackView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 75.0),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 270.0)
        ])
    }
}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        let data = selectedImage.jpegData(compressionQuality: 1.0)
        // save to db.
        
        UIView.animate(withDuration: 0.3) {
            self.accountIconView.pin(to: self.accountIconButton)
            self.accountIconView.image = selectedImage
            self.view.layoutIfNeeded()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


extension AccountViewController {
    func updateData(with model: UserViewModel) {
        UIView.animate(withDuration: 0.3) {
            self.usernameLabel.text = model.name
            if model.imageData.isEmpty == false {
                if let url = URL(string: model.imageData) {
                    self.accountIconView.kf.indicatorType = .activity
                    self.accountIconView.kf.setImage(with: url)
                }
            } else {
                self.accountIconView.image = Constants.Images.defaultAccountIcon
            }
            self.accountIconView.pinTop(to: self.accountIconButton)
            self.view.layoutIfNeeded()
        }
    }
}
