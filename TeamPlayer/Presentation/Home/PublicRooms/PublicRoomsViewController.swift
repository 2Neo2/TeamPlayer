//
//  PublicRoomsViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import UIKit

final class PublicRoomsViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Публичные сообщества"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            PublicRoomsViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var presenter: PublicRoomsPresenter?
    var rooms = [PublicRoomsCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    func configureData(publicRooms models: [PublicRoomsCellViewModel]) {
        rooms.append(contentsOf: models)
        collectionView.reloadData()
        UIBlockingProgressHUD.dismiss()
    }
}

extension PublicRoomsViewController {
    private func insertViews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PublicRoomCell.self,
            forCellWithReuseIdentifier: PublicRoomCell.identifier
        )
        collectionView.backgroundColor = .clear
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        titleLabel.pinTop(to: view, 65)
        titleLabel.pinLeft(to: view, 55)
        
        collectionView.pinTop(to: titleLabel.bottomAnchor, 15)
        collectionView.pinLeft(to: view.leadingAnchor, 20)
        collectionView.pinRight(to: view.trailingAnchor, 20)
        collectionView.pinBottom(to: view.bottomAnchor, 160)
    }
}

extension PublicRoomsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PublicRoomCell.identifier,
            for: indexPath
        ) as? PublicRoomCell else {
            return UICollectionViewCell()
        }
        let model = rooms[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let room = rooms[indexPath.row]
        
        presenter?.openSelectedRoom(with: room)
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
