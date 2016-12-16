//
//  EightViewController.m
//  runtime
//
//  Created by ZhouYong on 16/4/14.
//  Copyright © 2016年 SF. All rights reserved.
// runtime实现的自定义对象存储

#import "EightViewController.h"
#import "Movie.h"

@interface EightViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textfield;


@end

@implementation EightViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"runtime_movie"];
    
//    Movie這個自定義對象通過runtime实现的实现归档
    Movie *movie = [Movie new];
    NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    movie = array[0];
    NSLog(@"movie.pic_url:--->%@",movie.pic_url);
    self.label.text = movie.pic_url;

}

- (IBAction)storeClick:(id)sender {
    
    Movie *movie = [Movie new];
    movie.pic_url = self.textfield.text;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"runtime_movie"];
    NSArray *array = @[movie];
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    
    NSArray *array1= [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    movie = array1[0];
    self.label.text = movie.pic_url;
}




@end










