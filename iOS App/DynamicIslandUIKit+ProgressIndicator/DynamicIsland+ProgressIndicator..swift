//
//  DynamicIsland+ProgressIndicator..swift
//  iOS App
//
//  Created by Иван Марин on 29.08.2023.
//

import UIKit

extension DynamicIsland {
    public struct ProgressIndicator {
        private let progressIndicatorImpl: DynamicIslandProgressIndicatorImplementation
        
        init () {
            progressIndicatorImpl = .init()
            progressIndicatorImpl.add(toContext: window)
        }
        
        /// Окно, к которому прикреплен индикатор прогресса.
        /// По умолчанию он добавляется к главному окну (или первому окну
        /// первой сцены), но вы можете изменить это, присвоив другое окно
        /// этому свойству.
        public var window: UIWindow = Self.getMainWindow() {
            didSet {
                progressIndicatorImpl.changeContext(to: window)
            }
        }
        
        /// Текущий прогресс индикатора, от 0 до 100.
        /// - Примечание: Для этого требуется установить `isProgressIndeterminate` в значение `false`.
        public var progress: Double {
            get { progressIndicatorImpl.progress }
            set { progressIndicatorImpl.progress = newValue }
        }
        
        /// Цвет индикатора прогресса. Значение по умолчанию - `UIColor.red`.
        public var progressColor: UIColor {
            get { progressIndicatorImpl.progressColor }
            set { progressIndicatorImpl.progressColor = newValue }
        }
        
        /// Определяет, должен ли индикатор прогресса отображать неопределенный прогресс
        /// (это полезно, когда вы не знаете, сколько времени потребуется). Значение по умолчанию - `true`.
        public var isProgressIndeterminate: Bool {
            get { progressIndicatorImpl.isProgressIndeterminate }
            set { progressIndicatorImpl.isProgressIndeterminate = newValue }
        }
        
        /// Отображает анимацию индикатора неопределенного прогресса на динамическом острове.
        /// - Примечание: Для этого требуется установить `isProgressIndeterminate` в значение `true`.
        public func showIndeterminateProgressAnimation() {
            progressIndicatorImpl.showIndeterminateProgressAnimation()
        }
        
        /// Скрывает индикатор прогресса на динамическом острове.
        public func hideProgressIndicator() {
            progressIndicatorImpl.hideProgressIndicator()
        }
        
        private static func getMainWindow() -> UIWindow {
            lazy var keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }!
            
            if #available(iOS 13.0, *) {
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                return windowScene?.windows.first ?? keyWindow
            }
            
            return keyWindow
        }
    }
}
