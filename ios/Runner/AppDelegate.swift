import UIKit
import Flutter
<<<<<<< HEAD
=======
import FirebaseCore
>>>>>>> af76110fefd5820a6609b078dabbb5fc0f9c76ca

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
<<<<<<< HEAD
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
=======
    
  ) -> Bool {
      FirebaseApp.configure()
       if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

   // <Add>
    override func applicationWillResignActive(
      _ application: UIApplication
    ) {
      window?.rootViewController?.view.endEditing(true)
      self.window.isHidden = true;
    }
    override func applicationDidBecomeActive(
      _ application: UIApplication
    ) {
      self.window.isHidden = false;
    }
>>>>>>> af76110fefd5820a6609b078dabbb5fc0f9c76ca
}
