//
//  MainViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.04.2024.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - UIViews.
    
    private var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private lazy var collectionImage: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        collection.layer.cornerRadius = 24
        return collection
    }()

    private lazy var pageControlView: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = images.count
        control.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        control.currentPage = 0
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = .purple
        control.translatesAutoresizingMaskIntoConstraints = false

        return control
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Присоединяйся к сообществу!"
        label.font = Constants.Font.getFont(name: "ExtraBold", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Погружайся в мир музыки вместе с TeamPlayer"
        label.textColor = Constants.Colors.textGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Constants.Font.getFont(name: "Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackViewH: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.setTitle("Авторизация", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = Constants.Colors.general
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = Constants.Font.getFont(name: "ExtraBold", size: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(regButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Variables.
    
    private var images = [UIImage(named: "welcome1"), UIImage(systemName: "circle"), UIImage(named: "welcome1")]
    
    var presenter: MainPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertView()
        setupView()
        layoutViews()
    }
    
    // MARK: - Button Actions
    
    @objc func authButtonTapped() {
        presenter?.openAuthFlow()
    }
    
    @objc func regButtonTapped() {
        presenter?.openRegFlow()
    }
    
    @objc
    func pageControlTapped(_ sender: UIPageControl) {
        print(sender.currentPage)
        collectionImage.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension MainViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout.
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
    
    // MARK: - UIScrollViewDelegate.
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControlView.currentPage = Int(pageIndex)
    }
}

extension MainViewController {
    func setupView() {
        self.view.backgroundColor = Constants.Colors.backgroundColor
        stackViewH.addArrangedSubview(authButton)
        stackViewH.addArrangedSubview(regButton)
    }
    
    func insertView() {
        view.addSubview(collectionImage)
        view.addSubview(pageControlView)
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(stackViewH)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 76.0),
            collectionImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            collectionImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            collectionImage.heightAnchor.constraint(equalToConstant: 390.0),
            
            pageControlView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15),
            pageControlView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 60.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44.0),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44.0),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44.0),
            
            stackViewH.bottomAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 154.0),
            stackViewH.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48.0),
            stackViewH.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48.0),
            stackViewH.heightAnchor.constraint(equalToConstant: 66.0)
        ])
    }
}

class ImageCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    func setupImageView() {
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
    }
}

