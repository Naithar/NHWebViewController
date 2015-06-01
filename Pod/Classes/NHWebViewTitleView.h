//
//  NHWebViewTitleLabel.h
//  Pods
//
//  Created by Sergey Minakov on 01.06.15.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NHWebViewTitleViewState) {
    NHWebViewTitleViewStateText,
    NHWebViewTitleViewStateLoading,
    NHWebViewTitleViewStateFailed,
};

@interface NHWebViewTitleView : UIView

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *urlString;

- (void)setState:(NHWebViewTitleViewState)state;
@end
