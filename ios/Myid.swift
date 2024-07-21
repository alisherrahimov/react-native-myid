
import Foundation
import MyIdSDK
import React

@objc(Myid)
class Myid: RCTEventEmitter, MyIdClientDelegate {
    func onSuccess(result: MyIdSDK.MyIdResult) {
        sendEvent(
            withName: "onSuccess",
            body: [
              "code": result.code,
              "comparison": result.comparisonValue
            ]
          )
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
    

//  @objc(multiply:withB:withResolver:withRejecter:)
//  func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
//    resolve(a*b)
//  }
    @objc
      static func constantsToExport() -> [String: Any]{
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
    func startMyId(_ clientId:String, clientHash:String, clientHashId:String, language:String, type:String) {
          print(clientId,"call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
         let config = MyIdConfig()
            config.clientId=clientId
            config.clientHash=clientHash
            config.clientHashId=clientHashId
            config.buildMode = type=="DEBUG" ? MyIdBuildMode.DEBUG : MyIdBuildMode.PRODUCTION
            config.locale = self.checkLang(lang: language)
            
            MyIdClient.start(withConfig: config, withDelegate: self)
        })
         
      }
    
    func checkLang(lang:String)->MyIdLocale{
        switch(lang){
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

