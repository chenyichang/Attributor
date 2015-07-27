//
//  TextStatisAttributorViewController.m
//  Attributor
//
//  Created by easonchen on 15/7/23.
//  Copyright (c) 2015年 easonchen. All rights reserved.
//

#import "TextStatisAttributorViewController.h"

@interface TextStatisAttributorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *outLineCount;
@property (weak, nonatomic) IBOutlet UILabel *colorCount;

@end

@implementation TextStatisAttributorViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.textToAnalyze=[[NSAttributedString alloc] initWithString:@"testStr" attributes:@{NSStrokeWidthAttributeName:@-3,NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze=textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)updateUI
{
    self.outLineCount.text=[NSString stringWithFormat:@"outLine:%d",[[self characterWithAttributor:NSStrokeWidthAttributeName] length]];
    self.colorCount.text=[NSString stringWithFormat:@"color:%d",[[self characterWithAttributor:NSForegroundColorAttributeName] length]];
}

- (NSAttributedString *)characterWithAttributor:(NSString *)attributeName
{
    NSMutableAttributedString *characters=[[NSMutableAttributedString alloc] init];
    
    int index=0;
    NSRange range;
    while (index<[self.textToAnalyze length]) {
        id value= [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index=range.location+range.length;
        }
        else{
            index++;
        }
    }
    
    return characters;
}

@end
