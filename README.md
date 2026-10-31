# Pinterest Dark Mode (iOS 6 / Pinterest 3.0)

Experimental MobileSubstrate tweak source for the uploaded Pinterest 3.0 IPA.

## What it does

Intercepts common UIKit colour setters and inverts colours whose RGB channels
are sufficiently close together (near-neutral black, white, grey, and slightly
tinted neutrals). Saturated colours are left alone. It does not intentionally
modify image pixels, so photos and colourful pin images should remain unchanged.

## Important limitations

This is **source code, not a compiled/installable .deb**. This environment does
not have Theos, an iOS SDK, MobileSubstrate headers/libraries, or an iOS device
runtime available, so I cannot honestly claim to have built or tested a working
binary here.

This first pass only catches colours explicitly assigned through the hooked
UIKit setters. Some UIKit controls use internal/default colours without calling
these setters, and custom-drawn views or web content may remain light. Pinterest
also uses image assets for some UI chrome; those are not changed by this tweak.
A more complete patch may need additional hooks or selectively edited assets
after testing on-device.

## Build

On a jailbroken iOS tweak build setup with Theos and an iOS SDK installed:

1. Place this folder in your Theos project directory.
2. Ensure your Theos toolchain supports the target architectures and deployment
   target. For an iOS 6-only device, `armv7` is the relevant architecture.
3. Run `make package`.
4. Install the resulting `.deb` and respring.

The filter plist targets bundle identifier `pinterest`. Confirm that identifier
against the installed app if injection does not occur.

## Tuning

In `Tweak.xm`, change `spread > 0.20` to a lower value to catch more tinted
colours, or a higher value to preserve more coloured accents. This deliberately
uses RGB inversion for near-neutrals, not full-screen inversion, so images are
not inverted.
