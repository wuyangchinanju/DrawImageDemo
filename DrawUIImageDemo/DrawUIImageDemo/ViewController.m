//
//  ViewController.m
//  DrawUIImageDemo
//
//  Created by 吴洋 on 16/4/1.
//  Copyright © 2016年 吴洋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [self saveToImage];
    
    UIImageView *imageView =  [[UIImageView alloc] initWithImage:image];
    
    [self.view addSubview:imageView];
    
    imageView.center = self.view.center;
    
}

- (UIImage *)saveToImage
{
    UIImage *image = [UIImage imageNamed:@"Anvdi.png"];
    
    CGSize size = [image size];
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height * 2));
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
    [image drawAtPoint:CGPointMake(0, size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (UIImage *)cgSaveToImage
{
    UIImage *image = [UIImage imageNamed:@"Anvdi.png"];
    
    CGSize size = [image size];
    
    CGImageRef imageLeft = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, size.width/2, size.height));
    
    CGImageRef imageRight = CGImageCreateWithImageInRect([image CGImage], CGRectMake(size.width/2, 0, size.width/2, size.height));
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width*1.5, size.height));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, 0, size.width/2, size.height), flip(imageLeft));
    
    CGContextDrawImage(context, CGRectMake(size.width, 0, size.width/2, size.height), flip(imageRight));
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return resultImage;
}

static inline CGImageRef flip (CGImageRef im)
{
    CGSize size = CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    
    UIGraphicsBeginImageContext(size);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height), im);
    
    CGImageRef result = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    
    UIGraphicsEndImageContext();
    
    return result;
}


@end
