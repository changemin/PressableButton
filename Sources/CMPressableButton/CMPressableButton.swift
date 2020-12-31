import SwiftUI

public struct CMPressableButton<Content: View> : View{
    @State var isPressed: Bool = false
    var color: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    var cornerRadius: CGFloat = 5
    var width: CGFloat = 280
    var height: CGFloat = 52
    var depth: CGFloat =  5
    var hapticEffect: (useHaptic: Bool, intensity: UIImpactFeedbackGenerator.FeedbackStyle) = (true, .heavy)
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
                            if(hapticEffect.useHaptic) {
                                UIImpactFeedbackGenerator(style: hapticEffect.intensity).impactOccurred()
                            }
                            withAnimation(Animation.easeInOut(duration: 0.05)) {
                                isPressed = true
                            }
                        } else {
                            if(hapticEffect.useHaptic) {
                                UIImpactFeedbackGenerator(style: hapticEffect.intensity).impactOccurred()
                            }
                            action()
                            withAnimation(Animation.easeInOut(duration: 0.05)) {
                                isPressed = false
                            }
                        }
                }))
                .frame(width: width, height: height)
                .offset(y: isPressed ? -5 : -depth-5)
            Rectangle()
                .fill(Color.black)
                .cornerRadius(cornerRadius)
                .frame(width: width, height: height)
                .opacity(isPressed ? 0.03 : 0)
                .offset(y: isPressed ? -5 : -depth-5)
            content.offset(y: isPressed ? -5 : -depth-5)
        }
    }
    
    public init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content, width: CGFloat, height: CGFloat, color: Color, cornerRadius: CGFloat, useHaptic: Bool, hapticIntensity: UIImpactFeedbackGenerator.FeedbackStyle) {
        self.content = content()
        self.action = action
        self.width = width
        self.height = height
        self.color = color
        self.cornerRadius = cornerRadius
        self.hapticEffect = (useHaptic, hapticIntensity)
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
                          cornerRadius: self.cornerRadius,
                          useHaptic: self.hapticEffect.0,
                          hapticIntensity: self.hapticEffect.1)
    }
    public func cornerRadius(_ amount: CGFloat) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: { self.content },
                          width: self.width,
                          height: self.height,
                          color: self.color,
                          cornerRadius: amount,
                          useHaptic: self.hapticEffect.0,
                          hapticIntensity: self.hapticEffect.1)
    }
    public func frame(width: CGFloat, height: CGFloat) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: { self.content },
                          width: width,
                          height: height,
                          color: self.color,
                          cornerRadius: self.cornerRadius,
                          useHaptic: self.hapticEffect.0,
                          hapticIntensity: self.hapticEffect.1)
    }
    public func enableHaptic(intensity: UIImpactFeedbackGenerator.FeedbackStyle) -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: { self.content },
                          width: self.width,
                          height: self.height,
                          color: self.color,
                          cornerRadius: self.cornerRadius,
                          useHaptic: self.hapticEffect.0,
                          hapticIntensity: intensity)
    }
    public func disableHaptic() -> CMPressableButton {
        CMPressableButton(action: self.action,
                          content: { self.content },
                          width: self.width,
                          height: self.height,
                          color: self.color,
                          cornerRadius: self.cornerRadius,
                          useHaptic: false,
                          hapticIntensity: self.hapticEffect.1)
    }
}
