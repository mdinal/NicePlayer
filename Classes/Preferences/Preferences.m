/**
 * Preferences.m
 * NicePlayer
 *
 * The preferences cache for the application.
 */

#import "Preferences.h"
#import "../Viewer Interface/NPPluginReader.h"



@implementation Preferences

+(Preferences *)mainPrefs
{
        static Preferences * prefs = nil;
	if(prefs == nil)
		prefs = [Preferences new];
	return prefs;
}

+(int)defaultTimeDisplayValuesNum;
{
	return 2;
}

+(int)defaultRepeatModeValuesNum;
{
	return 3;
}

-(id)init
{
	if((self = [super init])){
		doubleClickMoviePref = [[NSUserDefaults standardUserDefaults] integerForKey:@"doubleClickMoviePref"];
		rightClickMoviePref = [[NSUserDefaults standardUserDefaults] integerForKey:@"rightClickMoviePref"];
		scrollWheelMoviePref = [[NSUserDefaults standardUserDefaults] integerForKey:@"scrollWheelMoviePref"];

		if([[NSUserDefaults standardUserDefaults] objectForKey:@"scrollResizePin"] == nil)
		    scrollResizePin = PIN_SMART;
		else
		    scrollResizePin = [[NSUserDefaults standardUserDefaults] integerForKey:@"scrollResizePin"];
		defaultTimeDisplay = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultTimeDisplay"];
		defaultRepeatMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultRepeatMode"];
		defaultOpenMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultOpenMode"];

		rrSpeed = ([[NSUserDefaults standardUserDefaults] integerForKey:@"rrSpeed"] == 0)
			? 5 
			: [[NSUserDefaults standardUserDefaults] integerForKey:@"rrSpeed"];
		ffSpeed = ([[NSUserDefaults standardUserDefaults] integerForKey:@"ffSpeed"] == 0) 
			? 5 
			: [[NSUserDefaults standardUserDefaults] integerForKey:@"ffSpeed"];

		autoplayOnFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:@"autoplayOnFullScreen"];
		autostopOnNormalScreen = [[NSUserDefaults standardUserDefaults] boolForKey:@"autostopOnNormalScreen"];

		showInitialOverlays = ![[NSUserDefaults standardUserDefaults] boolForKey:@"noShowInitialOverlays"];
		fadeOverlays = ![[NSUserDefaults standardUserDefaults] boolForKey:@"noFadeOverlays"];
		fadeOverlayTime = ([[NSUserDefaults standardUserDefaults] floatForKey:@"fadeOverlayTime"] <= 0.0) 
		    ? 5.0
		    : [[NSUserDefaults standardUserDefaults] floatForKey:@"fadeOverlayTime"];
		
		showNotificationOverlays = ![[NSUserDefaults standardUserDefaults] boolForKey:@"noShowNotificationOverlays"];
		fadeNotificationOverlays = ![[NSUserDefaults standardUserDefaults] boolForKey:@"noFadeNotificationOverlays"];
		displayNotificationTime = ([[NSUserDefaults standardUserDefaults] floatForKey:@"displayNotificationTime"] <= 0.0) 
		    ? 2.0
		    : [[NSUserDefaults standardUserDefaults] floatForKey:@"displayNotificationTime"];
		notificationColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"notificationColor"];
		if(notificationColor)
		    notificationColor =	[[NSUnarchiver unarchiveObjectWithData:notificationColor] retain];
		else
		    notificationColor = [[NSColor whiteColor] retain];
		
		movieOpenedPlay = [[NSUserDefaults standardUserDefaults] boolForKey:@"movieOpenedPlay"];
		movieOpenedFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:@"movieOpenedFullScreen"];
		windowAlwaysOnTop = ![[NSUserDefaults standardUserDefaults] boolForKey:@"windowNotAlwaysOnTop"];
		windowLeaveFullScreen = ![[NSUserDefaults standardUserDefaults] boolForKey:@"windowNotLeaveFullScreen"];
		
		[self integrateViewerPluginPrefs];
	}
	return self;
}

-(enum doubleClickMoviePrefValues)doubleClickMoviePref
{
	return doubleClickMoviePref;
}

-(void)setDoubleClickMoviePref:(enum doubleClickMoviePrefValues)anInt
{
	doubleClickMoviePref = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"doubleClickMoviePref"];
}

-(enum rightClickMoviePrefValues)rightClickMoviePref
{
	return rightClickMoviePref;
}

-(void)setRightClickMoviePref:(enum rightClickMoviePrefValues)anInt
{
	rightClickMoviePref = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"rightClickMoviePref"];
}

-(enum scrollWheelMoviePrefValues)scrollWheelMoviePref
{
    return scrollWheelMoviePref;
}

-(void)setScrollWheelMoviePref:(enum scrollWheelMoviePrefValues)anInt
{
    scrollWheelMoviePref = anInt;
    [[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"scrollWheelMoviePref"];
}

-(enum scrollResizePinValues)scrollResizePin
{
	return scrollResizePin;
}

-(void)setScrollResizePin:(enum scrollResizePinValues)anInt
{
	scrollResizePin = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"scrollResizePin"];
}

-(enum defaultTimeDisplayValues)defaultTimeDisplay
{
	return defaultTimeDisplay;
}

-(void)setDefaultTimeDisplay:(enum defaultTimeDisplayValues)anInt
{
	defaultTimeDisplay = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"defaultTimeDisplay"];
}

-(enum defaultRepeatModeValues)defaultRepeatMode
{
	return defaultRepeatMode;
}

-(void)setDefaultRepeatMode:(enum defaultRepeatModeValues)anInt
{
	defaultRepeatMode = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"defaultRepeatMode"];
}

-(enum defaultOpenModeValues)defaultOpenMode
{
	return defaultOpenMode;
}

-(void)setDefaultOpenMode:(enum defaultOpenModeValues)anInt
{
	defaultOpenMode = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"defaultOpenMode"];
}

#pragma mark -

-(int)rrSpeed
{
	return rrSpeed;
}

-(void)setRrSpeed:(int)anInt
{
	rrSpeed = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"rrSpeed"];
}

-(int)ffSpeed
{
	return ffSpeed;
}

-(void)setFfSpeed:(int)anInt
{
	ffSpeed = anInt;
	[[NSUserDefaults standardUserDefaults] setInteger:anInt forKey:@"ffSpeed"];
}

#pragma mark -

-(BOOL)autoplayOnFullScreen
{
	return autoplayOnFullScreen;
}

-(void)setAutoplayOnFullScreen:(BOOL)aBool
{
	autoplayOnFullScreen = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:aBool forKey:@"autoplayOnFullScreen"];
}

-(BOOL)autostopOnNormalScreen
{
	return autostopOnNormalScreen;
}

-(void)setAutostopOnNormalScreen:(BOOL)aBool
{
	autostopOnNormalScreen = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:aBool forKey:@"autostopOnNormalScreen"];
}

#pragma mark -

-(BOOL)showInitialOverlays
{
	return showInitialOverlays;
}

-(void)setShowInitialOverlays:(BOOL)aBool
{
	showInitialOverlays = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:!aBool forKey:@"noShowInitialOverlays"];
}

-(BOOL)fadeOverlays
{
	return fadeOverlays;
}

-(void)setFadeOverlays:(BOOL)aBool
{
	fadeOverlays = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:!aBool forKey:@"noFadeOverlays"];
}

-(float)fadeOverlayTime
{
    return fadeOverlayTime;
}

-(void)setFadeOverlayTime:(float)aFloat
{
    fadeOverlayTime = aFloat;
    [[NSUserDefaults standardUserDefaults] setFloat:aFloat forKey:@"fadeOverlayTime"];
}

#pragma mark -

-(BOOL)showNotificationOverlays
{
    return showNotificationOverlays;
}

-(void)setShowNotificationOverlays:(BOOL)aBool
{
    showNotificationOverlays = aBool;
    [[NSUserDefaults standardUserDefaults] setBool:!aBool forKey:@"noShowNotificationOverlays"];
}

-(BOOL)fadeNotificationOverlays
{
    return fadeNotificationOverlays;
}

-(void)setFadeNotificationOverlays:(BOOL)aBool
{
    fadeNotificationOverlays = aBool;
    [[NSUserDefaults standardUserDefaults] setBool:!aBool forKey:@"noFadeNotificationOverlays"];
}

-(float)displayNotificationTime
{
    return displayNotificationTime;
}

-(void)setDisplayNotificationTime:(float)aFloat
{
    displayNotificationTime = aFloat;
    [[NSUserDefaults standardUserDefaults] setFloat:aFloat forKey:@"displayNotificationTime"];
}

-(id)notificationColor
{
    return notificationColor;
}

-(void)setNotificationColor:(id)anObject
{
    notificationColor = anObject;
    [[NSUserDefaults standardUserDefaults] setObject:[NSArchiver archivedDataWithRootObject:anObject] forKey:@"notificationColor"];
}

#pragma mark -

-(BOOL)movieOpenedPlay
{
	return movieOpenedPlay;
}

-(void)setMovieOpenedPlay:(BOOL)aBool
{
	movieOpenedPlay = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:aBool forKey:@"movieOpenedPlay"];
}

-(BOOL)movieOpenedFullScreen
{
	return movieOpenedFullScreen;
}

-(void)setMovieOpenedFullScreen:(BOOL)aBool
{
	movieOpenedFullScreen = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:aBool forKey:@"movieOpenedFullScreen"];
}

-(BOOL)windowAlwaysOnTop
{
	return windowAlwaysOnTop;
}

-(void)setWindowAlwaysOnTop:(BOOL)aBool
{
	windowAlwaysOnTop = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:!aBool forKey:@"windowNotAlwaysOnTop"];
}

-(BOOL)windowLeaveFullScreen
{
	return windowLeaveFullScreen;
}

-(void)setWindowLeaveFullScreen:(BOOL)aBool
{
	windowLeaveFullScreen = aBool;
	[[NSUserDefaults standardUserDefaults] setBool:!aBool forKey:@"windowNotLeaveFullScreen"];
}

#pragma mark -

-(void)integrateViewerPluginPrefs
{
	viewerPluginPrefs = [[NPPluginReader pluginReader] integratePrefs:
		[[NSUserDefaults standardUserDefaults] valueForKey:@"viewerPluginPrefs"]];
}

-(NSMutableArray *)viewerPluginPrefs
{
	return viewerPluginPrefs;
}

-(void)setViewerPluginPrefs:(NSMutableArray *)anArray
{
	viewerPluginPrefs = anArray;
	[[NSUserDefaults standardUserDefaults] setObject:anArray forKey:@"viewerPluginPrefs"];
}

@end
