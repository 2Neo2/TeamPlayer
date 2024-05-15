//
//  CustomTabBarController.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.04.2024.
//

import UIKit

class CustomTabBarController : UITabBarController {
    // TODO: Implement Music player view as Clean Swift.
    private lazy var musicPlayer = MusicPlayerAssembly.build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.layer.borderColor = Constants.Colors.general?.cgColor
        tabBar.layer.borderWidth = 1
        addSomeTabItems()
        addMusicPlayer()
    }
    
    private func addMusicPlayer() {
        view.addSubview(musicPlayer)
        musicPlayer.pinHorizontal(to: view, 10)
        musicPlayer.pinBottom(to: tabBar.topAnchor, 3)
    }
    
    private func addSomeTabItems() {
        let homeVC = configureTabBarItems(for: HomeConfigurator.configure(), with: Constants.Images.listenRoomIcon!, with: "Главная")
        let searchVC = configureTabBarItems(for: SearchConfigurator.configure(isFromAnotherView: false), with: Constants.Images.searchButton!, with: "Поиск")
        let listenVC = configureTabBarItems(for: RoomsConfigurator.configure(isFromAnotherView: false), with: Constants.Images.musicBarIcon!, with: "Сообщества")
        let libraryVC = configureTabBarItems(for: LibraryConfigurator.configure(), with: Constants.Images.libraryBarIcon!, with: "Моя медиатека")
        
        viewControllers = [homeVC, searchVC, listenVC, libraryVC]
    }
    
    private func configureTabBarItems(for controller: UIViewController, with image: UIImage, with text: String) -> UIViewController {
        controller.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = image.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.title = text
        return UINavigationController(rootViewController: controller)
    }
}
