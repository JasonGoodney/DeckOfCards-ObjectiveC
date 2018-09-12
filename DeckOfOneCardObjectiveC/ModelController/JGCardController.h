//
//  JGCardController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGCard.h"
#import <UIKit/UIKit.h>

@interface JGCardController : NSObject

@property (nonatomic) NSMutableArray<JGCard *> *cards;
@property (nonatomic) NSInteger userCardCount;

+ (JGCardController *)shared;


- (void) drawCards:(NSInteger)numberOfCards inDeckId:(NSString *)deckId
     completion:(void (^_Nullable)(BOOL success))completion;

- (void) fetchCardImage:(JGCard *)card
       completion:(void (^_Nullable)(UIImage *_Nullable))completion;

- (void)deck:(void (^_Nullable)(NSString *_Nullable))completion;

@end
