//
//  UIImage+Image.m
//  MovingAnnotation
//
//  Created by ZeroJianMBP on 16/8/11.
//  Copyright © 2016年 ZeroJian. All rights reserved.
//

#import "UIImage+Image.h"
#import <Photos/Photos.h>

@implementation UIImage (Image)


- (UIImage*)zj_imageRotatedByAngle:(CGFloat)Angle
{
  
  CGFloat width = CGImageGetWidth(self.CGImage);
  CGFloat height = CGImageGetHeight(self.CGImage);
  
  CGSize rotatedSize;
  
  rotatedSize.width = width;
  rotatedSize.height = height;
  
  UIGraphicsBeginImageContext(rotatedSize);
  CGContextRef bitmap = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
  CGContextRotateCTM(bitmap, Angle * M_PI / 180);
  CGContextRotateCTM(bitmap, M_PI);
  CGContextScaleCTM(bitmap, -1.0, 1.0);
  CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

@end
