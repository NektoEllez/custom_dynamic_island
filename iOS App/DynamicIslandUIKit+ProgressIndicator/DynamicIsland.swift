//
//  DynamicIsland.swift
//  iOS App
//
//  Created by Иван Марин on 29.08.2023.
//

import UIKit
import SwiftUI

/// Тип, который предоставляет информацию о Dynamic Island, а также функциональность, такую как индикатор прогресса.
/// - Примечание: Предоставленная информация (например, размер) относится к статическому острову, а не к расширенному (например, когда запущена живая активность).
public enum DynamicIsland {
    
    /// Объект, который предоставляет индикатор прогресса, показывающий прогресс вокруг выреза Dynamic Island.
      public static let progressIndicator: ProgressIndicator = {
        precondition(DynamicIsland.isAvailable,
                     "Невозможно показать индикатор прогресса на динамическом острове на устройстве, которое его не поддерживает!")
        return .init()
      }()
    
    /// Размер выреза Dynamic Island.
    public static let size: CGSize = {
        return .init(width: 126.0, height: 37.33)
    }()
    
    /// Начальная позиция выреза Dynamic Island.
    public static let origin: CGPoint = {
        return .init(x: UIScreen.main.bounds.midX - size.width / 2, y: 11)
    }()
    
    /// Прямоугольник с размером и позицией выреза Dynamic Island.
    public static let rect: CGRect = {
        return .init(origin: origin, size: size)
    }()
    
    /// Радиус закругления углов выреза Dynamic Island.
    public static let cornerRadius: Double = {
        return size.width / 2
    }()
    
    /// Возвращает, поддерживает ли это устройство Dynamic Island.
    /// Возвращает `true` для iPhone 14 Pro и iPhone Pro Max, в противном случае возвращает `false`.
    public static let isAvailable: Bool = {
        if #unavailable(iOS 16.2) {
            return false
        }
        
#if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
#else
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
#endif
        
        return identifier == "iPhone15,2" || identifier == "iPhone15,3"
    }()
}
