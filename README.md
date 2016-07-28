# MIAlertController
A simple fully customizable alert controller

# Setup
- Copy the "MIAlertController" folder to your project.
- Create a new instance with just a line of code

```
MIAlertController(

  title: "I'm a default alert, am I cute?",
  message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris",
  buttons: [
    MIAlertController.Button(title: "Yep"),
    MIAlertController.Button(title: "Nope", type: .Destructive)
  ]

).presentOn(self, buttonTapped: { (buttonIndex) in
  
  print("button \(buttonIndex) tapped")

})
```
