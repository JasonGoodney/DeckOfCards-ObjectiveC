//
//  JGDrawCardViewController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "JGDrawCardViewController.h"

@interface JGDrawCardViewController ()

@property (weak, nonatomic) IBOutlet UIButton *drawACardButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation JGDrawCardViewController

static NSString * const reuseIdentifier = @"cardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _drawACardButton.layer.cornerRadius = 5;
    [self addShadow:_drawACardButton];
}

- (IBAction)drawCardButtonTapped:(UIButton *)sender {
    [[JGCardController shared] drawCards:4 completion:^(BOOL success) {
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self collectionView] reloadData];
                [[self collectionView] scrollToItemAtIndexPath: [NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            });
        }
    }];
}


# pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[JGCardController shared].cards count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JGCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    JGCard *card = [JGCardController shared].cards[indexPath.row];
    cell.card = card;
    
    return cell;
}

- (void)addShadow:(UIView *)view {
    view.layer.shadowRadius = 5.0;
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowOffset = CGSizeMake(0.5, 0.4);
    view.layer.masksToBounds =  NO;
    
}

@end

