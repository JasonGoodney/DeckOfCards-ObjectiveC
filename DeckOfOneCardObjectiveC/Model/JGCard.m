//
//  JGCard.m
//  DeckOfOneCardObjectiveC
//
//  Created by Jason Goodney on 9/11/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

#import "JGCard.h"

@implementation JGCard

- (instancetype)initWithCode:(NSString *)code value:(NSString *)value suit:(NSString *)suit image:(NSString *)image {
    if (self = [super init]) {
        _code = code;
        _value = value;
        _suit = suit;
        _image = image;
    }
    return self;
}

@end

@implementation JGCard (JSONConvertible)

static NSString * const CardsKey = @"cards";
static NSString * const CodeKey = @"code";
static NSString * const ValueKey = @"value";
static NSString * const SuitKey = @"suit";
static NSString * const ImageKey = @"image";

- (instancetype)initWithDictionary:(NSDictionary *)cardDictionary {

    if (!cardDictionary[CodeKey] || !cardDictionary[ValueKey] ||
        !cardDictionary[SuitKey] || !cardDictionary[ImageKey]) {
        
        return nil;
    }
    
    NSString *code = cardDictionary[CodeKey];
    NSString *value = cardDictionary[ValueKey];
    NSString *suit = cardDictionary[SuitKey];
    NSString *image = cardDictionary[ImageKey];
    
    return [self initWithCode:code value:value suit:suit image:image];
}

@end
