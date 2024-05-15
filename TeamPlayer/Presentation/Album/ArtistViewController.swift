//
//  AlbumViewController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

final class AlbumViewController: UIViewController {
    var presenter: AlbumPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.general
    }
}
