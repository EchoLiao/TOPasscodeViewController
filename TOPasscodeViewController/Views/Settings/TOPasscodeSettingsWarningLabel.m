//
//  TOPasscodeSettingsWarningLabel.m
//
//  Copyright 2017 Timothy Oliver. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "TOPasscodeSettingsWarningLabel.h"

@interface TOPasscodeSettingsWarningLabel ()

/* Text label displaying passcode count */
@property (nonatomic, strong) UILabel *label;

/* Background view that provides rounded corners */
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation TOPasscodeSettingsWarningLabel

#pragma mark - View Setup -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    _numberOfWarnings = 0;
    _textPadding = CGSizeMake(14.0f, 6.0f);

    [super setBackgroundColor:[UIColor clearColor]];

    // Create and configure the background view
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundView.backgroundColor = [UIColor redColor];
    [self addSubview:self.backgroundView];

    // Create and configure the text label
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:15.0f];
    [self setTextForCount:0];
    [self.label sizeToFit];
    [self addSubview:self.label];
}

#pragma mark - View Layout -

- (void)sizeToFit
{
    [super sizeToFit];
    [self.label sizeToFit];

    CGRect labelFrame = self.label.frame;
    CGRect frame = self.frame;

    labelFrame = CGRectInset(labelFrame, -self.textPadding.width, -self.textPadding.height);
    frame.size = labelFrame.size;
    self.frame = CGRectIntegral(frame);
}

- (void)layoutSubviews
{
    CGRect frame = self.frame;

    // Layout the background
    self.backgroundView.frame = self.bounds;
    self.backgroundView.layer.cornerRadius = CGRectGetHeight(frame) * 0.5f;

    // Layout the text
    CGRect labelFrame = self.label.frame;
    labelFrame.origin.x = (CGRectGetWidth(frame) - CGRectGetWidth(labelFrame)) * 0.5f;
    labelFrame.origin.y = (CGRectGetHeight(frame) - CGRectGetHeight(labelFrame)) * 0.5f;
    self.label.frame = labelFrame;
}

#pragma mark - View State Handling -

- (void)setTextForCount:(NSInteger)count
{
    NSString *text = nil;
    if (count == 1) {
        text = NSLocalizedString(@"1 Failed Passcode Attempt", @"");
    }
    else {
        text = [NSString stringWithFormat:NSLocalizedString(@"%ld Failed Passcode Attempts", @""), (long)count];
    }
    self.label.text = text;

    [self sizeToFit];
}

#pragma mark - Accessors -

- (void)setNumberOfWarnings:(NSInteger)numberOfWarnings
{
    _numberOfWarnings = numberOfWarnings;
    [self setTextForCount:_numberOfWarnings];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    self.backgroundView.backgroundColor = backgroundColor;
}

@end
