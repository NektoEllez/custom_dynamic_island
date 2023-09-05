//
//  ViewController.swift
//  My_App_DYnamic_Test
//
//  Created by Иван Марин on 23.08.2023.
//

import UIKit
import ActivityKit


@available(iOS 16.2, *)
class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var newNumberButton: UIButton!
    private var dynamicIslandModel: DynamicIslandModel?
    
    private var currentNumber: Int = 0 {
        didSet {
            
            self.numberLabel.text = "Count — \(self.currentNumber)"
            
            ViewController.count = self.currentNumber
            Task.init {
                await LiveActivityManager.updateActivity(satellites: self.currentNumber)
            }
            
        }
    }
    
    static var count: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentNumber = 0
        newNumberButton.layer.cornerRadius = 10
        // Инициализируем экземпляр DynamicIslandModel и передаем ему родительское представление
        dynamicIslandModel = DynamicIslandModel(parentView: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if currentNumber > 0 {
            // Начните активность, когда представление контроллера появляется на экране
            Task.init {
                await LiveActivityManager.startActivity(satellites: currentNumber)
            }
        }
    }
    
    
    @IBAction func changeNumberTapped(_ sender: UIButton) {
        NumberGenerator.shared.generateRandomNumber()
        currentNumber = NumberGenerator.shared.getCurrentNumber()
        dynamicIslandModel?.updateNumber(currentNumber)
    }
}

import Foundation

class NumberGenerator {
    static let shared = NumberGenerator()
    private var currentNumber: Int = 0
    
    private init() {
        generateRandomNumber()
    }
    
    func getCurrentNumber() -> Int {
        return currentNumber
    }
    
    func generateRandomNumber() {
        currentNumber = Int.random(in: 1...100)
        // Обновление числа в DynamicIslandModel
    }
}
