//
//  Movie.m
//  runtime
//
//  Created by ZhouYong on 16/4/11.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//  自动归档和解档的宏

#import "Movie.h"
#import <objc/runtime.h>

/**
 通过runtime运行时技术对模型进行归档操作，速度快、简洁方便。
 
 @param A 需要进行归档的类名
 @return - (void)encodeWithCoder:(NSCoder *)encoder  方法内部的实现代码
 
 */
#define encodeRuntime(A) \
\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [self valueForKey:key];\
[encoder encodeObject:value forKey:key];\
}\
free(ivars);\
\


/**
 通过runtime运行时技术对模型进行归档操作，速度快、简洁方便。
 
 @param A 需要进行归档的类名
 @return - (id)initWithCoder:(NSCoder *)decoder
 
 */
#define initCoderRuntime(A) \
\
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [decoder decodeObjectForKey:key];\
[self setValue:value forKey:key];\
}\
free(ivars);\
}\
return self;\
\

@implementation Movie


- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([Movie class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
        
    }
    
    free(ivars);
    
}

#pragma mark 現在评估使用的方法为：  - (void)encodeWithCoder:(NSCoder *)aCoder  要将宏定义里面的encoder－－－>aCoder
/*
#pragma mark  使用runtime,結合宏定義,直接用一行代碼解決掉。
- (void)encodeWithCoder:(NSCoder *)encoder
{
    encodeRuntime(Movie)
}
*/



- (id)initWithCoder:(NSCoder *)decoder

{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Movie class], &count);
        
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
            
        }
        free(ivars);
        
    }
    return self;
}

/*
#pragma mark  使用runtime,結合宏定義,直接用一行代碼解決掉。
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    initCoderRuntime(Movie)
}
*/



#pragma mark  不光归档自身的属性，还要循环把所有父类的属性也找出来。视情况选择不同的方法吧😄😄
/*
- (void)tuc_initWithCoder:(NSCoder *)aDecoder {
    // 不光归档自身的属性，还要循环把所有父类的属性也找出来
    Class selfClass = self.class;
    while (selfClass &&selfClass != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(selfClass, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 如果有实现忽略属性的方法
            if ([self respondsToSelector:@selector(ignoredProperty)]) {
                // 就跳过这个属性
                if ([[self ignoredProperty] containsObject:key]) continue;
            }
            
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }
    
}
*/



- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--%@", _movieName, _movieId, _pic_url, _user];
}


//如果用系统的方法字典转模型，一定要实现这个方法
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    
//}
@end
