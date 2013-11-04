//
//  Game.h
//  PongTutorial
//
//  Created by Attila Csala on 11/4/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import <UIKit/UIKit.h>

int Y;
int X;

@interface Game : UIViewController
{
    IBOutlet UIImageView *Ball;
    IBOutlet UIButton *StartButton;
    NSTimer *timer;
}

-(IBAction)StartButton:(id)sender;
-(void)BallMovement;


@end
