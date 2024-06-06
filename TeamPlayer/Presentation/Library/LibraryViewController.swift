//
//  LibraryViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.04.2024.
//

import UIKit

enum DataTypes {
    case playlists(viewModels: [PlaylistViewModel])
    case rooms(viewModels: [RoomViewModel])
    
    var title: String {
        switch self {
        case .rooms:
            return "Мои сообщества"
        case .playlists:
            return "Плейлисты"
        }
    }
}

enum DataCategory {
    case rooms
    case playlists
    case empty
}

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
    
    private lazy var mainContentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout{ sectionIndex, _ -> NSCollectionLayoutSection? in
            LibraryViewController.createSectionLayout(section: sectionIndex)
        })
        return collectionView
    }()
    
    private lazy var libraryButton: CustomFavouritesButton = {
        let button = CustomFavouritesButton(title: "Медиатека")
        button.addTarget(self, action: #selector(libraryButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var roomButton: CustomFavouritesButton = {
        let button = CustomFavouritesButton(title: "Мои сообщества")
        button.addTarget(self, action: #selector(roomButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var favouritesMusicButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favouritesMusicIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.heartIcon
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    var presenter: LibraryPresenter?
    var sections = [DataTypes]()
    
    // MARK: - Init.
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
        configureMainCollectionView()
    }
    
    // MARK: - Actions.
    @objc
    private func accountButtonTapped() {
        presenter?.openAccountFlow()
    }
    
    @objc
    private func libraryButtonTapped() {
        presenter?.openMusicFlow()
    }
    
    @objc
    private func roomButtonTapped() {
        presenter?.openRoomsFlow()
    }
    
    @objc
    private func dataDidUpdate(_ notification: Notification) {
        presenter?.fetchData()
    }
    
    @objc
    private func favouritesButtonTapped() {
        presenter?.openFavouritesFlow()
    }
}

extension LibraryViewController {
    func updateDataOnView(with rooms: [RoomViewModel], and playlists: [PlaylistViewModel]) {
        sections = [
            .playlists(viewModels: playlists),
            .rooms(viewModels: rooms)
        ]
        if rooms.count == 0 && playlists.count == 0 {
            changeCollectionViewLayout(with: .empty)
        }
        
        if rooms.count == 0 && playlists.count != 0 {
            filterContent(for: .playlists)
            updateCollectionViewLayout(for: .rooms)
            changeCollectionViewLayout(with: .playlists)
        }
        
        if playlists.count == 0 && rooms.count != 0 {
            filterContent(for: .rooms)
            updateCollectionViewLayout(for: .playlists)
            changeCollectionViewLayout(with: .rooms)
        }
        mainContentCollectionView.reloadData()
    }
    
    private func changeCollectionViewLayout(with category: DataCategory) {
        switch category {
        case .playlists:
            libraryButton.pinTop(to: accountButton.bottomAnchor, 15)
            mainContentCollectionView.pinTop(to: libraryButton.bottomAnchor, 5)
            roomButton.isHidden = false
            libraryButton.isHidden = true
        case .rooms:
            roomButton.pinTop(to: accountButton.bottomAnchor, 15)
            mainContentCollectionView.pinTop(to: roomButton.bottomAnchor, 5)
            roomButton.isHidden = true
            libraryButton.isHidden = false
        case .empty:
            mainContentCollectionView.isHidden = true
            libraryButton.isHidden = false
            roomButton.isHidden = false
            libraryButton.pinTop(to: accountButton.bottomAnchor, 15)
            roomButton.pinTop(to: libraryButton.bottomAnchor, 5)
        }
        
        self.view.layoutIfNeeded()
    }
    
    private func filterContent(for category: DataCategory) {
        switch category {
        case .playlists:
            sections = sections.filter {
                if case .playlists = $0 { return true }
                return false
            }
        case .rooms:
            sections = sections.filter {
                if case .rooms = $0 { return true }
                return false
            }
        case .empty:
            print("empty")
        }
        mainContentCollectionView.reloadData()
    }
}

extension LibraryViewController {
    private func insertViews() {
        accountButton.addSubview(accountImageView)
        favouritesMusicButton.addSubview(favouritesMusicIcon)
        
        view.addSubview(accountButton)
        view.addSubview(titleLabel)
        view.addSubview(mainContentCollectionView)
        view.addSubview(libraryButton)
        view.addSubview(roomButton)
        view.addSubview(favouritesMusicButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidUpdate(_:)), name: NotificationCenter.updateLibraryVC, object: nil)
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
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75)
        ])
        
        
        favouritesMusicButton.pinTop(to: view, 75)
        favouritesMusicButton.pinRight(to: view, 30)
        favouritesMusicButton.setWidth(45)
        favouritesMusicButton.setHeight(40)
        
        favouritesMusicIcon.pin(to: favouritesMusicButton)
        
        libraryButton.pinTop(to: accountButton.bottomAnchor, 15)
        libraryButton.pinHorizontal(to: view, 30)
        libraryButton.setHeight(48)
        
        roomButton.pinTop(to: libraryButton.bottomAnchor, 5)
        roomButton.pinHorizontal(to: view, 30)
        roomButton.setHeight(48)
        
        mainContentCollectionView.pinTop(to: accountButton.bottomAnchor, 10)
        mainContentCollectionView.pinHorizontal(to: view, 30)
        mainContentCollectionView.pinBottom(to: view, 160)
    }
}

extension LibraryViewController {
    private func configureMainCollectionView() {
        mainContentCollectionView.register(
            RoomCollectionViewCell.self,
            forCellWithReuseIdentifier: RoomCollectionViewCell.identifier
        )
        mainContentCollectionView.register(
            LibraryPlaylistCollectionViewCell.self,
            forCellWithReuseIdentifier: LibraryPlaylistCollectionViewCell.identifier
        )
        mainContentCollectionView.register(
            TitleHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier
        )
        mainContentCollectionView.delegate = self
        mainContentCollectionView.dataSource = self
        mainContentCollectionView.backgroundColor = .clear
    }
    
    private func updateCollectionViewLayout(for category: DataCategory) {
        switch category {
        case .playlists:
            mainContentCollectionView.setCollectionViewLayout(
                UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                    return LibraryViewController.createPlaylistSectionLayout()
                }, animated: true
            )
        default:
            mainContentCollectionView.setCollectionViewLayout(
                UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                    return LibraryViewController.createSectionLayout(section: sectionIndex)
                }, animated: true
            )
        }
    }
    
    static func createPlaylistSectionLayout() -> NSCollectionLayoutSection {
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
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(80)
                ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
        ]
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize (
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(240)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(240)
                    ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
        case 1:
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize (
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(80)
                    ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize (
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        
        switch type {
        case .rooms(let viewModels):
            return viewModels.count
        case .playlists(let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        
        switch type {
        case .playlists(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LibraryPlaylistCollectionViewCell.identifier,
                for: indexPath
            ) as? LibraryPlaylistCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let model = viewModels[indexPath.row]
            cell.configure(with: model)
            return cell
        case .rooms(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RoomCollectionViewCell.identifier,
                for: indexPath
            ) as? RoomCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = viewModels[indexPath.row]
            cell.configure(with: model)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = sections[indexPath.section]
        
        switch type {
        case .playlists(let viewModels):
            presenter?.openSinglePlaylistFlow(with: viewModels[indexPath.row])
        case .rooms(let viewModels):
            MiniPlayerService.shared.markDirty = true
            presenter?.openSingleRoomFlow(with: viewModels[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = mainContentCollectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()
        }
        let section = indexPath.section
        header.tag = section
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(collectionHeaderSectionTapped))
        header.addGestureRecognizer(tapGestureRecognizer)
        
        let title = sections[section].title
        
        header.configure(with: title)
        return header
    }
    
    @objc
    private func collectionHeaderSectionTapped(_ sender: UITapGestureRecognizer) {
        guard let type = sender.view?.tag else { return }
        
        switch type {
        case 0:
            presenter?.openMusicFlow()
        case 1:
            presenter?.openRoomsFlow()
        default:
            return
        }
    }
}
