//
//  PlayerViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import UIKit
import Kingfisher

protocol ClosePlayerProtocol: AnyObject {
    func openMiniPlayerFlow(with model: TrackViewModel?)
}

final class PlayerViewController: UIViewController {
    private lazy var bottomArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(bottomArrowButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private let bottomArrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.arrowDown
        imageView.tintColor = .white
        return imageView
    }()
    
    private let musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleMusicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var  playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.playIcon
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var forwardPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var forwardPlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.forwardPlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var backwardPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var backwardPlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.backwardPlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var cyclePlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(cycleButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var cyclePlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.cyclePlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var intersectionPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(intersectionButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var intersectionPlayIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.intersectionPlayIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var likeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.likeIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var dislikeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(dislikeButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var dislikeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.dislikeIcon
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    var presenter: PlayerPresenter?
    var currentModel: TrackViewModel?
    var delegate: ClosePlayerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc
    private func playButtonTapped() {
        self.playButton.isSelected.toggle()
        if self.playButton.isSelected {
            self.playIcon.image = Constants.Images.pauseIcon
        } else {
            self.playIcon.image = Constants.Images.playIcon
        }
    }
    
    @objc
    private func bottomArrowButtonTapped() {
        presenter?.hideView()
        delegate?.openMiniPlayerFlow(with: self.currentModel)
    }
    
    @objc
    private func forwardButtonTapped() {
        presenter?.fetchData()
    }
    
    @objc
    private func backwardButtonTapped() {
        presenter?.fetchData()
    }
    
    @objc
    private func cycleButtonTapped() {
        
    }
    
    @objc
    private func intersectionButtonTapped() {
        
    }
    
    @objc
    private func likeButtonTapped() {
        self.likeButton.isSelected.toggle()
        
        if likeButton.isSelected {
            likeIcon.tintColor = Constants.Colors.general
        } else {
            likeIcon.tintColor = .white
        }
    }
    
    @objc
    private func dislikeButtonTapped() {
        self.dislikeButton.isSelected.toggle()
        
        if dislikeButton.isSelected {
            dislikeIcon.tintColor = Constants.Colors.general
        } else {
            dislikeIcon.tintColor = .white
        }
    }
}

extension PlayerViewController {
    private func insertViews() {
        backwardPlayButton.addSubview(backwardPlayIcon)
        forwardPlayButton.addSubview(forwardPlayIcon)
        bottomArrowButton.addSubview(bottomArrowIcon)
        cyclePlayButton.addSubview(cyclePlayIcon)
        intersectionPlayButton.addSubview(intersectionPlayIcon)
        likeButton.addSubview(likeIcon)
        dislikeButton.addSubview(dislikeIcon)
        playButton.addSubview(playIcon)
        view.addSubview(musicImageView)
        view.addSubview(titleMusicLabel)
        view.addSubview(artistLabel)
        view.addSubview(playButton)
        view.addSubview(bottomArrowButton)
        view.addSubview(backwardPlayButton)
        view.addSubview(forwardPlayButton)
        view.addSubview(likeButton)
        view.addSubview(dislikeButton)
        view.addSubview(intersectionPlayButton)
        view.addSubview(cyclePlayButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.generalLight
        titleMusicLabel.text = self.currentModel?.name
        artistLabel.text = self.currentModel?.artist
        musicImageView.kf.indicatorType = .activity
        musicImageView.kf.setImage(with: URL(string: self.currentModel?.imageURL ?? ""))
    }
    
    func updateTrack(with model: TrackViewModel?) {
        guard let model = model else { return }
        titleMusicLabel.text = model.name
        artistLabel.text = model.artist
        musicImageView.kf.indicatorType = .activity
        musicImageView.kf.setImage(with: URL(string: model.imageURL))
        self.currentModel = model
        UIBlockingProgressHUD.dismiss()
    }
    
    private func layoutViews() {
        bottomArrowButton.pinTop(to: view, 30)
        bottomArrowButton.pinLeft(to: view, 15)
        bottomArrowButton.setHeight(30)
        bottomArrowButton.setWidth(30)
        bottomArrowIcon.pin(to: bottomArrowButton)
        
        musicImageView.pinTop(to: bottomArrowButton.bottomAnchor, 10)
        musicImageView.pinHorizontal(to: self.view, 30)
        musicImageView.setHeight(320)
        
        titleMusicLabel.pinTop(to: musicImageView.bottomAnchor, 10)
        titleMusicLabel.pinLeft(to: self.view, 30)
        titleMusicLabel.setWidth(view.frame.width - 60.0)
        
        artistLabel.pinTop(to: titleMusicLabel.bottomAnchor, 2)
        artistLabel.pinLeft(to: self.view, 30)
        artistLabel.setWidth(view.frame.width - 60.0)
        
        playButton.pinCenterX(to: self.view)
        playButton.pinTop(to: artistLabel.bottomAnchor, 50)
        playButton.setHeight(60)
        playButton.setWidth(60)
        
        playIcon.pin(to: playButton)
        
        backwardPlayButton.pinRight(to: playButton.leadingAnchor, 30)
        backwardPlayButton.pinCenterY(to: playButton.centerYAnchor)
        backwardPlayButton.setWidth(50)
        backwardPlayIcon.pin(to: backwardPlayButton)
        
        forwardPlayButton.pinCenterY(to: playButton.centerYAnchor)
        forwardPlayButton.pinLeft(to: playButton.trailingAnchor, 30)
        forwardPlayButton.setWidth(50)
        forwardPlayIcon.pin(to: forwardPlayButton)
        
        dislikeButton.pinCenterY(to: backwardPlayButton)
        dislikeButton.pinLeft(to: view, 30)
        dislikeButton.setHeight(30)
        dislikeButton.setWidth(30)
        dislikeIcon.pin(to: dislikeButton)
        
        likeButton.pinCenterY(to: forwardPlayButton)
        likeButton.pinRight(to: view, 30)
        likeButton.setHeight(30)
        likeButton.setWidth(30)
        likeIcon.pin(to: likeButton)
        
        intersectionPlayButton.pinTop(to: playButton.bottomAnchor, 20)
        intersectionPlayButton.pinLeft(to: view, 30)
        intersectionPlayButton.setHeight(30)
        intersectionPlayButton.setWidth(30)
        intersectionPlayIcon.pin(to: intersectionPlayButton)
        
        cyclePlayButton.pinTop(to: playButton.bottomAnchor, 20)
        cyclePlayButton.pinLeft(to: intersectionPlayButton.trailingAnchor, 15)
        cyclePlayButton.setHeight(30)
        cyclePlayButton.setWidth(30)
        cyclePlayIcon.pin(to: cyclePlayButton)
    }
}

