import SwiftUI

public struct CMPressableButton<Content: View> : View{
    @State var isPressed: Bool = false
    var color: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    var cornerRadius: CGFloat = 5
    var width: CGFloat = 280
    var height: CGFloat = 52
    var depth: CGFloat =  5
    let content: Content
    var action: () -> () = {}
    
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .cornerRadius(cornerRadius)
                .frame(width: width, height: height)
                .shadow(radius: isPressed ? 2 : 5)
            Color.black.opacity(0.25)
                .cornerRadius(cornerRadius)
                .frame(width: width, height: height)
            Rectangle()
                .fill(color)
                .cornerRadius(cornerRadius)
                .modifier(
                    TouchEventModifier(changeState: { (buttonState) in
                        if buttonState == .pressed {
                            withAnimation(Animation.easeInOut(duration: 0.05)) {
                                isPressed = true
                            }
                            
                        } else {
                            action()
                            withAnimation(Animation.easeInOut(duration: 0.05)) {
                                isPressed = false
                            }
                            
                        }
                }))
                .frame(width: width, height: height)
                .offset(y: isPressed ? -3 : -depth-3)
            Rectangle()
                .fill(Color.black)
                .cornerRadius(cornerRadius)
                .frame(width: width, height: height)
                .opacity(isPressed ? 0.03 : 0)
                .offset(y: isPressed ? -3 : -depth-3)
            content.offset(y: isPressed ? -3 : -depth-3)
        }
        
    }
    
    public init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content, width: CGFloat, height: CGFloat, color: Color, cornerRadius: CGFloat) {
        self.content = content()
        self.action = action
        self.width = width
        self.height = height
        self.color = color
        self.cornerRadius = cornerRadius
    }
    
    public init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.action = action
    }
}

extension CMPressableButton {
    public func accentColor(_ color: Color) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: { self.content },
                          width: self.width,
                          height: self.height,
                          color: color,
                          cornerRadius: self.cornerRadius)
    }
    public func cornerRadius(_ amount: CGFloat) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: { self.content },
                          width: self.width,
                          height: self.height,
                          color: self.color,
                          cornerRadius: amount)
    }
    public func frame(width: CGFloat, height: CGFloat) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: { self.content },
                          width: width,
                          height: height,
                          color: self.color,
                          cornerRadius: self.cornerRadius)
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
