//
//  AppDelegate.swift
//  PopupUpdate
//
//  Created by nadezhdanikolova on 11/14/2019.
//  Copyright (c) 2019 Upnetix. All rights reserved.
//

import UIKit
import PopupUpdate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// Setup Initial View Controller
        window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialViewController")

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()

        /// Force update example with only required properties
            PUUpdateApplicationManager.shared.checkForUpdate(shouldForceUpdate: true,
                                                                minimumVersionNeeded: "1.2.3",
                                                                urlToOpen: "https://www.upnetix.com/")
        
        /// Normal update with all parameters
//        PUUpdateApplicationManager.shared.checkForUpdate(shouldForceUpdate: false,
//                                                            minimumVersionNeeded: "2.0.1",
//                                                            urlToOpen: "https://www.upnetix.com/",
//                                                            currentVersion: "1.0.1",
//                                                            keyWindow: window,
//                                                            alertTitle: "AlertTitle",
//                                                            alertDescription: "AlertDescription",
//                                                            updateButtonTitle: "UpdateButton",
//                                                            okButtonTitle: "Ok") { error in
//                                                                if let error = error {
//                                                                    print("Error Supported version: \(error)")
//                                                                }
//        }
        
        return true
    }

}
