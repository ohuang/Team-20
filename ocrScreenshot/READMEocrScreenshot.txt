this project is an attempt at using mouse tracking events to the effect of recreating a functionality similar to that of cmd-shift-4


the overall purpose of these mouse events is to create a CGRect that can be passed to this function:
CGDisplayCreateImage(displayID, rect: rect)

this function  works to the effect of creating a screenshot of the whole screen localized relative to the provided rect


