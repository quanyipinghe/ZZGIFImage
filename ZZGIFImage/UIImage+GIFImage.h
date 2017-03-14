//
//  UIImage+GIFImage.h
//  Xcode8Demo
//
//  Created by macuser on 17/3/14.
//  Copyright © 2017年 macuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIFImage)

+ (nullable UIImage *)gifImageNamed:(NSString * _Nullable)name;

+ (nullable UIImage *)gifImageWithContentsOfFile:(NSString * _Nullable)path;

+ (nullable UIImage *)gifImageWithData:(NSData * _Nullable)data;

@end
