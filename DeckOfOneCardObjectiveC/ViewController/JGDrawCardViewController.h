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

@interface JGDrawCardViewController : UIViewController

@property (nonatomic) JGCard *card;

- (void) addShadow:(UIView *)view;

@end
