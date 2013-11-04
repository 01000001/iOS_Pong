//
//  Game.m
//  PongTutorial
//
//  Created by Attila Csala on 11/4/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

-(IBAction)StartButton:(id)sender
{
    // running the random number generator to produce anything between 0 an 10 inc 0 and 10
    Y = arc4random() % 11;
    // make this range from -5 to 5, so 50-50 chance the ball is gonna go up or down
    Y = Y - 5;
    
    X = arc4random() % 11;
    X = X - 5;
    
    // don't let the ball move directy up or down
    if (Y == 0)
    {
        Y = 1;
    }
    
    if (X == 0) {
        X = 1;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(BallMovement) userInfo:nil repeats:YES];
}

-(void)BallMovement
{
    // changing X and Y in order to move to ball
    Ball.center = CGPointMake(Ball.center.x + X, Ball.center.y + Y);
    
    //the size of the image of the ball is 30, 30/2 = 15, if x < 15 bounce ball back
    if (Ball.center.x < 15) {
        // if x < 15, x must be moving towards the left side of the screen, in this case x must be negative
        // if we subtract a negative number from 0 we got back a positive number
        X = 0 - X;
    }
    
    if (Ball.center.x > 305) {
        X = 0 - X;
    }
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
