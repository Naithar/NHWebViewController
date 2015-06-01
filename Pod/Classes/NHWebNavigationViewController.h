//
//  NHWebNavigationViewController.h
//  Pods
//
//  Created by Sergey Minakov on 01.06.15.
//
//

#import <UIKit/UIKit.h>
#import "NHWebViewController.h"

@interface NHWebNavigationViewController : UINavigationController

@property (nonatomic, readonly, strong) NHWebViewController *webViewController;

@end
