//
//  oneViewController.m
//  runtime
//
//  Created by ZhouYong on 16/4/13.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//

#import "oneViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "Movie.h"
@interface oneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (nonatomic, strong) Person *person;
@end

@implementation oneViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"真的viewWillAppear方法被调用了...");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [Person new];
    _person.name = @"xiaoming";
    NSLog(@"XiaoMing first answer is %@",self.person.name);
    
   
    
}


- (void)sayName
{
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *proname = [NSString stringWithUTF8String:varName];
        
        if ([proname isEqualToString:@"_name"]) {   //这里别忘了给属性加下划线
            object_setIvar(self.person, var, @"daming");
            break;
        }
    }
    NSLog(@"XiaoMing change name  is %@",self.person.name);
    self.textfield.text = self.person.name;
    
}

- (IBAction)changename:(UIButton *)sender {
    [self sayName];
    NSLog(@"%@",self.person.name);
    
    
}

@end
