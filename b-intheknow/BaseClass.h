//
//  BaseClass.h
//
//  Created by   on 21/10/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
//@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double v;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *url;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
