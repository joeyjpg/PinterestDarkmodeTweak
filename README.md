# Pinterest Dark Mode (iOS 6 / Pinterest 3.0)

Experimental MobileSubstrate tweak source. Version 0.2 inverts every colour passed through the hooked UIKit and Core Animation setters, rather than limiting inversion to near-neutral colours.

## Expected behaviour

- White/black/grey and coloured UI elements handled by the hooked setters have their RGB colours inverted.
- Normal image pixel data is not modified, so photos and Pinterest pins should remain as they were.
- Template images/icons that use a tint colour may change because their tint is a UI colour.

## Limitations

This is still a selective setter-hook approach, not a true display-wide inversion filter. It may miss colours rendered internally by UIKit, WebKit/web views, custom drawing, or UI chrome baked into image assets. Some UI colours may also be assigned more than once, so test it on-device. It has not been independently tested on an iOS 6 device.

## Build

Build with Theos on a compatible tweak build environment using `make package`. The filter targets bundle identifier `pinterest` and the build targets ARMv7/iOS 6.
