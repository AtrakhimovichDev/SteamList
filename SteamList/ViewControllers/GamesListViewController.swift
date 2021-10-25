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
        //view.addSubview(view1)
        // Do any additional setup after loading the view.
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
