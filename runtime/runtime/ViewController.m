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
#define kMovieListURL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php"
@interface ViewController ()
@property (nonatomic, retain) NSMutableArray *allDataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"welcome to read!");
    
}

- (IBAction)click:(id)sender {
    
    TableViewController *tabvc = [TableViewController new];
    
    [self.navigationController pushViewController:tabvc animated:YES];
}




@end
