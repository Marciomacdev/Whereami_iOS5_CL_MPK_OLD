//
//  MapPoint.m
//  Whereami
//
//  Created by Marcio Ferreira on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

@synthesize title, coordinate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t {
    
    [super init];
    coordinate = c;
    [self setTitle:t];
    
    return self;
}

-(void)dealloc {
    [title release];
    [super dealloc];
}

@end
