# Pinterest Dark Mode (iOS 6 / Pinterest 3.0) — v0.3

Experimental MobileSubstrate tweak source for Pinterest's `pinterest` bundle ID, targeting ARMv7/iOS 6.

## What changed from v0.2

v0.2 hooked both `UIView.setBackgroundColor:` and `CALayer.setBackgroundColor:`. A UIView normally forwards its background colour to its backing CALayer, so the same colour could be inverted twice and end up light again. v0.3 removes the CALayer background hook and removes overlapping tint/title-colour hooks that could also apply the transform twice.

## Behaviour and limitations

- Inverts colours passed through selected UIKit setters, including view backgrounds, text colours, separators, bar backgrounds, and several controls.
- Does not alter image pixel data, so normal Pinterest photos/pins should remain unchanged.
- May miss colours drawn internally by UIKit, WebKit, custom drawing, or UI chrome baked into image assets.
- This is not a full-screen pixel inversion filter and has not been independently tested on an iOS 6 device.

## Build

Run `make clean package FINALPACKAGE=1` in a compatible Theos environment. The package depends on MobileSubstrate.
