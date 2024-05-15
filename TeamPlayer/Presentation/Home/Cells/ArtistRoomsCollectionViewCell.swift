//
//  ArtistRoomsCollectionViewCell.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.05.2024.
//

import UIKit

class ArtistRoomsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ArtistRoomsCollectionViewCell"
    
    private lazy var artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var artistTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 15)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupViews()
        layoutViews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistTitleLabel.text = nil
        artistImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ArtistRoomsViewModel) {
        artistTitleLabel.text = model.name
        artistImageView.image = UIImage(named: model.image)
    }
}

extension ArtistRoomsCollectionViewCell {
    private func insertViews() {
        contentView.addSubview(artistImageView)
        contentView.addSubview(artistTitleLabel)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func layoutViews() {
        artistImageView.pinTop(to: contentView, 10)
        artistImageView.pinLeft(to: contentView, 10)
        artistImageView.pinRight(to: contentView, 10)
        artistImageView.pinBottom(to: contentView, 60)
        
        artistTitleLabel.pinTop(to: artistImageView.bottomAnchor, 10)
        artistTitleLabel.pinLeft(to: contentView, 15)
    }
}
