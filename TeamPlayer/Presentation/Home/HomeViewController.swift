//
//  HomeViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

enum HomeSectionType{
    case publicRooms(viewModels: [PublicRoomsCellViewModel])
    case artistRooms(viewModels: [ArtistRoomsViewModel])
    case newReleases(viewModels: [NewReleasesCellViewModel])
    
    var title: String {
        switch self {
        case .publicRooms:
            return "Публичные сообщества"
        case .artistRooms:
            return "Сообщества артистов"
        case .newReleases:
            return "Новые релизы"
        }
    }
}

final class HomeViewController: UIViewController {
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
    
    private lazy var allButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Все", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Colors.general
        button.titleLabel?.font = Constants.Font.getFont(name: "Black", size: 12)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(allButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var musicButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Музыка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Colors.generalLight
        button.titleLabel?.font = Constants.Font.getFont(name: "Black", size: 12)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(musicButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var roomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сообщества", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.Colors.generalLight
        button.titleLabel?.font = Constants.Font.getFont(name: "Black", size: 12)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(roomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var ratingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ratingTableButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.crownIcon
        imageView.tintColor = Constants.Colors.general
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mainContentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout{ sectionIndex, _ -> NSCollectionLayoutSection? in
            HomeViewController.createSectionLayout(section: sectionIndex)
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var presenter: HomePresenter?
    private var musicButtonLeadingConstraint = NSLayoutConstraint()
    private var roomButtonLeadingConstraint = NSLayoutConstraint()
    var sections = [HomeSectionType]()
    private var artistsRooms = [
        ArtistRoomsViewModel(name: "Jay-Z", image: "jay-z", isPrivate: false),
        ArtistRoomsViewModel(name: "Eminem", image: "eminem", isPrivate: false),
        ArtistRoomsViewModel(name: "Баста", image: "баста", isPrivate: false),
        ArtistRoomsViewModel(name: "Guf", image: "guf", isPrivate: false),
        ArtistRoomsViewModel(name: "ASAP Rocky", image: "asap", isPrivate: false),
        ArtistRoomsViewModel(name: "OBLADAET", image: "obladaet", isPrivate: false),
        ArtistRoomsViewModel(name: "Егор Крид", image: "krid", isPrivate: false),
        ArtistRoomsViewModel(name: "Queen", image: "queen", isPrivate: false),
    ]
    
    private func configureMainCollectionView() {
        mainContentCollectionView.register(
            NewReleasesCollectionViewCell.self,
            forCellWithReuseIdentifier: NewReleasesCollectionViewCell.identifier
        )
        mainContentCollectionView.register(
            PublicRoomsCollectionViewCell.self,
            forCellWithReuseIdentifier: PublicRoomsCollectionViewCell.identifier
        )
        mainContentCollectionView.register(
            ArtistRoomsCollectionViewCell.self,
            forCellWithReuseIdentifier: ArtistRoomsCollectionViewCell.identifier
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        sections.append(.artistRooms(viewModels: self.artistsRooms))
        configureMainCollectionView()
        
        presenter?.fetchData()
    }
    
    @objc
    private func accountButtonTapped() {
        presenter?.openAccountFlow()
    }
    
    @objc
    private func allButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.allButton.backgroundColor = Constants.Colors.general
            self.musicButton.backgroundColor = Constants.Colors.generalLight
            self.roomButton.backgroundColor = Constants.Colors.generalLight
        }
    }
    
    @objc
    private func musicButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.allButton.backgroundColor = Constants.Colors.generalLight
            self.musicButton.backgroundColor = Constants.Colors.general
            self.roomButton.backgroundColor = Constants.Colors.generalLight
        }
    }
    
    @objc
    private func roomButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.allButton.backgroundColor = Constants.Colors.generalLight
            self.musicButton.backgroundColor = Constants.Colors.generalLight
            self.roomButton.backgroundColor = Constants.Colors.general
        }
    }
    
    @objc
    private func ratingTableButtonTapped() {
        presenter?.openRatingFlow()
    }
    
    @objc
    private func collectionHeaderSectionTapped(_ sender: UITapGestureRecognizer) {
        guard let type = sender.view?.tag else { return }
        
        switch type {
        case 0:
            // TODO: Create artist logic.
            print("Artist")
        case 1:
            presenter?.openPublicRoomsFlow()
        case 2:
            presenter?.openReleasesFlow()
        default:
            return
        }
    }
}

extension HomeViewController {
    private func insertViews() {
        accountButton.addSubview(accountImageView)
        ratingButton.addSubview(ratingImageView)
        view.addSubview(accountButton)
        view.addSubview(allButton)
        view.addSubview(musicButton)
        view.addSubview(roomButton)
        view.addSubview(ratingButton)
        view.addSubview(mainContentCollectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutViews() {
        accountButton.pinTop(to: view, 60)
        accountButton.pinLeft(to: view, 15)
        accountButton.setHeight(60)
        accountButton.setWidth(60)
        
        accountImageView.pinCenter(to: accountButton)
        accountImageView.setHeight(35)
        accountImageView.setWidth(35)
        
        [allButton, musicButton, roomButton].forEach {
            if $0.titleLabel?.text == "Сообщества" {
                $0.setWidth(90)
            } else {
                $0.setWidth(60)
            }
            $0.setHeight(30)
            $0.pinTop(to: accountButton, 15)
        }
        
        allButton.pinLeft(to: accountButton.trailingAnchor, 15)
        
        musicButton.pinLeft(to: allButton.trailingAnchor, 7)
        
        roomButton.pinLeft(to: musicButton.trailingAnchor, 7)
        
        ratingButton.pinTop(to: view, 68)
        ratingButton.pinRight(to: view, 30)
        ratingButton.setHeight(40)
        ratingButton.setWidth(40)
        
        ratingImageView.pinCenter(to: ratingButton)
        ratingImageView.setHeight(30)
        ratingImageView.setWidth(30)
        
        
        mainContentCollectionView.pinTop(to: accountButton.bottomAnchor, 20)
        mainContentCollectionView.pinLeft(to: view, 15)
        mainContentCollectionView.pinRight(to: view, 15)
        mainContentCollectionView.pinBottom(to: view.bottomAnchor, 160)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        
        switch type {
        case .publicRooms(let viewModels):
            return viewModels.count
        case .artistRooms(viewModels: let viewModels):
            return viewModels.count
        case .newReleases(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = sections[indexPath.section]
        
        switch type {
        case .newReleases(let viewModels):
            presenter?.openSingleRelease(with: viewModels[indexPath.row])
        case .artistRooms(_):
            print("art")
        case .publicRooms(let viewModels):
            presenter?.openSingleRoom(with: viewModels[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        
        switch type {
        case .newReleases(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleasesCollectionViewCell.identifier,
                for: indexPath
            ) as? NewReleasesCollectionViewCell else {
                return UICollectionViewCell()
            }
            // TODO: Configure cell.
            let model = viewModels[indexPath.row]
            cell.configure(with: model)
            return cell
        case .artistRooms(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ArtistRoomsCollectionViewCell.identifier,
                for: indexPath
            ) as? ArtistRoomsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = viewModels[indexPath.row]
            cell.configure(with: model)
            return cell
        case .publicRooms(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PublicRoomsCollectionViewCell.identifier,
                for: indexPath
            ) as? PublicRoomsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = viewModels[indexPath.row]
            cell.configure(with: model)
            return cell
        }
    }
    
    func configureModels(publicRooms: [PublicRoomsCellViewModel], newReleases: [NewReleasesCellViewModel]) {
        sections.append(.publicRooms(viewModels: publicRooms))
        sections.append(.newReleases(viewModels: newReleases))
        
        mainContentCollectionView.reloadData()
        UIBlockingProgressHUD.dismiss()
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
            // Create item layout.
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize (
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(240)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Create vertical group layout in other horizontal group.
            
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(240)
                    ),
                subitem: item,
                count: 1
            )
            
            // Create section layout.
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
        case 1:
            // Create item layout.
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize (
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(240)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Create vertical group layout in other horizontal group.
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(240)
                    ),
                subitem: item,
                count: 1
            )
            
            // Create section layout.
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
            
        case 2:
            // Create item layout.
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize (
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Create vertical group layout in other horizontal group.
            
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
            // Create item layout.
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize (
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Create vertical group layout in other horizontal group.
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    ),
                subitem: item,
                count: 1
            )
            
            // Create section layout.
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
