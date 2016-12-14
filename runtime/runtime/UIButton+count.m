//
//  UIButton+count.m
//  runtime
//
//  Created by ZhouYong on 16/4/16.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//  攔截并且替換方法。  注意：方法替换分为类方法和实例方法。对应于两个不同的函数哦😄，注意哦。

#import "UIButton+count.h"
#import "Tool.h"
@implementation UIButton (count)


/**
 load方法会在类第一次加载的时候被调用,调用的时间比较靠前，适合在这个方法里做方法交换,方法交换应该被保证，在程序中只会执行一次。
 */
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
    
        //源方法的SEL和Method
        SEL oriSEL = @selector(sendAction:to:forEvent:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
//        以上三行代碼可直接簡單寫成下面這樣
//        class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
        
//        交换方法的SEL和Method
        SEL cusSEL = @selector(mySendAction:to:forEvent:);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        // 添加成功：将源方法的实现替换到交换方法的实现
        if (addSucc) {
            
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
            
        }else {  //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
            
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
        
    });
}


- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [[Tool sharedManager] addCount];
    [self mySendAction:action to:target forEvent:event];
    
    
}

@end
