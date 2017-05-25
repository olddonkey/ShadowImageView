//
//  Extension+CIContext.h
//  ShadowImageView
//
//  Created by Jinkey on 2017/5/20.
//  Copyright © 2017年 Jinkey. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIContext (bridging)
+ (CIContext * _Nonnull)bridging_contextWithOptions:(nullable NSDictionary<NSString*,id> *)options
NS_AVAILABLE(10_4,5_0);
@end
