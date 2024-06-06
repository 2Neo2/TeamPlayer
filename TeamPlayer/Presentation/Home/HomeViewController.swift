//
//  HomeViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

enum HomeSectionType {
    case publicRooms(viewModels: [PublicRoomsCellViewModel])
    case newReleases(viewModels: [NewReleasesCellViewModel])
    
    var title: String {
        switch self {
        case .publicRooms:
            return "Публичные сообщества"
        case .newReleases:
            return "Новые треки в этом месяце"
        }
    }
}

enum Category {
    case all
    case music
    case rooms
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
    private var filteredSections = [HomeSectionType]()
    
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
            self.filterContent(for: .all)
            self.updateCollectionViewLayout(for: .all)
        }
    }
    
    @objc
    private func musicButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.allButton.backgroundColor = Constants.Colors.generalLight
            self.musicButton.backgroundColor = Constants.Colors.general
            self.roomButton.backgroundColor = Constants.Colors.generalLight
            self.filterContent(for: .music)
            self.updateCollectionViewLayout(for: .music)
        }
    }
    
    @objc
    private func roomButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.allButton.backgroundColor = Constants.Colors.generalLight
            self.musicButton.backgroundColor = Constants.Colors.generalLight
            self.roomButton.backgroundColor = Constants.Colors.general
            self.filterContent(for: .rooms)
            self.updateCollectionViewLayout(for: .rooms)
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
            presenter?.openPublicRoomsFlow()
        case 1:
            presenter?.openReleasesFlow()
        default:
            return
        }
    }
    
    private func filterContent(for category: Category) {
        switch category {
        case .all:
            filteredSections = sections
        case .music:
            filteredSections = sections.filter {
                if case .newReleases = $0 { return true }
                return false
            }
        case .rooms:
            filteredSections = sections.filter {
                if case .publicRooms = $0 { return true }
                return false
            }
        }
        mainContentCollectionView.reloadData()
    }
    
    private func updateCollectionViewLayout(for category: Category) {
        switch category {
        case .music:
            mainContentCollectionView.setCollectionViewLayout(
                UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                    return HomeViewController.createMusicSectionLayout()
                }, animated: true
            )
        default:
            mainContentCollectionView.setCollectionViewLayout(
                UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                    return HomeViewController.createSectionLayout(section: sectionIndex)
                }, animated: true
            )
        }
    }
    
    @objc
    private func dataDidUpdate(_ notification: Notification) {
        self.presenter?.fetchData()
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
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidUpdate(_:)), name: NotificationCenter.updateHomveVC, object: nil)
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
        
        
        mainContentCollectionView.pinTop(to: accountButton.bottomAnchor, 10)
        mainContentCollectionView.pinLeft(to: view, 15)
        mainContentCollectionView.pinRight(to: view, 15)
        mainContentCollectionView.pinBottom(to: view.bottomAnchor, 160)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = filteredSections[section]
        
        switch type {
        case .publicRooms(let viewModels):
            return viewModels.count
        case .newReleases(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        filteredSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = filteredSections[indexPath.section]
        
        switch type {
        case .newReleases(let viewModels):
            presenter?.openSingleRelease(with: viewModels[indexPath.row])
        case .publicRooms(let viewModels):
            MiniPlayerService.shared.markDirty = true
            presenter?.fetchJoinRoom(with: viewModels[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = filteredSections[indexPath.section]
        
        switch type {
        case .newReleases(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleasesCollectionViewCell.identifier,
                for: indexPath
            ) as? NewReleasesCollectionViewCell else {
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
        sections = [
            .publicRooms(viewModels: publicRooms),
            .newReleases(viewModels: newReleases)
        ]
        
        self.filteredSections = sections
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
        
        let title = filteredSections[section].title
        
        header.configure(with: title)
        
        return header
    }
    
    static func createMusicSectionLayout() -> NSCollectionLayoutSection {
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
