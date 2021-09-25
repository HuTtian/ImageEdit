//
//  SSPFileUtil.m
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/24.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "SSPFileUtil.h"
#import <sys/file.h>
#import <sys/stat.h>
#import <dirent.h>

const static NSErrorDomain SSPFileCreateFailDomain   = @"SSPFileCreateFailDomain";
const static NSErrorDomain SSPFileNotExistDomain     = @"SSPFileNotExistDomain";
const static NSErrorDomain SSPFileNotBackupDomain    = @"SSPFileNotBackupDomain";
const static NSErrorDomain SSPFileReadFailedDomain   = @"SSPFileReadFailedDomain";
const static NSErrorDomain SSPFileDeleteFailedDomain = @"SSPFileDeleteFailedDomain";

@implementation SSPFileUtil

#pragma mark - Public Methods
+ (BOOL)fileExist:(NSString *)filePath {
    if (filePath.length <= 0) {
        if (SSPMacroConfigureM.infoLogBlock) {
            SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileNotExistDomain code:-1 userInfo:nil]);
        }
        return NO;
    }
    
    struct stat temp;
    return lstat(filePath.UTF8String, &temp) == 0;
}

+ (BOOL)createPath:(NSString *)path{
    if (![SSPFileUtil fileExist:path]) {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        if (nil == fileMgr) return NO;
        
        // path is not null && is not '/'
        NSError *error;
        if (path.length > 1 && ![fileMgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            if (SSPMacroConfigureM.infoLogBlock) {
                SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileCreateFailDomain code:-1 userInfo:nil]);
            }
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL)createFile:(NSString *)filePath {
    BOOL bCreated = NO;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    do {
        if (nil == fileMgr) break;
        
        if (![fileMgr fileExistsAtPath:filePath]) {
            // create file
            if ([fileMgr createFileAtPath:filePath contents:nil attributes:nil]) {
                bCreated = YES;
                break;
            }
            
            // create path
            NSString *nsPath = [filePath stringByDeletingLastPathComponent];
            
            // path is not null && is not '/'
            NSError *error;
            if (nsPath.length > 1 && ![fileMgr createDirectoryAtPath:nsPath withIntermediateDirectories:YES attributes:nil error:&error]) {
                if (SSPMacroConfigureM.infoLogBlock) {
                    SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileCreateFailDomain code:-1 userInfo:nil]);
                }
                break;
            }
            
            // create file
            if (![fileMgr createFileAtPath:filePath contents:nil attributes:nil]) {
                if (SSPMacroConfigureM.infoLogBlock) {
                    SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileCreateFailDomain code:-1 userInfo:nil]);
                }
                break;
            }
        }
        bCreated = YES;
    } while(NO);
    
    return bCreated;
}

+ (long long)getFileSize:(NSString *)path {
    struct stat temp;
    if (lstat(path.UTF8String, &temp) == 0) {
        return temp.st_size;
    }
    return -1;
}

+ (NSString *)getTmpPath {
    return NSTemporaryDirectory();
}

static NSString *kDocPath = nil;
+ (NSString *)getDocPath {
    if (nil == kDocPath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        kDocPath = (NSString *)paths.firstObject;
    }
    return kDocPath;
}

static NSString *kLibraryCachePath = nil;
+ (NSString *)getLibraryCachePath{
    if (nil == kLibraryCachePath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *nsLibraryPath = (NSString *)paths.firstObject;
        if (nsLibraryPath.length > 0) {
            kLibraryCachePath = nsLibraryPath;
            if (![SSPFileUtil fileExist:kLibraryCachePath]) {
                [SSPFileUtil createPath:kLibraryCachePath];
                [SSPFileUtil setDoNotBackupForPath:kLibraryCachePath];
            } else {
                BOOL bIsNotBackup = [SSPFileUtil isNotBackupPath:kLibraryCachePath];
                if (SSPMacroConfigureM.infoLogBlock) {
                    SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileNotBackupDomain code:-2 userInfo:nil]);
                }
                if (!bIsNotBackup) {
                    [SSPFileUtil setDoNotBackupForPath:kLibraryCachePath];
                }
            }
        }
    }
    return kLibraryCachePath;
}

static NSString *kSystemCachePath = nil;
+ (NSString *)getSystemCachePath {
    if (nil == kSystemCachePath) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        if (path.length > 0) {
            kSystemCachePath = [[NSString alloc] initWithString:path];
            if (![SSPFileUtil fileExist:kSystemCachePath]) {
                [SSPFileUtil createPath:kSystemCachePath];
            }
        }
    }
    return kSystemCachePath;
}

+ (NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path {
    if (![self fileExist:path]) {
        return [NSArray array];
    }
    NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        if (SSPMacroConfigureM.infoLogBlock) {
            SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileReadFailedDomain code:-1 userInfo:nil]);
        }
        return [NSArray array];
    }

    return files;
}

+ (BOOL)removeItemAtPath:(NSString *)path{
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (error) {
        if (SSPMacroConfigureM.infoLogBlock) {
            SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileDeleteFailedDomain code:-1 userInfo:nil]);
        }
        return NO;
    }
    return YES;
}

+ (void)safeUnarchive:(NSString *)path {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id temp = nil;
        if (![SSPFileUtil fileExist:path]) {
            if (SSPMacroConfigureM.infoLogBlock) {
                SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileNotExistDomain code:-2 userInfo:nil]);
            }
        }
        @try {
            int64_t n64FileSize = [SSPFileUtil getFileSize:path];
            
            // 大于1mb就不走read data，免得爆内存
            if (n64FileSize > 1024 * 1024) {
                temp = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            } else {
                NSError *error = nil;
                // 使用NSDataReadingUncached，数据将不会存入内存中，对于只会使用一次的数据，这么做会提高性能。
                NSData *dtTemp = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
                
                if (error != nil) {
                    if (SSPMacroConfigureM.infoLogBlock) {
                        SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileReadFailedDomain code:-1 userInfo:nil]);
                    }
                }
                
                if ([dtTemp length] == 0) {
                    if (SSPMacroConfigureM.infoLogBlock) {
                        SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:@"dtTemp is nil" code:-1 userInfo:nil]);
                    }
                } else {
                    temp = [NSKeyedUnarchiver unarchiveObjectWithData:dtTemp];
                }
            }
        } @catch (NSException *exception) {
            if (SSPMacroConfigureM.infoLogBlock) {
                SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileReadFailedDomain code:-1 userInfo:nil]);
            }
        }
    });
}

+ (void)safeUnarchiveFromData:(NSData *)data {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id temp = nil;
        if (data) {
            @try {
                temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            } @catch (NSException *exception) {
                if (SSPMacroConfigureM.infoLogBlock) {
                    SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileCreateFailDomain code:-1 userInfo:nil]);
                }
            }
        }
    });
}

#pragma mark - Private Methods
+ (BOOL)isNotBackupPath:(NSString *)path {
    NSURL *url= [NSURL fileURLWithPath:path];
    NSError *error = nil;
    NSNumber *value = nil;
    BOOL success = [url getResourceValue:&value forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (!success) {
        if (SSPMacroConfigureM.infoLogBlock) {
            SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileNotBackupDomain code:-1 userInfo:nil]);
        }
    }
    return value.boolValue;
}

// 标记不备份到icloud
+ (BOOL)setDoNotBackupForPath:(NSString *)path {
    NSURL *url= [NSURL fileURLWithPath:path];
    NSError *error = nil;
    NSNumber *value = @(YES);
    BOOL success = [url setResourceValue:value forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (!success) {
        if (SSPMacroConfigureM.infoLogBlock) {
            SSPMacroConfigureM.infoLogBlock([NSError errorWithDomain:SSPFileNotBackupDomain code:-1 userInfo:nil]);
        }
    }
    return success;
}

@end
