//
//  RoomsViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

final class RoomsViewController: UIViewController {
    private lazy var accountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.layer.borderColor = Constants.Colors.textGray?.cgColor
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.accountPerson
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 24)
        label.text = "Мои сообщества"
        label.textAlignment = .left
        return label
    }()

    private lazy var joinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var joinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.joinRoomIcon
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.plusButton
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "BoldItalic", size: 20)
        label.text = "Создай свое сообщество, чтобы слушать музыку вместе с друзьями!"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RoomListCell.self, forCellReuseIdentifier: RoomListCell.reuseIdentifier)
        tableView.separatorColor = .clear
        tableView.backgroundColor = Constants.Colors.backgroundColor
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    var presenter: RoomsPresenter?
    private var rooms = [RoomViewModel]()
    private var oldRowCount = 0
    var fromAnotherView: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
        
        presenter?.fetchData()
    }
    
    @objc
    private func accountButtonTapped() {
        presenter?.openAccountFlow()
    }
    
    @objc
    private func plusButtonTapped() {
        presenter?.openCreateFlow()
    }
    
    @objc
    private func joinButtonTapped() {
        presenter?.openJoinFlow()
    }
}

extension RoomsViewController {
    private func insertViews() {
        view.addSubview(accountButton)
        view.addSubview(titleLabel)
        view.addSubview(plusButton)
        view.addSubview(infoLabel)
        view.addSubview(tableView)
        view.addSubview(joinButton)
        
        
        accountButton.addSubview(accountImageView)
        plusButton.addSubview(plusImageView)
        joinButton.addSubview(joinImageView)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        
        if self.fromAnotherView! {
            self.createCustomTabBarLeftButton()
        }
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            accountButton.topAnchor.constraint(equalTo: view.topAnchor, constant: self.fromAnotherView! ? 100 : 60.0),
            accountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            accountButton.heightAnchor.constraint(equalToConstant: 60.0),
            accountButton.widthAnchor.constraint(equalToConstant: 60.0),
            
            accountImageView.heightAnchor.constraint(equalToConstant: 35.0),
            accountImageView.widthAnchor.constraint(equalToConstant: 35.0),
            accountImageView.centerXAnchor.constraint(equalTo: accountButton.centerXAnchor),
            accountImageView.centerYAnchor.constraint(equalTo: accountButton.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: accountButton.trailingAnchor, constant: 20.0),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: self.fromAnotherView! ? 115 : 75),
            
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: self.fromAnotherView! ? 113 : 73.0),
            plusButton.heightAnchor.constraint(equalToConstant: 40.0),
            plusButton.widthAnchor.constraint(equalToConstant: 40.0),
            
            joinButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -5.0),
            joinButton.topAnchor.constraint(equalTo: view.topAnchor, constant: self.fromAnotherView! ? 115 : 75.0),
            joinButton.heightAnchor.constraint(equalToConstant: 37.0),
            joinButton.widthAnchor.constraint(equalToConstant: 37.0)
        ])
        
        tableView.pinTop(to: titleLabel.bottomAnchor, 20)
        tableView.pinLeft(to: self.view, 30)
        tableView.pinRight(to: self.view, 30)
        tableView.pinBottom(to: self.view, 160)
        
        infoLabel.pinCenter(to: self.view)
        infoLabel.pinLeft(to: self.view, 30)
        infoLabel.pinRight(to: self.view, 30)
        
        plusImageView.pin(to: plusButton)
        
        joinImageView.pin(to: joinButton)
    }
}

extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomListCell.reuseIdentifier, for: indexPath)
        
        guard let roomListCell = cell as? RoomListCell else {
            return UITableViewCell()
        }
        
        roomListCell.configureCell(for: rooms[indexPath.row])
        
        roomListCell.selectionStyle = .none
        return roomListCell
    }
}

extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRoom = rooms[indexPath.row]
        presenter?.didRoomTapped(viewModel: selectedRoom)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}

extension RoomsViewController {
    func updateUI(with models: [RoomViewModel]) {
        rooms = models
        
        let newRowCount = rooms.count
        print(newRowCount)
        print(oldRowCount)
        if newRowCount > oldRowCount {
            let diff = newRowCount - oldRowCount
            let indexPathsToInsert = rooms.suffix(diff).indices.map { IndexPath(row: $0, section: 0) }
            tableView.performBatchUpdates({
                tableView.insertRows(at: indexPathsToInsert, with: .automatic)
            }, completion: nil)
        }
        
        oldRowCount = newRowCount
        if self.rooms.count != 0 {
            self.infoLabel.isHidden = true
        } else {
            self.infoLabel.isHidden = false
            self.tableView.isHidden = true
        }
    }
}

extension RoomsViewController: CreateRoomVCProtocol {
    func updateTableView() {
        SnackBar.make(in: self.view, message: "Комната создана! Код приглашения скопирован!", duration: .lengthLong).show()
        presenter?.fetchData()
    }
}

extension RoomsViewController: JoinVCProtocol {
    func updateRooms() {
        
    }
}

