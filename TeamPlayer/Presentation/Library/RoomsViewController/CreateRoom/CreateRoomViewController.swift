//
//  CreateRoomViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.04.2024.
//

import UIKit

final class CreateRoomViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Создать сообщество"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var photoIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.photoIcon
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var iconButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 13
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        return button
    }()
    
    private let squareCheckmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .black
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let checkboxLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        label.text = "Приватная комната ?"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var cancelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.cancelButton
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var nameTextField: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = .white
        field.placeholder = "Название комнаты"
        field.layer.cornerRadius = 10
        field.font = Constants.Font.getFont(name: "Bold", size: 17)
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    private lazy var descriptionTextField: CustomTextField = {
        let field = CustomTextField()
        field.backgroundColor = .white
        field.placeholder = "Введите описание сообщества"
        field.layer.cornerRadius = 10
        field.font = Constants.Font.getFont(name: "Bold", size: 17)
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Создать комнату", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: CreateRoomPresenter?
    private var imageData: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc
    private func checkboxTapped() {
        self.checkboxButton.isSelected.toggle()
        
        if self.checkboxButton.isSelected {
            squareCheckmarkImageView.isHidden = false
        } else {
            squareCheckmarkImageView.isHidden = true
        }
    }
    
    @objc
    private func cancelButtonTapped() {
        presenter?.hideView()
    }
    
    @objc
    private func iconButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc
    private func createButtonTapped() {
        guard
              nameTextField.text?.isEmpty != true
        else {
            return
        }
        
        presenter?.fetchRoom(with: nameTextField.text!, isPrivate: checkboxButton.isSelected, image: imageData, description: descriptionTextField.text ?? "")
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
    
    func notifyObserves() {
        NotificationCenter.default.post(name: NotificationCenter.updateHomveVC, object: nil)
        NotificationCenter.default.post(name: NotificationCenter.updateRoomVC, object: nil)
        NotificationCenter.default.post(name: NotificationCenter.updateLibraryVC, object: nil)
    }
}

extension CreateRoomViewController {
    private func insertViews() {
        iconButton.addSubview(photoIconView)
        cancelButton.addSubview(cancelImageView)
        checkboxButton.addSubview(squareCheckmarkImageView)
        view.addSubview(titleLabel)
        view.addSubview(iconButton)
        view.addSubview(cancelButton)
        view.addSubview(nameTextField)
        view.addSubview(checkboxLabel)
        view.addSubview(checkboxButton)
        view.addSubview(createButton)
        view.addSubview(descriptionTextField)
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
        
        titleLabel.pinTop(to: self.view, 106)
        titleLabel.pinLeft(to: self.view, 30)
        
        iconButton.pinTop(to: titleLabel.bottomAnchor, 42)
        iconButton.setHeight(198)
        iconButton.pinLeft(to: self.view, 98)
        iconButton.pinRight(to: self.view, 98)
        
        photoIconView.pinCenter(to: iconButton)
        
        nameTextField.pinTop(to: iconButton.bottomAnchor, 15)
        nameTextField.pinLeft(to: self.view, 30)
        nameTextField.pinRight(to: self.view, 30)
        nameTextField.setHeight(48)
        
        descriptionTextField.pinTop(to: nameTextField.bottomAnchor, 10)
        descriptionTextField.pinLeft(to: self.view, 30)
        descriptionTextField.pinRight(to: self.view, 30)
        descriptionTextField.setHeight(70)
        
        checkboxLabel.pinTop(to: descriptionTextField.bottomAnchor, 25)
        checkboxLabel.pinLeft(to: self.view, 35)
        
        checkboxButton.pinTop(to: descriptionTextField.bottomAnchor, 23)
        checkboxButton.pinLeft(to: checkboxLabel.trailingAnchor, 15)
        checkboxButton.setWidth(25)
        checkboxButton.setHeight(25)
        
        createButton.pinTop(to: checkboxButton.bottomAnchor, 40)
        createButton.pinLeft(to: self.view, 30)
        createButton.pinRight(to: self.view, 30)
        createButton.setHeight(56)
        
        squareCheckmarkImageView.pin(to: checkboxButton)
    }
}

extension CreateRoomViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        self.imageData = imageData.base64EncodedString()
        
        UIView.animate(withDuration: 0.3) {
            self.photoIconView.pin(to: self.iconButton)
            self.photoIconView.image = selectedImage
            self.view.layoutIfNeeded()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
