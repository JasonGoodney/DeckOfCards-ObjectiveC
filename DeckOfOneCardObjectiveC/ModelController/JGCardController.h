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

+ (JGCardController *)shared;

- (void) drawCards:(NSInteger)numberOfCards
     completion:(void (^_Nullable)(BOOL success))completion;

- (void) fetchCardImage:(JGCard *)card
       completion:(void (^_Nullable)(UIImage *_Nullable))completion;

@end
