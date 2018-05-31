#import "CPViewController.h"

@interface CPViewController ()
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation CPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *quickFox = @"The quick brown fox jumped over the lazy dog.";
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(scrollView);
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:horizontalConstraints];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[scrollView]-|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:verticalConstraints];
    
    NSArray *familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

    UIView *previousView = nil;
    for (NSString *fontName in familyNames) {
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [label setAdjustsFontSizeToFitWidth:YES];
        label.font = [UIFont fontWithName:fontName size:24.0f];
        label.text = [NSString stringWithFormat:@"%@: %@", fontName, quickFox];

        [scrollView addSubview:label];

        NSDictionary *views = NSDictionaryOfVariableBindings(label);
        [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]" options:0 metrics:nil views:views]];
        
        if (previousView == nil) {
            [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
        } else {
             [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0]];
        }
        
        previousView = label;
    }
    
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    self.scrollView = scrollView;
}

- (void)viewDidLayoutSubviews {
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            [label setNeedsLayout];
            [label sizeToFit];
            dispatch_async(dispatch_get_main_queue(), ^{
                label.preferredMaxLayoutWidth = label.bounds.size.width;
            });
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
