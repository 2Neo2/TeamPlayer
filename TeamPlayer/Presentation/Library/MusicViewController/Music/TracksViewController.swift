//
//  TracksViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 10.05.2024.
//

import UIKit

final class TracksViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Музыкальный контент"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            TracksViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var presenter: TracksPresenter?
    private var tracks = [TrackViewModel]()
    var currentPlaylistModel: PlaylistViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    
        presenter?.fetchData()
    }
}

extension TracksViewController {
    private func insertViews() {
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
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
        self.createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        titleLabel.pinTop(to: view, 65)
        titleLabel.pinLeft(to: view, 55)
        
        collectionView.pinTop(to: titleLabel.bottomAnchor, 20)
        collectionView.pinLeft(to: self.view, 30)
        collectionView.pinRight(to: self.view, 30)
        collectionView.pinBottom(to: self.view, 160)
    }
}


extension TracksViewController {
    func updateView(with tracks: [TrackViewModel]) {
        self.tracks = tracks
        collectionView.reloadData()
        UIBlockingProgressHUD.dismiss()
    }
}

extension TracksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackCollectionViewCell.identifier,
            for: indexPath
        ) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = tracks[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        
        guard let id = self.currentPlaylistModel?.id else { return }
        
        presenter?.addTrackToPlaylist(with: track, playlistID: id)
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
