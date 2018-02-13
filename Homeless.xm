#define homelessPrefs @"/var/mobile/Library/Preferences/ch.mdaus.homeless.plist"

@interface MTLumaDodgePillView : UIView
@end

@interface MTStaticColorPillView : UIView
@end

@interface SBDashBoardQuickActionsButton : UIView
@end

@interface SBFLockScreenDateView : UIView
@end

@interface SBFLockScreenDateSubtitleView : UIView
@end

@interface SBDashBordTeachableMomentsContainterView : UIView
@end


static NSMutableDictionary *settings;
BOOL enabled = YES;
BOOL lockscreenBarHidden = YES;
BOOL quickButtonsHidden = YES;
BOOL clockHidden = YES;
BOOL dateHidden = YES;


BOOL appBarHidden = YES;


void refreshPrefs() {
  settings = nil;
  settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[homelessPrefs stringByExpandingTildeInPath]];
  if([settings objectForKey:@"enabled"])enabled = [[settings objectForKey:@"enabled"] boolValue];
  if([settings objectForKey:@"lockscreenBarHidden"])lockscreenBarHidden = [[settings objectForKey:@"lockscreenBarHidden"] boolValue];
  if([settings objectForKey:@"quickButtonsHidden"])quickButtonsHidden = [[settings objectForKey:@"quickButtonsHidden"] boolValue];
  if([settings objectForKey:@"clockHidden"])clockHidden = [[settings objectForKey:@"clockHidden"] boolValue];
  if([settings objectForKey:@"dateHidden"])dateHidden = [[settings objectForKey:@"dateHidden"] boolValue];

  if([settings objectForKey:@"appBarHidden"])appBarHidden = [[settings objectForKey:@"appBarHidden"] boolValue];
}


static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  refreshPrefs();
}



%hook MTLumaDodgePillView
-(void)initWithFrame:(CGRect)arg1{
    %orig(arg1);

    if(enabled && appBarHidden)
        self.alpha = 0;


}
%end


%hook MTStaticColorPillView
-(void)initWithFrame:(CGRect)arg1{
    %orig(arg1);

    if(enabled && lockscreenBarHidden)
        self.alpha = 0;
}
%end


%hook SBDashBoardQuickActionsButton
-(void)initWithFrame:(CGRect)arg1{
    %orig(arg1);

    if(enabled && quickButtonsHidden)
        self.alpha = 0;
}
%end


%hook SBFLockScreenDateView
-(void)initWithFrame:(CGRect)arg1{
    %orig(arg1);

    if(enabled && clockHidden)
        self.hidden = YES;

}
%end

%hook SBFLockScreenDateSubtitleView
-(void)initWithFrame:(CGRect)arg1{
    %orig(arg1);

    if(enabled && dateHidden)
        self.hidden = YES;

}
%end

%ctor {
  @autoreleasepool {
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[homelessPrefs stringByExpandingTildeInPath]];
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("ch.mdaus.homeless.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    refreshPrefs();

  }
}
