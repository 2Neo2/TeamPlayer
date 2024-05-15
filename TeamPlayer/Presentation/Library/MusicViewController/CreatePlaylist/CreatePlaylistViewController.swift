//
//  CreatePlaylistViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol CreatePlaylistVCProtocol {
    func playlistCreated()
}

final class CreatePlaylistViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Создать плейлист"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var photoIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.photoIcon
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var iconButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 13
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
        return button
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
    
    private lazy var nameTextField: CustomTextField = {
        let field = CustomTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.placeholder = "Название плейлиста"
        field.layer.cornerRadius = 10
        field.font = Constants.Font.getFont(name: "Bold", size: 17)
        return field
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Создать плейлист", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: CreatePlaylistPresenter?
    private var imageData: String? = nil
    var delegate: CreatePlaylistVCProtocol?
    
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
        
        let model = PlaylistViewModel(id: UUID(), name: nameTextField.text!, imageData: (self.imageData ?? UIImage(named: "playlist")?.jpegData(compressionQuality: 1.0)?.base64EncodedString()))
        presenter?.fetchPlaylist(with: model)
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}

extension CreatePlaylistViewController {
    private func insertViews() {
        iconButton.addSubview(photoIconView)
        cancelButton.addSubview(cancelImageView)
        view.addSubview(titleLabel)
        view.addSubview(iconButton)
        view.addSubview(cancelButton)
        view.addSubview(nameTextField)
        view.addSubview(createButton)
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
        
        createButton.pinTop(to: nameTextField.bottomAnchor, 40)
        createButton.pinLeft(to: self.view, 30)
        createButton.pinRight(to: self.view, 30)
        createButton.setHeight(56)
    }
}

extension CreatePlaylistViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

