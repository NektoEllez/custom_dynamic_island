//
//  CustomSatelliteCapsuleView.swift
//  iOS App
//
//  Created by Иван Марин on 29.08.2023.
//
import UIKit

/// Пользовательский  класс, представляющий капсулу для отображения количества спутников.
class CustomSatelliteCapsuleView: UIView {
    
    /// Ширина капсулы.
    private let frameWidth: CGFloat
    /// Метка для отображения числа спутников.
    private let satellitesLabel: UILabel = UILabel()
    
    private var satelliteImage: UIImage? = UIImage(named: "satellite")
    private var logoImage: UIImage? = UIImage(named: "logo")
    
    private let satelliteImageSize: CGFloat
    private let logoImageSize: CGFloat
    
    /// Инициализатор для создания экземпляра капсулы.
    /// - Parameters:
    ///   - frame: Прямоугольная рамка, определяющая положение и размер капсулы.
    ///   - satellites: Количество спутников, которое необходимо отобразить.
    init(frame: CGRect, satellites: Int) {
        self.frameWidth = frame.size.width - 20 // 10 пикселей отступ с каждой стороны
        self.satelliteImageSize = self.frameWidth * 0.15
        self.logoImageSize = self.frameWidth * 0.15
        
        super.init(frame: frame)
        
        // Создание слоя для отображения капсулы.
        let capsuleLayer = CAShapeLayer()
        capsuleLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
        capsuleLayer.strokeColor = UIColor.green.cgColor
        capsuleLayer.lineWidth = 1.0
        capsuleLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(capsuleLayer)
        
        // Добавление изображения слева капсулы.
        let imageView1 = UIImageView(image: satelliteImage)
        imageView1.frame = CGRect(x: 10, y: (frame.size.height - satelliteImageSize) / 2, width: satelliteImageSize, height: satelliteImageSize)

        imageView1.tintColor = .white
        addSubview(imageView1)
        
        // Добавление изображения справа капсулы.
        let imageView2 = UIImageView(image: logoImage)
        imageView2.frame = CGRect(x: frame.size.width - 10 - logoImageSize, y: (frame.size.height - logoImageSize) / 2, width: logoImageSize, height: logoImageSize)

        imageView2.tintColor = .white
        addSubview(imageView2)
        // Добавление разделителей для равномерного разделения капсулы на три части.
        let middleX = frame.size.width / 3
        
        // Добавление разделителей для равномерного разделения капсулы на три части.
        let divider1 = UIView(frame: CGRect(x: middleX - 1, y: 0, width: 1, height: frameWidth * 0.2))
        divider1.center.y = frame.size.height / 2
        divider1.backgroundColor = .white
        addSubview(divider1)
        
        let divider2 = UIView(frame: CGRect(x: middleX * 2 - 1, y: 0, width: 1, height: frameWidth * 0.2))
        divider2.center.y = frame.size.height / 2
        divider2.backgroundColor = .white
        addSubview(divider2)
        
        // Настройка метки для отображения числа спутников.
        satellitesLabel.adjustsFontSizeToFitWidth = true
        satellitesLabel.minimumScaleFactor = 0.5 // При необходимости можно настроить этот параметр
        
        satellitesLabel.frame = CGRect(x: divider1.frame.maxX, y: 0, width: divider2.frame.minX - divider1.frame.maxX, height: frameWidth * 0.4)
        satellitesLabel.center.y = frame.size.height / 2
        satellitesLabel.textAlignment = .center
        satellitesLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        satellitesLabel.textColor = .white
        satellitesLabel.text = "\(satellites)"
        addSubview(satellitesLabel)
    }
    
    /// Обновление отображаемого числа спутников.
    /// - Parameter newCount: Новое количество спутников для отображения.
    func updateSatelliteCount(_ newCount: Int) {
        satellitesLabel.text = "\(newCount)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


