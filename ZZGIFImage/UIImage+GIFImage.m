//
//  UIImage+GIFImage.m
//  Xcode8Demo
//
//  Created by macuser on 17/3/14.
//  Copyright © 2017年 macuser. All rights reserved.
//

#import "UIImage+GIFImage.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UIImage (GIFImage)

+ (UIImage *)gifImageNamed:(NSString *)name {
    
    return [self animatedGifImage:[UIImage imageNamed:name]];
    
}

+ (UIImage *)gifImageWithContentsOfFile:(NSString *)path {
    
    return [self animatedGifImage:[UIImage imageWithContentsOfFile:path]];
    
}

+ (UIImage *)gifImageWithData:(NSData *)data {
    
    return [self animatedGifImage:[UIImage imageWithData:data]];
    
}

+ (UIImage *)animatedGifImage:(UIImage *)image {
    
    if (image == nil) {
        return nil;
    }
    
    // 获取GIF图片的数量
    size_t count = image.images.count;
    // 如果图片个数为1或者小于1，那么此图片不是GIF图片，直接返回
    if (count <= 1) {
        return image;
    }
    
    // 创建GIFImage对象，用来保存最终的结果
    UIImage *gifImage = nil;
    
    // 创建一个用来保存最终GIF图像的数据源
    NSMutableData *mulData = [NSMutableData data];
    // 创建一个图像目的地，用来写入GIF的多张图片
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)mulData, kUTTypeGIF, count, NULL);
    // 给图像目的地设置属性
    NSDictionary *properties = @{(__bridge NSString *)kCGImagePropertyGIFDictionary:@{
                                         (__bridge NSString *)kCGImagePropertyGIFLoopCount:@5}};
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)properties);
    
    // 把每一张图片数据添加到图像目的地
    for (size_t i = 0; i < count; i++) {
        
        CGImageDestinationAddImage(destination, [image.images objectAtIndex:i].CGImage, NULL);
        
    }
    
    // 确定图片目的地不能够再添加图片数据
    CGImageDestinationFinalize(destination);
    
    // 释放图像目的地对象
    CFRelease(destination);
    
    // 获取最终的GIF图像对象
    gifImage = [UIImage imageWithData:mulData];
    
    return gifImage;
    
}

@end
