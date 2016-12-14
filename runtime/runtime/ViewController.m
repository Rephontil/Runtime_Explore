//
//  ViewController.m
//  runtime
//
//  Created by ZhouYong on 16/4/11.
//  Copyright © 2016年 ZhouYong/Rephontil. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "Movie.h"

@interface ViewController ()
@property (nonatomic, retain) NSMutableArray *allDataArray;
@end

@implementation ViewController

#define STRING_MACRO(A)   NSLog(@"%@",A)


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"welcome to read!");
    
}

- (IBAction)click:(id)sender {
    
    TableViewController *tabvc = [TableViewController new];
    
    [self.navigationController pushViewController:tabvc animated:YES];
}




@end
