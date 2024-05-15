//
//  HelpViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 11.04.2024.
//

import UIKit

final class HelpViewController: UIViewController {
    private lazy var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.getFont(name: "Bold", size: 23)
        label.textColor = .black
        label.text = "Помощь"
        return label
    }()
    
    var presenter: HelpPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc
    private func securityButtonTapped() {
        
    }
    
}

extension HelpViewController {
    private func insertViews() {
        view.addSubview(generalLabel)
    }
    
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        createCustomTabBarLeftButton()
    }
    
    private func layoutViews() {
        generalLabel.pinTop(to: self.view.topAnchor, 100)
        generalLabel.pinLeft(to: self.view.leadingAnchor, 15)
    }
}

