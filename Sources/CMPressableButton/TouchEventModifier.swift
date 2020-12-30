//
//  File.swift
//  
//
//  Created by 변경민 on 2020/12/30.
//

import SwiftUI

public enum ButtonState {
    case pressed
    case notPressed
}

public struct TouchEventModifier: ViewModifier {
    @GestureState private var isPressed = false
    let changeState: (ButtonState) -> Void
    
    public func body(content: Content) -> some View {
        let drag = DragGesture(minimumDistance: 0)
            .updating($isPressed) { (value, gestureState, transaction) in
            gestureState = true
        }
        
        return content
        .gesture(drag)
        .onChange(of: isPressed, perform: { (pressed) in
            if pressed {
                self.changeState(.pressed)
            } else {
                self.changeState(.notPressed)
            }
        })
    }
    
    public init(changeState: @escaping (ButtonState) -> Void) {
        self.changeState = changeState
    }
}
