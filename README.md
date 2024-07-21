# react-native-myid

This package is a react-native module for MyID

## Installation

```sh
npm install react-native-myid
```
## Setting up on Android
```sh

buildscript {

...

allprojects {
  repositories {
    // add this line
  +  maven { url "https://artifactory.aigroup.uz:443/artifactory/myid" }
  }
}

apply plugin: "com.facebook.react.rootproject"


```
## Setting up on IOS
```sh
pod install
```

## Usage


```js
import { startMyId } from 'react-native-myid';

// ...

startMyId(
    client_id // 
    clientHash //
    clientHashId //
    language // "EN" "UZ" "RU" "KY"
    type? // "DEBUG" "PRODUCTION"
)
```





## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
