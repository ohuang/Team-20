this project is our CURRENT GOAL FOR WEDNESDAY



it revolves around the following 2 lines in the viewcontroller:

        let displayID = CGMainDisplayID()
        
        
        let cgScreenshot = CGDisplayCreateImage(displayID)

cgScreenshot is a screenshot of the entire screen

what happens next is we set that screenshot into an imageview in the window

point being, we can easily get it set up so that we can drag boxes over that window in order to specify the area over which we would like to perform OCR

that area would specified by a corresponding CGRect created in accordance with the mouse event, as the screenshot method can also be called with a rect specified:
CGDisplayCreateImage(displayID, rect: rect)



here are the next steps:

0) after the fullscreen image is posted to the imageview, we want to make that window full screen; investigate programmatically going into fullscreen mode
 
1) make it so mouse events allows user to drag a box over the window

2) turn that mouse selection into a CGRect

3) use that CGRect to isolate the corresponding portion of the image 

4) configure Tesseract so that plays nice with this app

5) pass that subsection of the image into tesseract
