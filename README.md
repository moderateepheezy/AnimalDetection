
### Animal Detection

This is a simple CoreML sample project to detect trained data set that current process 10 animals.
 
1. Dog
2. Cat
3. Butterfly
4. Horse
5. Elephant
6. Squirrel
7. Cow
8. Spider
9. Sheep
10. Chicken

> **Technology Used**

    Xcode, Swift, ARKit, Vision, CoreML
    
> **How to test**

Make sure you have the following tool:  a Macbook, XCode 12+(download from the AppStore if you don't have one), a Physical device(iPhone 7 and above).
Folllow the steps below after you've confrim Xcode on your Macbook:

1. Clone the project
2. Open the `.xcodeproj` file on Xcode
3. Connect your iPhone to your commputer (https://www.twilio.com/blog/2018/07/how-to-test-your-ios-application-on-a-real-device.html)
4. Click Run

You can now test the app on a physical device.

> **How it works**

If you place the app infront of an object, every 0.5 seconds `ARSCNView` captures it's current frame, and process a request using a custom `VNCoreMLModel` called `AnimalClassifierModel` a image classifier that has trained data set for the 10 animals. If the current captured frame is a picture of an animal, it automatically presents a new screen with the captured image, a caption with percentage of accurancy.

**Note:-** The detection accuracy is not currently perfect as you'll find case where it detects a random object as butterfly or any other animal in the sample. 
