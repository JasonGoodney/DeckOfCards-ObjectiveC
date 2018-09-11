//
//  JGCard.h
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGCard : NSObject

@property (nonatomic) NSString *image;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *value;
@property (nonatomic) NSString *suit;

- (instancetype) initWithCode:(NSString *)code value:(NSString *)value
                         suit:(NSString *)suit image:(NSString *)image;

@end

@interface JGCard (JSONConvertible)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
