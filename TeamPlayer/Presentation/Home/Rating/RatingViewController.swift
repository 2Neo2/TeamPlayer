//
//  RatingViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import UIKit

final class RatingViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинговая таблица"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Комнат пока нет"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .black
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            RatingViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    var presenter: RatingPresenter?
    private var rooms = [RoomRatingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    func configureUI(with models: [RoomRatingModel]) {
        rooms = models
        
        if rooms.count == 0 {
            infoLabel.isHidden = false
        } else {
            collectionView.reloadData()
            collectionView.isHidden = false
            infoLabel.isHidden = true
        }
        UIBlockingProgressHUD.dismiss()
    }
}

extension RatingViewController {
    private func insertViews() {
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(collectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            RatingItemViewCell.self,
            forCellWithReuseIdentifier: RatingItemViewCell.identifier
        )
        collectionView.backgroundColor = .clear
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        titleLabel.pinTop(to: view, 65)
        titleLabel.pinLeft(to: view, 55)
        
        infoLabel.pinCenter(to: view)
        
        collectionView.pinTop(to: titleLabel.bottomAnchor, 20)
        collectionView.pinHorizontal(to: view, 30)
        collectionView.pinBottom(to: view, 160)
    }
}


extension RatingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RatingItemViewCell.identifier,
            for: indexPath
        ) as? RatingItemViewCell else {
            return UICollectionViewCell()
        }
        let room = rooms[indexPath.row]
        cell.configureCell(with: room)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let room = rooms[indexPath.row]
        
//        presenter?.openPlaylistFlow(with: playlist)
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
