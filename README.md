# native-segmented-control

[![npm](https://img.shields.io/npm/v/native-segmented-control.svg)](https://www.npmjs.com/package/native-segmented-control) [![license](https://img.shields.io/npm/l/native-segmented-control.svg)](https://github.com/AnishSapre/native-segmented-control/blob/main/LICENSE)

**npm:** [native-segmented-control](https://www.npmjs.com/package/native-segmented-control) · **GitHub:** [AnishSapre/native-segmented-control](https://github.com/AnishSapre/native-segmented-control)

Apple's `UISegmentedControl` for React Native's New Architecture. On iOS 26 it is the
system **liquid glass** segmented control, with the sliding glass selection and press
feedback.

## Requirements

- React Native 0.76+ with the **New Architecture** (Fabric). This is a Fabric component;
  it has no old-architecture (Paper) implementation.
- **iOS only.** On Android the component renders nothing, so check `isAvailable` (or
  `Platform.OS`) and render your own fallback there.
- The liquid glass look needs **iOS 26+** (built with the iOS 26 SDK or later). On earlier
  iOS you get the classic system look. `hasLiquidGlass` tells you which one is showing.

## Install

```sh
npm install native-segmented-control
cd ios && pod install
```

Then rebuild the app (a Metro reload is not enough for new native code).

## Usage

```tsx
import { SegmentedControl } from 'native-segmented-control'

const [index, setIndex] = useState(0)

<SegmentedControl
  values={['Active', 'Completed']}
  selectedIndex={index}
  onChange={setIndex}
  selectedSegmentTintColor="#4D2E97"
  selectedTextColor="#FFFFFF"
/>
```

| Prop | Type | |
|---|---|---|
| `values` | `string[]` | Segment titles |
| `selectedIndex` | `number` | Controlled selection |
| `onChange` | `(index) => void` | User picked a segment |
| `selectedSegmentTintColor` | colour | Fill of the selected segment (system default if unset) |
| `textColor` / `selectedTextColor` | colour | Title colours |
| `colorScheme` | `'light' \| 'dark' \| 'system'` | Default `'system'` |
| `style` | ViewStyle | Default height 32 |
| `testID` | `string` | |

## How it works

A small Fabric component wraps Apple's own UIKit control, so iOS draws and animates it.
React Native's codegen builds the bridge from the TypeScript spec in
`src/*NativeComponent.ts` during `pod install`.

## Related packages

Native iOS controls for React Native (New Architecture), with liquid glass on iOS 26:

- [native-tab-bar](https://github.com/AnishSapre/native-tab-bar) ([npm](https://www.npmjs.com/package/native-tab-bar)): Apple's UITabBar (iOS 26 liquid glass tab bar) with a React Navigation adapter
- [native-glass-button](https://github.com/AnishSapre/native-glass-button) ([npm](https://www.npmjs.com/package/native-glass-button)): iOS 26 liquid glass buttons and menus
- [native-slider](https://github.com/AnishSapre/native-slider) ([npm](https://www.npmjs.com/package/native-slider)): Apple's UISlider

## License

MIT © Anish Sapre
