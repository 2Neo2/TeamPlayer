//
//  JoinViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 18.04.2024.
//

import UIKit

final class JoinViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Присоединиться к сообществу"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var codeTextField: CustomTextField = {
        let field = CustomTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.placeholder = "Код сообщества"
        field.layer.cornerRadius = 10
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.font = Constants.Font.getFont(name: "Bold", size: 17)
        return field
    }()
    
    private lazy var cancelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.cancelButton
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var joinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Присоединиться", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: JoinPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc
    private func cancelButtonTapped() {
        presenter?.hideView()
    }
    
    @objc
    private func createButtonTapped() {
        guard
              codeTextField.text?.isEmpty != true
        else {
            return
        }
        
        presenter?.fetchRoom(with: codeTextField.text!)
    }
    
    func notifyObserves() {
        NotificationCenter.default.post(name: NotificationCenter.updateRoomVC, object: nil)
        NotificationCenter.default.post(name: NotificationCenter.updateLibraryVC, object: nil)
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}

extension JoinViewController {
    private func insertViews() {
        cancelButton.addSubview(cancelImageView)
        view.addSubview(titleLabel)
        view.addSubview(cancelButton)
        view.addSubview(codeTextField)
        view.addSubview(joinButton)
        
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideTextField))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func layoutViews() {
        cancelButton.pinTop(to: self.view, 80)
        cancelButton.pinRight(to: self.view, 30)
        
        cancelImageView.pinCenter(to: cancelButton)
        cancelImageView.setWidth(25)
        cancelImageView.setHeight(30)
        
        titleLabel.pinTop(to: self.view, 76)
        titleLabel.pinLeft(to: self.view, 30)
        titleLabel.setWidth(210)
        
        codeTextField.pinTop(to: titleLabel.bottomAnchor, 30)
        codeTextField.pinLeft(to: self.view, 30)
        codeTextField.setHeight(48)
        codeTextField.setWidth(200)
        
        joinButton.pinTop(to: codeTextField.bottomAnchor, 80)
        joinButton.pinLeft(to: self.view, 30)
        joinButton.pinRight(to: self.view, 30)
        joinButton.setHeight(48)
    }
}
