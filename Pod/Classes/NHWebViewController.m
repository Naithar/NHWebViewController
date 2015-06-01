//
//  NHWebViewController.m
//  Pods
//
//  Created by Sergey Minakov on 01.06.15.
//
//

#import "NHWebViewController.h"

@interface NHWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NHWebViewTitleView *titleView;

@property (nonatomic, weak) UIBarButtonItem *backButton;
@property (nonatomic, weak) UIBarButtonItem *forwardButton;
@property (nonatomic, weak) UIBarButtonItem *updateButton;
@end

@implementation NHWebViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.webView = [[UIWebView alloc] init];
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0 constant:0]];
    
    self.titleView = [[NHWebViewTitleView alloc]
                      initWithFrame:CGRectMake(0,
                                               0,
                                               self.view.frame.size.width,
                                               self.view.frame.size.width > self.view.frame.size.height
                                               ? 30 : 42)];
    self.titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = self.titleView;
}

- (void)viewWillLayoutSubviews {
    
    self.titleView.frame = CGRectMake(0,
                                      0,
                                      self.view.frame.size.width,
                                      self.view.frame.size.width > self.view.frame.size.height
                                      ? 30 : 42);
    [super viewWillLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setToolbarItems:(NSArray *)toolbarItems animated:(BOOL)animated {
    [super setToolbarItems:toolbarItems animated:animated];
    
    self.backButton = self.toolbarItems[0];
    self.forwardButton = self.toolbarItems[1];
    self.updateButton = self.toolbarItems[3];
    
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}

- (void)setUrlPath:(NSString*)urlPath {
    NSURL *url = [NSURL URLWithString:urlPath];
    [self setUrl:url];
}

- (void)setUrl:(NSURL*)url {
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)updateCurrentPage {
}

- (void)moveToPreviousPage {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (void)moveToNextPage {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

- (void)openInSafari {
    NSURL *url = [NSURL URLWithString:self.webView.request.URL.absoluteString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)copyLink {
    [[UIPasteboard generalPasteboard] setString:self.webView.request.URL.absoluteString];
}


//MARK: web view delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.titleView.titleString = [self webPageTitle];
    self.titleView.urlString = [self webPageUrl];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.titleView.titleString = [self webPageTitle];
    self.titleView.urlString = [self webPageUrl];
    [self updateButtonState];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.titleView.titleString = [self webPageTitle];
    self.titleView.urlString = [self webPageUrl];
    [self updateButtonState];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.titleView.urlString = [self webPageUrlForRequest:request];
    return YES;
}

- (NSString*)webPageTitle {
    NSString *documentTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    return (documentTitle && [documentTitle isKindOfClass:[NSString class]] && [documentTitle length] > 0)
    ? documentTitle
    : @"...";
}

- (NSString*)webPageUrl {
    return [self webPageUrlForRequest:self.webView.request];
}

- (NSString*)webPageUrlForRequest:(NSURLRequest*)request {
    return [request.URL.absoluteString.lowercaseString
            stringByTrimmingCharactersInSet:[NSCharacterSet
                                             whitespaceAndNewlineCharacterSet]];
}

- (void)updateButtonState {
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}

@end
