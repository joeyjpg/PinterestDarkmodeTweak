# Pinterest Dark Mode Tweak v0.5

This version is based on v0.3, with the text-colour hooks removed. It retains the existing inversion of view backgrounds, tint colours, table separators, navigation/tool bars, bar button tint, progress controls, switches, segmented controls, page controls, and CALayer border/shadow colours.

The tweak does not intentionally modify UILabel, UITextField, or UITextView text colours. This should keep ordinary UIKit text in its original colour while retaining the v0.3 treatment of other hooked UI colours. Text rendered through custom drawing, attributed strings, or WebKit may still be affected if its colour is supplied through a hooked non-text setter; no general guarantee is possible for every rendering path.

Build with the existing GitHub Actions workflow. This source has not been tested on-device.
