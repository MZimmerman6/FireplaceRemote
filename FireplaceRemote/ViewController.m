//
//  ViewController.m
//  FireplaceRemote
//
//  Created by Matthew Zimmerman on 12/21/12.
//  Copyright (c) 2012 Matthew Zimmerman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize songTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sendingUpdate = NO;
    
    songArray = [[NSMutableArray alloc] init];
    filenames = [[NSMutableArray alloc] init];
    
    [songArray addObject:@"Fireplace Crackling"];
    [filenames addObject:@"crackling"];
    
    [songArray addObject:@"I'll Be Home For Christmas"];
    [filenames addObject:@"illbehome"];
    
    [songArray addObject:@"Silent Night"];
    [filenames addObject:@"silentnight"];
    
    [songArray addObject:@"Let It Snow! Let It Snow! Let It Snow!"];
    [filenames addObject:@"letitsnow"];
    
    [songArray addObject:@"What Child Is This"];
    [filenames addObject:@"whatchild"];
    
    [songArray addObject:@"Away In A Manger"];
    [filenames addObject:@"awayinamanger"];
    
    [songArray addObject:@"White Christmas"];
    [filenames addObject:@"whitechristmas"];
    
    [songArray addObject:@"Joy To The World"];
    [filenames addObject:@"joytotheworld"];
    
    [songArray addObject:@"Go Tell It On The Mountain"];
    [filenames addObject:@"gotellitto"];
    
    [songArray addObject:@"O Little Town Of Bethlehem"];
    [filenames addObject:@"olittletown"];
    
    [songArray addObject:@"Winter Wonderland"];
    [filenames addObject:@"winterwonderland"];
    
    [songArray addObject:@"The Little Drummer Boy"];
    [filenames addObject:@"littledrummer"];
    
    [songArray addObject:@"O Holy Night"];
    [filenames addObject:@"oholynight"];
    
    [songArray addObject:@"Silver Bells"];
    [filenames addObject:@"silverbells"];
    
    [songArray addObject:@"Have Yourself A Merry Little Christmas"];
    [filenames addObject:@"haveyourself"];
    
    isPaused = 0;
    [playButton setHidden:YES];
    selectedSong = @"silentnight";
    volume = [volumeSlider value];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)PlayPausePressed:(id)sender {
    
    if (isPaused == 1) {
        [playButton setHidden:YES];
        [pauseButton setHidden:NO];
        isPaused = 0;
    } else {
        [playButton setHidden:NO];
        [pauseButton setHidden:YES];
        isPaused = 1;
    }
    [self updateFireplace];

}

-(IBAction)volumeChanged:(id)sender {
    
    UISlider *volSlider = (UISlider*)sender;
    volume = [volSlider value];
    [self updateFireplace];
}

-(void) updateFireplace {
    
    if (!sendingUpdate) {
        NSURL *updateURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://mzimm16.dyndns.org/Fireplace/postUpdate.php?file=%@&volume=%f&pause=%i",selectedSong,volume,isPaused]];
        
        NSURLRequest *updateRequest = [[NSURLRequest alloc] initWithURL:updateURL cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:1.5];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:updateRequest delegate:self];
        connection = nil;
        sendingUpdate = YES;
    }
    
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    sendingUpdate = NO;
    NSLog(@"request failed");
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection {
    sendingUpdate = NO;
    NSLog(@"sent request");
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [songArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = [songArray objectAtIndex:indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedSong = [filenames objectAtIndex:indexPath.row];
    NSLog(@"%@",selectedSong);
    [self updateFireplace];
}


@end
