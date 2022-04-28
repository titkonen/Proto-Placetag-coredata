import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  private let coreDataStack = CoreDataStack.shared

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let context = coreDataStack.context
    let contentView = PlacesListView()
      .environment(\.managedObjectContext, context)

    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }

  func sceneWillResignActive(_ scene: UIScene) {
    coreDataStack.saveContext()
  }
}
