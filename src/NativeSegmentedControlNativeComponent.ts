import { codegenNativeComponent, type CodegenTypes, type ColorValue, type ViewProps } from 'react-native'

export interface NativeProps extends ViewProps {
  values: ReadonlyArray<string>
  selectedIndex: CodegenTypes.Int32
  /** Fill of the selected segment. */
  selectedSegmentTintColor?: ColorValue
  selectedTextColor?: ColorValue
  textColor?: ColorValue
  colorScheme?: CodegenTypes.WithDefault<'light' | 'dark' | 'system', 'system'>
  onSegmentSelect?: CodegenTypes.DirectEventHandler<Readonly<{ index: CodegenTypes.Int32 }>>
}

export default codegenNativeComponent<NativeProps>('NativeSegmentedControl')
