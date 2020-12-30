import SwiftUI

public struct CMPressableButton<Content: View> : View{
    @State var isPressed: Bool = false
    var color: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    var cornerRadius: CGFloat = 5
    let content: Content
    var action: () -> () = {}
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .cornerRadius(cornerRadius)
                .frame(width: 100, height: 40)
            Color.black.opacity(0.25)
                .cornerRadius(cornerRadius)
                .frame(width: 100, height: 40)
            Rectangle()
                .fill(color)
                .cornerRadius(cornerRadius)
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
            content.offset(y: isPressed ? -3 : -10)
        }
        
    }
    
    public init(action: @escaping () -> Void, @ViewBuilder content: () -> Content, color: Color, cornerRadius: CGFloat) {
        self.content = content()
        self.action = action
        self.color = color
        self.cornerRadius = cornerRadius
    }
    
    public init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.action = action
    }
}

extension CMPressableButton {
    func accentColor(_ color: Color) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: self.content as! () -> Content,
                          color: color,
                          cornerRadius: self.cornerRadius)
    }
    func cornerRadius(_ amount: CGFloat) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: self.content as! () -> Content,
                          color: self.color,
                          cornerRadius: amount)
    }
}



//extension Color {
//    /**
//     Create a ligher color
//     */
//    func lighter(by percentage: CGFloat = 10.0) -> Color {
//        return self.adjustBrightness(by: abs(percentage))
//    }
//
//    /**
//     Create a darker color
//     */
//    func darker(by percentage: CGFloat = 10.0) -> Color {
//        return self.adjustBrightness(by: -abs(percentage))
//    }
//
//    /**
//     Try to adjust brightness and falls back to adjusting colors if necessary
//     */
//    func adjustBrightness(by percentage: CGFloat) -> Color {
//        var alpha, hue, saturation, brightness, red, green, blue, white : CGFloat
//        (alpha, hue, saturation, brightness, red, green, blue, white) = (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
//
//        let multiplier = percentage / 100.0
//
//        self.hue
//        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
//            let newBrightness: CGFloat = max(min(brightness + multiplier*brightness, 1.0), 0.0)
//            return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
//        }
//        else if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
//            let newRed: CGFloat = min(max(red + multiplier*red, 0.0), 1.0)
//            let newGreen: CGFloat = min(max(green + multiplier*green, 0.0), 1.0)
//            let newBlue: CGFloat = min(max(blue + multiplier*blue, 0.0), 1.0)
//            return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
//        }
//        else if self.getWhite(&white, alpha: &alpha) {
//            let newWhite: CGFloat = (white + multiplier*white)
//            return UIColor(white: newWhite, alpha: alpha)
//        }
//
//        return self
//    }
//}
