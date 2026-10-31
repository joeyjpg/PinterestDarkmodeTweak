# Pinterest Dark Mode Tweak

A lightweight MobileSubstrate tweak that makes the legacy Pinterest app more comfortable to use in dark environments by inverting selected interface colours. It is intended for Pinterest 3.0 on jailbroken devices running iOS 6.x, with the original iPad 2 / ARMv7 setup as the main target.

## What it does

The tweak inverts colours when they are assigned through a set of UIKit and Core Animation properties, including view backgrounds, tint colours, table separators, navigation and toolbar colours, progress indicators, switches, segmented controls, page indicators, and layer borders and shadows. The goal is a mostly dark-friendly interface without inverting the actual photos and pins displayed in the feed.

This is a best-effort compatibility tweak, not a complete system-wide dark mode. It only affects colours that pass through the properties it hooks. Some interface elements may remain light, and text or other content drawn by WebKit, custom drawing code, or image assets may not behave consistently. In v0.5, standard `UILabel`, `UITextField`, and `UITextView` text-colour setters are deliberately not hooked, to avoid directly inverting ordinary UIKit text.

## Compatibility

- Pinterest 3.0 (target application)
- Jailbroken iOS 6.x, ARMv7 devices
- MobileSubstrate

Compatibility with other Pinterest versions, iOS releases, or devices has not been established.

## Building

The project uses Theos. From the project directory, build a Debian package with:

```sh
make clean package FINALPACKAGE=1
```

The resulting `.deb` can be installed on a compatible jailbroken device using a package manager or another supported installation method. Respring after installation if required.

## Status

Experimental and tested informally on the target device. Coverage is incomplete by design: the tweak modifies selected UI colours rather than applying a post-render filter, so it cannot guarantee that every interface element becomes dark.

## Credits and AI disclosure

- **Project owner and maintainer:** Clover (barely lmao)
- **AI assistance:** OpenAI ChatGPT (GPT-6) assisted with implementation ideas, source-code drafting, troubleshooting, and documentation.

The code and behaviour should be reviewed and tested on-device; AI assistance does not imply that every change has been independently verified.
