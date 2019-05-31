//
//  AppDelegate.m
//  DockButtonTest
//
//  Created by BP on 30/05/2019.
//  Copyright © 2019 BP. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
{
    id activity;
    NSDate * _dateStart;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    //使window位于界面最上层
    [self.window orderFront:self];
    _dateStart = [NSDate date];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //若没有下边的函数，timer会因为系统的休眠机制，调用的频率越来越慢。当软件与其他自动化软件配合使用的时候，软件的休眠可能会导致一些问题，所以用以下函数来避免这个问题。
    [self avoidSleep];
}

- (void)getTime
{
    NSTimeInterval time1 =[[NSDate date] timeIntervalSinceDate:_dateStart];//获取从点击开始之后的时间
    // NSDateFormatter *format1=[[NSDateFormatter alloc]init];
    // [format1 setDateFormat:@"mm:ss:SS"];
    //_timelab.stringValue = [format1 stringFromDate:date];
    
    //若上边未调用avoidSleep函数，这个打印信息的频率会越来越慢。
    NSLog(@"%@",[NSString stringWithFormat:@"%.2f",time1]);
}

//防止软件休眠
- (void)avoidSleep
{
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(beginActivityWithOptions:reason:)])
    {
        if(activity == nil)
        {
            activity = [[NSProcessInfo processInfo] beginActivityWithOptions:NSActivityUserInitiatedAllowingIdleSystemSleep reason:@"Disable App Nap"];
        }
    }
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//点击关闭按钮后彻底关闭app
//- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
//{
//    return YES;
//}

//设置点击Dock，使app重新打开。注意！！！ 在MainMenu.xib中取消“Visible At Launch”。
- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    if (flag) {
        return NO;
    }else{
        [self.window makeKeyAndOrderFront:self];
        return YES;
    }
}

//将nstextField和nsbutton绑定在此同一个方法。
- (IBAction)clickBtn:(id)sender {
    NSLog(@"%@",_tf1.stringValue);
}

@end
