//
//  AppDelegate.swift
//  banubaBridge
//
//  Created by Mayank Verma on 26/09/23.
//

import Foundation
import UIKit
import React

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // Specify name of your project module
  private let moduleName = "banubaBridge"
  private let rootPath = "index"
  
  static let licenseToken =   "TMdbt1gDGcXFRD4STgk6qDRKfl6KoEI4M7W1GH3HmBnIrkvZ5UFkfyXBArfdDPJ+ruILLhDjOrIbQji4RQLoFqZ6zIvTZOOVAcdrM/qGgzdNiv1jLHq12mexlUOOm7mxDBeuccYFsN5AggiYDzhEQAD42AxMTvFOvMP+3tmO8h9yOzUbFjK4AlOFL0jWE703NrxoOfEs6tHcfo7q3XvOMVZ6cFD8E7rsWUKBmXDS90jsSKo6i42uapUBtoxZp2Pp2Hs/r+Id2/7WwqUx4N3+g75l5B1UwBsQv73urcNXlx4AeW+3p5opSq9L4TGg0+ZrRBvzffK5uUkZyaDTNmyca7Bxn4Xq9RAcNUtdijPckDB9Z1kGxCTsnEtYif1xEk0tEfAfowi5yzbo7N2XajwXILQu8/PoWpTnRxZ4o59cfcl41AUOhwmc0o7Tek5pHZ/RK0LO4rdBK9vtONV+2gcoxYn3skld5smlyGtEI+M88Eq55ldrV3XreiUyyuUMtVMXCHYJAYd371r/WqrZ3zrEJuHFXR9pLUVBPpdJ"

  
  var window: UIWindow?
  
  var bridge: RCTBridge!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let jsCodeLocation: URL = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: rootPath)
    
    let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: moduleName, initialProperties: nil, launchOptions: launchOptions)
    let rootViewController = UIViewController()
    
    rootViewController.view = rootView
    
    print("rootView==",rootView.bridge)
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.bridge = rootView.bridge
    self.window?.rootViewController = rootViewController
    self.window?.makeKeyAndVisible()
    return true
  }
}
