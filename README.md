<p align="center">
  <a href="" rel="noopener">
 <img width=300px  src="src/Logo.gif" alt="Project logo"></a>
</p>

<h3 align="center">🕹 CM Preesable Button 🕹</h3>

<div align="center">

![License](https://img.shields.io/github/license/CM-Material/CMPressableButton?style=for-the-badge)
![Release](https://img.shields.io/github/v/release/CM-Material/CMPressableButton?style=for-the-badge)

</div>

---

## 📹 Preview

<p align="center">
    <img src="src/appVideo.gif" width="40%" />
</p>

## 🏁 Getting Started

### Requirements
* Xcode 11+
* SwiftUI
* iOS 14+
* macOS 10.15+

### Installaion
#### Swift Package Manager(SPM)
    File ➜ Swift Packages ➜ Add Package Dependancy..

```Swift
.package(url: "https://github.com/CM-Material/CMPressableButton", from: "1.0.0")
```

## 🎈Usage
```Swift
CMPressableButton(action: { YOUR ACTION }) {
    // YOUR VIEW
}
```
* `action` : Functions to execute

#### 🛠Custom Modifiers
```Swift
CMPressableButton(action: { YOUR ACTION }) {
    // YOUR VIEW
}.accentColor(_ color: color)
.cornerRadius(_ amount: CGFloat)
.frame(height: CGFloat, width: CGFloat)
```
* `.accentColor()` : Accent color
* `.cornerRadius()` : Corner Radius of the button
* `.frame()` : Size of the button
## Example
#### 👶 Simple
```Swift
import CMPressableButton

struct ContentView: View {
    var body: some View {
        CMPressableButton(action: {
            print("Button pressed")
        }) {
            Text("Simple Example").foregroundColor(.white)
        }
    }
}
```
#### Result
<p float="left">
    <img src="src/Example-simple-1.png" width="25%">
    <img src="src/Example-simple-2.png" width="25%">
</p>

### 🛠 Custom Modifier
```Swift
import CMPressableButton

struct ContentView: View {
    var body: some View {
        CMPressableButton(action: {
            print("Button pressed")
        }) {
            Text("PUSH ME !").foregroundColor(.white)
        }
        .accentColor(.orange)
        .cornerRadius(0)
    }
}
```

### Result
<p float="left">
    <img src="src/Example-customModifier-1.png" width="25%">
    <img src="src/Example-customModifier-2.png" width="25%">
</p>

## ✅ TODO
- [ ] support variable styles `FlatStyle`, `PushButtonStyle`, etc

## 📜 License

CMPressableButton is available under the MIT license. See the `LICENSE` file for more info.

## ✍️ Author

- Byun Kyung Min ➜ [🇰🇷@Changemin](https://github.com/Changemin)
