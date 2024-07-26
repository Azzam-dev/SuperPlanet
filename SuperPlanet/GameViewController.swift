//
//  GameViewController.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import UIKit
import SnapKit

class GameViewController: UIViewController {

    @IBOutlet var pauseView: UIVisualEffectView!
    var displayLink: CADisplayLink?
    var lastUpdateTime: CFTimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseView.alpha = 0
        view.addSubview(pauseView)
        pauseView.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        
        
        // Set up the display link
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .main, forMode: .default)
        
        // Initialize the last update time
        lastUpdateTime = CACurrentMediaTime()
    }

    @objc func gameLoop() {
        let currentTime = CACurrentMediaTime()
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        // Update game state
        update(deltaTime: deltaTime)
        
        // Render the game
        render()
    }
    
    func update(deltaTime: CFTimeInterval) {
        // Update your game state here using deltaTime
    }
    
    func render() {
        // Render your game here
    }
    
    @IBAction func pauseAndStartButtons(_ sender: UIButton) {
        if pauseView.isHidden {
            pauseView.isHidden = false
            UIView.animate(withDuration: 1) {
                self.pauseView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.pauseView.alpha = 0
            } completion: { _ in
                self.pauseView.isHidden = true
            }

        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Invalidate the display link when the view is about to disappear
        displayLink?.invalidate()
    }
    
}
