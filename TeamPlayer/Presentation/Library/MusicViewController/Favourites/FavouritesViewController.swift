//
//  FavouritesViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.04.2024.
//

import UIKit

final class FavouritesViewController: UIViewController {
    private lazy var favouritesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15.0
        view.backgroundColor = Constants.Colors.general
        return view
    }()
    
    private lazy var heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.heartIcon
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var favouritesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.text = "Мои любимые треки"
        label.textAlignment = .center
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MusicListCell.self, forCellReuseIdentifier: MusicListCell.reuseIdentifier)
        tableView.separatorColor = .clear
        tableView.backgroundColor = Constants.Colors.backgroundColor
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    var presenter: FavouritesPresenter?
    private var tracks = [TrackViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    @objc
    private func plusButtonTapped() {
        presenter?.openMusicFlow()
    }
}

extension FavouritesViewController {
    private func insertViews() {
        favouritesView.addSubview(heartImageView)
        plusButton.addSubview(plusImageView)
        view.addSubview(favouritesView)
        view.addSubview(favouritesTitleLabel)
        view.addSubview(plusButton)
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        self.createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 68.0),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            
            plusImageView.heightAnchor.constraint(equalToConstant: 35),
            plusImageView.widthAnchor.constraint(equalToConstant: 35),
            
            favouritesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
            favouritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 74.0),
            favouritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -74.0),
            favouritesView.heightAnchor.constraint(equalToConstant: 242.0),
            
            heartImageView.centerXAnchor.constraint(equalTo: favouritesView.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: favouritesView.centerYAnchor),
            heartImageView.heightAnchor.constraint(equalToConstant: 80.0),
            heartImageView.widthAnchor.constraint(equalToConstant: 90.0),
            
            favouritesTitleLabel.topAnchor.constraint(equalTo: favouritesView.bottomAnchor, constant: 15.0),
            favouritesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 86.0),
            favouritesTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -86.0),
        ])
        
        tableView.pinTop(to: favouritesTitleLabel.bottomAnchor, 15)
        tableView.pinLeft(to: self.view, 30)
        tableView.pinRight(to: self.view, 30)
        tableView.pinBottom(to: self.view, 160)
    }
}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMusic = tracks[indexPath.row]
        //presenter?.didRoomTapped(viewModel: selectedRoom)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicListCell.reuseIdentifier, for: indexPath)
        
        guard let musicListCell = cell as? MusicListCell else {
            return UITableViewCell()
        }
        
        musicListCell.configureCell(for: tracks[indexPath.row])
        
        musicListCell.selectionStyle = .none
        return musicListCell
    }
}

extension FavouritesViewController {
    func updateTableView(with tracks: [TrackViewModel]) {
        self.tracks.append(contentsOf: tracks)
        let indexPathsToInsert = self.tracks.indices.map { IndexPath(row: $0, section: 0) }
        tableView.performBatchUpdates({
            tableView.insertRows(at: indexPathsToInsert, with: .automatic)
        }, completion: nil)
    }
}
