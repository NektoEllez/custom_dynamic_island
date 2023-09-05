//
//  SatellitesLogo.swift
//  Widget Extension
//
//  Created by Иван Марин on 27.08.2023.
//
import SwiftUI
///
/// `SatellitesLogo` представляет собой пользовательский элемент `View`, который отображает логотип внутри круга.
///
/// Эта структура создаёт круглую рамку, внутри которой находится изображение логотипа. Цвет рамки меняется в зависимости от количества спутников: красный, если спутников нет, и зелёный в противном случае.
///
/// - Параметры:
///   - `frameWidth`: Ширина рамки для изображения и круга.
///   - `lineWidth`: Ширина линии круга. По умолчанию равна 0.
///   - `satellites`: Количество спутников. Используется для определения цвета круга.
///
/// Пример использования:
///
///     SatellitesLogo(satellites: 5, frameWidth: 100)
///
struct SatellitesLogo: View {
    @State var frameWidth: CGFloat = 100 // Задает значение по умолчанию, чтобы избежать опционала
    @State var lineWidth: CGFloat = 0.0
    @State var satellites: Int = 0 // новое свойство
    
    var body: some View {
        let color: Color = satellites == 0 ? .red : .green
        
        ZStack(alignment: .center) { // Явно задает выравнивание по центру
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(color)
                .overlay( // Использует .overlay, чтобы поместить изображение внутрь круга
                    Image("logo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: frameWidth * 0.7, height: frameWidth * 0.7) // Задает разный размер рамки для изображения
                )
                .frame(width: frameWidth, height: frameWidth) // Задает размер рамки для изображения, чтобы он был таким же, как у круга
        }
        .frame(width: frameWidth, height: frameWidth) // Задает общий размер рамки для ZStack
    }
}
