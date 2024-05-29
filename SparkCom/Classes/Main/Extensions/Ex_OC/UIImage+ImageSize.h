//
//  UIImage+ImageSize.h
//  SparkBase
//
//  Created by sfh on 2022/8/16.
//  Copyright © 2022 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageSize)

+ (CGSize)getImageSizeWithURL:(id)imageURL;

@end

NS_ASSUME_NONNULL_END
