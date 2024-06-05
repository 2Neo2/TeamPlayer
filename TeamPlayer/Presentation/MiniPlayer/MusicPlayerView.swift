//
//  MusicPlayerView.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 06.05.2024.
//

import UIKit
import Kingfisher
import AVFoundation

final class MusicPlayerView: UIView,
                            MusicPlayerDisplayLogic {
    // MARK: - Constants
    private enum MusicPlayerConstants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let router: MusicPlayerRoutingLogic
    private let interactor: MusicPlayerBusinessLogic
    private var currentTrack: TrackViewModel?
    private var progressTimer: Timer?
    private var isPlay: Bool = false
    
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var musicNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 13)
        label.textColor = .black
        return label
    }()
    
    private lazy var musicArtistNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.getFont(name: "Black", size: 10)
        label.textColor = Constants.Colors.placeholder
        return label
    }()
    
    private lazy var musicPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(playMusicButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var musicPlayButtonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.playIcon
        imageView.tintColor = Constants.Colors.general
        return imageView
    }()
    
    private lazy var musicProgressView: UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = Constants.Colors.placeholder
        progress.layer.cornerRadius = 5
        progress.progressTintColor = Constants.Colors.general
        return progress
    }()
    
    // MARK: - LifeCycle
    init(
        router: MusicPlayerRoutingLogic,
        interactor: MusicPlayerBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(frame: .zero)
        insertViews()
        setupUI()
        layoutViews()
        interactor.loadStart(Model.Start.Request())
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.miniPlayerDidUpdate, object: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(MusicPlayerConstants.fatalError)
    }
    
    // MARK: - Setup
    private func insertViews() {
        musicPlayButton.addSubview(musicPlayButtonIcon)
        addSubview(musicImageView)
        addSubview(musicNameLabel)
        addSubview(musicArtistNameLabel)
        addSubview(musicPlayButton)
        addSubview(musicProgressView)
    }
    
    private func setupUI() {
        self.setHeight(70)
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = Constants.Colors.general?.cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(miniPlayerDidUpdate(_:)), name: NotificationCenter.miniPlayerDidUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(miniPlayerDidUpdate(_:)), name: NotificationCenter.miniPlayerHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(miniPlayerDidUpdate(_:)), name: NotificationCenter.miniPlayerOpen, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func layoutViews() {
        self.setHeight(70)
        musicImageView.pinTop(to: self, 7)
        musicImageView.pinLeft(to: self, 7)
        musicImageView.pinBottom(to: self, 13)
        musicImageView.setWidth(50)
        
        musicNameLabel.pinLeft(to: musicImageView.trailingAnchor, 11)
        musicNameLabel.pinTop(to: self, 8)
        musicNameLabel.setWidth(170)
        
        musicArtistNameLabel.pinTop(to: musicNameLabel.bottomAnchor, 2)
        musicArtistNameLabel.pinLeft(to: musicImageView.trailingAnchor, 11)
        musicArtistNameLabel.setWidth(170)
        
        musicPlayButton.pinCenterY(to: self)
        musicPlayButton.pinRight(to: self, 18)
        musicPlayButton.setWidth(25)
        musicPlayButton.setHeight(25)
        musicPlayButtonIcon.pin(to: musicPlayButton)
        
        musicProgressView.pinLeft(to: musicImageView.trailingAnchor, 11)
        musicProgressView.pinTop(to: musicArtistNameLabel.bottomAnchor, 8)
        musicProgressView.pinRight(to: musicPlayButton.leadingAnchor, 7)
        musicProgressView.setHeight(3)
    }
    
    // MARK: - Actions
    @objc
    private func viewTapped() {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = true
            self.musicImageView.isHidden = true
            self.musicNameLabel.isHidden = true
            self.musicPlayButton.isHidden = true
            self.musicArtistNameLabel.isHidden = true
            self.router.routeToPlayer(with: self.currentTrack, mode: self.isPlay)
        }
    }
    
    @objc
    private func playMusicButtonTapped() {
        self.musicPlayButton.isSelected.toggle()
        if self.musicPlayButton.isSelected {
            self.musicPlayButtonIcon.image = Constants.Images.pauseIcon
            interactor.loadPlay(Model.Play.Request())
            startUpdatingProgressView()
            self.isPlay = true
        } else {
            self.musicPlayButtonIcon.image = Constants.Images.playIcon
            interactor.loadPause(Model.Pause.Request())
            stopUpdatingProgressView()
            self.isPlay = false
        }
    }
    
    @objc
    private func updateProgressBar() {
        if let durationValue = MiniPlayerService.shared.playerItem?.duration,
           let timeValue = MiniPlayerService.shared.player?.currentTime()
        {
            let duration = CMTimeGetSeconds(durationValue)
            let currentTime = CMTimeGetSeconds(timeValue)
            let progress = Float(currentTime / duration)
            
            UIView.animate(withDuration: 0.1) {
                self.musicProgressView.progress = progress
            }
        }
    }
    
    @objc
    private func miniPlayerDidUpdate(_ notification: Notification) {
        if notification.name == NotificationCenter.miniPlayerHide {
            UIView.animate(withDuration: 0.3) {
                self.isHidden = true
            }
        } else if notification.name == NotificationCenter.miniPlayerOpen {
            UIView.animate(withDuration: 0.3) {
                self.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                if self.musicPlayButton.isSelected == false {
                    self.musicPlayButton.isSelected.toggle()
                    self.musicPlayButtonIcon.image = Constants.Images.pauseIcon
//                    self.interactor.loadPlay(Model.Play.Request())
                    self.startUpdatingProgressView()
                    self.isPlay = true
                }
                self.isPlay = true
                self.currentTrack = MiniPlayerService.shared.currentTrack
                guard let musicLink = self.currentTrack?.imageURL  else { return }
                self.musicNameLabel.text = self.currentTrack?.name
                self.musicArtistNameLabel.text = self.currentTrack?.artist
                self.musicImageView.kf.indicatorType = .activity
                self.musicImageView.kf.setImage(with: URL(string: musicLink))
                self.interactor.loadPlay(Model.Play.Request())
            }

        }
    }
    
    private func startUpdatingProgressView() {
        progressTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateProgressBar),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func stopUpdatingProgressView() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    // MARK: - MusicPlayerDisplayLogic
    func displayStart(_ viewModel: Model.Current.ViewModel) {
        musicNameLabel.text = viewModel.currentTrack.name
        musicArtistNameLabel.text = viewModel.currentTrack.artist
        musicImageView.kf.indicatorType = .activity
        musicImageView.kf.setImage(with: URL(string: viewModel.currentTrack.imageURL))
        self.currentTrack = viewModel.currentTrack
    }
}

extension MusicPlayerView: ClosePlayerProtocol {
    func openMiniPlayerFlow(with model: TrackViewModel?) {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = false
            self.musicImageView.isHidden = false
            self.musicNameLabel.isHidden = false
            self.musicPlayButton.isHidden = false
            self.musicArtistNameLabel.isHidden = false
        }
        guard let model = model else { return }
        if MiniPlayerService.shared.isPlay {
            if self.musicPlayButton.isSelected == false {
//                self.musicPlayButton
            }
        }
        musicNameLabel.text = model.name
        musicArtistNameLabel.text = model.artist
        musicImageView.kf.indicatorType = .activity
        musicImageView.kf.setImage(with: URL(string: model.imageURL))
        self.currentTrack = model
    }
}
