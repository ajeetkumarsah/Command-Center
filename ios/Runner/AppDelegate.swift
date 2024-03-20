import UIKit
import Flutter
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
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
}
