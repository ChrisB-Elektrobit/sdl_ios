//  SDLSyncMsgVersion.h
//


#import "SDLRPCMessage.h"

/**
 * Specifies the version number of the SDL V4 interface. This is used by both the application and SDL to declare what interface version each is using.
 * 
 * @since SDL 1.0
 */
@interface SDLSyncMsgVersion : SDLRPCStruct {
}

/**
 * @abstract Constructs a newly allocated SDLSyncMsgVersion object
 */
- (instancetype)init;

/**
 * @abstract Constructs a newly allocated SDLSyncMsgVersion object indicated by the dictionary parameter
 * @param dict The dictionary to use
 */
- (instancetype)initWithDictionary:(NSMutableDictionary *)dict;

// TODO: (Alex M.)[2016-12-1] Change from NSInteger to UInt8
- (instancetype)initWithMajorVersion:(NSInteger)majorVersion minorVersion:(NSInteger)minorVersion __deprecated_msg("Use initWithMajorVersion:minorVersion:patchVersion: instead");

- (instancetype)initWithMajorVersion:(NSInteger)majorVersion minorVersion:(NSInteger)minorVersion patchVersion:(NSInteger)patchVersion;

/**
 * @abstract The major version indicates versions that is not-compatible to previous versions
 * 
 * Required, Integer, 1 - 10
 */
@property (strong) NSNumber *majorVersion;
/**
 * @abstract The minor version indicates a change to a previous version that should still allow to be run on an older version (with limited functionality)
 * 
 * Required, Integer, 0 - 1000
 */
@property (strong) NSNumber *minorVersion;

/**
 * @abstract Optional, allows backward-compatible fixes to the API without increasing the minor version of the interface
 *
 */
@property (strong) NSNumber *patchVersion;

@end
