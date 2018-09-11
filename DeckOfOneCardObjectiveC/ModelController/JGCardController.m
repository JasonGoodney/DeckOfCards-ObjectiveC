//
//  JGCardController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "JGCardController.h"

@implementation JGCardController

+ (JGCardController *)shared
{
    static JGCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [JGCardController new];
    });
    return shared;
}


static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new/draw/";

- (void)drawCards:(NSInteger)numberOfCards completion:(void (^)(JGCard * _Nullable))completion {
    
    NSString *cardCount =[NSString stringWithFormat:@"%ld", numberOfCards];
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *countQueryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[countQueryItem];
    NSURL *url = [urlComponents URL];
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error in %s: %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            NSDictionary<NSString *, id> *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Error parsing the json: %@", error);
                completion(nil);
                return;
            }
            
            //JGCard *card = [[JGCard alloc] initWithDictionary:dictionary];
            
            NSDictionary<NSString *, id> *cardDictionaries = dictionary[@"cards"];
            
            self->_cards = [[NSMutableArray<JGCard *> alloc] init];
            
            for (NSDictionary<NSString *, id> *cardDictionary in cardDictionaries) {
                JGCard *card = [[JGCard alloc] initWithDictionary:cardDictionary];
               
                [[JGCardController shared].cards addObject:card];
                
            }
            
        }
    }] resume];
}

- (void)fetchCardImage:(JGCard *)card fetchImageAction:(FetchImageCompletion)completion {

    NSURL *imageURL = [NSURL URLWithString:card.image];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    
    UIImage *cardImage = [UIImage imageWithData:data];
    
    completion(cardImage);
}


@end
