//
//  UserModel.m
//  myKaxiu
//
//  Created by 方灵勇 on 16/7/2.
//  Copyright © 2016年 Shanghai mai yi sports co., LTD. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.dept_no forKey:@"dept_no"];
    [aCoder encodeObject:self.ischoose forKey:@"ischoose"];
    [aCoder encodeObject:self.P_LSM forKey:@"P_LSM"];
    [aCoder encodeObject:self.P_NAME forKey:@"P_NAME"];
    [aCoder encodeObject:self.PASSWORD forKey:@"PASSWORD"];
    [aCoder encodeObject:self.P_STATE forKey:@"P_STATE"];
    [aCoder encodeObject:self.P_LEVER forKey:@"P_LEVER"];
    [aCoder encodeObject:self.LastLoginTime forKey:@"LastLoginTime"];
    [aCoder encodeObject:self.LINKCALL forKey:@"LINKCALL"];
    [aCoder encodeObject:self.EMail forKey:@"EMail"];
    [aCoder encodeObject:self.P_Type forKey:@"P_Type"];
    [aCoder encodeObject:self.RID forKey:@"RID"];
    [aCoder encodeObject:self.PostAddress forKey:@"PostAddress"];
    [aCoder encodeObject:self.dept_No1 forKey:@"dept_No1"];
    [aCoder encodeObject:self.Ischoose1 forKey:@"Ischoose1"];
    [aCoder encodeObject:self.ThemeID forKey:@"ThemeID"];
    [aCoder encodeObject:self.spelltype forKey:@"spelltype"];
    [aCoder encodeObject:self.handphone forKey:@"handphone"];
    [aCoder encodeObject:self.RegisterMemo forKey:@"RegisterMemo"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.dept_no = [aDecoder decodeObjectForKey:@"dept_no"];
        self.ischoose = [aDecoder decodeObjectForKey:@"ischoose"];
        self.P_LSM = [aDecoder decodeObjectForKey:@"P_LSM"];
        self.P_NAME = [aDecoder decodeObjectForKey:@"P_NAME"];
        self.PASSWORD = [aDecoder decodeObjectForKey:@"PASSWORD"];
        self.P_STATE = [aDecoder decodeObjectForKey:@"P_STATE"];
        self.P_LEVER = [aDecoder decodeObjectForKey:@"P_LEVER"];
        self.LastLoginTime = [aDecoder decodeObjectForKey:@"LastLoginTime"];
        self.LINKCALL = [aDecoder decodeObjectForKey:@"LINKCALL"];
        self.EMail = [aDecoder decodeObjectForKey:@"EMail"];
        self.P_Type = [aDecoder decodeObjectForKey:@"P_Type"];
        self.RID = [aDecoder decodeObjectForKey:@"RID"];
        self.PostAddress = [aDecoder decodeObjectForKey:@"PostAddress"];
        self.dept_No1 = [aDecoder decodeObjectForKey:@"dept_No1"];
        self.Ischoose1 = [aDecoder decodeObjectForKey:@"Ischoose1"];
        self.ThemeID = [aDecoder decodeObjectForKey:@"ThemeID"];
        self.spelltype = [aDecoder decodeObjectForKey:@"spelltype"];
        self.handphone = [aDecoder decodeObjectForKey:@"handphone"];
        self.RegisterMemo = [aDecoder decodeObjectForKey:@"RegisterMemo"];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(void)saveModel:(UserModel *)model{
    NSData *data = [NSData archivedDataWithRootObject:model];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"AnimaUserModel"];
    [defaults synchronize];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(UserModel *)getUserModel{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"AnimaUserModel"];
    return [NSData unarchiveObjectWithData:data];
}
+(void)initModel{
    UserModel *model = [[UserModel alloc] init];
    [UserModel saveModel:model];
}

@end

