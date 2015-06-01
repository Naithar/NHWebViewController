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
                                                               initWithImage:[UIImage imageNamed:@"NHWebView.close.png"]
                                                               style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(closeNavigationButtonTouch:)];
    self.webViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                                initWithImage:[UIImage imageNamed:@"NHWebView.options.png"]
                                                                style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(optionsNavigationButtonTouch:)];
    
    self.backButton = [[UIBarButtonItem alloc]
                       initWithImage:[UIImage imageNamed:@"NHWebView.back.png"]
                       style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(backToolbarButtonTouch:)];
    
    self.forwardButton = [[UIBarButtonItem alloc]
                          initWithImage:[UIImage imageNamed:@"NHWebView.forward.png"]
                       style:UIBarButtonItemStylePlain
                       target:self
                       action:@selector(forwardToolbarButtonTouch:)];
    
    self.updateButton = [[UIBarButtonItem alloc]
                         initWithImage:[UIImage imageNamed:@"NHWebView.update.png"]
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
