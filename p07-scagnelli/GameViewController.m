//
//  GameViewController.m
//  p07-scagnelli
//
//  Created by Eric Scagnelli on 4/19/17.
//  Copyright © 2017 escagne1. All rights reserved.
//

#import "GameViewController.h"
#import "Universe.h"
#import "Level.h"

@implementation GameViewController
@synthesize levelScoreLabel, totalScoreLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Game view did load %@", self);
    
    totalScoreInt = 0;
    levelScoreInt = 0;
    
    // Load the SKScene from 'GameScene.sks'
    scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    [scene setGameDelegate:self];
    
    [[Universe sharedInstance] setGameViewController:self];
    
    [scene setCurrentLevel:[[Universe sharedInstance] getCurrentLevel]];
    [scene levelSetup:1000];
    
    
/*
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics = YES;
*/
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)setGameSceneLevel:(Level *)level{
    [scene setCurrentLevel:level];
}

-(IBAction)pauseGame:(id)sender{
    scene.paused = YES;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main"
                                    bundle:[NSBundle mainBundle]];
    UIViewController *pauseController = [storyBoard
                instantiateViewControllerWithIdentifier:@"pauseController"];
    [self presentViewController:pauseController animated:YES completion:nil];
}

-(IBAction)resumeGame:(UIStoryboardSegue *)segue{
    scene.paused = NO;
}

-(IBAction)restartLevel:(UIStoryboardSegue *)segue{
    
    [scene clearBlocksAndStars];
    Level *level = [[Universe sharedInstance] getCurrentLevel];
    level.levelBegan = NO;
    [self totalScoreChanged:scene.currentRoundPoints * -1];  //Get rid of the points we already awarded this level
    [scene setCurrentLevel:level];
    NSLog(@"Setting up level with %d", level.possibleScore);
    [scene levelSetup:level.possibleScore];
}

-(void)levelScoreChanged:(int)difference{
    levelScoreInt -= difference;
    levelScoreLabel.text = [NSString stringWithFormat:@"%d", levelScoreInt];
}

-(void)totalScoreChanged:(int)difference{
    totalScoreInt += difference;
    totalScoreLabel.text = [NSString stringWithFormat:@"%d", totalScoreInt];
}

-(void)setUpLevel:(int)startingScore{
    levelScoreLabel.text = [NSString stringWithFormat:@"%d", startingScore];
    levelScoreInt = startingScore;
}

-(void)showLostLevelScreen{

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *lostLevelController = [storyBoard
                       instantiateViewControllerWithIdentifier:@"LostLevelViewController"];
    [self presentViewController:lostLevelController animated:YES completion:nil];
}

-(void)nextLevel{
    [scene levelSetup:[[Universe sharedInstance] getCurrentLevel].possibleScore];
}

-(void)clearLevel{
    [scene clearBlocksAndStars];
}

@end
