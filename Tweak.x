int applicationDidFinishLaunching;

%hook BSPlatform //Enable gestures
- (NSInteger)homeButtonType{
	return 2;
}%end

%hook MTLumaDodgePillSettings //Hide home bar
- (void)setHeight:(double)arg1{
	arg1=0; %orig;
}
- (void)setMinWidth:(double)arg1{
	arg1=0; %orig;
}%end

%hook UIKeyboardImpl //Default keyboard
+(UIEdgeInsets)deviceSpecificPaddingForInterfaceOrientation:(NSInteger)orientation inputMode:(id)mode{
	UIEdgeInsets orig=%orig;
	orig.bottom=0;
	orig.left=0;
	orig.right=0;
	return orig;
}%end

%hook CCUIModularControlCenterOverlayViewController //Hide status bar in CC
- (void)setOverlayStatusBarHidden:(BOOL)arg1{
	return;
}%end

%hook CCUIOverlayStatusBarPresentationProvider  //Hide status bar in CC
- (void)_addHeaderContentTransformAnimationToBatch:(id)arg1 transitionState:(id)arg2{
	return;
}%end

%hook CSQuickActionsViewController //No quick toggles
+ (BOOL)deviceSupportsButtons{
	return NO;
}%end

%hook SBLockHardwareButtonActions //Buttons
- (id)initWithHomeButtonType:(long long)arg1 proximitySensorManager:(id)arg2{
	return %orig(1, arg2);
}%end

%hook SBHomeHardwareButtonActions //Buttons
- (id)initWithHomeButtonType:(long long)arg1{
	return %orig(1);
}%end

%hook SpringBoard //Buttons
-(void)applicationDidFinishLaunching:(id)application{
	applicationDidFinishLaunching=2;
	%orig;
}%end

%hook SBPressGestureRecognizer //Buttons
- (void)setAllowedPressTypes:(NSArray *)arg1{
	NSArray * lockHome=@[@104, @101];
	NSArray * lockVol=@[@104, @102, @103];
	if ([arg1 isEqual:lockVol] && applicationDidFinishLaunching==2){
	%orig(lockHome);
	applicationDidFinishLaunching--;
	return;
	}%orig;
}%end

%hook SBClickGestureRecognizer //Buttons
- (void)addShortcutWithPressTypes:(id)arg1{
	if (applicationDidFinishLaunching==1){
	applicationDidFinishLaunching--;
	return;
	}%orig;
}%end

%hook SBHomeHardwareButton //Buttons
- (id)initWithScreenshotGestureRecognizer:(id)arg1 homeButtonType:(long long)arg2{
	return %orig(arg1,1);
}%end

%hook UITraitCollection //Rounded dock
- (CGFloat)displayCornerRadius {
    return 6.0;
}%end

%hook SBIconView //Hidden labels
-(void)setLabelHidden:(BOOL)arg1 {
    return %orig(YES);
}%end