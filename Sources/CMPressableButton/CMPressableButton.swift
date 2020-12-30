import SwiftUI

public struct CMPressableButton<Content: View> : View{
    @State var isPressed: Bool = false
    var color: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    let content: Content
    var action: () -> () = {}
    
    public init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 100, height: 40)
            Rectangle()
                .fill(color)
                .modifier(
                    TouchEventModifier(changeState: { (buttonState) in
                        if buttonState == .pressed {
                            isPressed = true
                        } else {
                            isPressed = false
                        }
                }))
                .frame(width: 100, height: 40)
                .offset(y: isPressed ? -3 : -10)
        }
    }
}


