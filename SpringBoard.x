#import <AVFoundation/AVFoundation.h>
#import <FrontBoard/FBProcess.h>
#import <FrontBoard/FBProcessState.h>
#import <Cephei/HBPreferences.h>

BOOL enabled;
AVAudioPlayer *player;

#pragma mark - Functionality

void playOofSound() {
    if (!enabled) {
        return;
    }

    // Get sound URL
    NSBundle *resourceBundle = [NSBundle bundleWithPath:@"/var/mobile/Library/oof/foo.bundle"];
    NSURL *audioURL = [resourceBundle URLForResource:@"oof" withExtension:@"wav"];

    if (!player) {
        // Create player
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
        player.numberOfLoops = 0;
        player.volume = 1.0;

        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    }
    
    // Play oof
    [player play];
}

#pragma mark - Hooks

%hook SBMainWorkspace

- (void)process:(FBProcess *)process stateDidChangeFromState:(FBProcessState *)fromState toState:(FBProcessState *)toState {
    %orig;

    if (!fromState.foreground || toState.foreground) {
        return;
    }

    playOofSound();
}

%end

#pragma mark - Constructor

%ctor {
    // Load Preferences
    HBPreferences *preferences = [HBPreferences preferencesForIdentifier:@"com.shade.oof"];
    [preferences registerBool:&enabled default:YES forKey:@"enabled"];
}