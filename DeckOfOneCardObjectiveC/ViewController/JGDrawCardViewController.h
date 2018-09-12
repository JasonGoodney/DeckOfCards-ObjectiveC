//
//  JGDrawCardViewController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGCardController.h"
#import "JGCard.h"
#import "JGCardCollectionViewCell.h"

@interface JGDrawCardViewController : UIViewController <UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) JGCard *card;

- (void) addShadow:(UIView *)view;
- (void) updateButtonTitle:(NSInteger)count;

@end
