//
//  NHWebViewTitleLabel.m
//  Pods
//
//  Created by Sergey Minakov on 01.06.15.
//
//

#import "NHWebViewTitleLabel.h"

@implementation NHWebViewTitleLabel

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    
}

@end
