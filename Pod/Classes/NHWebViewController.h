//
//  NHWebViewController.h
//  Pods
//
//  Created by Sergey Minakov on 01.06.15.
//
//

#import <UIKit/UIKit.h>
#import "NHWebViewTitleLabel.h"

@interface NHWebViewController : UIViewController

@property (nonatomic, readonly, strong) UIWebView *webView;
@property (nonatomic, readonly, strong) NHWebViewTitleLabel *titleLabel;

- (void)updateCurrentPage;
- (void)moveToPreviousPage;
- (void)moveToNextPage;
- (void)openInSafari;
- (void)copyLink;

@end
