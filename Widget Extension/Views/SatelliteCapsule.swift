//
//  SatelliteCapsule.swift
//  Widget Extension
//
//  Created by Иван Марин on 27.08.2023.
//
import SwiftUI
/// `SatelliteCapsule` представляет собой пользовательский элемент `View`, который отображает количество спутников внутри овала.
///
/// Эта структура создает зеленый овал, внутри которого отображается белый текст с количеством спутников.
///
/// Пример использования:
///
///     SatelliteCapsule(satellites: 5)
///
struct SatelliteCapsule: View {
    
    /// Ширина капсулы.
    @State var frameWidth: CGFloat = 100
    
    /// Толщина линии капсулы.
    @State var lineWidth: CGFloat = 1.0
    
    /// Количество спутников для отображения.
    @State var satellites: Int = 0
    
    /// Размер шрифта текста, отображающего количество спутников.
    private let fontSize: CGFloat = 24
    
    var body: some View {
        ZStack {
            
            /// Отображает основную форму капсулы с зеленым контуром.
            Capsule()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.green)
            
            /// Внутри капсулы размещается текст с количеством спутников.
                .overlay(
                    Text("\(satellites)")
                        .font(.system(size: fontSize))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .frame(width: frameWidth * 0.6, height: frameWidth * 0.6)
                )
        }
        /// Устанавливает размеры для всей капсулы.
        .frame(width: frameWidth * 2, height: frameWidth)
    }
}
