//
//  threeViewController.m
//  runtime
//
//  Created by ZhouYong on 16/4/13.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//

#import "threeViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface threeViewController ()

@property (nonatomic, strong) Person *person;
@property (weak, nonatomic) IBOutlet UITextField *textview;

@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person new];
    
    NSLog(@"%@",_person.sayName);
    
    NSLog(@"%@",_person.saySex);
    
    Method m1 = class_getInstanceMethod([self.person class], @selector(sayName));
    Method m2 = class_getInstanceMethod([self.person class], @selector(saySex));
    
    method_exchangeImplementations(m1, m2);
    
    [self exchange_Method];
}

- (IBAction)sayName:(id)sender {
    
    self.textview.text = [_person sayName];
    
}
- (IBAction)saySex:(id)sender {
    
    self.textview.text = [_person saySex];;
}



#pragma mark 方法交换
- (void)exchange_Method1
{
    NSLog(@"exchange_Method1");
}
- (void)exchange_Method2
{
    NSLog(@"exchange_Method2");
}

/**
 交换方法:黑魔法(移魂大法)   注意: 交换方法之后，以后每次调用这两个方法都会交换方法的实现
 */
- (void)exchange_Method
{
    objc_msgSend(self, @selector(exchange_Method1));
    //    2016-12-12 17:44:37.283 Runtime[4463:285682] exchange_Method1
    
    Method mtd1 = class_getInstanceMethod([self class], @selector(exchange_Method1));
    Method mtd2 = class_getInstanceMethod([self class], @selector(exchange_Method2));
    method_exchangeImplementations(mtd1, mtd2);
    objc_msgSend(self, @selector(exchange_Method1));
    //    2016-12-12 17:44:37.284 Runtime[4463:285682] exchange_Method2
}



@end
