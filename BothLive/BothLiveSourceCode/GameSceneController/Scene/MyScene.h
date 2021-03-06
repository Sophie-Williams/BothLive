//
//  MyScene.h
//  BothLive
//

//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define BABY_X_POSITION 88

#define BABY_JUMP_HEIGHT 88

#define BABY_ACTION_RUN     @"BABY_ACTION_RUN"
#define BABY_ACTION_JUMP    @"BABY_ACTION_JUMP"
#define BABY_ACTION_CRASH   @"BABY_ACTION_CRASH"

static const uint32_t obstacleCategory    =  0x1 << 0;
static const uint32_t babyCategory        =  0x1 << 1;

@protocol MySceneDelegate <NSObject>

/*!
 *  TODO:撞了
 *
 *  @author pigpigdaddy
 */
- (void)crash;

@end

@interface MyScene : SKScene<SKPhysicsContactDelegate>

@property (nonatomic, assign)id<MySceneDelegate> mySceneDelegate;

@property(nonatomic, strong) SKSpriteNode *upBaby;
@property(nonatomic, strong) SKSpriteNode *downBaby;

@property (nonatomic, strong) NSMutableArray *babyRunFrames;
@property (nonatomic, strong) NSMutableArray *babyJumpFrames;
@property (nonatomic, strong) NSMutableArray *babyCrashFrames;
@property (nonatomic, strong) NSMutableArray *obstacleFrames;

@property (nonatomic, strong) NSMutableArray *obstacleNodes;

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@property (nonatomic, assign)BOOL isUpBabyAction;
@property (nonatomic, assign)BOOL isDownBabyAction;
@property (nonatomic, assign)BOOL isCrash;

@end
