# React Native Charts Wrapper

This library is a React Native wrapper for popular native charting libraries [MPAndroidChart](https://github.com/PhilJay/MPAndroidChart) and [Charts](https://github.com/danielgindi/Charts).

## Introduction

Inspired by [react-native-mp-android-chart](https://github.com/mskec/react-native-mp-android-chart) and [react-native-ios-charts](https://github.com/Jpadilla1/react-native-ios-charts), React Native Charts Wrapper is built on MPAndroidChart (v3.1.0) and Charts (v3.3.0), supporting both Android and iOS platforms.

## Supported Chart Types

* Bar (Stack, Group)
* Line
* Scatter
* Bubble
* Pie
* Radar
* Combined
* CandleStick

## Setup

### Expo
1. `expo init demo`
2. `cd demo`
3. `expo install react-native-charts-wrapper`
4. `eas build`

### React Native
1. `npx react-native init demo`
2. `cd demo`
3. `npm install --save react-native-charts-wrapper`
4. `cd ios && pod install`
5. `npx react-native run-ios/run-android`

### Sample App.js

```javascript
import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View, 
  processColor
} from 'react-native';

import {LineChart} from 'react-native-charts-wrapper';

export default class App extends React.Component {
  render() {
    return (
      <View style={{flex: 1}}>
        <View style={styles.container}>
          <LineChart style={styles.chart}
            data={{dataSets:[{label: "demo", values: [{y: 1}, {y: 2}, {y: 1}]}]}}
          />
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF'
  },
  chart: {
    flex: 1
  }
});
```

## Usage

There are 8 supported chart types with numerous configuration options. Almost all configurations available in the base MPAndroidChart library are accessible through this wrapper. More details on available configurations can be found in their [wiki](https://github.com/PhilJay/MPAndroidChart/wiki).

Examples of how charts are used and how to apply configurations can be found in the example directory.

## Platform Conventions

Android and iOS have different conventions:

1. Color alpha values in Android range from 0-255, while in iOS they range from 0-1
2. Percentages in Android range from 0-100, while in iOS they range from 0-1
3. Animation duration in MPAndroidChart is measured in milliseconds, while in Charts it's measured in seconds
4. Enum case names always differ between platforms. For example, XAxisPosition in MPAndroidChart is BOTH_SIDED, while in Charts it's bothSided

**This library uses Android conventions**

**Always use `processColor()` to set colors**

## Data Format

- Complete Form:
```javascript
data: {
    ...
    dataSets: [
        {
            values: [
                {x: 5, y: 90},
                {x: 10, y: 130},
                {x: 50, y: 2000, marker: "eat more"},
                {x: 80, y: 9000, marker: "eat less"}
            ]
        },
        ...
    ]
}
```

The `marker` property is optional. If `x` is omitted, the index will be used instead.

- Simplified Form:
```javascript
data: {
    ...
    dataSets: [
        {
            values: [5, 40, 77, 81, 43]
        },
        ...
    ]
}
```

In this case, the index will be used as the x-value.

Check Example->TimeSeriesLineChart for more details.

## Supported Callbacks

**onSelect**

Triggered when a chart value is selected. The event passed back will include the coordinates of the touch as well as the data (including marker label) selected.

**onChange**

Triggered for various supported events on each platform. Due to the different nature of gesture handling on each platform and the different implementations of the underlying chart libraries, not all events are supported on every platform. For full details on the supported events, see the table below:

| Event Name | Description | iOS | Android |
| --------------- | -------- | ------- | ---- |
| `chartScaled`       | When a chart is scaled/zoomed via a pinch zoom gesture. | ✅ | ✅ |
| `chartTranslated`   | When a chart is moved/translated via a drag gesture. | ✅ | ✅ |
| `chartPanEnd`       | When a chart pan gesture ends. | ✅ | ❌ |
| `chartGestureStart` | When a chart gesture starts. | ❌ | ✅ |
| `chartGestureEnd`   | When a chart gesture ends. | ❌ | ✅ |
| `chartLongPress`    | When a chart is long pressed. | ❌ | ✅ |
| `chartSingleTap`    | When a chart is single tapped. | ❌ | ✅ |
| `chartFling`        | When a chart receives a fling gesture. | ❌ | ✅ |
| `doubleTapped`      | When a chart is double tapped. | ❌ | ✅ |

Check Example->MultipleChart for more details.

## Direct Function Calls

The library supports direct function calls. You can use functions like `chart.moveViewToX(...)` and others directly.

Check Example->MovingWindowChart for details.

Supported functions:

1. `highlights([...])`
   - Used to highlight entries programmatically, or clear already highlighted entries by passing an empty array: `highlights([])`

2. `moveViewTo/moveViewToX/moveViewToAnimated/centerViewTo/centerViewToAnimated`

3. `fitScreen`

4. `setDataAndLockIndex`
   - By default, charts rescale and move to the beginning of your data when new data is set. This behavior is not desirable when loading more data as users scroll.
   - `setDataAndLockIndex` maintains the x/y position and zoom level when you load more data.
   - Due to the implementation of MPAndroidChart, if `setDataAndLockIndex` is triggered by user dragging, the range of new data (xMax - xMin) should equal the original data range for accurate position transition. Otherwise, the chart may suddenly jump to another position.
   - This restriction only exists in Android; iOS does not have this limitation.
   - Check the example in InfiniteScrollLineChartScreen.

## Special Properties

Several additional properties are available:

1. `group`, `identifier`, `syncX`, and `syncY`
   - These properties are useful for implementing linked charts.
   - Charts will synchronize operations with other charts in the same group. All synchronization is handled at the native level.
   - Check the example in LinkageChartScreen.
   - Another method for synchronizing charts is to use the `onChange` callback, but performance may be poorer.
   - Check the example in MultipleChartScreen.
   - The stock kLine chart example combines the `group`, `identifier`, and `setDataAndLockIndex` features.

## Custom Marker Content

The library supports custom marker content. Check Example->TimeSeriesLineChart for details.

## Important Notes

**Chart Sizing**  
You can set charts to either fixed width and height or use `flex: 1` for responsive sizing.

## Conventional Commits

This project uses a specification called **Conventional Commits**, please **ensure** this specification is followed when commiting code to this project.

Guide: https://www.conventionalcommits.org/en/v1.0.0/

## Pull Requests, Approvals & Releases

###### Creating the develop release pull request

Pull Requests made to this project are required in order to merge to **develop** or **main**

When submitting a Pull Request, at least one approval is required before merging.

When constructing a release, ensure that a release branch is created based off of the contents of develop, the only changes contained within this branch should be the version numbers in **package.json**.

The Pull Request should be named as **[develop] release vX.Y.Z**

###### Creating the main release pull request

Once this Pull Request has been created, you will need to generate a new Pull Request based off **main** comparing the **develop** release branch you have just created, this should ensure that all changes that have been made to **develop** since the last release are contained within this update.

The Pull Request should be named as **[main] release vX.Y.Z**

###### Creating the release tag

Once this has been done and both Pull Requests have been merged, a release tag should be generated, named as **vX.Y.Z**

## License
The MIT License

Copyright (c) 2017 wuxudong

Copyright (c) 2016 Martin Skec

Copyright (c) 2016 Jose E. Padilla

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
