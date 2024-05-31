//
//  Constants.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 01.04.2024.
//

import UIKit

struct Constants {
    struct Images {
        static let security = UIImage(named: "security")
        static let homeBarIcon = UIImage(systemName: "house")
        static let libraryBarIcon = UIImage(systemName: "rectangle.on.rectangle")
        static let listenRoomIcon = UIImage(systemName: "music.note.house.fill")
        static let accountPerson = UIImage(systemName: "person.fill")
        static let searchButton = UIImage(systemName: "magnifyingglass")
        static let plusButton = UIImage(systemName: "plus")
        static let cancelButton = UIImage(systemName: "multiply")
        static let filterGridTableButton = UIImage(systemName: "square.grid.2x2")
        static let filterGridListButton = UIImage(systemName: "list.bullet")
        static let playIconCell = UIImage(systemName: "play.fill")
        static let musicItemCellIcon = UIImage(named: "itemCell")
        static let roomIconCell = UIImage(named: "music.note.house.fill")
        static let rightArrowIcon = UIImage(systemName: "arrow.right")
        static let heartIcon = UIImage(systemName: "heart.fill")
        static let photoIcon = UIImage(named: "photo")
        static let musicBarIcon = UIImage(systemName: "music.quarternote.3")
        static let cancelIconCustom = UIImage(named: "cancelCustom")
        static let regIcon = UIImage(named: "regIcon")
        static let authIcon = UIImage(named: "authIcon")
        static let backwardIcon = UIImage(systemName: "chevron.right")
        static let arrowDown = UIImage(systemName: "chevron.down")
        static let logoutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        static let starIcon = UIImage(systemName: "star")
        static let fillStarIcon = UIImage(systemName: "star.fill")
        static let linkIcon = UIImage(systemName: "link")
        static let soundIcon = UIImage(systemName: "speaker.wave.3")
        static let speakerSlach = UIImage(systemName: "speaker.slash")
        static let backwardPlayIcon = UIImage(systemName: "backward.fill")
        static let forwardPlayIcon = UIImage(systemName: "forward.fill")
        static let playIcon = UIImage(systemName: "play")
        static let pauseIcon = UIImage(systemName: "pause")
        static let joinRoomIcon = UIImage(systemName: "music.mic")
        static let customRoomIcon = UIImage(named: "musicRoom")
        static let roomIcon = UIImage(systemName: "music.note.tv")
        static let crownIcon = UIImage(systemName: "crown.fill")
        static let albumIcon = UIImage(systemName: "rectangle.stack.badge.play.fill")
        static let musicNoteIcon = UIImage(systemName: "music.note")
        static let playlistIcon = UIImage(systemName: "play.square.stack.fill")
        static let cyclePlayIcon = UIImage(systemName: "arrow.2.squarepath")
        static let intersectionPlayIcon = UIImage(systemName: "arrow.up.left.arrow.down.right.circle.fill")
        static let likeIcon = UIImage(systemName: "hand.thumbsup.fill")
        static let dislikeIcon = UIImage(systemName: "hand.thumbsdown.fill")
        static let defaultAccountIcon = UIImage(named: "accountDefault")
        static let playlistDefault = UIImage(named: "playlistDefault")
        static let minusIcon = UIImage(systemName: "minus")
        static let removeUserIcon = UIImage(systemName: "xmark.bin.fill")
        static let userDjIcon = UIImage(systemName: "repeat.circle")
        static let boltIcon = UIImage(systemName: "bolt.square.fill")
    }
    
    struct Colors {
        static var textGray = UIColor(named: "gray_text")
        static var general = UIColor(named: "general")
        static var placeholder = UIColor(named: "placeholder")
        static var backgroundColor = UIColor(named: "background")
        static var generalLight = UIColor(named: "general_light")
        static var boldGray = UIColor(named: "bold_gray")
    }
    
    struct Font {
        static func getFont(name: String, size: CGFloat) -> UIFont {
            return UIFont(name: "Poppins-\(name)", size: size) ?? UIFont()
        }
    }
    
    struct Network {
        static let defaultVaporBaseURL: String = "http://localhost:8080"
        static let yaToken: String = "y0_AgAEA7qkELrSAAG8XgAAAAEAzIBdAADDl2YkAfJDva6IL0K_w9vgo9Yx8A"
        static let defaultYandexMusicBaseURL: String = "https://api.mipoh.ru"
    }
}
