//
//  CPViewController.m
//  iOS5Fonts
//
//  Created by Cameron Lowell Palmer on 15.10.12.
//  Copyright (c) 2012 Cameron Lowell Palmer. All rights reserved.
//

#import "CPViewController.h"

@interface CPViewController ()

@end

@implementation CPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *quickFox = @"The quick brown fox jumped over the lazy dog.";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];

    
    NSArray *familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    CGFloat y = 0.0f;
    for (NSString *fontName in familyNames) {
        NSString *displayText = [NSString stringWithFormat:@"%@: %@", fontName, quickFox];
        
        UIFont *font = [UIFont fontWithName:fontName size:24.0f];
        CGSize size = [displayText sizeWithFont:font];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, y, size.width, size.height)];
        label.font = font;
        label.text = displayText;
        y += size.height;
        
        [scrollView addSubview:label];
        [label release];
    }
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, y);
    
    [scrollView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
