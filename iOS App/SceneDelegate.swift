import UIKit
import WidgetKit

@available(iOS 16.2, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var timer: Timer?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
       
        // Запускается активность, когда представление контроллера появляется на экране
        guard let count =  ViewController.count else {
            debugPrint("Count of sattelite is a NIL"); return
        }
        guard count != 0 else { debugPrint("Count of sattelite is a 0"); return }
        // Запускается активность, когда представление контроллера появляется на экране
        Task.init {
            await LiveActivityManager.startActivity(satellites: count)
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        Task.init {
            await LiveActivityManager.endActivity(satellites: 0)
        }
    }
}
