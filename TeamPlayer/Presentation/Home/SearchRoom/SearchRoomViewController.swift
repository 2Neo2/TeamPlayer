//
//  SearchViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 26.05.2024.
//

import UIKit

final class SearchRoomViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Поиск сообществ"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let field = SearchTextField()
        field.layer.borderWidth = 1
        field.layer.borderColor = Constants.Colors.boldGray!.cgColor
        field.layer.cornerRadius = 10
        field.font = Constants.Font.getFont(name: "Bold", size: 17)
        field.delegate = self
        field.placeholder = "Введите название сообщества"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            SearchRoomViewController.createCollectionViewLayout()
        })
    }()
    
    var presenter: SearchRoomPresenter?
    var searchResult = [CreateRoomModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
}

extension SearchRoomViewController {
    private func insertViews() {
        view.addSubview(titleLabel)
        view.addSubview(searchTextField)
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
    }
    
    private func layoutViews() {
        titleLabel.pinTop(to: self.view, 95)
        titleLabel.pinLeft(to: self.view, 20)
        
        searchTextField.pinTop(to: titleLabel.bottomAnchor, 15)
        searchTextField.pinLeft(to: self.view, 30)
        searchTextField.pinRight(to: self.view, 30)
        searchTextField.setHeight(34)
        
        collectionView.pinTop(to: searchTextField.bottomAnchor, 20)
        collectionView.pinBottom(to: self.view, 160)
        collectionView.pinHorizontal(to: self.view, 30)
        
        infoLabel.pinCenter(to: self.view)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideTextField))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        self.createCustomTabBarLeftButton()
        self.configureCollectionView()
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
}

extension SearchRoomViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let updated = (searchTextField.text as? NSString)?.replacingCharacters(in: range, with: string) {
            print(updated)
            presenter?.fetchSearchData(with: updated)
            return true
        }
        return false
    }
}


extension SearchRoomViewController {
    private func configureCollectionView() {
        collectionView.register(
            SearchRoomCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchRoomCollectionViewCell.identifier
        )
        
        collectionView.register(
            TitleSearchRoomCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleSearchRoomCollectionReusableView.identifier
        )
        
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Constants.Colors.boldGray
        collectionView.layer.cornerRadius = 10
    }
    
    func updateUI(with models: [CreateRoomModel]) {
        if models.count == 0 {
            self.infoLabel.isHidden = false
        } else {
            self.infoLabel.isHidden = true
            self.searchResult = models
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
}

extension SearchRoomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchRoomCollectionViewCell.identifier,
            for: indexPath
        ) as? SearchRoomCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = searchResult[indexPath.row]
        
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = searchResult[indexPath.row]
        MiniPlayerService.shared.markDirty
        presenter?.openSingleFlow(with: result)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header =  collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleSearchRoomCollectionReusableView.identifier,
            for: indexPath
        ) as? TitleSearchRoomCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()
        }
        return header
    }
    
    static func createCollectionViewLayout() -> NSCollectionLayoutSection {
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
        
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(70)
                ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
}
