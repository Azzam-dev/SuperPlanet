//
//  GameViewController.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import UIKit
import SnapKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet var pauseView: UIVisualEffectView!
    var displayLink: CADisplayLink?
    var lastUpdateTime: CFTimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGameScene()
        setupPauseView()
    }
    
    fileprivate func setupGameScene() {
        if let view = self.view as? SKView {
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    
    fileprivate func setupPauseView() {
        pauseView.alpha = 0
        view.addSubview(pauseView)
        pauseView.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
    }
    
    
    @IBAction func didPlayCard(_ sender: UIButton) {
        if let view = self.view as? SKView,
           let gameScene = view.scene as? GameScene {
            switch sender.tag {
            case 0:
                gameScene.player.jump() // Call the jump method in GameScene
            case 1:
                gameScene.player.move(by: CGPoint(x: 50, y: 0))
            default:
                gameScene.player.move(by: CGPoint(x: -50, y: 0))
            }
            
        }
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
    
    @IBAction func backToHomeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Invalidate the display link when the view is about to disappear
        displayLink?.invalidate()
    }
    
}
