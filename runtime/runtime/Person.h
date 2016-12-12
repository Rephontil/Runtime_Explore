//
//  Person.h
//  runtime
//
//  Created by ZhouYong on 16/4/16.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *sex;
-(NSString *)sayName;
-(NSString *)saySex;
@end
