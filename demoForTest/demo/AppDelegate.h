//
//  AppDelegate.h
//  demo
//
//  Created by Minsol on 2018/10/18.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AD_LAUNCH_ALERT         @"A8_iOS_AD_LAUNCH_ALERT"//  启动弹窗
#define AD_GUESS_TOP            @"A8_iOS_AD_GUESS_TOP"//  竞猜顶部广告
#define AD_LIVE_ROOM_GUESS      @"A8_iOS_AD_LIVE_ROOM_GUESS"//  直播间竞猜广告
#define AD_GUESS_BET            @"A8_iOS_AD_GUESS_BET"//  竞猜投注买一注广告
#define AD_ONE_KEY_BET          @"A8_iOS_AD_ONE_KEY_BET"//  直播间一键购彩
#define AD_LIVE_LINE_1          @"A8_iOS_AD_LIVE_LINE_1"//  直播间线路广告1
#define AD_LIVE_LINE_2          @"A8_iOS_AD_LIVE_LINE_2"//  直播间线路广告2
#define AD_NEWS_BOTTOM          @"A8_iOS_AD_NEWS_BOTTOM"//  新闻详情底部广告
#define AD_NEWS_BOTTOM_XALIVE   @"A8_iOS_AD_NEWS_BOTTOM_XALIVE" // 新闻详情底部小爱广告
#define AD_NEWS_ONE_KEY_BET     @"A8_iOS_AD_NEWS_ONE_KEY_BET"//  新闻详情底部一键购彩
#define AD_VIDEO_PLAYER         @"A8_iOS_AD_VIDEO_PLAYER"//  视频5秒前贴
#define AD_VIDEO_RELATEDNEWSAD  @"A8_iOS_AD_VIDEO_RELATEDNEWSAD" // 视频相关推荐广告
#define AD_VIDEO_RELATEDNEWSAD_XALIVE @"A8_iOS_AD_VIDEO_RELATEDNEWSAD_XALIVE" // 视频相关推荐小爱广告
#define AD_GAME_LEAGUE_SCHEDULE @"A8_iOS_AD_GAME_LEAGUE_SCHEDULE"//  比赛-联赛-赛程广告
#define AD_GUESS_MY_GUESS       @"A8_iOS_AD_GUESS_MY_GUESS"//  我的竞猜广告
#define AD_HOME_VIDEO           @"A8_iOS_AD_HOME_VIDEO"//  首页视频广告
#define AD_HOME_COLLECTION      @"A8_iOS_AD_HOME_COLLECTION"//  首页视频集锦列表广告
#define AD_HOME_HOT             @"A8_iOS_AD_NEWS_HOT"//  首页热门广告
#define AD_HOME_HOT_LARGEIMAGE  @"A8_iOS_AD_NEWS_HOT_LARGEIMAGE" // 首页热门大图广告
#define AD_HOME_HOT_BANNER      @"A8_iOS_AD_NEWS_HOT_BANNER" // 首页热门Banner广告
#define AD_HOME_GUESS           @"A8_iOS_AD_NEWS_GUESS"//  首页竞彩广告
#define AD_GAME_GUESS           @"A8_iOS_AD_GAME_GUESS"//  比赛竞彩广告
#define AD_GAME_HOT             @"A8_iOS_AD_GAME_HOT" // 比赛热门广告
#define AD_LAUNCH_SCREEN        @"A8_iOS_AD_LAUNCH_SCREEN"//  启动开屏
#define AD_HOME_FLOAT           @"A8_iOS_AD_HOME_FLOAT"//  首页悬浮窗
#define AD_VIDEO_PAUSE          @"A8_iOS_AD_VIDEO_PAUSE" // 视频暂停广告
#define AD_HOME_NEWSFLASH       @"A8_iOS_AD_NEWS_FLASH" // 首页热门快讯广告
#define A8_iOS_AD_GMAE_WORLDCUP_GUESS      @"A8_iOS_AD_GMAE_WORLDCUP_GUESS" // 比赛竞猜（世界杯）
#define AD_ALERT_ACTIVITY       @"A8_iOS_ALERT_ACTIVITY" // 弹窗活动广告位
#define AD_Recomment_News       @"A8_iOS_Recomment_News" // 资讯详情页相关推荐增加广告位
#define AD_VideoList_End        @"A8_iOS_VideoList_End" // 列表页视频播放结束后5秒广告
#define AD_VideoDetail_Start    @"A8_iOS_VideoDetail_Start" // 视频详情页5秒前贴广告
#define AD_VideoDetail_End      @"A8_iOS_VideoDetail_End" // 视频详情页5秒后贴广告
#define AD_LIVE_VideoPlay       @"A8_iOS_LIVE_VideoPlay" // 比赛前半个小时点击【视频直播】，出现弹框广告
#define AD_NEWS_HOT_FIVE        @"A8_iOS_AD_NEWS_HOT_FIVE" // 首页热门默认第五位
#define AD_NEWS_HOT_TEN         @"A8_iOS_AD_NEWS_HOT_TEN" //首页热门默认第十位


#define GDT_A8News_APPID                   @"1106870114" // A8体育新闻 广点通Key
#define GDT_A8Fans_APPID                   @"1106696701" // A8球迷社区 广点通Key


#define InMobi_Account_ID            @"6998923b1cc74c129baabeb2dc9bc983"
#define InMobi_Launch_ID             1509317029846
#define InMobi_ALERT_ID              (APP_SHARED_CONFIGURE.inmobi_alert_ID)
#define InMobi_LINE_ID               (APP_SHARED_CONFIGURE.inmobi_line_ID)


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

