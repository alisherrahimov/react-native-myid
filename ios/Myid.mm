
#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"


@interface RCT_EXTERN_MODULE(Myid, RCTEventEmitter)

RCT_EXTERN_METHOD(startMyId:
                  (NSString *) clientId
                  clientHash: (NSString *)clientHash
                  clientHashId: (NSString *)clientHashId
                  language: (NSString *)language
                  type: (NSString *)type
                  passport: (NSString *)passport
                  birthDate: (NSString *)birthDate
)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
