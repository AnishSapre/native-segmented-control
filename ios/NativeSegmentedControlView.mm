#import "NativeSegmentedControlView.h"

#import <react/renderer/components/NativeSegmentedControlSpec/ComponentDescriptors.h>
#import <react/renderer/components/NativeSegmentedControlSpec/EventEmitters.h>
#import <react/renderer/components/NativeSegmentedControlSpec/Props.h>
#import <react/renderer/components/NativeSegmentedControlSpec/RCTComponentViewHelpers.h>

#import <React/RCTConversions.h>
#import <React/RCTFabricComponentsPlugins.h>

using namespace facebook::react;

@interface NativeSegmentedControlView () <RCTNativeSegmentedControlViewProtocol>
@end

@implementation NativeSegmentedControlView {
  UISegmentedControl *_control;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<NativeSegmentedControlComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const NativeSegmentedControlProps>();
    _props = defaultProps;

    _control = [[UISegmentedControl alloc] initWithItems:@[]];
    [_control addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    self.contentView = _control;
  }
  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<NativeSegmentedControlProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<NativeSegmentedControlProps const>(props);

  BOOL valuesChanged = (NSUInteger)_control.numberOfSegments != newViewProps.values.size() ||
      oldViewProps.values != newViewProps.values;
  if (valuesChanged) {
    [_control removeAllSegments];
    NSUInteger index = 0;
    for (const auto &value : newViewProps.values) {
      [_control insertSegmentWithTitle:[NSString stringWithUTF8String:value.c_str()] atIndex:index++ animated:NO];
    }
  }

  if (oldViewProps.selectedSegmentTintColor != newViewProps.selectedSegmentTintColor) {
    _control.selectedSegmentTintColor = RCTUIColorFromSharedColor(newViewProps.selectedSegmentTintColor);
  }

  if (oldViewProps.textColor != newViewProps.textColor) {
    UIColor *color = RCTUIColorFromSharedColor(newViewProps.textColor);
    [_control setTitleTextAttributes:color ? @{NSForegroundColorAttributeName : color} : nil
                            forState:UIControlStateNormal];
  }
  if (oldViewProps.selectedTextColor != newViewProps.selectedTextColor) {
    UIColor *color = RCTUIColorFromSharedColor(newViewProps.selectedTextColor);
    [_control setTitleTextAttributes:color ? @{NSForegroundColorAttributeName : color} : nil
                            forState:UIControlStateSelected];
  }

  if (oldViewProps.colorScheme != newViewProps.colorScheme) {
    switch (newViewProps.colorScheme) {
      case NativeSegmentedControlColorScheme::Light:
        _control.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        break;
      case NativeSegmentedControlColorScheme::Dark:
        _control.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        break;
      case NativeSegmentedControlColorScheme::System:
        _control.overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
        break;
    }
  }

  // JS owns the selection; keep the control in step with it.
  if (valuesChanged || oldViewProps.selectedIndex != newViewProps.selectedIndex ||
      _control.selectedSegmentIndex != newViewProps.selectedIndex) {
    NSInteger selected = newViewProps.selectedIndex;
    _control.selectedSegmentIndex =
        selected >= 0 && selected < _control.numberOfSegments ? selected : UISegmentedControlNoSegment;
  }

  [super updateProps:props oldProps:oldProps];
}

- (void)valueChanged
{
  if (!_eventEmitter) {
    return;
  }
  std::static_pointer_cast<const NativeSegmentedControlEventEmitter>(_eventEmitter)
      ->onSegmentSelect(NativeSegmentedControlEventEmitter::OnSegmentSelect{
          .index = (int)_control.selectedSegmentIndex});
}

@end
