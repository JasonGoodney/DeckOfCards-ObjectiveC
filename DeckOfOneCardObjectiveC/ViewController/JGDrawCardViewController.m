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
@property (weak, nonatomic) IBOutlet UIPickerView *cardCountPickerView;

@end

@implementation JGDrawCardViewController

static NSString * const reuseIdentifier = @"cardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _drawACardButton.layer.cornerRadius = 5;
    [self addShadow:_drawACardButton];
    
    [JGCardController shared].userCardCount = 1;
    [self updateButtonTitle:[JGCardController shared].userCardCount];
}

- (IBAction)drawCardButtonTapped:(UIButton *)sender {
    
    [[JGCardController shared] deck:^(NSString *deckId) {
        
        [[JGCardController shared] drawCards:[JGCardController shared].userCardCount inDeckId:deckId completion:^(BOOL success) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[self collectionView] reloadData];
                    [[self collectionView] scrollToItemAtIndexPath: [NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                });
            }
        }];
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

# pragma UIPickerViewDelegate & UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 52;
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger cardCount = row + 1;
    NSLog(@"%ld", cardCount);
    [JGCardController shared].userCardCount = cardCount;
    [self updateButtonTitle:cardCount];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%ld", row + 1 ];
}


- (void)addShadow:(UIView *)view {
    view.layer.shadowRadius = 5.0;
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowOffset = CGSizeMake(0.5, 0.4);
    view.layer.masksToBounds =  NO;
    
}

- (void)updateButtonTitle:(NSInteger)count {
    NSString *title = [NSString stringWithFormat:@"DRAW %ld CARDS", count];
    [[self drawACardButton] setTitle:title forState:UIControlStateNormal];
}


@end

