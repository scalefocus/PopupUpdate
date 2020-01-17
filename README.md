# PopupUpdate

[![CI Status](https://img.shields.io/travis/nadezhdanikolova/PopupUpdate.svg?style=flat)](https://github.com/scalefocus/PopupUpdate)
[![Version](https://img.shields.io/cocoapods/v/PopupUpdate.svg?style=flat)](https://cocoapods.org/pods/PopupUpdate)
[![License](https://img.shields.io/cocoapods/l/PopupUpdate.svg?style=flat)](https://cocoapods.org/pods/PopupUpdate)
[![Platform](https://img.shields.io/cocoapods/p/PopupUpdate.svg?style=flat)](https://cocoapods.org/pods/PopupUpdate)

PopupUpdate is a library that provides us an easy way to show a popup for a new available version for the current application. PopupUpdate purpose is to make the user to update the application. It shows a popup, which is configurable. You can choose to have a normal popup, which reminds the user that a new version is available and the user can ignore it, or you can choose "force update", which forces the user to update the application.

Supports Light Mode:

<img src="https://user-images.githubusercontent.com/53303123/68941792-80374b00-07af-11ea-946e-675fd6c02bcf.png" alt="drawing" width="250"/>

<img src="https://user-images.githubusercontent.com/53303123/68941809-8b8a7680-07af-11ea-824a-d8f4b8d1ce62.png" alt="drawing" width="250"/>

<br>

And Dark Mode:

<img src="https://user-images.githubusercontent.com/53303123/68943411-d0181100-07b3-11ea-8f09-e83ac60a43f3.png" alt="drawing" width="250"/>

<img src="https://user-images.githubusercontent.com/53303123/68943378-b8d92380-07b3-11ea-92e2-f9902b13a9b8.png" alt="drawing" width="250"/>


## Usage

First you should import the library:
```Swift
import PopupUpdate
```

Force update:
```Swift
 /// Force update example
PUUpdateApplicationManager.shared.checkForUpdate(shouldForceUpdate: true,
                                                    minimumVersionNeeded: "1.2.3",
                                                    urlToOpen: "https://www.upnetix.com/") { error in
    if let error = error {
        print("Error Supported version: \(error)")
    }
}
```

Normal update:
```Swift
 /// Normal nofity update example
PUUpdateApplicationManager.shared.checkForUpdate(shouldForceUpdate: false,
                                                    minimumVersionNeeded: "1.2.3",
                                                    urlToOpen: "https://www.upnetix.com/")
```

Update with all parameters:

```Swift
PUUpdateApplicationManager.shared.checkForUpdate(shouldForceUpdate: false,
                                                    minimumVersionNeeded: "2.0.1",
                                                    urlToOpen: "https://www.upnetix.com/",
                                                    currentVersion: "1.0.1",
                                                    keyWindow: window,
                                                    alertTitle: "AlertTitle",
                                                    alertDescription: "AlertDescription",
                                                    updateButtonTitle: "UpdateButton",
                                                    okButtonTitle: "Ok") { error in
    if let error = error {
        print("Error Supported version: \(error)")
    }
}
```


## Example

Try it out. You can download and run the example project, clone the repo, and run `pod install`.

## Installation

PopupUpdate is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PopupUpdate'
```

and don't forget to install the pod by running the following command in the terminal from the directory of your project:

```
pod install
```

## Author

Upnetix, code@upnetix.com

## License

PopupUpdate is available under the MIT license. See the LICENSE file for more info.
