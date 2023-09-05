//
//  SatelliteNumberCapsule.swift
//  Widget Extension
//
//  Created by Иван Марин on 27.08.2023.
//
import SwiftUI
///
/// `SatelliteNumberCapsule` представляет собой пользовательский элемент `View`, который отображает изображение спутника и количество спутников внутри овала.
///
/// Эта структура создает зеленый овал с изображением спутника, вертикальным разделителем и количеством спутников.
///
/// Пример использования:
///
///     SatelliteNumberCapsule(satellites: 5)
///
struct SatelliteNumberCapsule: View {
    
    /// Ширина капсулы.
    @State var frameWidth: CGFloat = 100
    
    /// Количество спутников для отображения.
    @State var satellites: Int = 0
    
    /// Изображение спутника.
    @State private var satelliteImage: UIImage? = UIImage(named: "satellite")
    
    /// Толщина линии капсулы.
    private let capsuleStrokeWidth: CGFloat = 1
    
    /// Цвет капсулы.
    private let capsuleColor: Color = .green
    
    /// Отступ для изображения спутника.
    private let imagePadding: CGFloat = 1
    
    /// Ширина вертикального разделителя.
    private let separatorWidth: CGFloat = 0.5
    
    /// Размер шрифта текста, отображающего количество спутников.
    private let fontSize: CGFloat = 15
    
    var body: some View {
        ZStack {
            
            /// Фоновая капсула с заданными шириной линии и цветом.
            Capsule()
                .stroke(lineWidth: capsuleStrokeWidth)
                .foregroundColor(capsuleColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            /// Контент с изображением спутника, разделителем и числом спутников.
            HStack(spacing: 4) {
                /// Изображение спутника с заданным масштабом и отступом.
                Image(uiImage: satelliteImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: frameWidth * 0.5, height: frameWidth * 0.6)
                    .padding(.horizontal, imagePadding)
                
                /// Вертикальный разделитель.
                Rectangle()
                    .fill(Color.green)
                    .frame(width: separatorWidth, height: frameWidth * 0.6)
                
                /// Количество спутников с заданным размером шрифта.
                Text("\(satellites)")
                    .font(.system(size: fontSize).bold())
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .frame(width: frameWidth * 0.5, height: frameWidth * 0.6)
                    .padding(.horizontal, imagePadding)
            }
            .foregroundColor(.white)
        }
        /// Устанавливает размеры для всей капсулы.
        .frame(width: frameWidth * 2, height: frameWidth)
    }
}
