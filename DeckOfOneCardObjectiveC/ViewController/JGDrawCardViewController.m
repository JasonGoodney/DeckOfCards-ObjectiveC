//
//  JGDrawCardViewController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "JGDrawCardViewController.h"

@interface JGDrawCardViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UIButton *drawACardButton;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *suitLabel;

@end

@implementation JGDrawCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _drawACardButton.layer.cornerRadius = 5;
    [self addShadow:_drawACardButton];
}

- (IBAction)drawCardButtonTapped:(UIButton *)sender {
    [[JGCardController shared] drawCards:4 completion:^(JGCard * card) {
        
        NSLog(@"%@", card);
        
        self.card = card;
        
        [[JGCardController shared] fetchCardImage:card fetchImageAction:^(UIImage *image) {
            NSLog(@"%@", image);
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_cardImageView.image = image;
            });
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_valueLabel.text = card.value;
            self->_suitLabel.text = card.suit;
        });
        
    
    }];
}

- (void)addShadow:(UIView *)view {
    view.layer.shadowRadius = 5.0;
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowOffset = CGSizeMake(0.5, 0.4);
    view.layer.masksToBounds =  NO;
    
}

@end
