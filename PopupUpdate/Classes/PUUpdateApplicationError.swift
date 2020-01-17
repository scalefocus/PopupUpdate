//
//  PUUpdateApplicationError.swift
//  Upnetix
//
//  Created by Nadezhda on 15.11.19.
//  Copyright © 2019 Upnetix. All rights reserved.
//

/// Enum that is used to describe the errors that may occur while using PUUpdateApplicationManager
public enum PUUpdateApplicationError: LocalizedError {
    
    case noUpdateNeeded
    case invalidURL
    case applicationNameNotFound
    case versionNotFound
    case couldNotOpenURL
    
    public var localizedDescription: String {
        switch self {
        case .noUpdateNeeded:
            return "\(Constants.prefix): \(Constants.noUpdateNeeded)"
        case .invalidURL:
            return "\(Constants.prefix): \(Constants.invalidURL)"
        case .applicationNameNotFound:
            return "\(Constants.prefix): \(Constants.applicationNameNotFound)"
        case .versionNotFound:
            return "\(Constants.prefix): \(Constants.versionNotFound)"
        case .couldNotOpenURL:
            return "\(Constants.prefix): \(Constants.couldNotOpenURL)"
        }
    }
    
    private struct Constants {
        static let prefix = "PUUpdateApplicationError"
        static let noUpdateNeeded = "Current version does not need an update."
        static let invalidURL = "Invalid url passed as an argument."
        static let applicationNameNotFound = "Application name not found."
        static let versionNotFound = "Version number not found."
        static let couldNotOpenURL = "Passed URL could not be opened."
    }
    
}
