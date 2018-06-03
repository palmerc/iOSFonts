#import "CPViewController.h"

@interface CPViewController ()
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation CPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *quickFox = @"The quick brown fox jumped over the lazy dog.";
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];

    UIFont *fontNameFont = [UIFont fontWithName:@"Courier" size:14.0];
    NSArray<NSString *> *familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

    NSMutableArray *labels = [[NSMutableArray alloc] initWithCapacity:[familyNames count]];
    for (NSString *fontName in familyNames) {
        NSString *baseString = [fontName stringByAppendingString:@": "];
        
        NSMutableAttributedString *fontNameAttributedString = [[NSMutableAttributedString alloc] initWithString:baseString];
        [fontNameAttributedString addAttribute:NSFontAttributeName value:fontNameFont range:NSMakeRange(0, baseString.length)];
        
        UIFont *demoFont = [UIFont fontWithName:fontName size:24.0f];
        NSMutableAttributedString *demoFontAttributedString = [[NSMutableAttributedString alloc] initWithString:quickFox];
        [demoFontAttributedString addAttribute:NSFontAttributeName value:demoFont range:NSMakeRange(0, quickFox.length)];
    
        [fontNameAttributedString appendAttributedString:demoFontAttributedString];
        
        NSAttributedString *attributedText = fontNameAttributedString;
        
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.attributedText = attributedText;

        [scrollView addSubview:label];
        
        [labels addObject:label];
    }
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0]];
    
    UILabel *previousLabel = nil;
    for (UILabel *label in labels) {
        // Label left-side horizontal
        [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:8.0]];
        
        // Label right-side horizontal
        [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:label attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:8.0]];
        
        // Label top
        if (previousLabel == nil) {
            [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:8.0]];
        } else {
            // Label top of label to bottom of previous
            [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0]];
        }
        
        previousLabel = label;
    }
    
    // Last label attached to bottom of scrollview
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:previousLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0]];
    
    self.scrollView = scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
