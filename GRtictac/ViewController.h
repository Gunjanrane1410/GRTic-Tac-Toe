//
//  ViewController.h
//  GRtictac
//
//  Created by Student P_01 on 28/09/16.
//  Copyright © 2016 Gunjan Rane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    int numberOfTurnsToPlay;
    int currentPlayer;
    BOOL gameFinished;
    int player;

    
    NSArray *winCombinationArray;
    NSMutableArray *stateCheckArray;
}

- (IBAction)buttonTap:(id)sender;
- (IBAction)lastWinAction:(id)sender;


@end

