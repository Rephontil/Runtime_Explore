//
//  HGUser.h
//  runtime
//
//  Created by ZhouYong on 16/4/12.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, strong) NSString *uid;
@end
