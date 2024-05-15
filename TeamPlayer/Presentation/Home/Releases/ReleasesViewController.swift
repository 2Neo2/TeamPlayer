//
//  ReleasesViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import UIKit

final class ReleasesViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Новые релизы"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            ReleasesViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var presenter: ReleasesPresenter?
    var releases = [NewReleasesCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    func configureData(newReleases models: [NewReleasesCellViewModel]) {
        releases.append(contentsOf: models)
        collectionView.reloadData()
        UIBlockingProgressHUD.dismiss()
    }
}

extension ReleasesViewController {
    private func insertViews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            NewReleasesCollectionViewCell.self,
            forCellWithReuseIdentifier: NewReleasesCollectionViewCell.identifier
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

extension ReleasesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return releases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewReleasesCollectionViewCell.identifier,
            for: indexPath
        ) as? NewReleasesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let release = releases[indexPath.row]
        cell.configure(with: release)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let release = releases[indexPath.row]
        
        presenter?.openSelectedRelease(with: release)
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
