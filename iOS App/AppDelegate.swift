import UIKit
import WidgetKit

@available(iOS 16.2, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationDidEnterBackground(_ application: UIApplication) async {
        // Вызываем фоновое обновление, когда приложение переходит в фоновый режим
//        await LiveActivityManager.updateActivity(satellites: 0 )
    }
}
