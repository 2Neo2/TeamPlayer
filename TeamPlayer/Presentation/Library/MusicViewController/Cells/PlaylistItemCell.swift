//
//  PlaylistItemCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.04.2024.
//

import UIKit

class PlaylistItemViewCell: UICollectionViewCell {
    static let identifier = String(describing: PlaylistItemViewCell.self)
    
    private lazy var playlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var playlistTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var removePlaylistButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var removeIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Constants.Colors.general
        imageView.image = Constants.Images.minusIcon
        return imageView
    }()
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 10)
        label.text = "Плейлист"
        label.textColor = Constants.Colors.placeholder
        label.textAlignment = .center
        return label
    }()
    
    private var currentModel: PlaylistViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with model: PlaylistViewModel) {
        playlistTitleLabel.text = model.name
        if let imageData = model.imageData, imageData.isEmpty == false {
            if let data = Data(base64Encoded: imageData) {
                playlistImageView.image = UIImage(data: data)
                return
            }
        }
        currentModel = model
        playlistImageView.image = Constants.Images.playlistDefault
    }
    
    private func insertViews() {
        removePlaylistButton.addSubview(removeIconView)
        contentView.addSubview(playlistImageView)
        contentView.addSubview(playlistTitleLabel)
        contentView.addSubview(removePlaylistButton)
        contentView.addSubview(infoTitleLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        playlistImageView.pinTop(to: contentView, 10)
        playlistImageView.pinCenterY(to: contentView)
        playlistImageView.pinLeft(to: contentView, 10)
        playlistImageView.setWidth(56)
        
        playlistTitleLabel.pinTop(to: contentView, 13)
        playlistTitleLabel.pinLeft(to: playlistImageView.trailingAnchor, 5)
        
        infoTitleLabel.pinTop(to: playlistTitleLabel.bottomAnchor, 3)
        infoTitleLabel.pinLeft(to: playlistImageView.trailingAnchor, 5)
        
        removePlaylistButton.pinCenterY(to: contentView)
        removePlaylistButton.pinRight(to: contentView, 30)
        removeIconView.pin(to: removePlaylistButton)
        removeIconView.setHeight(2)
    }
}


extension PlaylistItemViewCell {
    private func fetchRemove() {
        UIBlockingProgressHUD.show()
        let vaporService = PlaylistService()
        
        guard 
            let token = UserDataStorage().token,
            let id = currentModel?.id
        else { return }
        
        vaporService.removePlaylist(token: token, playlistID: id) { result in
            switch result {
            case .success(_):
                print("ok")
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    @objc
    private func removeButtonTapped() {
        guard let currentModel = currentModel else { return }
        self.fetchRemove()
    }
}

