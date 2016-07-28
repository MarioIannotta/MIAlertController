# MIAlertController
A simple fully customizable alert controller

# Setup
- Copy the "MIAlertController" folder to your project.
- Create a new instance with just a line of code

```
MIAlertController(

  title: "Your alert title",
  message: "Your alert description",
  buttons: [
    MIAlertController.Button(title: "Button one"),
    MIAlertController.Button(title: "Button two")
  ]

).presentOn(self, buttonTapped: { (buttonIndex) in
  
  print("button \(buttonIndex) tapped")

})
```
# Customization
- You can customize the alert's behavior and UI by creating a new instance of the struct MIAlertController.Config and changing it's property as you like
- There are three type of buttons (.Default, .Destructive, .Cancel) with different UI but you can create a new type by using the struct MIAlertController.Button.Config
```
// Alert UI and behavior
var googlishAlertControllerConfig = MIAlertController.Config()

googlishAlertControllerConfig.firstButtonRatio = 0.8
googlishAlertControllerConfig.alertViewCornerRadius = 1
googlishAlertControllerConfig.messageLabelTextColor = UIColor(white: 0.45, alpha: 1)

googlishAlertControllerConfig.messageVerticalSpaceFromTitle = 25
googlishAlertControllerConfig.messageLabelFont = UIFont.systemFontOfSize(17)

googlishAlertControllerConfig.alertMarginSize = CGSize(width: 10, height: 10)
googlishAlertControllerConfig.alertViewMaxSize = CGSize(width: UIScreen.mainScreen().bounds.size.width - 80, height: 340)

googlishAlertControllerConfig.titleLabelTextAlignment = NSTextAlignment.Left
googlishAlertControllerConfig.messageLabelTextAlignment = NSTextAlignment.Left

// Buttons UI
var googlishAlertControllerLeftButtonConfig = MIAlertController.Button.Config()

googlishAlertControllerLeftButtonConfig.textColor = UIColor(red: 19/255.0, green: 152/255.0, blue: 138/255.0, alpha: 1)
googlishAlertControllerLeftButtonConfig.textAlignment = .Right
googlishAlertControllerLeftButtonConfig.font = UIFont.boldSystemFontOfSize(15)

var googlishAlertControllerRightButtonConfig = MIAlertController.Button.Config()

googlishAlertControllerRightButtonConfig.textColor = UIColor(red: 19/255.0, green: 152/255.0, blue: 138/255.0, alpha: 1)
googlishAlertControllerRightButtonConfig.font = UIFont.boldSystemFontOfSize(15)

MIAlertController(

  title: "I'm a googlish alert!",
  message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna   aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris",
  buttons: [
    MIAlertController.Button(title: "COOL", config: googlishAlertControllerLeftButtonConfig),
    MIAlertController.Button(title: "OK", config: googlishAlertControllerRightButtonConfig)
  ],
  config: googlishAlertControllerConfig

).presentOn(self, buttonTapped: { (buttonIndex) in

  print("button \(buttonIndex) tapped")

})

```
#Demo
In this repository you can also find a demo.

<img src="demo.gif" height="500"/>

# Info
If you like this git you can follow me here or on twitter :) [@MarioIannotta](http://www.twitter.com/marioiannotta)

Cheers from Italy!
