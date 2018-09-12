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

static NSString * const newDeckURLString = @"https://deckofcardsapi.com/api/deck/new/";
static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/";

- (void)drawCards:(NSInteger)numberOfCards inDeckId:(NSString *)deckId completion:(void (^)(BOOL))completion {
    
    NSString *cardCount =[NSString stringWithFormat:@"%ld", numberOfCards];
    
    NSURL *baseURL = [[[NSURL URLWithString:baseURLString]
                       URLByAppendingPathComponent:deckId]
                      URLByAppendingPathComponent:@"draw"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *countQueryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[countQueryItem];
    NSURL *url = [urlComponents URL];
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error in %s: %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            completion(false);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            
            NSDictionary<NSString *, id> *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Error parsing the json: %@", error);
                completion(false);
                return;
            }
            
            NSDictionary<NSString *, id> *cardDictionaries = dictionary[@"cards"];
            
            self->_cards = [[NSMutableArray<JGCard *> alloc] init];
            
            for (NSDictionary<NSString *, id> *cardDictionary in cardDictionaries) {
                JGCard *card = [[JGCard alloc] initWithDictionary:cardDictionary];
                
                [[JGCardController shared].cards addObject:card];
            }
            
            completion(YES);
        }
    }] resume];

        
}

- (void)fetchCardImage:(JGCard *)card completion:(void (^)(UIImage * _Nullable))completion {

    if (!completion) {
        completion = ^(UIImage *image) {};
    }

    NSURL *imageURL = [NSURL URLWithString:card.image];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    
    UIImage *cardImage = [UIImage imageWithData:data];
    
    completion(cardImage);
}

- (void)deck:(void (^)(NSString * _Nullable))completion {

    NSURL *url = [NSURL URLWithString:newDeckURLString];
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error in %s: %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response) {
            //NSLog(@"%@", response);
        }
        
        if (data) {
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            
            if ([jsonDictionary[@"deck_id"] isKindOfClass:[NSString class]]) {
                completion(jsonDictionary[@"deck_id"]);

            }
        }
    
    }] resume];
}


@end
