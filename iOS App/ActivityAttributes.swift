
import Foundation
import ActivityKit

struct ActivityAttribute: ActivityAttributes, Codable, Hashable {
    /// Ваша пользовательская структура, которая описывает динамическое содержимое Live Activity.
    struct ContentStateAttribute: Codable, Hashable {
        var satellites: Int
    }
    /// Количество спутников является статическим контентом Live Activity.
    var satellites: Int
    /// Тип, описывающий динамическое содержимое Live Activity.
    public typealias ContentState = ContentStateAttribute
}
