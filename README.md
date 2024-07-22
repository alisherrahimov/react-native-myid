# react-native-myid

This package is a react-native module for MyID

## Installation

```sh
npm install react-native-myid
```
## Setting up on Android
```sh
////
AndroidManifest.xml:

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />

////

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
////
Info.plist:

<key>NSCameraUsageDescription</key>
<string>Required for document and facial capture</string>

////

pod install


```

## Usage


```js
import { startMyId, useListener } from 'react-native-myid';

// ...

const App = ()=>{
  const {code,error,success} = useListener()
  if(success){
    console.log(code)
  }else{
    console.log(error)
  }

  return(
      <View>
        <Button title="start myid" onPress={()=>{
            startMyId(
            client_id // 
            clientHash //
            clientHashId //
            language // "EN" "UZ" "RU" "KY"
            type? // "DEBUG" "PRODUCTION"
          )
        }} />
      <View/>
  )

}


```





## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
