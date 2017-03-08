//  SDLSyncMsgVersion.h
//


#import "SDLRPCMessage.h"

/**
 * Specifies the version number of the SDL V4 interface. This is used by both the application and SDL to declare what interface version each is using.
 * 
 * @since SDL 1.0
 */

NS_ASSUME_NONNULL_BEGIN

@interface SDLSyncMsgVersion : SDLRPCStruct

// TODO: (Alex M.)[2016-12-1] Change from NSInteger to UInt8
- (instancetype)initWithMajorVersion:(NSInteger)majorVersion minorVersion:(NSInteger)minorVersion;

/**
 * @abstract The major version indicates versions that is not-compatible to previous versions
 * 
 * Required, Integer, 1 - 10
 */
@property (strong, nonatomic) NSNumber<SDLInt> *majorVersion;
/**
 * @abstract The minor version indicates a change to a previous version that should still allow to be run on an older version (with limited functionality)
 * 
 * Required, Integer, 0 - 1000
 */
@property (strong, nonatomic) NSNumber<SDLInt> *minorVersion;

@end

NS_ASSUME_NONNULL_END
