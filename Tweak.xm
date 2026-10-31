#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <substrate.h>
#import <math.h>

/*
 * Pinterest 3.0 / iOS 6 dark-mode experiment.
 *
 * Only near-neutral colours are inverted, so photos and colourful UI accents
 * are not intentionally touched. UIKit setters are intercepted so the app's
 * own original colours are converted at assignment time (rather than toggled
 * repeatedly during layout).
 */

static UIColor *PDMTransformColor(UIColor *color) {
    if (!color || color == [UIColor clearColor]) return color;

    CGFloat r = 0, g = 0, b = 0, a = 0;
    if (![color getRed:&r green:&g blue:&b alpha:&a]) {
        CGColorRef cg = color.CGColor;
        if (!cg || CGColorGetNumberOfComponents(cg) < 2) return color;
        const CGFloat *c = CGColorGetComponents(cg);
        size_t n = CGColorGetNumberOfComponents(cg);
        if (n == 2) { r = g = b = c[0]; a = c[1]; }
        else if (n >= 4) { r = c[0]; g = c[1]; b = c[2]; a = c[3]; }
        else return color;
    }

    if (a < 0.02) return color;

    CGFloat hi = fmax(r, fmax(g, b));
    CGFloat lo = fmin(r, fmin(g, b));
    CGFloat spread = hi - lo;

    // Keep saturated colours. The 0.20 tolerance includes slightly tinted
    // greys/off-whites, while leaving most colourful artwork and accents alone.
    if (spread > 0.20) return color;

    // Avoid changing very faint translucent overlays.
    CGFloat nr = 1.0 - r;
    CGFloat ng = 1.0 - g;
    CGFloat nb = 1.0 - b;

    return [UIColor colorWithRed:nr green:ng blue:nb alpha:a];
}

%hook UIView
- (void)setBackgroundColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UILabel
- (void)setTextColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UITextField
- (void)setTextColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UITextView
- (void)setTextColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UITableView
- (void)setSeparatorColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UINavigationBar
- (void)setTintColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UIToolbar
- (void)setTintColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UIProgressView
- (void)setProgressTintColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
- (void)setTrackTintColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end

%hook UISwitch
- (void)setOnTintColor:(UIColor *)color {
    %orig(PDMTransformColor(color));
}
%end
