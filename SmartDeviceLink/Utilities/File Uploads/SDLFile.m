//
//  SDLFile.m
//  SmartDeviceLink-iOS
//
//  Created by Joel Fischer on 10/14/15.
//  Copyright © 2015 smartdevicelink. All rights reserved.
//

#import "SDLFile.h"

#import "SDLFileManager.h"
#import "SDLFileType.h"


NS_ASSUME_NONNULL_BEGIN

@interface SDLFile ()

@property (copy, nonatomic, readwrite, nullable) NSURL *fileURL;
@property (copy, nonatomic, readwrite) NSData *data;

@property (strong, nonatomic, readwrite) SDLFileType fileType;
@property (assign, nonatomic, readwrite) BOOL persistent;
@property (copy, nonatomic, readwrite) NSString *name;

@end


@implementation SDLFile

#pragma mark - Lifecycle

- (instancetype)initWithFileURL:(NSURL *)url name:(NSString *)name persistent:(BOOL)persistent {
    self = [super init];
    if (!self) {
        return nil;
    }

    BOOL exists = url.isFileURL && [url checkResourceIsReachableAndReturnError:nil];
    if (!exists) {
        return nil;
    }

    _fileURL = url;
    _data = [NSData data];
    _name = name;
    _persistent = persistent;
    _fileType = [self.class sdl_fileTypeFromFileExtension:url.pathExtension];
    _overwrite = NO;

    return self;
}

+ (instancetype)persistentFileAtFileURL:(NSURL *)url name:(NSString *)name {
    return [[self alloc] initWithFileURL:url name:name persistent:YES];
}

+ (instancetype)fileAtFileURL:(NSURL *)url name:(NSString *)name {
    return [[self alloc] initWithFileURL:url name:name persistent:NO];
}

- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileExtension:(NSString *)extension persistent:(BOOL)persistent {
    self = [super init];
    if (!self) {
        return nil;
    }
    if (data.length == 0) {
        return nil;
    }

    _fileURL = nil;
    _data = data;
    _name = name;
    _persistent = persistent;
    _fileType = [self.class sdl_fileTypeFromFileExtension:extension];
    _overwrite = NO;

    return self;
}

+ (instancetype)persistentFileWithData:(NSData *)data name:(NSString *)name fileExtension:(NSString *)extension {
    return [[self alloc] initWithData:data name:name fileExtension:extension persistent:YES];
}

+ (instancetype)fileWithData:(NSData *)data name:(NSString *)name fileExtension:(NSString *)extension {
    return [[self alloc] initWithData:data name:name fileExtension:extension persistent:NO];
}


#pragma mark - Getters

- (NSData *)data {
    if (_data.length == 0 && _fileURL != nil) {
        _data = [NSData dataWithContentsOfURL:_fileURL];
    }

    return _data;
}


#pragma mark - File Type

+ (SDLFileType)sdl_fileTypeFromFileExtension:(NSString *)fileExtension {
    if ([fileExtension caseInsensitiveCompare:@"bmp"] == NSOrderedSame) {
        return SDLFileTypeBMP;
    } else if (([fileExtension caseInsensitiveCompare:@"jpg"] == NSOrderedSame) ||
               ([fileExtension caseInsensitiveCompare:@"jpeg"] == NSOrderedSame)) {
        return SDLFileTypeJPEG;
    } else if ([fileExtension caseInsensitiveCompare:@"png"] == NSOrderedSame) {
        return SDLFileTypePNG;
    } else if ([fileExtension caseInsensitiveCompare:@"wav"] == NSOrderedSame) {
        return SDLFileTypeWAV;
    } else if ([fileExtension caseInsensitiveCompare:@"mp3"] == NSOrderedSame) {
        return SDLFileTypeMP3;
    } else if ([fileExtension caseInsensitiveCompare:@"aac"] == NSOrderedSame) {
        return SDLFileTypeAAC;
    } else if ([fileExtension caseInsensitiveCompare:@"json"] == NSOrderedSame) {
        return SDLFileTypeJSON;
    } else {
        return SDLFileTypeBinary;
    }
}


#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[self.class allocWithZone:zone] initWithFileURL:_fileURL name:_name persistent:_persistent];
}

@end

NS_ASSUME_NONNULL_END
