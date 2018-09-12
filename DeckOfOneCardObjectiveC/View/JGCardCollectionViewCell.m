//
//  JGCardCollectionViewCell.m
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "JGCardCollectionViewCell.h"

@interface JGCardCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *suitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

@end

@implementation JGCardCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)updateView {
    _valueLabel.text = _card.value;
    _suitLabel.text = _card.suit;
    
    [[JGCardController shared] fetchCardImage:_card completion:^(UIImage * image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_cardImageView.image = image;
        });
    }];
}

- (void)setCard:(JGCard *)card {
    _card = card;
    [self updateView];
}

@end
