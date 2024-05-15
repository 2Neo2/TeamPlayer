//
//  RatingViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 03.05.2024.
//

import UIKit

final class RatingViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Рейтинговая таблица"
        label.font = Constants.Font.getFont(name: "Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    var presenter: RatingPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
}

extension RatingViewController {
    private func insertViews() {
        view.addSubview(titleLabel)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        titleLabel.pinTop(to: view, 65)
        titleLabel.pinLeft(to: view, 55)
    }
}
