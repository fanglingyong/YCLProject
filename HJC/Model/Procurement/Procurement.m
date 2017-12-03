//
//  Procurement.m
//  HJC
//
//  Created by 陈晨 on 2017/12/3.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "Procurement.h"
//
//  JiltOrderChoose.m
//  JieBa
//
//  Created by zhifu360 on 17/3/6.
//  Copyright © 2017年 zhixin. All rights reserved.
//

#import "Procurement.h"

@implementation Procurement
-(id) init{
    if(self = [super init]){
        _allClass = 0;
        _suppliers = 0;
        _promotions = 0;
    }
    
    return self;
}
/**
 *  initWithCoder
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.allClass = [aDecoder decodeIntegerForKey:@"allClass"];
        self.suppliers = [aDecoder decodeIntegerForKey:@"suppliers"];
        self.promotions = [aDecoder decodeIntegerForKey:@"promotions"];
    }
    
    return self;
}

-(NSString *)allClassTitle{
    if (self.allClass == 0) {
        return @"全部分类";
    }
    return [self.allClassArray objectAtIndex: self.allClass];
}

-(NSString *)suppliersTitle{
    if (self.suppliers == 0) {
        return @"供应商";
    }
    return [self.suppliersArray objectAtIndex:self.suppliers];
}

-(NSString *)promotionsTitle{
    if (self.promotions == 0) {
        return @"促销";
    }
    return [self.promotionsArray objectAtIndex:self.promotions];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.allClass forKey:@"allClass"];
    [aCoder encodeInteger:self.suppliers forKey:@"suppliers"];
    [aCoder encodeInteger:self.promotions forKey:@"promotions"];
}

-(void) setupBasicArray:(NSArray *) conditions{
    for (int i = 0; i < conditions.count; i++) {
        if (i == 0) {
            self.allClassArray = conditions[i];
        }
        if (i == 1) {
            self.suppliersArray = conditions[i];
        }
        if (i == 2) {
            self.promotionsArray = conditions[i];
        }
    }
}
@end



