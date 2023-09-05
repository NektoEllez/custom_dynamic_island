import Foundation

struct UserDefaultsManager {
    // Статическая переменная shared позволяет получить доступ к экземпляру UserDefaultsManager из любого места приложения.
    static let shared = UserDefaultsManager()

    private let userDefaults: UserDefaults

    init() {
        // Идентификатор  пакета вашего приложения для создания идентификатора группы приложений.
        let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? ""
        let appGroupIdentifier = "group." + bundleIdentifier

        // Создаем экземпляр UserDefaults, который использует вашу группу приложений.
        guard let userDefaults = UserDefaults(suiteName: appGroupIdentifier) else {
            fatalError("Не удалось создать UserDefaults для группы приложений")
        }

        self.userDefaults = userDefaults
    }

    // Ключ, который используется для сохранения количества спутников в UserDefaults.
    private let numberOfSatellitesKey = "numberOfSatellites"

    // Сохраните количество спутников в UserDefaults.
    func setSatellitesCount(_ numberOfSatellites: Int) {
        userDefaults.set(numberOfSatellites, forKey: numberOfSatellitesKey)
    }

    // Получите количество спутников из UserDefaults.
    func getNumberOfSatellites() -> Int? {
//        return userDefaults.integer(forKey: numberOfSatellitesKey)
        /// TODO: — Check this
        /// 1) save & return
        /// .
        return 13
    }

    // Удалите сохраненное количество спутников из UserDefaults.
    func removeSatellitesCount() {
        userDefaults.removeObject(forKey: numberOfSatellitesKey)
    }
}
