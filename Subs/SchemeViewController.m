//
//  SchemeViewController.m
//  Subs
//
//  Created by Martin van Amersfoorth on 9/18/12.
//  Copyright (c) 2012 Martin van Amersfoorth. All rights reserved.
//

#import "SchemeViewController.h"
#import "NSArray+Addons.h"
#import "AudioToolbox/AudioToolbox.h"

@implementation SchemeViewController
@synthesize countdownLabel;

NSTimer *timer;
int counter = 0;
NSArray *sectionTitles;
NSArray *sectionData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *keepers = [_players intersection:@[@"Dieuwe", @"Luc", @"Ziggy"]];
    NSString *keeper = [keepers firstObject];
    keepers = @[keeper];
    _players = [_players difference:keepers];
    
    NSArray *pips = [_players intersection:@[@"Stijn", @"Vito"]];
    _players = [_players difference:pips];
    
    NSArray *subs = [_players subarrayWithRange:NSMakeRange(0, _numSubs)];
    NSArray *squad = [_players difference:subs];
    
    sectionTitles = @[
        @"Subs",
        @"Squad",
        @"Pips",
        @"Keeper" ];
    
    sectionData = @[
        [[NSMutableArray alloc] initWithArray:subs],
        [[NSMutableArray alloc] initWithArray:squad],
        [[NSMutableArray alloc] initWithArray:pips],
        [[NSMutableArray alloc] initWithArray:keepers]];
}

- (void)setPlayers:(NSArray *)players
{
    _players = [players shuffle];
}

- (void)setNumOutfield:(int)numOutfield
{
    _numOutfield = numOutfield;
}

- (void)setNumSubs:(int)numSubs
{
    _numSubs = numSubs;
}

- (void)setNumMinutes:(int)numMinutes
{
    _numMinutes = numMinutes;
}

- (NSString *)timeRemaining:(int)seconds
{
    return [NSString stringWithFormat:@"%d:%02d",(int)floor( seconds / 60.0 ), seconds % 60];
}

- (int)rotationSpeed
{
    NSMutableArray *subs = [sectionData objectAtIndex:0];
    NSMutableArray *lineup = [sectionData objectAtIndex:1];
    
    int numberOfPlayers = subs.count + lineup.count;
    
    if ( numberOfPlayers > 0 )
    {
        return _numMinutes * 60 / numberOfPlayers;
    }
    
    return 0;
}

- (void)updateTimer
{
    int rotationSpeed = [self rotationSpeed];
    
    if ( ++counter < rotationSpeed )
    {
        [countdownLabel setText:[self timeRemaining:rotationSpeed - counter]];
    }
    else
    {
        AudioServicesPlaySystemSound(1005);
        [self stopTimer];
    }
}

- (void)showTimer
{
    [countdownLabel setText:[self timeRemaining:[self rotationSpeed]]];
}

- (void)startTimer
{
    [self showTimer];
    counter = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if ( timer != nil )
    {
        [timer invalidate];
        timer = nil;        
    }
}

- (IBAction)replace:(id)sender
{
    NSMutableArray *lineup = [sectionData objectAtIndex:1];
    NSString *out = [lineup objectAtIndex:0];
    
    NSMutableArray *subs = [sectionData objectAtIndex:0];
    NSString *in = [subs objectAtIndex:0];
    
    [lineup removeObject:out];
    [lineup addObject:in];

    [subs removeObject:in];
    [subs addObject:out];
    
    [_tableView reloadData];
    
    [self stopTimer];
    [self startTimer];
}

- (IBAction)edit:(id)sender
{
    if ( [_tableView isEditing] )
    {
        [_tableView setEditing:NO];
        [sender setTitle:@"Edit"];
        [countdownLabel setText:[self timeRemaining:[self rotationSpeed]]];
    }
    else
    {
        [_tableView setEditing:YES animated:YES];
        [sender setTitle:@"Done"];
    }
}

- (IBAction)timer:(id)sender
{
    if ( timer != nil )
    {
        [self stopTimer];
        [sender setTitle:@"Start"];
    }
    else
    {
        [self startTimer];
        [sender setTitle:@"Stop"];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sectionData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchemeCell"];
    cell.textLabel.text = [[sectionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *sourceArray = [sectionData objectAtIndex:sourceIndexPath.section];
    NSMutableArray *destinationArray = [sectionData objectAtIndex:destinationIndexPath.section];
    
    NSString *sourceItem = [sourceArray objectAtIndex:sourceIndexPath.row];
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    [destinationArray insertObject:sourceItem atIndex:destinationIndexPath.row];
}

@end
