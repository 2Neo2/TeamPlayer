//
//  MusicViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.04.2024.
//

import UIKit


final class MusicViewController: UIViewController {
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
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.plusButton
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Моя музыка"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playlistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Плейлисты", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = Constants.Font.getFont(name: "Black", size: 12)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.placeholder?.cgColor
        button.addTarget(self, action: #selector(playlistButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var albumsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Альбомы", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = Constants.Font.getFont(name: "Black", size: 12)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.placeholder?.cgColor
        button.addTarget(self, action: #selector(albumsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.textGray?.cgColor
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var cancelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.cancelButton
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var customFavouritesButton: CustomFavouritesButton = {
        let button = CustomFavouritesButton(title: "Моя музыка")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var customDownloadedButton: CustomFavouritesButton = {
        let button = CustomFavouritesButton(title: "Загруженное")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(downloadedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Создавай плейлисты и находи самое нужное!"
        label.font = Constants.Font.getFont(name: "BoldItalic", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            MusicViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    private var playlistButtonLeadingConstraint = NSLayoutConstraint()
    private var albumsButtonLeadingConstraint = NSLayoutConstraint()
    private var playlists = [PlaylistViewModel]()
    var presenter: MusicPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    @objc
    private func playlistButtonTapped() {
        albumsButton.isHidden = true
        cancelFilterButton.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.playlistButton.backgroundColor = Constants.Colors.general
            self.playlistButton.setTitleColor(.white, for: .normal)
            self.playlistButton.layer.borderColor = UIColor.clear.cgColor
            self.playlistButtonLeadingConstraint.constant = 11.0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func albumsButtonTapped() {
        playlistButton.isHidden = true
        cancelFilterButton.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.albumsButton.backgroundColor = Constants.Colors.general
            self.albumsButton.setTitleColor(.white, for: .normal)
            self.albumsButton.layer.borderColor = UIColor.clear.cgColor
            self.albumsButtonLeadingConstraint.constant = 11.0
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions.
    @objc
    private func accountButtonTapped() {
        presenter?.openAccountFlow()
    }
    
    @objc
    private func favouritesButtonTapped() {
        presenter?.openFavouritesFlow()
    }
    
    @objc
    private func downloadedButtonTapped() {
        presenter?.openDownloadedFlow()
    }
    
    @objc
    private func plusButtonTapped() {
        presenter?.openCreateFlow()
    }
    
    @objc
    private func cancelButtonTapped() {
        UIView.animate(withDuration: 0.4) {
            self.playlistButton.layer.borderColor = Constants.Colors.placeholder?.cgColor
            self.playlistButton.backgroundColor = .white
            self.playlistButton.setTitleColor(.black, for: .normal)
            
            self.albumsButton.layer.borderColor = Constants.Colors.placeholder?.cgColor
            self.albumsButton.backgroundColor = .white
            self.albumsButton.setTitleColor(.black, for: .normal)
            
            self.cancelFilterButton.isHidden = true
            self.playlistButton.isHidden = false
            self.albumsButton.isHidden = false
            self.playlistButtonLeadingConstraint.constant = -30.0
            self.albumsButtonLeadingConstraint.constant = 61.0
            self.view.layoutIfNeeded()
        }
    }
}

extension MusicViewController {
    func updateData(with models: [PlaylistViewModel]) {
        playlists = models
        
        if playlists.count == 0 {
            infoLabel.isHidden = false
        } else {
            collectionView.reloadData()
            collectionView.isHidden = false
            infoLabel.isHidden = true
        }
        UIBlockingProgressHUD.dismiss()
    }
}

extension MusicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlaylistItemViewCell.identifier,
            for: indexPath
        ) as? PlaylistItemViewCell else {
            return UICollectionViewCell()
        }
        let model = playlists[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlist = playlists[indexPath.row]
        
        presenter?.openPlaylistFlow(with: playlist)
    }

    static func createCollectionViewLayout() -> NSCollectionLayoutSection {
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
                    heightDimension: .absolute(80)
                ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

extension MusicViewController {
    private func insertViews() {
        view.addSubview(accountButton)
        view.addSubview(titleLabel)
        view.addSubview(plusButton)
        view.addSubview(playlistButton)
        view.addSubview(albumsButton)
        view.addSubview(cancelFilterButton)
        view.addSubview(customFavouritesButton)
        view.addSubview(customDownloadedButton)
        view.addSubview(infoLabel)
        view.addSubview(collectionView)
        
        accountButton.addSubview(accountImageView)
        plusButton.addSubview(plusImageView)
        cancelFilterButton.addSubview(cancelImageView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PlaylistItemViewCell.self,
            forCellWithReuseIdentifier: PlaylistItemViewCell.identifier
        )
        collectionView.backgroundColor = .clear
        self.createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        playlistButtonLeadingConstraint = self.playlistButton.leadingAnchor.constraint(equalTo: cancelFilterButton.trailingAnchor, constant: -30.0)
        albumsButtonLeadingConstraint = self.albumsButton.leadingAnchor.constraint(equalTo: cancelFilterButton.trailingAnchor, constant: 61.0)
        NSLayoutConstraint.activate([
            accountButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
            accountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            accountButton.heightAnchor.constraint(equalToConstant: 60.0),
            accountButton.widthAnchor.constraint(equalToConstant: 60.0),
            
            accountImageView.heightAnchor.constraint(equalToConstant: 35.0),
            accountImageView.widthAnchor.constraint(equalToConstant: 35.0),
            accountImageView.centerXAnchor.constraint(equalTo: accountButton.centerXAnchor),
            accountImageView.centerYAnchor.constraint(equalTo: accountButton.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: accountButton.trailingAnchor, constant: 10.0),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 115),
            
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35.0),
            plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 115.0),
            plusButton.heightAnchor.constraint(equalToConstant: 40.0),
            plusButton.widthAnchor.constraint(equalToConstant: 40.0),
            
            cancelFilterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            cancelFilterButton.topAnchor.constraint(equalTo: accountButton.bottomAnchor, constant: 24.0),
            cancelFilterButton.heightAnchor.constraint(equalToConstant: 30),
            cancelFilterButton.widthAnchor.constraint(equalToConstant: 30),
            
            cancelImageView.heightAnchor.constraint(equalToConstant: 15.0),
            cancelImageView.widthAnchor.constraint(equalToConstant: 15.0),
            cancelImageView.centerXAnchor.constraint(equalTo: cancelFilterButton.centerXAnchor),
            cancelImageView.centerYAnchor.constraint(equalTo: cancelFilterButton.centerYAnchor),
            
            playlistButtonLeadingConstraint,
            
            playlistButton.topAnchor.constraint(equalTo: accountButton.bottomAnchor, constant: 24.0),
            playlistButton.heightAnchor.constraint(equalToConstant: 30.0),
            playlistButton.widthAnchor.constraint(equalToConstant: 80.0),
            
            albumsButton.topAnchor.constraint(equalTo: accountButton.bottomAnchor, constant: 24.0),
            albumsButtonLeadingConstraint,
            albumsButton.heightAnchor.constraint(equalToConstant: 30.0),
            albumsButton.widthAnchor.constraint(equalToConstant: 80.0),
            
            customFavouritesButton.topAnchor.constraint(equalTo: albumsButton.bottomAnchor, constant: 26.0),
            customFavouritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            customFavouritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            customFavouritesButton.heightAnchor.constraint(equalToConstant: 44),
            
            customDownloadedButton.topAnchor.constraint(equalTo: customFavouritesButton.bottomAnchor, constant: 15),
            customDownloadedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            customDownloadedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            customDownloadedButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        infoLabel.pinTop(to: customDownloadedButton.bottomAnchor, 50)
        infoLabel.pinCenterY(to: view)
        infoLabel.pinHorizontal(to: view, 30)
        
        collectionView.pinTop(to: customDownloadedButton.bottomAnchor, 20)
        collectionView.pinHorizontal(to: view, 30)
        collectionView.pinBottom(to: view, 160)
        
        plusImageView.pin(to: plusButton)
    }
}

extension MusicViewController: CreatePlaylistVCProtocol {
    func playlistCreated() {
        presenter?.fetchData()
    }
}
