//
//  GamesListViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 25.10.21.
//

import UIKit

class GamesListViewController: UIViewController {

    var textLabel: UILabel!

    var view1: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel = UILabel()
        view1 = UIView()
        view1.backgroundColor = .red
        view1.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        textLabel.text = "dfgdfgdfg"
        textLabel.center = view.center
        view.addSubview(textLabel)
        // view.addSubview(view1)
        // Do any additional setup after loading the view.
    }

    func setupSettings() {
        view.backgroundColor = Colors.backgroundColor.getUIColor()
        title = "Games"
        let item = UITabBarItem()
        item.title = "Games"
        item.image = UIImage(systemName: "list.star")
        tabBarItem = item
    }

}
