//
//  ViewController.m
//  GRtictac
//
//  Created by Student P_01 on 28/09/16.
//  Copyright © 2016 Gunjan Rane. All rights reserved.
//

#import "ViewController.h"
#import "secondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initGame];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initGame{
    numberOfTurnsToPlay = 0;
    currentPlayer = 1;
    gameFinished = false;
    
    winCombinationArray =@[@[@0,@1,@2],
                           @[@1,@4,@7],
                           @[@3,@4,@5],
                           @[@2,@5,@8],
                           @[@6,@7,@8],
                           @[@0,@4,@8],
                           @[@0,@3,@6],
                           @[@2,@4,@6]];
    
    stateCheckArray = [[NSMutableArray alloc]initWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
    
    for(int i=100; i<=108 ;i++){
        UIButton *button =[ self.view viewWithTag:i];
        [button setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    }
}


//- (IBAction)lastWinAction:(id)sender {
//    [self buttonTap:[NSString stringWithFormat:@"%d",player]];
//    
//    secondViewController *SecondView=[self.storyboard instantiateViewControllerWithIdentifier:@"secondViewController"];
//    SecondView.valueFromTicTacToe =[NSString stringWithFormat:@"%d",player];
//    [self.navigationController pushViewController:SecondView animated:YES];
//    [self.navigationController setNavigationBarHidden:YES];
//    
//
//}

- (IBAction)buttonTap:(id)sender {
    
    numberOfTurnsToPlay=numberOfTurnsToPlay+1;
    UIButton *tile=sender;
    player=currentPlayer;
    UIImage*playerImage;
    
    
    BOOL isButtonNotSelected =[[stateCheckArray objectAtIndex:(tile.tag-100)] isEqual:@0];
    
    if(isButtonNotSelected){
        if(!gameFinished){
            if(player==1){
                playerImage =[UIImage imageNamed:@"nought"];
                [stateCheckArray replaceObjectAtIndex:(tile.tag-100) withObject:@1];
                currentPlayer=2;
            }
            else{
                playerImage =[UIImage imageNamed:@"cross"];
                [stateCheckArray replaceObjectAtIndex:(tile.tag-100) withObject:@2];
                currentPlayer=1;
            }
        }
        [tile setBackgroundImage:playerImage forState:UIControlStateNormal];
    }
    else{
        [self showAlertWithTitle:@"caution" message:@"please select another tile.."];
        
    }
    if(numberOfTurnsToPlay >=5){
        for(NSArray *combination in winCombinationArray){
            int indexOfTileOne =[[combination objectAtIndex:0]intValue];
            int indexOfTileTwo =[[combination objectAtIndex:1]intValue];
            int indexOfTileThree =[[combination objectAtIndex:2]intValue];
            NSNumber *stateAtTileOne =[stateCheckArray objectAtIndex:indexOfTileOne];
            NSNumber *stateAtTileTwo =[stateCheckArray objectAtIndex:indexOfTileTwo];
            NSNumber *stateAtTileThree =[stateCheckArray objectAtIndex:indexOfTileThree];
            
            if(![stateAtTileOne isEqual:@0] && [stateAtTileOne isEqual:stateAtTileTwo] && [stateAtTileTwo isEqual:stateAtTileThree]){
                gameFinished =YES;
                NSString *winningStatement =[NSString stringWithFormat:@"player %d has won",player];
                [self endAlertWithTitle:winningStatement messsage:@"Do you want to play again"];
                break;
            }
        }
    }
    if(!gameFinished){
        BOOL valuePresent = [stateCheckArray containsObject:@0];
        
        if(!valuePresent){
            [self endAlertWithTitle:@"Game Draw" messsage:@"Do you want to play again"];
            
        }
    }
    
    }






-(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message{
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)endAlertWithTitle:(NSString *)title
                messsage:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self initGame];
        
    }];
    [alert addAction:OK];
    
    
    //[self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancle= [UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
    }];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
    

}
- (IBAction)lastWinAction:(id)sender {
//    [self buttonTap:[NSString stringWithFormat:@"%d",player]];
    
    secondViewController *SecondView=[self.storyboard instantiateViewControllerWithIdentifier:@"secondViewController"];
    SecondView.valueFromTicTacToe =[NSString stringWithFormat:@"%d",player];
    [self.navigationController pushViewController:SecondView animated:YES];
//    [self.navigationController setNavigationBarHidden:YES];

}
@end
