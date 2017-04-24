//
//  GameViewController.m
//  p07-scagnelli
//
//  Created by Eric Scagnelli on 4/19/17.
//  Copyright © 2017 escagne1. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics = YES;
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

@end
