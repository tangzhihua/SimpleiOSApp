//
//  UIColor+Helper.m
//  ModelLib
//
//  Created by 唐志华 on 14-3-19.
//  Copyright (c) 2014年 唐志华. All rights reserved.
//

#import "UIColor+HexConvert.h"

@implementation UIColor (HexConvert)
+(UIColor *)colorFromHexString:(NSString *)colorString {
  NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  
  
  if ([cString length] < 6)
    return [UIColor whiteColor];
  if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
  if ([cString length] != 6)
    return [UIColor whiteColor];
  
  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];
  
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:((float) r / 255.0f)
                         green:((float) g / 255.0f)
                          blue:((float) b / 255.0f)
                         alpha:1.0f];
}

+ (NSString *)stringFromColor:(UIColor *)color {
  const CGFloat *cs=CGColorGetComponents(color.CGColor);
  
  
  NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
  NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
  NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
  return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
}

+(NSString *)ToHex:(int)tmpid {
  NSString *endtmp=@"";
  NSString *nLetterValue;
  NSString *nStrat;
  int ttmpig=tmpid%16;
  int tmp=tmpid/16;
  switch (ttmpig)
  {
    case 10:
      nLetterValue =@"A";break;
    case 11:
      nLetterValue =@"B";break;
    case 12:
      nLetterValue =@"C";break;
    case 13:
      nLetterValue =@"D";break;
    case 14:
      nLetterValue =@"E";break;
    case 15:
      nLetterValue =@"F";break;
    default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
      
  }
  switch (tmp)
  {
    case 10:
      nStrat =@"A";break;
    case 11:
      nStrat =@"B";break;
    case 12:
      nStrat =@"C";break;
    case 13:
      nStrat =@"D";break;
    case 14:
      nStrat =@"E";break;
    case 15:
      nStrat =@"F";break;
    default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
      
  }
  endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
  return endtmp;
}

- (void)getRGBComponents:(CGFloat [3])components {
  CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
  unsigned char resultingPixel[4];
  CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                               1,
                                               1,
                                               8,
                                               4,
                                               rgbColorSpace,
                                               (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
  CGContextSetFillColorWithColor(context, [self CGColor]);
  CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
  CGContextRelease(context);
  CGColorSpaceRelease(rgbColorSpace);
  
  for (int component = 0; component < 3; component++) {
    components[component] = resultingPixel[component] / 255.0f;
  }
}
@end
