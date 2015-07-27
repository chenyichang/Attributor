//
//  AttributorViewController.m
//  Attributor
//
//  Created by easonchen on 15/7/23.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "AttributorViewController.h"
#import "TextStatisAttributorViewController.h"

@interface AttributorViewController ()

@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headLine;

@property (weak, nonatomic) IBOutlet UIButton *outLineButton;

@end

@implementation AttributorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title=[[NSMutableAttributedString alloc] initWithString:self.outLineButton.currentTitle];
    [title setAttributes:@{NSStrokeWidthAttributeName: @3,NSStrokeColorAttributeName:self.outLineButton.currentTitleColor} range:NSMakeRange(0, [title length])];
    [self.outLineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"text analyze"]) {
        if ([segue.destinationViewController isKindOfClass:[TextStatisAttributorViewController class]]) {
            TextStatisAttributorViewController *textStatis=(TextStatisAttributorViewController *)segue.destinationViewController;
            textStatis.textToAnalyze=self.body.textStorage;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)preferredFontsChanged:(NSNotification *)notification
{
    [self usePreferredFonts];
}

- (void)usePreferredFonts
{
    self.headLine.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.body.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (IBAction)changeSelectedColorMatchBackgroundColorOfButton:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}
- (IBAction)outLineSelected
{
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-5,NSStrokeColorAttributeName:[UIColor greenColor]} range:self.body.selectedRange];
}
- (IBAction)unOutLineSelected
{
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

@end
