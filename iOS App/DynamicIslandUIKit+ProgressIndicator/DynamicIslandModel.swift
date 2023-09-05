//
//  DynamicIslandModel.swift
//  iOS App
//
//  Created by Иван Марин on 30.08.2023.
//
import UIKit

/// Модель для управления динамическим островом.
class DynamicIslandModel {
    // MARK: - Properties
    
    private weak var parentView: UIView?
    private var customDynamicIslandView: UIView?
    private var capsuleView: CustomSatelliteCapsuleView?
    private var isProgressIndicatorShown = false
    private var currentNumber: Int = 0
    
    // MARK: - Initialization
    
    /// Инициализирует модель динамического острова.
    ///
    /// - Parameter parentView: Родительское представление, к которому будет добавляться динамический остров.
    init(parentView: UIView) {
            self.parentView = parentView
            
            subscribeToNotifications()
        }
    
    deinit {
        debugPrint("DynamicIslandModel deinit")
        unsubscribeFromNotifications()
    }
    
    // MARK: - Public Methods
    
    /// Обновляет число спутников и визуальное отображение на динамическом острове.
    ///
    /// - Parameter newNumber: Новое число спутников для отображения.
    func updateNumber(_ newNumber: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Обновляем текущее число
            self.currentNumber = newNumber
            self.updateSatelliteCount(newNumber)
            
            // Показываем индикатор только если был обновлено число
            if newNumber != self.currentNumber {
                self.showProgressIndicatorForTwoCirclesAndThenCreateView()
            }
            
            // Создаем вью
            self.createCustomDynamicView()
        }
    }
    /// Обновляет текущее число спутников и вызывает метод обновления отображения спутников.
    ///
    /// - Parameter newNumber: Новое число спутников для отображения.
    func updateCurrentNumber(_ newNumber: Int) {
        currentNumber = newNumber
        updateSatelliteCount(currentNumber)
    }
    
    // MARK: - Private Methods
    
    /// Обновляет отображение числа спутников на капсуле.
    ///
    /// - Parameter newCount: Новое число спутников для отображения.
    private func updateSatelliteCount(_ newCount: Int) {
        capsuleView?.updateSatelliteCount(newCount)
    }
    
    /// Подписывается на уведомления о состоянии приложения и изменении числа спутников.
    private func subscribeToNotifications() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(currentNumberDidChange), name: Notifications.currentNumberUpdated, object: nil)
    }
    
    /// Отписывается от всех уведомлений.
    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Обработчик изменения текущего числа спутников по уведомлению.
    ///
    /// - Parameter notification: Уведомление о изменении числа спутников.
    @objc private func currentNumberDidChange(_ notification: Notification) {
        if let newCount = notification.object as? Int {
            updateSatelliteCount(newCount)
        }
    }
    
    /// Создает и добавляет динамический остров на родительское представление.
    private func createDynamicIslandView() {
        let margin: CGFloat = 6
        let widthIncrease: CGFloat = 12
        let value: CGFloat = 20
        
        customDynamicIslandView = UIView()
        let origin = DynamicIsland.origin
        let size = DynamicIsland.size
        let newHeight = size.height + 45
        customDynamicIslandView?.frame = CGRect(x: origin.x - margin, y: origin.y, width: size.width + widthIncrease, height: newHeight)
        customDynamicIslandView?.layer.cornerRadius = value
        customDynamicIslandView?.backgroundColor = .black
        
        DispatchQueue.main.async { [weak self] in
            self?.parentView?.addSubview(self?.customDynamicIslandView ?? UIView())
        }
    }
    
    /// Обработчик уведомления о переходе в неактивное состояние.
    @objc private func appWillResignActive() {
        customDynamicIslandView?.removeFromSuperview()
    }
    
    /// Обработчик уведомления о входе приложения в foreground.
    @objc private func appDidBecomeActive() {
        
        
        customDynamicIslandView?.removeFromSuperview()
        
        showProgressIndicatorForTwoCirclesAndThenCreateView()
        
    }
    
    /// Создает и добавляет кастомное представление динамического острова.
    private func createCustomDynamicView() {
        customDynamicIslandView?.removeFromSuperview()
        
        if DynamicIsland.isAvailable {
            createDynamicIslandView()
            addSatelliteCapsuleToDynamicIsland()
        }
    }
    
    /// Добавляет капсулу спутников к динамическому острову.
    private func addSatelliteCapsuleToDynamicIsland() {
        guard let dynamicIslandView = customDynamicIslandView else { return }
        
        let dynamicIslandWidth = dynamicIslandView.frame.width
        let capsuleFrameWidth = dynamicIslandWidth - 20 // Adjusted width
        
        let capsuleHeight = capsuleFrameWidth / 4
        let capsuleY = dynamicIslandView.frame.height - capsuleHeight - 10 // attached to the bottom with 10-pixel insets
        
        capsuleView = CustomSatelliteCapsuleView(frame: CGRect(x: 10, y: capsuleY, width: capsuleFrameWidth, height: capsuleHeight), satellites: currentNumber)
        
        if let capsuleView = capsuleView {
            dynamicIslandView.addSubview(capsuleView)
        }
    }
    
    /// Показывает индикатор прогресса для двух кругов и затем создает представление.
    private func showProgressIndicatorForTwoCirclesAndThenCreateView() {
        print("showProgressIndicatorForTwoCirclesAndThenCreateView called, currentNumber: \(currentNumber)")
        
        guard currentNumber > 0, !isProgressIndicatorShown else {
            print("No need to show progress indicator.")
            self.isProgressIndicatorShown = false
            return
        }
        
        isProgressIndicatorShown = true
        var progressIndicator = DynamicIsland.ProgressIndicator()
        progressIndicator.isProgressIndeterminate = true
        progressIndicator.showIndeterminateProgressAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            progressIndicator.hideProgressIndicator()
            self?.isProgressIndicatorShown = false
            
            print("Creating custom dynamic view after hiding the indicator")
            self?.createCustomDynamicView()
        }
    }
}

struct Notifications {
    static let currentNumberUpdated = Notification.Name("com.example.currentNumberUpdated")
}
