# react-native-myid

This package is a react-native module for MyID

## Installation

```sh
npm install react-native-myid
```
## Setting on Android
```sh

buildscript {
  ext {
    buildToolsVersion = "34.0.0"
    minSdkVersion = 23
    compileSdkVersion = 34
    targetSdkVersion = 34
    ndkVersion = "26.1.10909125"
    kotlinVersion = "1.9.22"
  }
  repositories {
    google()
    mavenCentral()
  }
  dependencies {
    classpath("com.android.tools.build:gradle")
    classpath("com.facebook.react:react-native-gradle-plugin")
    classpath("org.jetbrains.kotlin:kotlin-gradle-plugin")
  }
}

allprojects {
  repositories {
    // add this line
  +  maven { url "https://artifactory.aigroup.uz:443/artifactory/myid" }
  }
}

apply plugin: "com.facebook.react.rootproject"


```
## Setting on IOS
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
