//
//  MainViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import RealityKit
import CoreLocation
import ARKit
import Firebase

// MARK: - Main View Controller -> Tab 1

class MainViewController: UIViewController {

    @IBOutlet weak var arView: ARView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var creatorAvatarImage: UIImageView!
    @IBOutlet weak var creationTitleLabel: UILabel!
    @IBOutlet weak var creationDescriptionLabel: UILabel!
    @IBOutlet weak var creationTechniqueLabel: UILabel!
    @IBOutlet weak var creationTimeLabel: UILabel!
    
    private var readyForReality = true
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    var creation: CreationModel?
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> MainViewController? {

        guard let viewController = Storyboard.MainViewController.instantiate(MainViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabBarItemTag.firstViewController.rawValue
        
        CoverToMainDelegate = self
        
        if Auth0.loggedIn {
            setupLocationManager()
        }
        
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        
        getCreation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        
//        if readyForReality {
//            setupARView()
//        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if readyForReality {
//            pauseARView()
        }
    }
    
    func getCreation() {
        
        creation = Testing.defaultCreation
        
        guard let creation = creation else { return }
        
        creatorAvatarImage.setImageFromURL(creation.userImage ?? "")
        creationTitleLabel.text = creation.title
        creationDescriptionLabel.text = creation.description
        let date = creation.date?.rawDate
        creationTimeLabel.text = date?.currentDistance(to: Date())
        
        
    }
    
    // MARK: Setup Methods
    
    func setupARView() {
        arView.session.delegate = self
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    
    func pauseARView() {
        arView.session.pause()
    }
    
    // MARK: Object Placement
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = results.first {
            let anchor = ARAnchor(name: "toy_robot_vintage", transform: firstResult.worldTransform)
            arView.session.add(anchor: anchor)
        } else {
            print("No surface found")
        }
    }
    
    func placeObject(named entityName: String, for anchor: ARAnchor) {
        do {
            let entity = try ModelEntity.loadModel(named: entityName)
            
            entity.generateCollisionShapes(recursive: true)
            arView.installGestures([.rotation, .translation], for: entity)

            let anchorEntity = AnchorEntity(anchor: anchor)
            anchorEntity.addChild(entity)
            arView.scene.addAnchor(anchorEntity)
            
        } catch {
            print("No entity")
        }
    }
    
    
    // MARK: Creation Interaction
    
    @IBAction func tapLike(_ sender: UIButton) {
        sender.jump()
        Buzz.light()
        
        if sender.tintColor == .primary {
            sender.tintColor = .white
            sender.backgroundColor = UIColor(white: 0, alpha: 0.10)
        } else {
            sender.tintColor = .primary
            sender.backgroundColor = .background
        }
        
    }
    
    @IBAction func tapComment(_ sender: UIButton) {
        sender.jump()
        Buzz.light()
        MainToCoverDelegate?.tappedComments(creation: creation)
    }
    
    @IBAction func tapShare(_ sender: UIButton) {
        sender.jump()
        Buzz.light()
        
        MainToCoverDelegate?.tappedSendCreation(creation: creation)
        
    }
    
}

extension MainViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "toy_robot_vintage" {
                placeObject(named: anchorName, for: anchor)
            }
        }
    }
}
extension MainViewController: CoverToMainProtocolDelegate {
    func readyForSession() {
        readyForReality = true
        //setupARView()
    }
}

extension MainViewController {
    
    
    
}

extension MainViewController: CLLocationManagerDelegate {
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied, .notDetermined:
            
            break
        case .authorizedWhenInUse, .authorizedAlways:
            
            break
        @unknown default:
            print("Unknown Authorization Case")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] places, err in
            if let err = err {
                print(err)
            } else {
                if let city = places?.first?.locality,
                   let state = places?.first?.administrativeArea {
                    DispatchQueue.main.async {
                        self?.welcomeLabel.text = "\(city), \(state)"
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.welcomeLabel.text = "Welcome"
                    }
                }
                

                
            }
        }
        
    }
    
}
