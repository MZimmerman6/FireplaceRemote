//
//  ViewController.h
//  FireplaceRemote
//
//  Created by Matthew Zimmerman on 12/21/12.
//  Copyright (c) 2012 Matthew Zimmerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    
    float volume;
    NSString *selectedSong;
    BOOL songPaused;
    int isPaused;
    NSMutableArray *songArray;
    NSMutableArray *filenames;
    
    BOOL sendingUpdate;
    IBOutlet UISlider *volumeSlider;
    
    IBOutlet UIButton *playButton;
    IBOutlet UIButton *pauseButton;
    
}

@property (strong, nonatomic) IBOutlet UITableView *songTable;

-(IBAction)PlayPausePressed:(id)sender;

-(IBAction)volumeChanged:(id)sender;

-(void) updateFireplace;


@end
