//
//  SIPackageOperator.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 20.5.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SIPackageMO;

@interface SIPackageOperator : NSObject

+ (SIPackageOperator *)sharedOperator;
- (BOOL)expandPackage:(SIPackageMO *)aPackage;
- (BOOL)copyPackage:(SIPackageMO *)aPackage;
- (BOOL)extractPackagePayload:(SIPackageMO *)aPackage;

@end
