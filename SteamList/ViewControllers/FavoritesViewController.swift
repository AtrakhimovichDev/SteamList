//
//  FavoritesGamesViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupSettings() {
        view.backgroundColor = Colors.backgroundColor.getUIColor()
        title = "Favorites"
        let item = UITabBarItem()
        item.title = "Fav"
        item.image = UIImage(systemName: "star.fill")
        tabBarItem = item
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
