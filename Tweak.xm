#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <substrate.h>

/*
 * Pinterest 3.0 / iOS 6 dark-mode experiment, v0.5.
 *
 * Invert every colour passed through the UIKit / Core Animation setters we
 * hook, rather than only near-neutral colours. This changes UI colours while
 * leaving UIImage pixel data alone (ordinary photos/pins should not invert).
 * It cannot automatically invert pixels drawn by WebKit, custom drawing, or
 * UI chrome baked into image assets.
 */

static UIColor *PDMInvertedColor(UIColor *color) {
    if (!color || color == [UIColor clearColor]) return color;

    CGFloat r = 0, g = 0, b = 0, a = 0;
    if (![color getRed:&r green:&g blue:&b alpha:&a]) {
        CGColorRef cg = color.CGColor;
        if (!cg) return color;
        size_t n = CGColorGetNumberOfComponents(cg);
        const CGFloat *c = CGColorGetComponents(cg);
        if (!c) return color;
        if (n == 2) { r = g = b = c[0]; a = c[1]; }
        else if (n >= 4) { r = c[0]; g = c[1]; b = c[2]; a = c[3]; }
        else return color;
    }

    return [UIColor colorWithRed:(1.0 - r)
                           green:(1.0 - g)
                            blue:(1.0 - b)
                           alpha:a];
}

static CGColorRef PDMInvertedCGColor(CGColorRef color) {
    if (!color) return color;
    UIColor *source = [UIColor colorWithCGColor:color];
    return PDMInvertedColor(source).CGColor;
}

%hook UIView
- (void)setBackgroundColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
- (void)setTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end




%hook UITableView
- (void)setSeparatorColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook UINavigationBar
- (void)setBarTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook UIToolbar
- (void)setBarTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook UIBarButtonItem
- (void)setTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook UIProgressView
- (void)setProgressTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
- (void)setTrackTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook UISwitch
- (void)setOnTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook UISegmentedControl
- (void)setTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook UIPageControl
- (void)setPageIndicatorTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)color {
    %orig(PDMInvertedColor(color));
}
%end

%hook CALayer
/* Do not hook setBackgroundColor here: UIView's setter normally forwards to
 * its backing layer, which would invert the same background twice. */
- (void)setBorderColor:(CGColorRef)color {
    %orig(PDMInvertedCGColor(color));
}
- (void)setShadowColor:(CGColorRef)color {
    %orig(PDMInvertedCGColor(color));
}
%end
