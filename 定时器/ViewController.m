//
//  ViewController.m
//  定时器
//
//  Created by SGB on 16/3/10.
//  Copyright © 2016年 索马里猫集团股份有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *
     原文链接：http://www.jianshu.com/p/21d351116587

     */
    //一、NSTimer
    //[self createNSTimer];
    
    
    //二、CADisplayLink
    //[self createCADisplayLink];
    
    
    //三、GCD
    //[self createGCD];
    
    //四 加载XML
    
    
}
























































#pragma mark - 创建NSTimer
- (void)createNSTimer
{
    
    /**
     *
     TimerInterval : 执行之前等待的时间。比如设置成1.0，就代表1秒后执行方法
     
     
     target : 需要执行方法的对象。
     
     
     selector : 需要执行的方法   
     
     
     repeats : 是否需要循环
     */
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(action) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    /**
     * 。
     2. 释放方法
     [timer invalidate];
     */
}


#pragma mark - 创建CADisplayLink
- (void)createCADisplayLink
{
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    link.frameInterval = 60;
    
    
    /**
     * 
     文／伯恩的遗产（简书作者）
     原文链接：http://www.jianshu.com/p/21d351116587
     著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
     
     
     2. 停止方法
     ```objc
     [self.displayLink invalidate];
     
     self.displayLink = nil;
     ```
     **当把CADisplayLink对象add到runloop中后，selector就能被周期性调用，类似于重复的NSTimer被启动了；执行invalidate操作时，CADisplayLink对象就会从runloop中移除，selector调用也随即停止，类似于NSTimer的invalidate方法。**
     */
}

#pragma mark - 创建GCD
- (void)createGCD
{
    ////执行一次
    //double delayInSeconds = 2.0;
    //dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        ////执行事件
        //[self action];
    //});
    
    
    
    //重复执行
    
    NSTimeInterval period = 1.0; //设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        //在这里执行事件
        [self action];
    });
    
    dispatch_resume(_timer);
}



//事件
- (void)action
{
    static NSInteger i = 0 ;
    NSLog(@"执行事件%ld",++i);
 
}

@end
