//
//  AppDelegate.swift
//  PDFReader
//
//  Created by Dave on 4/19/21.
//

import UIKit
import PSPDFKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { 
        // PSPDFKit License Key
        PSPDFKit.SDK.setLicenseKey("0JYgOi9YuHoSVMFwjxV4WJOrGpcnPlkv7SkBySWBOUz2Js40bSfdo+SSBDU4IOoku4F5SQlwaHqu0bZSvGWklTL5cflB4zASkE+KCBAD7zr9XPA+8XIdWjxm3xEfPIFJA2dzSNizMAK9Z7ji9ODGjIUYJSFu7SDbbXzrY2MR/XvTFimxbxuIwX2zanFNMWkvWx3iIZfCC5H4z7IzevR7oyHS7gk7To16qJP++EcME1QqNwbybYw+YK5Ek5RoY+Fdm1dO/NxM3xOmpzH/BPngxBFJawT2ndxAffmW5FmaHksp1Vot9zhU9O6yVWj/lbwpx6HmIiTb3qjsbYE9Bpryr2dM5lHv+vbmybdNfbP3F38m+FzJTj/ry06jhdRlP3wCNs/Tcs6jQBEE0Eez8dZ/t+ke4BhhTE8gBEKvO/tzrlPuI9QqdZZdxA4zGORT5p2i4mdfVZzH5soZFC+MM5q2yQ==")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

