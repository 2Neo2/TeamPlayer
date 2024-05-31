//
//  AlbumViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit
import Kingfisher

final class AlbumViewController: UIViewController {
    private lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .placeholder
        label.font = Constants.Font.getFont(name: "Bold", size: 10)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            ReleasesViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var presenter: AlbumPresenter?
    var currentModel: NewReleasesCellViewModel?
    var currentImage: UIImage?
    var tracks = [TrackViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        configureView()
        
        presenter?.fetchData()
    }
    
    private func configureView() {
        if let urlString = self.currentModel?.img, let url = URL(string: urlString) {
            UIView.animate(withDuration: 0.3) {
                self.albumNameLabel.text = self.currentModel?.name
                self.artistNameLabel.text = self.currentModel?.artistName
                self.albumImageView.kf.indicatorType = .activity
                self.albumImageView.kf.setImage(with: url)
            }
        } else {
            print("Произошла ошибка с изображением")
            return
        }
    }
    
    func configureData(tracks models: [TrackViewModel]) {
        tracks.append(contentsOf: models)
        collectionView.reloadData()
        UIBlockingProgressHUD.dismiss()
    }
}

extension AlbumViewController {
    private func insertViews() {
        view.addSubview(albumImageView)
        view.addSubview(artistNameLabel)
        view.addSubview(albumNameLabel)
        view.addSubview(collectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            TrackCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .clear
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        albumImageView.pinTop(to: view, 100)
        albumImageView.pinLeft(to: view, 74)
        albumImageView.pinRight(to: view, 74)
        albumImageView.setHeight(242)
        
        albumNameLabel.pinCenterX(to: view)
        albumNameLabel.pinTop(to: albumImageView.bottomAnchor, 7)
        albumNameLabel.setWidth(200)
        
        artistNameLabel.pinTop(to: albumNameLabel.bottomAnchor, 3)
        artistNameLabel.pinCenterX(to: view)
        
        collectionView.pinTop(to: artistNameLabel.bottomAnchor, 15)
        collectionView.pinLeft(to: view.leadingAnchor, 20)
        collectionView.pinRight(to: view.trailingAnchor, 20)
        collectionView.pinBottom(to: view.bottomAnchor, 160)
    }
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackCollectionViewCell.identifier,
            for: indexPath
        ) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        let track = tracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let release = tracks[indexPath.row]
        MiniPlayerService.shared.currentTrack = release
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
