//
//  ScreenshotViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 9.11.21.
//

import UIKit

class ScreenshotViewController: UIViewController {

    var image: UIImage!
    var imageScrollView: ScreenshotView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        self.imageScrollView = ScreenshotView(frame: self.view.bounds)
        self.view.addSubview(self.imageScrollView)
        self.layoutImageScrollView()
        self.imageScrollView.display(image)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.restoreStatesForRotation(in: size)
    }

    func restoreStatesForRotation(in bounds: CGRect) {
        // recalculate contentSize based on current orientation
        let restorePoint = imageScrollView.pointToCenterAfterRotation()
        let restoreScale = imageScrollView.scaleToRestoreAfterRotation()
        imageScrollView.frame = bounds
        imageScrollView.setMaxMinZoomScaleForCurrentBounds()
        imageScrollView.restoreCenterPoint(to: restorePoint, oldScale: restoreScale)
    }

    func restoreStatesForRotation(in size: CGSize) {
        var bounds = self.view.bounds
        if bounds.size != size {
            bounds.size = size
            self.restoreStatesForRotation(in: bounds)
        }
    }

    func layoutImageScrollView() {
        self.imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalTo(view.safeAreaLayoutGuide)
            constraints.leading.trailing.equalToSuperview()
            constraints.width.equalToSuperview()
        }

//        let top = NSLayoutConstraint(item: self.imageScrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
//        let left = NSLayoutConstraint(item: self.imageScrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0)
//
//        let bottom = NSLayoutConstraint(item: self.imageScrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
//        let right = NSLayoutConstraint(item: self.imageScrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0)
//
//        self.view.addConstraints([top, left, bottom, right])
    }

}
