//
//  NHWebNavigationViewController.m
//  Pods
//
//  Created by Sergey Minakov on 01.06.15.
//
//

#import "NHWebNavigationViewController.h"

@interface NHWebNavigationViewController ()

@property (nonatomic, strong) NHWebViewController *webViewController;
@property (nonatomic, strong) UIBarButtonItem *backButton;
@property (nonatomic, strong) UIBarButtonItem *forwardButton;
@property (nonatomic, strong) UIBarButtonItem *updateButton;
@end

@implementation NHWebNavigationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass {
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = [UIColor blackColor];
    self.toolbarHidden = NO;
    self.toolbar.translucent = NO;
    self.toolbar.barTintColor = [UIColor whiteColor];
    self.toolbar.tintColor = [UIColor blackColor];
    
    self.webViewController = [[NHWebViewController alloc] init];
    
    self.webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                               initWithImage:[UIImage imageNamed:@"NHWebView.close"]
                                                               style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(closeNavigationButtonTouch:)];
    self.webViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                                initWithImage:[UIImage imageNamed:@"NHWebView.options"]
                                                                style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(optionsNavigationButtonTouch:)];
    
    self.backButton = [[UIBarButtonItem alloc]
                       initWithImage:[UIImage imageNamed:@"NHWebView.back"]
                       style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(backToolbarButtonTouch:)];
    
    self.forwardButton = [[UIBarButtonItem alloc]
                          initWithImage:[UIImage imageNamed:@"NHWebView.forward"]
                       style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(forwardToolbarButtonTouch:)];
    
    self.updateButton = [[UIBarButtonItem alloc]
                         initWithImage:[UIImage imageNamed:@"NHWebView.update"]
                       style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(updateToolbarButtonTouch:)];   

    [self.webViewController
     setToolbarItems:@[
                       self.backButton,
                       self.forwardButton,
                       [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                        target:nil
                        action:nil],
                       self.updateButton]];
    
    [self setViewControllers:@[self.webViewController]];
    
    [self.navigationBar addSubview:self.webViewController.progressView];
    [self.webViewController.progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webViewController.progressView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.navigationBar
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webViewController.progressView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.navigationBar
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webViewController.progressView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.navigationBar
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0 constant:0]];
    
    
    
}

- (void)closeNavigationButtonTouch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)optionsNavigationButtonTouch:(id)sender {
    __weak __typeof(self) weakSelf = self;
    
    if ([weakSelf.webDelegate respondsToSelector:@selector(didTouchOptionsButtonInWebController:)]) {
        [weakSelf.webDelegate didTouchOptionsButtonInWebController:weakSelf];
    }
}

- (void)backToolbarButtonTouch:(id)sender {
    [self.webViewController moveToPreviousPage];
}

- (void)forwardToolbarButtonTouch:(id)sender {
    [self.webViewController moveToNextPage];
}

- (void)updateToolbarButtonTouch:(id)sender {
    [self.webViewController updateCurrentPage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    
}


@end
