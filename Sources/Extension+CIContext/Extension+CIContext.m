//
//  Extension+CIContext.m
//  ShadowImageView
//
//  Created by Jinkey on 2017/5/20.
//  Copyright © 2017年 Jinkey. All rights reserved.
//

#import "Extension+CIContext.h"

@implementation CIContext (bridging)
+ (CIContext *)bridging_contextWithOptions:(NSDictionary<NSString *,id> *)options {
    return [CIContext contextWithOptions:options];
}
@end


