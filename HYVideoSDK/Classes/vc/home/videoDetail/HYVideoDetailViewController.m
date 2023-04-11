//
//  HYVideoDetailViewController.m
//  HYBaseTool
//
//  Created by oceanMAC on 2023/4/4.
//

#import "HYVideoDetailViewController.h"
#import <SJVideoPlayer/SJVideoPlayer.h>
#import <Masonry/Masonry.h>

#import <SJMediaCacheServer/NSURLRequest+MCS.h>
#import <SJMediaCacheServer/MCSURL.h>
#import <SJMediaCacheServer/MCSPrefetcherManager.h>
#import <SJBaseVideoPlayer/SJAVMediaPlaybackController.h>
#import <SJBaseVideoPlayer/SJBaseVideoPlayerConst.h>
#import "MCSDownload.h"
#import "SJMediaCacheServer.h"


static NSString *const DEMO_URL_HLS = @"https://cache.we-vip.com:2096/file.m3u8?data=NwmwEe5eNbjbU3YjM1YzU3MzQ3ZTE3OTA4NjY3M2Q4OThlZjQxNjgwNjAwNzEy";
//static NSString *const DEMO_URL_HLS = @"https://cache.we-vip.com:2096/file.m3u8?data=NwmwEe5eNbjbU3YjM1YzU3MzQ3ZTE3OTA4NjY3M2Q4OThlZjQxNjgwODUyNzE0";


@interface HYVideoDetailViewController ()

@property (nonatomic, strong, nullable) SJVideoPlayer *player;

@end

@implementation HYVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.redColor;
    [self.navBackButton setTitle:@"" forState:0];
    
    [self _setupViews];

    SJMediaCacheServer.shared.enabledConsoleLog = YES;
    SJMediaCacheServer.shared.logOptions = MCSLogOptionDownloader;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *url = DEMO_URL_HLS;
        NSURL *URL = [NSURL URLWithString:url];
        [self _play:URL];
    });
}

- (void)_setupViews {
    
    _player = SJVideoPlayer.player;
    _player.pausedInBackground = YES;
    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.centerY.offset(0);
        make.height.offset(210);
    }];
}

#pragma mark -

- (void)_play:(NSURL *)URL {
//    URL = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"com.SJMediaCacheServer.cache/87d5ff79f295648c071555a12fb412cc/file_0_0.mp4"]];
    
    NSURL *playbackURL = [SJMediaCacheServer.shared playbackURLWithURL:URL];
    // play
    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:playbackURL startPosition:0];
}

@end
