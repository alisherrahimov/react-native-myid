
import Foundation
import MyIdSDK
import React

@objc(Myid)
class Myid: RCTEventEmitter {
  @objc
  static func constantsToExport() -> [String: Any] {
    return ["initialCount": 0]
  }
      
  @objc
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
      
  @objc
  override func supportedEvents() -> [String]! {
    return ["onSuccess", "onError", "onUserExited"]
  }
      
  @objc
  func startMyId(_ clientId: String, clientHash: String, clientHashId: String, language: String, type: String, passport: String, birthDate: String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      let config = MyIdConfig()
      config.clientId = clientId
      config.clientHash = clientHash
      config.clientHashId = clientHashId
      config.buildMode = type == "DEBUG" ? MyIdBuildMode.DEBUG : MyIdBuildMode.PRODUCTION
      config.locale = self.checkLang(lang: language)
      config.passportData = passport
      config.dateOfBirth = birthDate
      config.withPhoto = true
      config.entryType = MyIdEntryType.FACE

      MyIdClient.start(withConfig: config, withDelegate: self)
    }
  }
    
  func checkLang(lang: String) -> MyIdLocale {
    switch lang {
    case "UZ":
      return MyIdLocale.UZ
    case "RU":
      return MyIdLocale.RU
    case "EN":
      return MyIdLocale.EN
    case "KY":
      return MyIdLocale.KY
    default:
      return MyIdLocale.UZ
    }
  }
}

extension Myid: MyIdClientDelegate {
  func onSuccess(result: MyIdSDK.MyIdResult) {
    if let image = result.image {
      if let imageData = image.jpegData(compressionQuality: 1) { // Compression quality can be adjusted
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        sendEvent(withName: "onSuccess", body: ["code": result.code, "comparison": result.comparisonValue, "image": base64String])
      } else {
        // Handle failure to get image data
        sendEvent(withName: "onError", body: ["message": "Failed to convert image to Data", "code": 0])
      }
    } else {
      // Handle the case where there is no image
      sendEvent(withName: "onError", body: ["message": "No image available", "code": 0])
    }
  }
    
  func onError(exception: MyIdSDK.MyIdException) {
    sendEvent(
      withName: "onError",
      body: [
        "message": exception.message,
        "code": exception.code
      ]
    )
  }
    
  func onUserExited() {
    sendEvent(
      withName: "onUserExited",
      body: [
        "message": "exited"
      ]
    )
  }
}
