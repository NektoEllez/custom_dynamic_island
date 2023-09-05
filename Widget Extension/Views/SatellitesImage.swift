//
//  SatellitesImage.swift
//  Widget Extension
//
//  Created by Иван Марин on 27.08.2023.
//

import SwiftUI
///
/// `SatellitesImage` представляет собой пользовательский элемент `View`, отображающий изображение спутника в круге с изменяемой окантовкой.
///
/// Элемент настраивается следующим образом:
/// - Круглая окантовка с шириной линии, определенной в `lineWidth`.
/// - Цвет окантовки меняется в зависимости от количества спутников: красный, если спутников нет, и зелёный в противном случае.
/// - Изображение спутника внутри круга масштабируется, чтобы соответствовать заданным размерам.
///
/// - Parameters:
///   - frameWidth: Ширина рамки и круга. По умолчанию равна 100.
///   - lineWidth: Ширина линии круга. По умолчанию равна 0.
///   - satellites: Количество спутников, используется для определения цвета круга.
///
struct SatellitesImage: View {
    @State var frameWidth: CGFloat = 100
    @State var lineWidth: CGFloat = 0.0
    @State var satellites: Int = 0
    @State private var satelliteImage: UIImage? = UIImage(named: "satellite")
    
    var body: some View {
        // Определяет цвет круга в зависимости от количества спутников.
        let color: Color = satellites == 0 ? .red : .green
        
        ZStack {
            // Круглый контур с заданной шириной линии и цветом.
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(color)
            
            // Изображение спутника, масштабируемое и подгоняемое под заданные размеры.
            if let image = satelliteImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: frameWidth * 0.5, height: frameWidth * 0.6)
            }
        }
        .frame(width: frameWidth, height: frameWidth) // Общий размер вида.
    }
}

