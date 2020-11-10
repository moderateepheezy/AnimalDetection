
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

    Swift, ARKit, Vision, CoreML

> **How it works**

Every 0.5 seconds `ARSCNView` captures it's current frame, and process a request using a custom `VNCoreMLModel` called `AnimalClassifierModel` a image classifier that has trained data set for the 10 animals. If the current captured frame is a picture of an animal, it automatically presents a new screen with the captured image, a caption with percentage of accurancy.

**Note:-** The detection accuracy is not currently perfect as you'll find case where it detects a random object as butterfly or any other animal in the sample. 
