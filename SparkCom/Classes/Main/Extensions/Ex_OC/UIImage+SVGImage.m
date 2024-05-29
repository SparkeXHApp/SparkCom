//
//  UIImage+SVGImage.m
//  SparkBase
//
//  Created by Apple on 2022/7/15.
//  Copyright © 2022 Spark. All rights reserved.
//

#import "UIImage+SVGImage.h"
#import <SVGKit/SVGKImage.h>

@implementation UIImage (SVGImage)

/**
 show svg image
 
 @param name svg name
 @return svg image
 */
+ (UIImage *)br_svgImageNamed:(NSString *)name {
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    return svgImage.UIImage;
}

/**
 show svg image
 
 @param name svg name
 @param size image size
 @return svg image
 */
+ (UIImage *)br_svgImageNamed:(NSString *)name size:(CGSize)size {
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    svgImage.size = size;
    return svgImage.UIImage;
}

/**
 show svg image
 
 @param name       svg name
 @param size       image size
 @param tintColor  image color
 @return svg image
 */
+ (UIImage *)br_svgImageNamed:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor {
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    svgImage.size = size;
    CGRect rect = CGRectMake(0, 0, svgImage.size.width, svgImage.size.height);
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.UIImage.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast || alphaInfo == kCGImageAlphaNoneSkipFirst || alphaInfo == kCGImageAlphaNone;
    UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, svgImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, svgImage.UIImage.CGImage);
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}


@end
