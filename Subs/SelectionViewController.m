//
//  SubsMasterViewController.m
//  Subs
//
//  Created by Martin van Amersfoorth on 9/18/12.
//  Copyright (c) 2012 Martin van Amersfoorth. All rights reserved.
//

#import "SelectionViewController.h"

#import "ParamsViewController.h"

@interface SelectionViewController ()
{
    NSMutableArray *_selection;
    NSMutableSet *_players;
}
@end

@implementation SelectionViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
        
    _selection = [[NSMutableArray alloc] initWithObjects:
        @"Aaron", @"Amine", @"Dieuwe", @"Ernesto", @"Ilias", @"Luc",
        @"Mohammed-Amine", @"Stijn", @"Vito", @"Ziggy", nil];
    
    _players = [[NSMutableSet alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckCell"];
    
    cell.textLabel.text = [_selection objectAtIndex:indexPath.row];
    
    if ( [_players containsObject:cell.textLabel.text] )
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selected = [_selection objectAtIndex:indexPath.row];
    
    if ( [_players member:selected] )
    {
        [_players removeObject:selected];
    }
    else
    {
        [_players addObject:selected];
    }
    
    [tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"setPlayers"])
    {
        [[segue destinationViewController] setPlayers:[[_players allObjects] copy]];
    }
}

@end
