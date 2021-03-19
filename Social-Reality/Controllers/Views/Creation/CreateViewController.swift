//
//  ViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import RealityKit
import PencilKit
import Vision

// MARK: Content Creation View Controller

class CreateViewController: UIViewController {
    
    @IBOutlet weak var arView: ARViewCreation!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var tutorialScrollView: UIScrollView!
    @IBOutlet weak var tutorialPageControl: UIPageControl!
    @IBOutlet weak var bottomContentView: UIView!
    @IBOutlet weak var bottomContentConstraint: NSLayoutConstraint!
    
    var bottomConstraintDefault: CGFloat = -92
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabBarItemTag.thirdViewController.rawValue
        
        tutorialScrollView.delegate = self
        view.sendSubviewToBack(arView)
        bottomContentConstraint.constant = 200
        backView.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        
        arView.setupView()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }

    
    @IBAction func tapBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
}

// MARK: Augmented Reality Functionality

extension CreateViewController {
 
    func initializeReality() {
        
        self.arView.startCoaching()
        
        let box = CustomBox(color: .red)
        
        arView.installGestures(.all, for: box) // Can change what gestures to use
        box.generateCollisionShapes(recursive: true)
        
        arView.scene.anchors.append(box)
        
        
        let mesh = MeshResource.generateText(
                    "RealityKit",
                    extrusionDepth: 0.1,
                    font: .systemFont(ofSize: 2),
                    containerFrame: .zero,
                    alignment: .left,
                    lineBreakMode: .byTruncatingTail)
                
                let material = SimpleMaterial(color: .white, isMetallic: false)
                let entity = ModelEntity(mesh: mesh, materials: [material])
                entity.scale = SIMD3<Float>(0.03, 0.03, 0.1)
                
                box.addChild(entity)
                
                entity.setPosition(SIMD3<Float>(0, 0.05, 0), relativeTo: box)
        
        
    }
    
    
    
}

// MARK: Tutorial Functionality

extension CreateViewController {
    
    @IBAction func tapGetStarted(_ sender: UIButton) {
        sender.pulsate()
        bottomContentConstraint.constant = bottomConstraintDefault
        UIView.animate(withDuration: 0.4) {
            self.backView.alpha = 0
            self.tutorialView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.initializeReality()
        }

    }
    
    @IBAction func changePager(_ sender: UIPageControl) {
        switch sender.currentPage {
        case 0:
            scrollToOffset(0)
        case 1:
            scrollToOffset(view.frame.width)
        case 3:
            scrollToOffset(view.frame.width * 2)
        default:
            scrollToOffset(0)
        }
    }
    
}

extension CreateViewController {
    
    @IBAction func bottomContentPanGesture(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else { return }
        
        
        if translation.y < 0 {
            if gestureView.frame.minY + translation.y >= view.frame.height * 0.2 {
                bottomContentConstraint.constant = bottomContentConstraint.constant + translation.y
            } else {
                bottomContentConstraint.constant = bottomContentConstraint.constant + ((view.frame.height * 0.2) - gestureView.frame.minY)
            }
        } else if translation.y > 0 {
            if bottomContentConstraint.constant + translation.y <= bottomConstraintDefault {
                bottomContentConstraint.constant = bottomContentConstraint.constant + translation.y
            } else {
                bottomContentConstraint.constant = bottomConstraintDefault
            }
        }
        
        guard gesture.state == .ended else {
            gesture.setTranslation(.zero, in: view)
            return
        }

        let velocity = gesture.velocity(in: view)
        
        if velocity.y > 100 {
            bottomContentConstraint.constant = bottomConstraintDefault
        } else if velocity.y < -100 {
            bottomContentConstraint.constant = bottomContentConstraint.constant + ((view.frame.height * 0.2) - gestureView.frame.minY)
        } else if gestureView.frame.minY < view.frame.height * 0.5 {
            bottomContentConstraint.constant = bottomContentConstraint.constant + ((view.frame.height * 0.2) - gestureView.frame.minY)
        } else {
            bottomContentConstraint.constant = bottomConstraintDefault
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        
        gesture.setTranslation(.zero, in: view)
        
    }
    
}

extension CreateViewController: UIScrollViewDelegate {
    
    func scrollToOffset(_ offset: CGFloat) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4) {
                self.tutorialScrollView.contentOffset.x = offset
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            tutorialPageControl.currentPage = 0
        } else if scrollView.contentOffset.x == view.frame.width {
            tutorialPageControl.currentPage = 1
        } else if scrollView.contentOffset.x == view.frame.width * 2 {
            tutorialPageControl.currentPage = 2
        }
    }
    
}
