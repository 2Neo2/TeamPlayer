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
        button.addTarget(self, action: #selector(membersListButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitRoomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.general
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 12)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(exitButtonTaped), for: .touchUpInside)
        return button
    }()
    
    private lazy var creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 12)
        label.textColor = Constants.Colors.placeholder
        label.textAlignment = .left
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView()
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
    
    private lazy var buttonsView: UIView = {
        let view = UIView()
        return view
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
        label.font = Constants.Font.getFont(name: "Bold", size: 18)
        label.textColor = .black
        label.text = "Eminem - Lose Yourself"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.playIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    private lazy var forwardPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var forwardPlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.forwardPlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var backwardPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var backwardPlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.backwardPlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var chatButton: UIButton = {
        let button = UIButton()
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
        button.backgroundColor = Constants.Colors.generalLight
        button.setTitle("Плейлист", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 12)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(playlistButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var musicProgressView: UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = Constants.Colors.placeholder
        progress.layer.cornerRadius = 5
        progress.progressTintColor = Constants.Colors.general
        return progress
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var scrollViewContent: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var collectionButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var playButtonsView: UIView = {
        let stackView = UIView()
        return stackView
    }()
    
    private lazy var musicButtonsView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var messageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            SelectedRoomViewController.createCollectionViewLayout()
        })
        collectionView.tag = 1
        return collectionView
    }()
    
    private lazy var playlistCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            SelectedRoomViewController.createCollectionViewLayout()
        })
        collectionView.tag = 2
        return collectionView
    }()
    
    private lazy var messageTextField: CustomMessageTextField = {
        let field = CustomMessageTextField()
        field.layer.borderWidth = 1
        field.layer.borderColor = Constants.Colors.boldGray!.cgColor
        field.layer.cornerRadius = 10
        field.font = Constants.Font.getFont(name: "Bold", size: 17)
        field.placeholder = "Сообщение"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    var presenter: SelectedRoomPresenter?
    var currentRoom: RoomViewModel?
    private var messages = [ChatMessageViewModel]()
    private var tracks = [TrackViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchChatHistory(by: currentRoom?.id)
        configurePlaylistCollectionView()
        configureMessageCollectionView()
        
        presenter?.connectToChat()
        presenter?.connectToStream()
        presenter?.fetchUserData(by: currentRoom?.creatorID ?? UUID())
    }
    
    @objc
    private func membersListButtonTapped() {
        presenter?.openMembersFlow(with: currentRoom?.id)
    }
    
    @objc
    private func exitButtonTaped() {
        guard let roomID = currentRoom?.id, let user = currentRoom?.creatorID else {return}
        presenter?.exitRoom(with: roomID, user)
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
            presenter?.fetchStream()
        } else {
            playIcon.image = Constants.Images.playIcon
        }
    }
    
    @objc
    private func chatButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.chatButton.backgroundColor = Constants.Colors.general
            self.playlistButton.backgroundColor = Constants.Colors.generalLight
            self.playlistCollectionView.isHidden = true
            self.messageCollectionView.isHidden = false
            self.messageTextField.isHidden = false
        }
    }
    
    @objc
    private func playlistButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.chatButton.backgroundColor = Constants.Colors.generalLight
            self.playlistButton.backgroundColor = Constants.Colors.general
            self.messageCollectionView.isHidden = true
            self.playlistCollectionView.isHidden = false
            self.messageTextField.isHidden = true
        }
    }
    
    private func configureMessageCollectionView() {
        messageCollectionView.register(
            ChatMessageCollectionViewCell.self,
            forCellWithReuseIdentifier: ChatMessageCollectionViewCell.identifier
        )
        
        messageCollectionView.register(
            TitleChatMessageCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleChatMessageCollectionReusableView.identifier
        )
        
        messageCollectionView.delegate = self
        messageCollectionView.dataSource = self
        messageCollectionView.backgroundColor = Constants.Colors.general
        messageCollectionView.layer.cornerRadius = 10
    }
    
    private func configurePlaylistCollectionView() {
        playlistCollectionView.register(
            TrackCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackCollectionViewCell.identifier
        )
        
        playlistCollectionView.register(
            TitlePlaylistCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitlePlaylistCollectionReusableView.identifier
        )
        
        playlistCollectionView.isHidden = true
        playlistCollectionView.delegate = self
        playlistCollectionView.dataSource = self
        playlistCollectionView.backgroundColor = Constants.Colors.boldGray
        playlistCollectionView.layer.cornerRadius = 10
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}

extension SelectedRoomViewController {
    private func insertViews() {
        view.addSubview(scrollViewContent)
        view.addSubview(membersButton)
        view.addSubview(exitRoomButton)
        view.addSubview(searchButton)
        scrollViewContent.addSubview(mainStackView)
        
        searchButton.addSubview(searchIcon)
        plusButton.addSubview(plusIcon)
        favouritesButton.addSubview(favouritesIcon)
        linkButton.addSubview(linkIcon)
        playButton.addSubview(playIcon)
        forwardPlayButton.addSubview(forwardPlayIcon)
        backwardPlayButton.addSubview(backwardPlayIcon)
        
        [plusButton, favouritesButton, linkButton].forEach { button in
            buttonsView.addSubview(button)
        }
        
        collectionButtonStackView.addArrangedSubview(chatButton)
        collectionButtonStackView.addArrangedSubview(playlistButton)
        
        playButtonsView.addSubview(backwardPlayButton)
        playButtonsView.addSubview(playButton)
        playButtonsView.addSubview(forwardPlayButton)
        
        musicButtonsView.addSubview(musicIconView)
        musicButtonsView.addSubview(buttonsView)

        mainStackView.addArrangedSubview(creatorNameLabel)
        mainStackView.addArrangedSubview(musicButtonsView)
        mainStackView.addArrangedSubview(musicNameLabel)
        mainStackView.addArrangedSubview(musicProgressView)
        mainStackView.addArrangedSubview(playButtonsView)
        mainStackView.addArrangedSubview(collectionButtonStackView)
        mainStackView.addArrangedSubview(messageCollectionView)
        mainStackView.addArrangedSubview(playlistCollectionView)
        mainStackView.addArrangedSubview(messageTextField)
    }

    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        self.messageTextField.sendActionMessage = { [weak self] message in
            self?.presenter?.fetchMessage(with: message, roomID: self?.currentRoom?.id)
        }
        self.membersButton.setCustomTitle(with: currentRoom?.name ?? "Сообщество")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideTextField))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        self.createCustomTabBarLeftButton()
    }

    private func layoutViews() {
        membersButton.pinLeft(to: self.view, 65)
        membersButton.pinTop(to: self.view, 63)
        
        exitRoomButton.pinLeft(to: membersButton.trailingAnchor, 10)
        exitRoomButton.pinTop(to: membersButton.topAnchor)
        exitRoomButton.pinRight(to: self.view, 101)
        exitRoomButton.pinBottom(to: membersButton.bottomAnchor)
        
        searchButton.pinRight(to: self.view, 36)
        searchButton.pinLeft(to: exitRoomButton.trailingAnchor, 36)
        searchButton.pinTop(to: exitRoomButton.topAnchor, 7)
        searchButton.setHeight(30)
        
        scrollViewContent.pinTop(to: membersButton.bottomAnchor, 8)
        scrollViewContent.pinLeft(to: self.view)
        scrollViewContent.pinRight(to: self.view)
        scrollViewContent.pinBottom(to: self.view)
        
        mainStackView.pinTop(to: scrollViewContent)
        mainStackView.pinLeft(to: scrollViewContent)
        mainStackView.pinRight(to: scrollViewContent)
        mainStackView.pinBottom(to: scrollViewContent, 160)
        mainStackView.pinWidth(to: scrollViewContent.widthAnchor)

        creatorNameLabel.pinLeft(to: mainStackView, 30)
        creatorNameLabel.pinTop(to: mainStackView)
        
        searchIcon.pin(to: searchButton)
        plusIcon.pin(to: plusButton)
        favouritesIcon.pin(to: favouritesButton)
        linkIcon.pin(to: linkButton)
        playIcon.pin(to: playButton)
        forwardPlayIcon.pin(to: forwardPlayButton)
        backwardPlayIcon.pin(to: backwardPlayButton)
        
        musicButtonsView.pinTop(to: creatorNameLabel.bottomAnchor, 8)
        musicButtonsView.pinLeft(to: mainStackView, 30)
        musicButtonsView.pinRight(to: mainStackView, 30)
        musicButtonsView.setHeight(200)
        
        musicIconView.pinTop(to: musicButtonsView)
        musicIconView.pinLeft(to: musicButtonsView)
        musicIconView.setWidth(250)
        musicIconView.setHeight(150)
        
        buttonsView.pinTop(to: musicButtonsView)
        buttonsView.pinRight(to: musicButtonsView, 30)
        
        plusButton.pinTop(to: buttonsView, 20)
        plusButton.pinCenterX(to: buttonsView)
        plusButton.setWidth(50)
        plusButton.setHeight(50)
        
        favouritesButton.pinTop(to: plusButton.bottomAnchor, 5)
        favouritesButton.pinCenterX(to: buttonsView)
        favouritesButton.setWidth(50)
        favouritesButton.setHeight(50)
        
        linkButton.pinTop(to: favouritesButton.bottomAnchor, 5)
        linkButton.pinCenterX(to: buttonsView)
        linkButton.setWidth(50)
        linkButton.setHeight(50)
        
        musicNameLabel.pinTop(to: musicIconView.bottomAnchor, 12)
        musicNameLabel.pinCenterX(to: mainStackView)
        
        musicProgressView.pinTop(to: musicNameLabel.bottomAnchor, 8)
        musicProgressView.pinHorizontal(to: mainStackView, 30)
        musicProgressView.setHeight(10)
        
        playButtonsView.pinTop(to: musicProgressView.bottomAnchor, 15)
        playButtonsView.pinLeft(to: mainStackView, 30)
        playButtonsView.pinRight(to: mainStackView, 30)
        playButtonsView.setHeight(70)
        
        forwardPlayButton.pinTop(to: playButtonsView, 7)
        forwardPlayButton.pinRight(to: playButtonsView, 25)
        forwardPlayButton.setWidth(75)
        forwardPlayButton.setHeight(50)
    
        playButton.pinTop(to: playButtonsView)
        playButton.pinCenterX(to: playButtonsView)
        playButton.setWidth(60)
        playButton.setHeight(60)
        
        backwardPlayButton.pinTop(to: playButtonsView, 7)
        backwardPlayButton.pinLeft(to: playButtonsView, 25)
        backwardPlayButton.setWidth(75)
        backwardPlayButton.setHeight(50)
        
        collectionButtonStackView.pinHorizontal(to: mainStackView, 30)
        collectionButtonStackView.pinTop(to: playButtonsView.bottomAnchor, 7)
        
        messageCollectionView.pinTop(to: collectionButtonStackView.bottomAnchor, 8)
        messageCollectionView.pinHorizontal(to: mainStackView, 30)
        messageCollectionView.setHeight(400)
        messageCollectionView.pinBottom(to: mainStackView, 50)
        
        playlistCollectionView.pinTop(to: collectionButtonStackView.bottomAnchor, 8)
        playlistCollectionView.pinHorizontal(to: mainStackView, 30)
        playlistCollectionView.setHeight(400)
        playlistCollectionView.pinBottom(to: mainStackView)
        
        messageTextField.pinTop(to: messageCollectionView.bottomAnchor, 7)
        messageTextField.pinHorizontal(to: mainStackView, 30)
        messageTextField.setHeight(50)
    }
}

extension SelectedRoomViewController {
    func updateDataOnView(with name: String) {
        self.creatorNameLabel.text = "Создатель: \(name)"
    }
}

extension SelectedRoomViewController {
    func updateMessageCollectionView(with models: [ChatMessageViewModel]) {
        self.messages = models
        self.messageCollectionView.reloadData()
    }
    
    func updatePlaylistCollectionView(with models: [TrackViewModel]) {
        
    }
    
    func addMessageToCollectionView(message value: ChatMessageViewModel) {
        self.messages.append(value)
        self.messageCollectionView.reloadData()
    }
}

extension SelectedRoomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return messages.count
        case 2:
            return tracks.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ChatMessageCollectionViewCell.identifier,
                for: indexPath
            ) as? ChatMessageCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = messages[indexPath.row]
            if let admin = self.currentRoom?.creatorID {
                cell.configureCell(with: model, adminId: admin)
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrackCollectionViewCell.identifier,
                for: indexPath
            ) as? TrackCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = tracks[indexPath.row]
            
            return cell
        default:
           return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch collectionView.tag {
        case 1:
            guard let header =  collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleChatMessageCollectionReusableView.identifier,
                for: indexPath
            ) as? TitleChatMessageCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()
            }
            return header
        case 2:
            guard let header =  collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitlePlaylistCollectionReusableView.identifier,
                for: indexPath
            ) as? TitlePlaylistCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }

    static func createCollectionViewLayout() -> NSCollectionLayoutSection {
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
        ]
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize (
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(70)
                ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
}


