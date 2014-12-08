//
//  BaseClass.m
//
//  Created by   on 21/10/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"


NSString *const kBaseClassId = @"_id";
//NSString *const kBaseClassId = @"id";
NSString *const kBaseClassV = @"__v";
NSString *const kBaseClassTitle = @"title";
NSString *const kBaseClassType = @"type";
NSString *const kBaseClassBody = @"body";
NSString *const kBaseClassTags = @"tags";
NSString *const kBaseClassUrl = @"url";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
//@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize v = _v;
@synthesize title = _title;
@synthesize type = _type;
@synthesize body = _body;
@synthesize tags = _tags;
@synthesize url = _url;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kBaseClassId fromDictionary:dict];
  //          self.internalBaseClassIdentifier = [[self objectOrNilForKey:kBaseClassId fromDictionary:dict] doubleValue];
            self.v = [[self objectOrNilForKey:kBaseClassV fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kBaseClassTitle fromDictionary:dict];
            self.type = [self objectOrNilForKey:kBaseClassType fromDictionary:dict];
            self.body = [self objectOrNilForKey:kBaseClassBody fromDictionary:dict];
            self.tags = [self objectOrNilForKey:kBaseClassTags fromDictionary:dict];
            self.url = [self objectOrNilForKey:kBaseClassUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kBaseClassId];
 //   [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kBaseClassId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.v] forKey:kBaseClassV];
    [mutableDict setValue:self.title forKey:kBaseClassTitle];
    [mutableDict setValue:self.type forKey:kBaseClassType];
    [mutableDict setValue:self.body forKey:kBaseClassBody];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kBaseClassTags];
    [mutableDict setValue:self.url forKey:kBaseClassUrl];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kBaseClassId];
  //  self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kBaseClassId];
    self.v = [aDecoder decodeDoubleForKey:kBaseClassV];
    self.title = [aDecoder decodeObjectForKey:kBaseClassTitle];
    self.type = [aDecoder decodeObjectForKey:kBaseClassType];
    self.body = [aDecoder decodeObjectForKey:kBaseClassBody];
    self.tags = [aDecoder decodeObjectForKey:kBaseClassTags];
    self.url = [aDecoder decodeObjectForKey:kBaseClassUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kBaseClassId];
  //  [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kBaseClassId];
    [aCoder encodeDouble:_v forKey:kBaseClassV];
    [aCoder encodeObject:_title forKey:kBaseClassTitle];
    [aCoder encodeObject:_type forKey:kBaseClassType];
    [aCoder encodeObject:_body forKey:kBaseClassBody];
    [aCoder encodeObject:_tags forKey:kBaseClassTags];
    [aCoder encodeObject:_url forKey:kBaseClassUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = [self.internalBaseClassIdentifier copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.v = self.v;
        copy.title = [self.title copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.body = [self.body copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
    }
    
    return copy;
}


@end
