//
//  SearchViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    private lazy var accountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.textGray?.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.accountPerson
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Поиск контента"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let field = SearchTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 1
        field.layer.borderColor = Constants.Colors.boldGray!.cgColor
        field.layer.cornerRadius = 10
        field.font = Constants.Font.getFont(name: "Bold", size: 17)
        field.delegate = self
        field.placeholder = "Введите контент"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Результат поиска"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    private lazy var favouritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить в избранное", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = Constants.Colors.general
        button.titleLabel?.font = Constants.Font.getFont(name: "Bold", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            SearchViewController.createCollectionViewLayout()
        })
    }()
    
    private lazy var resultSearchButton: SearchResultButton = SearchResultButton()
    private lazy var recentlyTracks = [TrackViewModel]()
    private var resultModel: TrackViewModel?
    private lazy var heightConstant = 75
    var fromAnotherView: Bool?
    
    var presenter: SearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc
    private func accountButtonTapped() {
        presenter?.openAccountFlow()
    }
    
    @objc
    private func handleTapOutsideTextField() {
        view.endEditing(true)
    }
    
    @objc
    private func favouritesButtonTapped() {
        guard let result = resultModel else { return }
        presenter?.fetchLike(with: String(result.id))
    }
}

extension SearchViewController {
    private func insertViews() {
        accountButton.addSubview(accountImageView)
        
        view.addSubview(accountButton)
        view.addSubview(searchTextField)
        view.addSubview(titleLabel)
        view.addSubview(resultLabel)
        view.addSubview(resultSearchButton)
        view.addSubview(collectionView)
        view.addSubview(favouritesButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideTextField))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        self.configureCollectionView()
        
        if fromAnotherView! {
            self.createCustomTabBarLeftButton()
        }
    }
    
    private func layoutViews() {
        accountButton.pinTop(to: view, fromAnotherView! ? 100 : 60)
        accountButton.pinLeft(to: view, 15)
        accountButton.setHeight(60)
        accountButton.setWidth(60)
        
        accountImageView.pinCenter(to: accountButton)
        accountImageView.setWidth(35)
        accountImageView.setHeight(35)
        
        searchTextField.pinTop(to: accountButton.bottomAnchor, 30)
        searchTextField.pinLeft(to: self.view, 30)
        searchTextField.pinRight(to: self.view, 30)
        searchTextField.setHeight(34)
        
        titleLabel.pinTop(to: self.view, fromAnotherView! ? 115 : 75)
        titleLabel.pinLeft(to: accountButton.trailingAnchor, 20)
        
        collectionView.pinTop(to: self.searchTextField.bottomAnchor, 20)
        collectionView.pinLeft(to: self.view, 30)
        collectionView.pinRight(to: self.view, 30)
        collectionView.setHeight(300)

        
        resultLabel.pinTop(to: collectionView.bottomAnchor, 15)
        resultLabel.pinLeft(to: self.view, 30)
        
        resultSearchButton.pinTop(to: resultLabel.bottomAnchor, 20)
        resultSearchButton.pinLeft(to: self.view, 47)
        resultSearchButton.pinRight(to: self.view, 47)
        resultSearchButton.setHeight(68)
        
        favouritesButton.pinTop(to: resultSearchButton.bottomAnchor, 15)
        favouritesButton.pinHorizontal(to: view, 30)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let updated = (searchTextField.text as? NSString)?.replacingCharacters(in: range, with: string) {
            presenter?.fetchSearchData(with: updated)
            return true
        }
        return false
    }
}

extension SearchViewController {
    func updateUI(with model: TrackViewModel) {
        if recentlyTracks.contains(where: { $0.imageURL == model.imageURL }) == false {
            recentlyTracks.append(model)
        }
        
        UIView.animate(withDuration: 0.1) {
            self.collectionView.isHidden = false
            self.resultLabel.isHidden = false
            self.resultSearchButton.isHidden = false
            self.favouritesButton.isHidden = false
            self.collectionView.reloadData()
        }
        self.resultModel = model
        resultSearchButton.updateUI(with: model)
    }
    
    private func configureCollectionView() {
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchCollectionViewCell.identifier
        )
        
        collectionView.register(
            TitleSearchCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleSearchCollectionReusableView.identifier
        )
        
        resultSearchButton.isHidden = true
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Constants.Colors.boldGray
        collectionView.layer.cornerRadius = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.identifier,
            for: indexPath
        ) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        // TODO: Configure cell.
        let model = recentlyTracks[indexPath.row]
        
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentlyTracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let selectedTrack = recentlyTracks[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header =  collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleSearchCollectionReusableView.identifier,
            for: indexPath
        ) as? TitleSearchCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()
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
