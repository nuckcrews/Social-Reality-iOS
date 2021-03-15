//
//  AppDelegate.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import Amplify
import AmplifyPlugins
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    public var env = Environment(id: "devs")
    public var userData = UserData()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey(GOOGLE_API_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        GIDSignIn.sharedInstance().clientID = GOOGLE_AUTH_ID
        
        
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels()) // UNCOMMENT this line once backend is deployed
        
        do {
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.add(plugin: apiPlugin) // UNCOMMENT this line once backend is deployed
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            // load data when user is signedin
//            self.checkUserSignedIn()
            
            // listen to auth events
            _ = Amplify.Hub.listen(to: .auth) { (payload) in
                
                switch payload.eventName {
                
                case HubPayload.EventName.Auth.signedIn:
                    self.updateSignIn(forSignInStatus: true)
                    
                case HubPayload.EventName.Auth.signedOut:
                    self.updateSignIn(forSignInStatus: false)
                    
                case HubPayload.EventName.Auth.sessionExpired:
                    self.updateSignIn(forSignInStatus: false)
                    
                default:
                    break
                }
            }
            
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
        
        return true
    }
    
    func updateSignIn(forSignInStatus : Bool) {
        self.userData.isSignedIn = forSignInStatus
    }
    
    func checkUserSignedIn() {
        _ = Amplify.Auth.fetchAuthSession { (result) in
            do {
                let session = try result.get()
                self.updateSignIn(forSignInStatus: session.isSignedIn)
            } catch {
                print("Fetch auth session failed with error - \(error)")
            }
            
        }
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    
}

