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

typedef void (^ DrawCardCompletion)(NSArray<JGCard *> *cards, NSError *error);
typedef void (^ FetchImageCompletion)(UIImage *image);

@interface JGCardController : NSObject

@property (nonatomic) NSMutableArray<JGCard *> *cards;

+ (JGCardController *)shared;

- (void) drawCards:(NSInteger)numberOfCards
     completion:(void (^_Nullable)(JGCard * _Nullable))completion;

- (void) fetchCardImage:(JGCard *)card
       fetchImageAction:(FetchImageCompletion)completion;

@end
