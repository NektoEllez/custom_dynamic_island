//  ActivityManager.swift
//  My_App_DYnamic_Test
//
//  Created by Иван Марин on 23.08.2023.
//
import Foundation
import ActivityKit
import WidgetKit

@available(iOS 16.2, *)
@available(iOSApplicationExtension 16.2, *)
class LiveActivityManager {
    // Хранит текущую активность
    static var currentActivity: Activity<ActivityAttribute>?
    static var oneMinute = Date().addingTimeInterval(60) // 1 минут и значение устареет в будущем
    
    /// Создает новый экземпляр `ActivityAttributes` и запрашивает у системы запуск Live Activity.
    static func startActivity(satellites: Int) async {
        
        let attributes = ActivityAttribute(satellites: satellites)
        let dynamicContent = ActivityContent(state: ActivityAttribute.ContentStateAttribute(satellites: satellites), staleDate: oneMinute)
        do {
            
            currentActivity = try Activity<ActivityAttribute>.request(attributes: attributes, content: dynamicContent)
            debugPrint("start activity: \(satellites)")
        } catch {
            debugPrint("Failed to start activity: \(error)")
        }
    }
    
    
    /// Обновляет текущую активность с новым количеством спутников.
    static func updateActivity(satellites: Int) async {
        guard let activity = currentActivity else {
            debugPrint("No current activity to update")
            return
        }
        
        // Динамически обновляем staleDate для актуальности содержимого
        
        let updatedContentState = ActivityAttribute.ContentStateAttribute(satellites: satellites)
        let updatedContent = ActivityContent(state: updatedContentState, staleDate: .now)
        
        await activity.update(updatedContent)
        debugPrint("update activity: \(satellites)")
    }
    
    /// Завершает текущую активность.
    static func endActivity(satellites: Int) async {
        guard let activity = currentActivity else {
            debugPrint("No current activity to end")
            return
        }
        // Завершаем активность с передачей последнего контента
        // Последнее обновление перед завершением активности
        Task.init {
            let lastContentState = ActivityAttribute.ContentStateAttribute(satellites: satellites)
            let lastContent = ActivityContent(state: lastContentState, staleDate: .now)
            await activity.end(lastContent, dismissalPolicy: .immediate)
            // Удаляем ссылку на завершенную активность
            currentActivity = nil
        }
    }
}
