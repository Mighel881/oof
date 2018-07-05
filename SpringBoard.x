#import <AVFoundation/AVFoundation.h>
#import <Cephei/HBPreferences.h>

BOOL enabled;
AVAudioPlayer *player;

void playOofSound() {
    if (!enabled) {
        return;
    }

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

%ctor {
    HBPreferences *preferences = [HBPreferences preferencesForIdentifier:@"com.shade.oof"];
    [preferences registerBool:&enabled default:YES forKey:@"enabled"];
}