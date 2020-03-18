# BottomAlertSheet

This package will perform the native-like ActionSheet, but you can customize the UI like line color, title and font.
Also you can pass button in and get more flexible control of the alert.

Usage:

```swift
let button1 = UIButton(type: .system)  
button1.setTitle("Button1", for: .normal)  
let button2 = UIButton(type: .system)  
button2.setTitle("Button2", for: .normal)  
let button3 = UIButton(type: .system)  
button3.setTitle("Button3", for: .normal)  

BottomAlertManager().performBottomAlert(title: "Hello",  
                                        message: "Hello", // message can be either string or attribute string  
                                        topButtons: [button1, button2, button3],  
                                        bottomButtonTitle: "Cancel") // input "" will remove the bottom buttonView  
```
                                                         
Screenshots  
<img src="https://res.cloudinary.com/drafmunin/image/upload/v1584490791/Button1_dhbx9j.png" width="300" height="260">

