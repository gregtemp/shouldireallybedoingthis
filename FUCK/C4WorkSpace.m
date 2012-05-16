//
//  C4WorkSpace.m
//  FUCK
//
//  Created by Gregory Debicki on 12-05-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "C4WorkSpace.h"
#import "SampleRecorder.h"
#import "MySample.h"

@interface C4WorkSpace ()
@property (readwrite, strong) C4Sample *audioSample;
@property (readwrite, strong) SampleRecorder *sampleRecorder;
@end

@implementation C4WorkSpace {
}
@synthesize audioSample, sampleRecorder;

NSInteger myTouches;
CGFloat myVol;
BOOL up;
BOOL shouldireallybedoingthis;

-(void)setup {
    sampleRecorder = [SampleRecorder new];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //CGPoint touch = [[touches anyObject] locationInView:self.canvas];
    
    myTouches++;
    if (myTouches % 4 == 1){
        shouldireallybedoingthis = NO;
        [sampleRecorder recordSample];
        C4Log(@"1");
    }
    if (myTouches % 4 == 2){
        shouldireallybedoingthis = NO;
        [sampleRecorder stopRecording];
        C4Log(@"2");
    }
    if (myTouches % 4 == 3){
        self.audioSample = nil;
        self.audioSample = sampleRecorder.sample;
            if(self.audioSample != nil)
                [self.audioSample play];
        self.audioSample.loops = YES;
        myVol = 0;
        shouldireallybedoingthis = YES;
        up = YES;
        [self fade];
        C4Log(@"3");
        
    }
    if (myTouches % 4 == 0) {
        shouldireallybedoingthis = YES;
        up = NO;
        [self fade];
        C4Log(@"4");
    }
}

-(void) fade {
    
    if (shouldireallybedoingthis == YES){
        if (up == YES){
            if (myVol < 1.0f){
                myVol = myVol + 0.01f;
                [self performSelector:@selector(fade) withObject:nil afterDelay:0.05f];
                C4Log(@"%f", myVol);
            }
            self.audioSample.volume = myVol;
        }
        if (up == NO){
            if (myVol > 0.01f){
                myVol = myVol - 0.01f;
                [self performSelector:@selector(fade) withObject:nil afterDelay:0.05f];
                C4Log(@"%f", myVol);
            }
            self.audioSample.volume = myVol;
            if (myVol <= 0.0f){
                [self.audioSample stop];
                C4Log(@"stop");
            }
        }
    }
    if (shouldireallybedoingthis == NO){
        up = YES;
        myVol = 0;
    }
}


@end
