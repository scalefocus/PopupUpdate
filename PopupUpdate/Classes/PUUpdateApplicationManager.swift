//
//  PUUpdateApplicationManager.swift
//  Upnetix
//
//  Created by Nadezhda on 14.11.19.
//  Copyright © 2019 Upnetix. All rights reserved.
//

import UIKit

/// Protocol for handling application update
public protocol UpdateApplicationManager {
    
    typealias PUUrlOpened = ((PUUpdateApplicationError?) -> Void)?
    
    /// Function that notify for a new update.
    /// You can call this function from everywhere but
    /// It is recommended to call it in:
    /// AppDelegate applicationDidBecomeActive function for force update and
    /// AppDelegate didFinishLaunchingWithOptions function for normal update
    /// Note that it is your responsibility to handle where and when to call this function.
    ///
    /// - Parameter shouldForceUpdate: bool that indicates if we need a force update alert
    /// - Parameter minimumVersionNeeded: minimum required version
    /// - Parameter urlToOpen: url that should be opened when we click the button "Update"
    /// - Parameter currentVersion: current version. If parameter is not passed we try to take "CFBundleShortVersionString"
    /// - Parameter keyWindow: window to present the alert. By default we use a new instance of type UIWindow
    /// - Parameter alertTitle: alert title - default value is "Update Available"
    /// - Parameter alertDescription: alert description
    /// - Parameter updateButtonTitle: button title for update - default value is "Update"
    /// - Parameter okButtonTitle: button title for the second button when we don't have force update
    /// - Parameter urlOpenedClosure: closure that returns an error with localized description if validation for the properties fails
    func checkForUpdate(shouldForceUpdate: Bool,
                        minimumVersionNeeded: String,
                        urlToOpen: String,
                        currentVersion: String?,
                        window: UIWindow?,
                        alertTitle: String,
                        alertDescription: String,
                        updateButtonTitle: String,
                        okButtonTitle: String,
                        urlOpenedClosure: PUUrlOpened)
}

public class PUUpdateApplicationManager: UpdateApplicationManager {
    
    /// Singleton instance
    public static let shared = PUUpdateApplicationManager()
    
    /// Default description text format for the force update alert.
    private let defaultAlertDescriptionFormat = "A new version of %@ is available. Please update now."
    
    // window instance, which we use when no window is provided
    private lazy var updateAlertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.backgroundColor = .clear
        window.rootViewController?.view.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                window.windowScene = currentWindowScene
            }
        }
        return window
    }()
    
    private init() { }
    
    public func checkForUpdate(shouldForceUpdate: Bool,
                               minimumVersionNeeded: String,
                               urlToOpen: String,
                               currentVersion: String? = nil,
                               window: UIWindow? = nil,
                               alertTitle: String = "Update Available",
                               alertDescription: String = "",
                               updateButtonTitle: String = "Update",
                               okButtonTitle: String = "Not now",
                               urlOpenedClosure: PUUrlOpened = nil) {
        
        /// Check if we have a value for version
        guard let appVersion = currentVersion ?? (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) else {
            urlOpenedClosure?(PUUpdateApplicationError.versionNotFound)
            return
        }
        
        /// Check if currentVersion or minimum version is empty
        guard !appVersion.isEmpty || !minimumVersionNeeded.isEmpty else {
            urlOpenedClosure?(PUUpdateApplicationError.versionNotFound)
            return
        }
        
        /// Check if the force update is needed
        guard minimumVersionNeeded.compare(appVersion, options: .numeric) == .orderedDescending else {
            urlOpenedClosure?(PUUpdateApplicationError.noUpdateNeeded)
            return
        }
        
        /// Check if passed URL is valid
        guard let url = URL(string: urlToOpen) else {
            urlOpenedClosure?(PUUpdateApplicationError.invalidURL)
            return
        }
        
        /// Check if we have a value for appName
        guard let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String else {
            urlOpenedClosure?(PUUpdateApplicationError.applicationNameNotFound)
            return
        }
        
        /// If the description is empty we can use the default text for it.
        var description = alertDescription
        if description.isEmpty {
            description = String(format: defaultAlertDescriptionFormat, appName)
        }
        
        /// Setup window value if needed
        let alertWindow = window ?? updateAlertWindow
        
        /// Present alert
        showPopup(shouldForceUpdate: shouldForceUpdate,
                  alertTitle: alertTitle,
                  alertDescription: description,
                  updateButtonTitle: updateButtonTitle,
                  okButtonTitle: okButtonTitle,
                  urlToOpen: url,
                  keyWindow: alertWindow,
                  executeAction: { error in urlOpenedClosure?(error) })
    }
    
    /// Function that shows the popup for update.
    ///
    /// - Parameter shouldForceUpdate: boolean that indicates if we need force update
    /// - Parameter alertTitle: alert title
    /// - Parameter alertDescription: alert description
    /// - Parameter urlToOpen: url to open when the button is clicked
    /// - Parameter executeAction: closure that notifies that the button is clicked
    /// - Parameter updateButtonTitle: update button title
    /// - Parameter okButtonTitle: ok button title
    /// - Parameter keyWindow: window to present the alert
    private func showPopup(shouldForceUpdate: Bool,
                           alertTitle: String,
                           alertDescription: String,
                           updateButtonTitle: String,
                           okButtonTitle: String,
                           urlToOpen: URL,
                           keyWindow: UIWindow?,
                           executeAction: @escaping ((PUUpdateApplicationError?) -> Void?) ) {
        
        /// Init alert controller
        let alert = UIAlertController(title: alertTitle,
                                      message: alertDescription,
                                      preferredStyle: .alert)
        
        /// Adding "Update" button
        let action = UIAlertAction(title: updateButtonTitle, style: .default) { _ in
            UIApplication.shared.open(urlToOpen, options: [:]) { isOpened in
                executeAction(isOpened ? nil : PUUpdateApplicationError.couldNotOpenURL)
            }
        }
        alert.addAction(action)
        
        /// Check if we have a force update
        if !shouldForceUpdate {
            /// Adding "Not now" button which dismiss the alert on click
            let action = UIAlertAction(title: okButtonTitle, style: .default) { [weak self] _ in
                guard let strongSelf = self else { return }
                alert.dismiss(animated: true, completion: nil)
                strongSelf.updateAlertWindow.isHidden = true
                executeAction(nil)
            }
            alert.addAction(action)
        }
        
        keyWindow?.isHidden = false
        /// Present alert
        keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
