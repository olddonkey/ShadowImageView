# ShadowImageView
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage) 
![CocoaPods Support](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg) 
![Swift Version](https://img.shields.io/badge/Swift-3.0-orange.svg) 
![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg) 

A apple music cover picture shadow style image library

ShadowImageView is a iOS 10 Apple Music style image view, help you create elegent image with shadow.

## Renderings

![ShadowOffsetRight](Screenshots/Rightoffset.png) ![Nooffset](Screenshots/NoOffset.png) ![largeRadius](Screenshots/largeRadius.png) ![lotus](Screenshots/lotus.png) ![Mountain](Screenshots/Mountain.png) ![CD1](Screenshots/CD1.png) ![CD2](Screenshots/CD2.png)


## Features

- [x] Auto resizing based on content mode.
- [x] Easy to change paramenters including offset, radius, alpha etc.
- [x] Storyboard(Nib) support.

## Usage

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `ShadowImageView` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'ShadowImageView'
```

#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/YourLibrary.framework` to an iOS project.

```
github "olddonkey/ShadowImageView"
```
#### Manually
1. Download and drop ```ShadowImageView.swift``` in your project.  
2. Congratulations!  

If you want to add by storyboard or nib, just drap a UIView into your canvas, and change the class to ShadowImageView, you will see the change in storyboard or nib, it is @IBDesignable supported.

## Requirements

- iOS 8.0+
- Swift 3+

The main development of ShadowImageView is based on Swift 3.

### Contact

Follow and contact me through [email](olddonkeyblog@gmail.com). If you find an issue, just [open a ticket](https://github.com/olddonkey/ShadowImageView/issues/new) on it. Pull requests are warmly welcome as well.

### License

ShadowImageView is released under the MIT license. See LICENSE for details.

### Kudos

Thanks to [PierrePerrin](https://github.com/PierrePerrin), his [PPMusicImageShadow](https://github.com/PierrePerrin/PPMusicImageShadow) inspires me, thought the implementation is diffrent, but the main idea comes from GaussianBlur.
