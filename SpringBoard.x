#import <AVFoundation/AVFoundation.h>
#import <HBLog.h>

AVAudioPlayer *player;

void playOofSound() {
    HBLogDebug(@"Press F to pay respects");

    NSBundle *resourceBundle = [NSBundle bundleWithPath:@"/var/mobile/Library/oof/foo.bundle"];
    NSURL *audioURL = [resourceBundle URLForResource:@"oof" withExtension:@"wav"];

    if (!player) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
        player.numberOfLoops = 0;
        player.volume = 1.0;

        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    }
    
    [player play];
}

%hook SBApplication

- (void)didAnimateDeactivation {
    %orig;

    playOofSound();
}

%end