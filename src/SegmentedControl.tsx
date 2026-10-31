import React from 'react'
import { StyleSheet, type ColorValue, type StyleProp, type ViewStyle } from 'react-native'
import NativeSegmentedControlView from './NativeSegmentedControlNativeComponent'
import { isAvailable } from './platform'

export type SegmentedControlProps = {
  values: string[]
  selectedIndex: number
  /** The user picked a segment. Selection is controlled: update selectedIndex to accept it. */
  onChange: (index: number) => void
  /** Fill of the selected segment. System default when unset. */
  selectedSegmentTintColor?: ColorValue
  textColor?: ColorValue
  selectedTextColor?: ColorValue
  colorScheme?: 'light' | 'dark' | 'system'
  style?: StyleProp<ViewStyle>
  testID?: string
}

/**
 * Apple's UISegmentedControl. On iOS 26 it is the system liquid glass control (sliding
 * glass selection, press feedback). Renders nothing on Android.
 */
export const SegmentedControl = ({ onChange, colorScheme = 'system', style, ...props }: SegmentedControlProps) => {
  if (!isAvailable) return null
  return (
    <NativeSegmentedControlView
      {...props}
      colorScheme={colorScheme}
      style={[styles.control, style]}
      onSegmentSelect={e => onChange(e.nativeEvent.index)}
    />
  )
}

const styles = StyleSheet.create({
  // UISegmentedControl's standard height; override through style.
  control: { height: 32 },
})
