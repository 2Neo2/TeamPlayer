//
//  DownloadedViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import UIKit
import MediaPlayer

final class DownloadedViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Музыка"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.plusButton
        imageView.tintColor = .black
        return imageView
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            DownloadedViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var tracks = [TrackViewModel]()
    var presenter: DownloadedPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    @objc
    private func plusButtonTapped() {
        print("pusButton")
        pickMusic()
    }
    
    private func pickMusic() {
        MPMediaLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    let mediaPicker = MPMediaPickerController(mediaTypes: .music)
                    mediaPicker.delegate = self
                    self.present(mediaPicker, animated: true, completion: nil)
                case .restricted:
                    print("Доступ к медиа-библиотеке ограничен")
                case .denied:
                    print("Доступ к медиа-библиотеке запрещен")
                case .notDetermined:
                    print("Статус доступа к медиа-библиотеке не определен")
                @unknown default:
                    print("Неизвестный статус доступа к медиа-библиотеке")
                }
            }
        }
    }
}

extension DownloadedViewController {
    func updateData(with models: [TrackViewModel]) {
        tracks = models
        collectionView.reloadData()
        
        UIBlockingProgressHUD.dismiss()
    }
}

extension DownloadedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlaylistItemViewCell.identifier,
            for: indexPath
        ) as? PlaylistItemViewCell else {
            return UICollectionViewCell()
        }
        let model = tracks[indexPath.row]
        // cell.configureCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlist = tracks[indexPath.row]
        
        // presenter?.openSelectedRoom(with: room)
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

extension DownloadedViewController {
    private func insertViews() {
        plusButton.addSubview(plusImageView)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(plusButton)
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
        titleLabel.pinTop(to: view, 65)
        titleLabel.pinLeft(to: view, 55)
        
        plusButton.pinTop(to: view, 68)
        plusButton.pinRight(to: view, 30)
        plusImageView.setWidth(35)
        plusImageView.setHeight(35)
        
        collectionView.pinTop(to: titleLabel.bottomAnchor, 15)
        collectionView.pinHorizontal(to: view, 30)
        collectionView.pinBottom(to: view, 160)
    }
}

extension DownloadedViewController: MPMediaPickerControllerDelegate {
    // MPMediaPickerController Delegate methods
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        self.dismiss(animated: true, completion: nil)
        print("you picked: \(mediaItemCollection)")//This is the picked media item.
    }
}
