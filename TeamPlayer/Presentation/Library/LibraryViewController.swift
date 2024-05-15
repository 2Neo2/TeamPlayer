//
//  LibraryViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.04.2024.
//

import UIKit

final class LibraryViewController: UIViewController {
    // MARK: - UIViews.
    private lazy var accountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.textGray?.cgColor
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.accountPerson
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Моя медиатека"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var scrollViewContent: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true 
        return scrollView
    }()
    
    private lazy var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.text = "Плейлисты"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var buttonMusic1: CustomButtonContent = {
        let button = CustomButtonContent(playIcon: Constants.Images.playIconCell!, model: LibraryItemViewModel(title: "Утренняя", subtitle: "Плейлист", icon: Constants.Images.musicItemCellIcon!))
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var buttonMusic2: CustomButtonContent = {
        let button = CustomButtonContent(playIcon: Constants.Images.playIconCell!, model: LibraryItemViewModel(title: "Чилл", subtitle: "Плейлист", icon: Constants.Images.musicItemCellIcon!))
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var buttonMusic3: CustomButtonContent = {
        let button = CustomButtonContent(playIcon: Constants.Images.playIconCell!, model: LibraryItemViewModel(title: "Спорт", subtitle: "Плейлист", icon: Constants.Images.musicItemCellIcon!))
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var buttonMusic4: CustomButtonContent = {
        let button = CustomButtonContent(playIcon: Constants.Images.playIconCell!, model: LibraryItemViewModel(title: "Под настроение", subtitle: "Плейлист", icon: Constants.Images.musicItemCellIcon!))
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var roomsTitileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.text = "Топ-3. Мои сообщества"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var roomsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10.0
        view.backgroundColor = Constants.Colors.generalLight
        return view
    }()
    
    private lazy var musicListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Слушать все", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = Constants.Colors.general
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(musicTitleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20.0
        return stackView
    }()
    
    private lazy var buttonRoom1: CustomButtonContent = {
        let button = CustomButtonContent(playIcon: Constants.Images.playIconCell!, model: LibraryItemViewModel(title: "Рабочаая мастерская", subtitle: "6 участников", icon: Constants.Images.musicItemCellIcon!))
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var buttonRoom2: CustomButtonContent = {
        let button = CustomButtonContent(playIcon: Constants.Images.playIconCell!, model: LibraryItemViewModel(title: "Палата 56", subtitle: "3 участника", icon: Constants.Images.musicItemCellIcon!))
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var buttonRoom3: CustomButtonContent = {
        let button = CustomButtonContent(playIcon: Constants.Images.playIconCell!, model: LibraryItemViewModel(title: "Студенческая", subtitle: "20 участников", icon: Constants.Images.musicItemCellIcon!))
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var roomsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var roomsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("К друзьям!", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 15)
        button.setTitleColor(Constants.Colors.general, for: .normal)
        button.addTarget(self, action: #selector(roomsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: LibraryPresenter?
    
    // MARK: - Init.
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    // MARK: - Actions.
    @objc
    private func accountButtonTapped() {
        presenter?.openAccountFlow()
    }
    
    @objc
    private func musicTitleButtonTapped() {
        presenter?.openMusicFlow()
    }
    
    @objc
    private func roomsButtonTapped() {
        presenter?.openRoomsFlow()
    }
}

extension LibraryViewController {
    private func insertViews() {
        accountButton.addSubview(accountImageView)
        
        [buttonMusic1, buttonMusic2, buttonMusic3, buttonMusic4].forEach { button in
            stackView.addArrangedSubview(button)
        }
        
        [buttonRoom1, buttonRoom2, buttonRoom3].forEach { button in
            roomsStackView.addArrangedSubview(button)
        }
        roomsView.addSubview(roomsTitileLabel)
        roomsView.addSubview(roomsStackView)
        roomsView.addSubview(roomsButton)
        
        mainStackView.addArrangedSubview(musicTitleLabel)
        mainStackView.addArrangedSubview(stackView)
        mainStackView.addArrangedSubview(musicListButton)
        mainStackView.addArrangedSubview(roomsView)
        
        scrollViewContent.addSubview(mainStackView)
        
        view.addSubview(accountButton)
        view.addSubview(titleLabel)
        view.addSubview(scrollViewContent)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            accountButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0),
            accountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            accountButton.heightAnchor.constraint(equalToConstant: 60.0),
            accountButton.widthAnchor.constraint(equalToConstant: 60.0),
            
            accountImageView.heightAnchor.constraint(equalToConstant: 35.0),
            accountImageView.widthAnchor.constraint(equalToConstant: 35.0),
            accountImageView.centerXAnchor.constraint(equalTo: accountButton.centerXAnchor),
            accountImageView.centerYAnchor.constraint(equalTo: accountButton.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: accountButton.trailingAnchor, constant: 10.0),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            
            scrollViewContent.topAnchor.constraint(equalTo: accountButton.bottomAnchor),
            scrollViewContent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollViewContent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            
            mainStackView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 30.0),
            mainStackView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -30.0),
            mainStackView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -100.0),
            mainStackView.widthAnchor.constraint(equalTo: scrollViewContent.widthAnchor, constant: -60.0),
            
            musicTitleLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            musicTitleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor, constant: 10.0),
            stackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            musicListButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20.0),
            musicListButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            musicListButton.heightAnchor.constraint(equalToConstant: 33.0),
            
            roomsView.topAnchor.constraint(equalTo: musicListButton.bottomAnchor, constant: 18.0),
            roomsView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            roomsView.heightAnchor.constraint(equalToConstant: 355),
            
            roomsTitileLabel.topAnchor.constraint(equalTo: roomsView.topAnchor, constant: 14.0),
            roomsTitileLabel.leadingAnchor.constraint(equalTo: roomsView.leadingAnchor, constant: 17.0),
            
            roomsStackView.topAnchor.constraint(equalTo: roomsTitileLabel.bottomAnchor, constant: 10.0),
            roomsStackView.leadingAnchor.constraint(equalTo: roomsView.leadingAnchor, constant: 17.0),
            roomsStackView.trailingAnchor.constraint(equalTo: roomsView.trailingAnchor, constant: -17.0),
            
            roomsButton.topAnchor.constraint(equalTo: roomsStackView.bottomAnchor, constant: 14.0),
            roomsButton.centerXAnchor.constraint(equalTo: roomsView.centerXAnchor),
            roomsButton.heightAnchor.constraint(equalToConstant: 43.0),
            roomsButton.widthAnchor.constraint(equalToConstant: 126)
        ])
    }
}

