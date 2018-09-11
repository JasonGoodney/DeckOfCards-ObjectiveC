//
//  JGCardCollectionViewCell.h
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGCard.h"
#import "JGCardController.h"

@interface JGCardCollectionViewCell : UICollectionViewCell

@property (nonatomic) JGCard *card;

- (void) updateView;

@end
