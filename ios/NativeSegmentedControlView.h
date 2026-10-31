#import <React/RCTViewComponentView.h>
#import <UIKit/UIKit.h>

#ifndef NativeSegmentedControlView_h
#define NativeSegmentedControlView_h

NS_ASSUME_NONNULL_BEGIN

/// The system UISegmentedControl as a Fabric component. On iOS 26 that is Apple's
/// liquid glass control: the sliding glass selection and press feedback come from UIKit.
@interface NativeSegmentedControlView : RCTViewComponentView
@end

NS_ASSUME_NONNULL_END

#endif /* NativeSegmentedControlView_h */
