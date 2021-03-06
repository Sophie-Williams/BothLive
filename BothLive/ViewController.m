//
//  ViewController.m
//  BothLive
//
//  Created by pigpigdaddy on 14-7-22.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "GameSceneViewController.h"

@interface ViewController()<MenuViewControllerDelegate, GameSceneViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong)MenuViewController *menuViewController;
@property (nonatomic, strong)GameSceneViewController *gameSceneViewController;

@property (nonatomic, strong)NSString *totleTime;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)initView
{
    [self initMenuViewController];
    [self initGameSceneViewController];
}

- (void)initMenuViewController
{
    self.menuViewController = [[MenuViewController alloc] init];
    self.menuViewController.delegate = self;
    [self.view addSubview:self.menuViewController.view];
}

- (void)initGameSceneViewController
{
    self.gameSceneViewController = [[GameSceneViewController alloc] init];
    self.gameSceneViewController.delegate = self;
    [self.view insertSubview:self.gameSceneViewController.view belowSubview:self.menuViewController.view];
}

/*!
 *  @Author pigpigdaddy, 14-10-30 15:10:24
 *
 *  @brief  重新开启主界面动画
 */
- (void)restartMenuViewAnimation
{
    [self.menuViewController.menuView.menuAnimationView startAnimation];
}

#pragma mark
#pragma mark ============ MenuViewControllerDelegate ===========
/*!
 *  @Author pigpigdaddy, 14-10-30 22:10:00
 *
 *  @brief  开始游戏
 *
 *  @param type 游戏类型
 */
- (void)beginGameWithType:(MENU_LIST_BUTTON_NAME)type
{
    [UIView transitionFromView:self.menuViewController.view toView:self.gameSceneViewController.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        //
        [self.menuViewController.menuView.menuAnimationView stopAnimation];
    }];
    [self.gameSceneViewController startGame];
}

#pragma mark
#pragma mark ============ GameSceneViewControllerDelegate ===========
/*!
 *  @Author pigpigdaddy, 14-10-23 11:10:42
 *
 *  @brief  撞击了
 *
 *  @param position 撞击的跑酷小孩位置 从上到下index值 从1开始
 *  @param time     总持续时间
 */
- (void)runningCrash:(int)position totalTime:(NSString *)time
{
    // 显示选择框 分享/取消
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哇塞！简直不敢相信" message:[NSString stringWithFormat:@"你竟然坚持了 %@ 秒", time] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享到微信朋友圈", @"分享给微信好友", nil];
    [alert show];
    self.totleTime = time;
}

//- (void)showWelcomeView
//{
//    if (!self.welcomeView) {
//        self.welcomeView = [[UIView alloc] initWithFrame:self.view.bounds];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//        button.frame = CGRectMake(60, 100, 200, 100);
//        [button setTitle:@"开始！！！！！" forState:UIControlStateNormal];
//        [self.welcomeView addSubview:button];
//        [button addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:self.welcomeView];
//        self.welcomeView.backgroundColor = [UIColor whiteColor];
//    }
//    self.welcomeView.hidden = NO;
//}
//
//- (void)startAction:(id)sender{
//    [self startGame];
//}
//
//- (void)startGame
//{
//    self.welcomeView.hidden = YES;
//    
//    self.skView = [[SKView alloc] initWithFrame:self.view.bounds];
//    [self.view insertSubview:self.skView belowSubview:self.welcomeView];
//    
//    self.scene = [MyScene sceneWithSize:self.skView.bounds.size];
//    self.scene.scaleMode = SKSceneScaleModeAspectFill;
//    self.scene.delegate = self;
//    
//    // Present the scene.
//    [self.skView presentScene:self.scene];
//    
//    [self showTimeCount];
//    self.timeCount = 0.0;
//    [self startTime];
//}
//
//- (void)showTimeCount
//{
//    if (!self.label) {
//        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100, 30, 100, 50)];
//        [self.view addSubview:self.label];
//    }
//    self.label.text = @"0.00";
//}
//
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    } else {
//        return UIInterfaceOrientationMaskAll;
//    }
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Release any cached data, images, etc that aren't in use.
//}
//
//- (void)startTime
//{
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//    self.timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(addTime) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
////
////    
////    uint64_t interval = 0.01 * NSEC_PER_SEC;
////    dispatch_queue_t queue = dispatch_queue_create("my queue", 0);
////    _timers = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
////    dispatch_source_set_timer(_timers, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
////    __weak ViewController *blockSelf = self;
////    dispatch_source_set_event_handler(_timers, ^()
////    {
////        [blockSelf addTime];
////    });
////    dispatch_resume(_timers);
//    
//    
////    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(newThread) object:nil];
////    [thread start];
//}
//
////- (void)newThread
////{
////    @autoreleasepool
////    {
////        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(addTime) userInfo:nil repeats:YES];
////        [[NSRunLoop currentRunLoop] run];
////    }
////}
//
//- (void)addTime{
//    self.timeCount++;
//    self.label.text = [NSString stringWithFormat:@"%.2f", self.timeCount/100];
////    dispatch_async(dispatch_get_main_queue(), ^{
////        self.label.text = [NSString stringWithFormat:@"%.2f", self.timeCount/100];
////    });
//}
//
///*!
// *  TODO:撞了
// *
// *  @author pigpigdaddy
// */
//- (void)crash
//{
//    // 停止计时
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//    // 显示选择框 分享/取消
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哇塞！简直不敢相信" message:[NSString stringWithFormat:@"你竟然坚持了 %@ 秒", self.label.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"分享到微信朋友圈", @"分享给微信好友", nil];
//    [alert show];
//
//    // 显示主界面
//    self.welcomeView.hidden = NO;
//    [self.skView removeFromSuperview];
//}
//
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(sendToWXTimeLine:)]) {
                [self.delegate sendToWXTimeLine:[NSString stringWithFormat:@"《跑酷好基友》哇塞！你坚持了 %@ 秒！！", self.totleTime]];
            }
        }
            break;
        case 2:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(sendToWXFriend:)]) {
                [self.delegate sendToWXFriend:[NSString stringWithFormat:@"《跑酷好基友》哇塞！你坚持了 %@ 秒！！", self.totleTime]];
            }
        }
            break;
            
        default:
            break;
    }
    [UIView transitionFromView:self.gameSceneViewController.view toView:self.menuViewController.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        //
        [self.menuViewController.menuView.menuAnimationView startAnimation];
    }];
    [self.gameSceneViewController stopGame];
}



@end
