//
//  ViewController.swift
//  drake-cellphone
//
//  Created by Isabella Vieira on 13/09/16.
//  Copyright © 2016 Isabella Vieira. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?
var drake = UIImage(named: "drake-happy")


class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var square : UIView!
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    
    var behavior : UIDynamicItemBehavior!
    
    let drakeView = UIImageView(image: drake!)
    
    var colidiu = false
    
    override func viewDidLoad() {
        
        playDrake()

        let cellphone = UIImage(named: "cellphone")
        let cellphoneView = UIImageView(image: cellphone!)
        
        
        cellphoneView.frame = CGRect(x: UIScreen.main.bounds.size.width/2 - 25, y: 1, width: 50, height: 100)
        view.addSubview(cellphoneView)
        
        drakeView.frame = CGRect(x: UIScreen.main.bounds.size.width/2 - 75, y: 500, width: 150, height: 200)
        view.addSubview(drakeView)

        
        // 2. faz o quadrado cair
        
        
        behavior = UIDynamicItemBehavior(items: [cellphoneView])
        behavior.elasticity = 1.13
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [cellphoneView])
        
        cellphoneView.alpha = 0
        UIView.animate(withDuration: 13, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            cellphoneView.alpha = 1
        }, completion: { finished in
            self.animator.addBehavior(self.gravity)
        })
        
        
        animator.addBehavior(behavior)
        
        // 3. impede o quadrado de cair além do fim da tela (faz com que o quadrado colida com o limite da tela)
        // 5. faz com que a barreira afete o quadrado e, de fato, atue como uma barreira
        collision = UICollisionBehavior(items: [cellphoneView])
        collision.collisionDelegate = self
        
        collision.addBoundary(withIdentifier: "drake" as NSCopying, for: UIBezierPath(rect: drakeView.frame))

        animator.addBehavior(collision)

        
        
        super.viewDidLoad()
    }

    func playDoh() {
        let url = Bundle.main.url(forResource: "Homer Simpson - D'oh!", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func playDrake() {
        let url = Bundle.main.url(forResource: "hotlinebling-edit", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        colidiu = true

        print("OEOEOE")

        if colidiu == true {
            playDoh()
            let drakeSadView = UIImageView(image: UIImage(named: "drake-sad"))

            drakeSadView.frame = CGRect(x: UIScreen.main.bounds.size.width/2 - 75, y: 500, width: 150, height: 200)
            view.addSubview(drakeSadView)
        }
    }
}

