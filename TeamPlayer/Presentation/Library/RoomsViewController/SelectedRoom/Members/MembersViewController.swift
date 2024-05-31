//
//  MembersViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 14.05.2024.
//

import UIKit

final class MembersViewController: UIViewController {
    private lazy var bottomArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(bottomArrowButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var bottomArrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.arrowDown
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Участники сообщества"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Участников пока нет"
        label.font = Constants.Font.getFont(name: "BoldItalic", size: 20)
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            MembersViewController.createCollectionViewLayout()
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    var presenter: MembersPresenter?
    var currentId: UUID?
    var members = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData(with: currentId!)
    }
    
    @objc
    private func bottomArrowButtonTapped() {
        presenter?.hideView()
    }
}

extension MembersViewController {
    func updateUI(with models: [UserModel]) {
        if models.count <= 1 {
            infoLabel.isHidden = false
            collectionView.isHidden = true
        } else {
            members = models
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
}

extension MembersViewController {
    private func insertViews() {
        bottomArrowButton.addSubview(bottomArrowIcon)
        view.addSubview(bottomArrowButton)
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(collectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.generalLight
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            MembersCollectionViewCell.self,
            forCellWithReuseIdentifier: MembersCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .clear
    }
    
    private func layoutViews() {
        bottomArrowButton.pinTop(to: view, 60)
        bottomArrowButton.pinLeft(to: view, 15)
        bottomArrowButton.setHeight(30)
        bottomArrowButton.setWidth(30)
        bottomArrowIcon.pin(to: bottomArrowButton)
        
        titleLabel.pinTop(to: view, 60)
        titleLabel.pinLeft(to: bottomArrowButton.trailingAnchor, 10)
        
        infoLabel.pinCenterX(to: view)
        infoLabel.pinCenterY(to: view)
        
        collectionView.pinTop(to: titleLabel.bottomAnchor, 15)
        collectionView.pinLeft(to: view, 30)
        collectionView.pinRight(to: view, 30)
        collectionView.pinBottom(to: view, 50)
    }
}

extension MembersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MembersCollectionViewCell.identifier,
            for: indexPath
        ) as? MembersCollectionViewCell else {
            return UICollectionViewCell()
        }
        let member = members[indexPath.row]
        cell.deleteAction = { [weak self] in
            guard let id = self?.currentId else { return }
            self?.presenter?.removeUser(id, member.id)
        }
        
        cell.setDjAction = { [weak self] in
            guard let id = self?.currentId else { return }
            self?.presenter?.setdj(id, member.id)
        }
        cell.configure(with: member)
        return cell
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
