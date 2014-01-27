//
//  ProjectTableViewController.m
//  GameAlfa
//
//  Created by lion carp on 7/20/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "Project.h"
#import "ProjectDetailViewController.h"
@interface ProjectTableViewController ()

@end

@implementation ProjectTableViewController

@synthesize projects;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        projects = [[NSMutableArray alloc] init];
        
    }
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];
    return self;
}

- (void)dealloc {
    [projects release]; // don't forget to clean up
    // ... more?
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Projects"];
    projects = [[NSMutableArray alloc] init];
    Project *project1 = [[Project alloc] init];
    project1.projectName = @"Mary";
    project1.rating = 45;
    
    
    Project *project2 = [[Project alloc] init];
    project2.projectName = @"Jessy";
    project2.rating = 45;
   
    Project *project3 = [[Project alloc] init];
    project3.projectName = @"Juan";
    project3.rating = 45;
    [projects addObject:project1];
    [projects addObject:project2];
    [projects addObject:project3];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetailProject"])
    {
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        ProjectDetailViewController *projectViewController = segue.destinationViewController;
        Project *project = [projects objectAtIndex:indexPath.row];
        [projectViewController setCurrentProject:project];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"carTableCell";
   UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    Project *project=(Project*) [self.projects objectAtIndex: [indexPath row]];
    cell.textLabel.text =project.projectName;
    cell.detailTextLabel.text = @"advance 45%";
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewC	ellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
