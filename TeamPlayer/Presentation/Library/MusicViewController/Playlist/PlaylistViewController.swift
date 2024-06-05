//
//  PlaylistViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import UIKit

final class PlaylistViewController: UIViewController {
    private lazy var playlistView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var typeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 17)
        label.textAlignment = .center
        label.text = "Плейлист"
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.backgroundColor
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.plusButton
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0 
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            PlaylistViewController.createCollectionViewLayout()
        })
        collectionView.isHidden = true
        return collectionView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добавляй контент в плейлисты и треки будут всегда под рукой!"
        label.font = Constants.Font.getFont(name: "BoldItalic", size: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    var presenter: PlaylistPresenter?
    var currentModel: PlaylistViewModel?
    private var tracks = [MusicObjectViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        configureView()
        //presenter?.fetchData(with: self.currentModel?.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.fetchData(with: self.currentModel?.id)
    }
    
    @objc
    private func plusButtonTapped() {
        guard let model = currentModel else { return }
        presenter?.openMusicFlow(with: model)
    }
    
    private func configureView() {
        nameTitleLabel.text = currentModel?.name
        descriptionLabel.text = currentModel?.description
        if let seconds = currentModel?.totalMinutes {
            typeTitleLabel.text = "Плейлист: \(Int(seconds / 60)) минут."
        }
        if let imageData = currentModel?.imageData, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                playlistImageView.image = UIImage(data: data)
            }
        } else {
            playlistImageView.image = Constants.Images.playlistDefault
        }
    }
}

extension PlaylistViewController {
    private func insertViews() {
        playlistView.addSubview(playlistImageView)
        plusButton.addSubview(plusImageView)
        view.addSubview(playlistView)
        view.addSubview(nameTitleLabel)
        view.addSubview(typeTitleLabel)
        view.addSubview(plusButton)
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PlaylistCollectionCell.self,
            forCellWithReuseIdentifier: PlaylistCollectionCell.identifier
        )
        collectionView.backgroundColor = .clear
        self.createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        plusButton.pinTop(to: view, 68)
        plusButton.pinRight(to: view, 30)
        plusImageView.setWidth(35)
        plusImageView.setHeight(35)
        
        playlistView.pinTop(to: view, 100)
        playlistView.pinHorizontal(to: view, 74)
        playlistView.setHeight(242)
        
        playlistImageView.pin(to: playlistView)
        
        nameTitleLabel.pinTop(to: playlistView.bottomAnchor, 10)
        nameTitleLabel.pinHorizontal(to: view, 86)
        
        typeTitleLabel.pinTop(to: nameTitleLabel.bottomAnchor, 3)
        typeTitleLabel.pinHorizontal(to: view, 86)
        
        descriptionLabel.pinTop(to: typeTitleLabel.bottomAnchor, 3)
        descriptionLabel.pinHorizontal(to: self.view, 30)
        
        infoLabel.pinTop(to: descriptionLabel.bottomAnchor, 15)
        infoLabel.pinHorizontal(to: view, 30)
        
        collectionView.pinTop(to: descriptionLabel.bottomAnchor, 5)
        collectionView.pinLeft(to: self.view, 30)
        collectionView.pinRight(to: self.view, 30)
        collectionView.pinBottom(to: self.view, 160)
    }
}


extension PlaylistViewController {
    func updateView(with tracks: [MusicObjectViewModel]) {
        self.tracks = tracks
        
        if tracks.count == 0 {
            infoLabel.isHidden = false
        } else {
            collectionView.reloadData()
            collectionView.isHidden = false
            infoLabel.isHidden = true
        }
        UIBlockingProgressHUD.dismiss()
    }
}

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlaylistCollectionCell.identifier,
            for: indexPath
        ) as? PlaylistCollectionCell else {
            return UICollectionViewCell()
        }
        let model = tracks[indexPath.row]
        cell.configure(with: model)
        cell.deleteAction = { [weak self] in
            self?.presenter?.deleteTrackFromPlaylist(with: self?.currentModel?.id, in: model.id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        guard let trackId = Int(track.trackID) else { return }
        MiniPlayerService.shared.currentTrack = TrackViewModel(
            id: trackId,
            name: track.name,
            artist: track.artist,
            imageURL: track.imgURL,
            trackURL: track.musicURL,
            duration: track.duration
        )
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
