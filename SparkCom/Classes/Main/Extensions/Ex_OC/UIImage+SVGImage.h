//
//  UIImage+SVGImage.h
//  SparkBase
//
//  Created by Apple on 2022/7/15.
//  Copyright © 2022 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SVGImage)

/**
 show svg image
 @param name svg name
 @return svg image
 */
+ (UIImage *)br_svgImageNamed:(NSString *)name;

/**
 show svg image
 @param name svg name
 @param size image size
 @return svg image
 */
+ (UIImage *)br_svgImageNamed:(NSString *)name size:(CGSize)size;

/**
 show svg image
 @param name       svg name
 @param size       image size
 @param tintColor  image color
 @return svg image
 */
+ (UIImage *)br_svgImageNamed:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
