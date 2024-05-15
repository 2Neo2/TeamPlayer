//
//  SelectedRoomViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

final class SelectedRoomViewController: UIViewController {
    private lazy var membersButton: CustomMembersButton = {
        let button = CustomMembersButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(membersListButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitRoomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.general
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 12)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(exitButtonTaped), for: .touchUpInside)
        return button
    }()
    
    private lazy var creatorInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Black", size: 12)
        label.textColor = Constants.Colors.placeholder
        label.textAlignment = .center
        label.text = "Создатель: "
        return label
    }()
    
    private lazy var creatorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 12)
        label.textColor = Constants.Colors.placeholder
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.searchButton
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var plusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.plusButton
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var favouritesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var favouritesIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.starIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var linkIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.linkIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var soundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(soundButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var soundIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.soundIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 26.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var musicIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Constants.Colors.general?.cgColor
        return imageView
    }()
    
    private lazy var musicNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 18)
        label.textColor = .black
        label.text = "Eminem - Lose Yourself"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.playIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var forwardPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var forwardPlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.forwardPlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var backwardPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var backwardPlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.backwardPlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var chatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.general
        button.setTitle("Чат", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 12)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playlistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.generalLight
        button.setTitle("Плейлист", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 12)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(playlistButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: SelectedRoomPresenter?
    var currentRoom: RoomViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        guard let creatorID = currentRoom?.creatorID else {return}
        presenter?.fetchUserData(by: creatorID)
    }
    
    @objc
    private func membersListButtonTapped() {
        presenter?.openMembersFlow(with: currentRoom?.id)
    }
    
    @objc
    private func exitButtonTaped() {
        // connect to the servier
        
        presenter?.hideView()
    }
    
    @objc
    private func searchButtonTapped() {
        presenter?.openSearchFlow()
    }
    
    @objc
    private func plusButtonTapped() {
        
    }
    
    @objc
    private func favouritesButtonTapped() {
        self.favouritesButton.isSelected.toggle()
        
        if self.favouritesButton.isSelected {
            favouritesIcon.image = Constants.Images.fillStarIcon
        } else {
            favouritesIcon.image = Constants.Images.starIcon
        }
    }
    
    @objc
    private func linkButtonTapped() {
        
    }
    
    @objc
    private func soundButtonTapped() {
        self.soundButton.isSelected.toggle()
        
        if self.soundButton.isSelected {
            soundIcon.image = Constants.Images.speakerSlach
        } else {
            soundIcon.image = Constants.Images.soundIcon
        }
    }
    
    @objc
    private func forwardButtonTapped() {
        
    }
    
    @objc
    private func backwardButtonTapped() {
        
    }
    
    @objc
    private func playButtonTapped() {
        self.playButton.isSelected.toggle()
        
        if self.playButton.isSelected {
            playIcon.image = Constants.Images.pauseIcon
        } else {
            playIcon.image = Constants.Images.playIcon
        }
    }
    
    @objc
    private func chatButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.chatButton.backgroundColor = Constants.Colors.general
            self.playlistButton.backgroundColor = Constants.Colors.generalLight
        }
    }
    
    @objc
    private func playlistButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.chatButton.backgroundColor = Constants.Colors.generalLight
            self.playlistButton.backgroundColor = Constants.Colors.general
        }
    }
}

extension SelectedRoomViewController {
    private func insertViews() {
        searchButton.addSubview(searchIcon)
        plusButton.addSubview(plusIcon)
        favouritesButton.addSubview(favouritesIcon)
        linkButton.addSubview(linkIcon)
        soundButton.addSubview(soundIcon)
        playButton.addSubview(playIcon)
        forwardPlayButton.addSubview(forwardPlayIcon)
        backwardPlayButton.addSubview(backwardPlayIcon)
        
        [plusButton, favouritesButton, linkButton, soundButton].forEach { button in
            buttonsStackView.addArrangedSubview(button)
        }
        
        view.addSubview(membersButton)
        view.addSubview(exitRoomButton)
        view.addSubview(creatorInfoLabel)
        view.addSubview(creatorNameLabel)
        view.addSubview(searchButton)
        view.addSubview(buttonsStackView)
        view.addSubview(musicIconView)
        view.addSubview(musicNameLabel)
        view.addSubview(playButton)
        view.addSubview(forwardPlayButton)
        view.addSubview(backwardPlayButton)
        view.addSubview(chatButton)
        view.addSubview(playlistButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        self.membersButton.setCustomTitle(with: currentRoom?.name ?? "Моя комната")
        self.createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        membersButton.pinLeft(to: self.view, 65)
        membersButton.pinTop(to: self.view, 63)
        exitRoomButton.pinLeft(to: membersButton.trailingAnchor, 10)
        exitRoomButton.pinTop(to: membersButton.topAnchor)
        exitRoomButton.pinRight(to: self.view, 101)
        exitRoomButton.pinBottom(to: membersButton.bottomAnchor)
        
        creatorInfoLabel.pinTop(to: membersButton.bottomAnchor, 13)
        creatorInfoLabel.pinLeft(to: self.view, 30)
        creatorNameLabel.pinLeft(to: self.creatorInfoLabel.trailingAnchor, 5)
        creatorNameLabel.pinTop(to: membersButton.bottomAnchor, 13)
        
        searchIcon.pin(to: searchButton)
        plusIcon.pin(to: plusButton)
        favouritesIcon.pin(to: favouritesButton)
        linkIcon.pin(to: linkButton)
        soundIcon.pin(to: soundButton)
        playIcon.pin(to: playButton)
        forwardPlayIcon.pin(to: forwardPlayButton)
        backwardPlayIcon.pin(to: backwardPlayButton)
        
        searchButton.pinRight(to: self.view, 36)
        searchButton.pinLeft(to: exitRoomButton.trailingAnchor, 36)
        searchButton.pinTop(to: exitRoomButton.topAnchor, 7)
        searchButton.setHeight(30)
        
        buttonsStackView.pinRight(to: self.view, 36)
        buttonsStackView.pinTop(to: searchButton.bottomAnchor, 46)
        buttonsStackView.setWidth(40)
        
        musicIconView.pinTop(to: creatorInfoLabel.bottomAnchor, 8)
        musicIconView.pinLeft(to: self.view, 30)
        musicIconView.pinRight(to: buttonsStackView.leadingAnchor, 38)
        musicIconView.pinBottom(to: buttonsStackView.bottomAnchor, -9)
        
        musicNameLabel.pinTop(to: musicIconView.bottomAnchor, 12)
        musicNameLabel.pinCenterX(to: self.view.centerXAnchor)
        
        playButton.pinTop(to: musicNameLabel.bottomAnchor, 32)
        playButton.pinCenterX(to: self.view.centerXAnchor)
        
        backwardPlayButton.pinRight(to: playButton.leadingAnchor, 100)
        backwardPlayButton.pinTop(to: playButton.topAnchor, 3)
        backwardPlayButton.setWidth(50)
        
        forwardPlayButton.pinTop(to: playButton.topAnchor, 3)
        forwardPlayButton.pinLeft(to: playButton.trailingAnchor, 100)
        forwardPlayButton.setWidth(50)
        
        chatButton.pinLeft(to: self.view, 30)
        chatButton.setHeight(27)
        chatButton.setWidth(72)
        chatButton.pinTop(to: forwardPlayButton.bottomAnchor, 63)
        
        playlistButton.pinLeft(to: chatButton.trailingAnchor, 10)
        playlistButton.setHeight(27)
        playlistButton.setWidth(125)
        playlistButton.pinTop(to: chatButton.topAnchor)
    }
}

extension SelectedRoomViewController {
    func updateDataOnView(with name: String) {
        self.creatorNameLabel.text = name
    }
}
