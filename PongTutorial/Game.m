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

-(void)Collision
{
    //the ball image touches any part of the player image
    if (CGRectIntersectsRect(Ball.frame, Player.frame)) {
        
        Y = arc4random() %5;
        
        //we have to convert Y to a negative number since the player is at the bottom at the screen, so the ball goes up
        Y = 0 - 5;
    }
    
    if (CGRectIntersectsRect(Ball.frame, Computer.frame)) {
        
        Y = arc4random() %5;
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // allows dragging
    UITouch *Drag = [[event allTouches] anyObject];
    
    //set the player to the point on the screen where the toch is
    Player.center = [Drag locationInView:self.view];
    
    // dont move player vertically, lock y value
    if (Player.center.y > 535) {
        Player.center = CGPointMake(Player.center.x, 535);
    }
    
    if (Player.center.y < 535) {
        Player.center = CGPointMake(Player.center.x, 535);
    }
    
    
    //prevent player to leave the screen
    if (Player.center.x < 37) {
        Player.center = CGPointMake(37, Player.center.y);
    }
    
    if (Player.center.x > 283) {
        Player.center = CGPointMake(283, Player.center.y);
    }
}

-(void)ComputerMovement
{
    
    // if Computer.center.x > Ball.center.x then the computer to the left compered to the ball, move the computer to the left
    if (Computer.center.x > Ball.center.x) {
        Computer.center = CGPointMake(Computer.center.x - 2, Computer.center.y);
    }
    
    // if the computer is to the left to the ball, move it to the right
    if (Computer.center.x < Ball.center.x) {
        Computer.center = CGPointMake(Computer.center.x + 2, Computer.center.y);
    }
    
    //prevent computer to leave the screen
    if (Computer.center.x < 37) {
        Computer.center = CGPointMake(37, Computer.center.y);
    }
    
    if (Computer.center.x > 283) {
        Computer.center = CGPointMake(283, Computer.center.y);
    }
    
}

-(IBAction)StartButton:(id)sender
{
    //every time we push the start button it becomes hidden
    StartButton.hidden = YES;
    Exit.hidden = YES;
    
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
    //run the code ComputerMovement and Collision all the time when BallMovement runs
    [self ComputerMovement];
    [self Collision];
    
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
    
    //scores
    if (Ball.center.y < 0) {
        PlayerScoreNumber = PlayerScoreNumber + 1;
        PlayerScore.text = [NSString stringWithFormat:@"%i", PlayerScoreNumber];
        
        [timer invalidate];
        StartButton.hidden = NO;
        
        //place computer and ball back to center
        Ball.center = CGPointMake(160, 239);
        Computer.center = CGPointMake(160, 32);
        
        if (PlayerScoreNumber == 3) {
            StartButton.hidden = YES;
            Exit.hidden = NO;
            WinOrLose.hidden = NO;
            WinOrLose.text = [NSString stringWithFormat:@"You Win!"];
            
        }
    }
    
    if (Ball.center.y > 580) {
        ComputerScoreNumber = ComputerScoreNumber + 1;
        ComputerScore.text = [NSString stringWithFormat:@"%i", ComputerScoreNumber];
        
        [timer invalidate];
        StartButton.hidden = NO;
        
        //place computer and ball back to center
        Ball.center = CGPointMake(160, 239);
        Computer.center = CGPointMake(160, 32);
        
        if (ComputerScoreNumber == 3) {
            StartButton.hidden = YES;
            Exit.hidden = NO;
            WinOrLose.hidden = NO;
            WinOrLose.text = [NSString stringWithFormat:@"You Lose!"];
            
        }
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
    PlayerScoreNumber = 0;
    ComputerScoreNumber = 0;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
