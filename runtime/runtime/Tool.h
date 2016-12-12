//
//  Tool.h
//  runtime
//
//  Created by ZhouYong on 16/4/16.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (instancetype)sharedManager;

- (NSString *)changeMethod;
- (void)addCount;
@end
