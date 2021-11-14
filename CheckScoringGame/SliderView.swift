//
//  SliderView.swift
//  CheckScoringGame
//
//  Created by Егор on 14.11.2021.
//

import SwiftUI

struct SliderView: UIViewRepresentable {
    
    @Binding var value: Double
    
    let alpha: Int
    let color: UIColor
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        // Сам слайдер
        
        slider.addTarget(
            context.coordinator, // Действия находится в кордиинаторе который в параметре контекст
            action: #selector(Coordinator.valueChanged), // Само действие, находится тоже в кордиинаторе
            for: .valueChanged // В какой момент вызывается метод, определяем событие
        )
        return slider
    }
    // Определяем цвет слайдера thumbTintColor withAlphaComponent
    func updateUIView(_ view: UISlider, context: Context) {
        view.thumbTintColor = color.withAlphaComponent(CGFloat(alpha) / 100) // Здесь выступает в подсчете очков потому что альфа задается в диапазоне до 1 а в иниициалиизатор передается значение от 1 до 100
        view.value = Float(value) // положение слайдера на дорожке
    }
    // Метод кордиинатор должен возвращать экземпляр класса который приниимает значение value из SwiftUI и передает в UIKit
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
}

// Для работы с координатором обьявляются именно одно свойство value, которое меняется из UIKit в SwiftUI
extension SliderView {
    class Coordinator: NSObject {
        @Binding var value: Double
        
        init(value: Binding<Double>) {
            self._value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(50), alpha: 100, color: .red)
    }
}
