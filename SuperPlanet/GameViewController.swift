//
//  GameViewController.swift
//  SuperPlanet
//
//  Created by الشيخ عزام on 20/01/1446 AH.
//

import UIKit
import SnapKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet var pauseView: UIVisualEffectView!
    var displayLink: CADisplayLink?
    var lastUpdateTime: CFTimeInterval = 0
    var playerActionCards = [PlayerAction]()
    
    @IBOutlet var actionCardsViews: [UIView]!
    @IBOutlet var actionCardsButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGameScene()
        setupPauseView()
        setupPlayerActionCards()
    }
    
    fileprivate func setupGameScene() {
        if let view = self.view as? SKView {
            let scene = GameScene(size: view.bounds.size)
            scene.gameSceneDelegate = self // Set the delegate
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
    
    fileprivate func setupPlayerActionCards() {
        playerActionCards = Array([
            PlayerAction(card: .attack),
            PlayerAction(card: .jump),
            PlayerAction(card: .forward),
            PlayerAction(card: .back),
            
            PlayerAction(card: .attack),
            PlayerAction(card: .jump),
            PlayerAction(card: .forward),
            PlayerAction(card: .back),
            
            PlayerAction(card: .attack),
            PlayerAction(card: .jump),
            PlayerAction(card: .forward),
            PlayerAction(card: .back),
        ].shuffled().prefix(5))
        
        actionCardsButtons.enumerated().forEach { index, cardButton in
            let image = UIImage(systemName: playerActionCards[index].card.rawValue)
            cardButton.setImage(image, for: .normal)
        }
    }
    
    func didUpdatePoints(_ points: Int) {
        pointsLabel.text = String(points)
    }
    
    @IBAction func didPlayCard(_ sender: UIButton) {
        if let view = self.view as? SKView,
           let gameScene = view.scene as? GameScene {
            switch playerActionCards[sender.tag].card {
            case .attack:
                print("☄️☄️☄️✨✨✨")
            case .jump:
                gameScene.player.jump()
            case .forward:
                gameScene.player.move(by: CGPoint(x: 30, y: 0))
            case .back:
                gameScene.player.move(by: CGPoint(x: -30, y: 0))
            }
        }
        
        playerActionCards[sender.tag] = [PlayerAction(card: .attack),PlayerAction(card: .jump),PlayerAction(card: .forward),PlayerAction(card: .back)].shuffled().first!
        let newCardIcon = UIImage(systemName: playerActionCards[sender.tag].card.rawValue)!
        cardAnimationAndUpdatingIcon(view: actionCardsViews[sender.tag], button: sender, icon: newCardIcon )
        
    }
    
    func cardAnimationAndUpdatingIcon(view: UIView, button: UIButton, icon: UIImage, duration: CFTimeInterval = 0.5) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: {
            view.alpha = 0
            view.transform = view.transform.rotated(by: .pi)
                .scaledBy(x: 0.5, y: 0.5)
        }, completion: { _ in
            UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: {
                button.setImage(icon, for: .normal)
                view.alpha = 1
                view.transform = view.transform.rotated(by: .pi)
                    .scaledBy(x: 2, y: 2)
            }, completion: { _ in
                // If you want to keep rotating the view indefinitely, uncomment the following line:
                // self.rotateView360Degrees(view: view)
            })
        })
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
