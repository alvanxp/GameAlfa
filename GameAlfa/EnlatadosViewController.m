//
//  EnlatadosViewController.m
//  GameAlfa
//
//  Created by lion carp on 1/2/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//
#import "GameAlfaService.h"
#import "EnlatadosViewController.h"
#import "Enlatado.h"
#import "TipoEnlatado.h"
#import "DTCustomColoredAccessory.h"
#import "EnlatadoDetailViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
@interface EnlatadosViewController ()
@property (strong, nonatomic) GameAlfaService *enlatadoService;
@end

@implementation EnlatadosViewController

@synthesize enlatados;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.enlatadoService = [[GameAlfaService alloc]init];

    NSLog(@"Starting to retrieve data");
    [self.loadingView startAnimating];
    [self.enlatadoService retrieveEnlatados:^(NSArray *items) {
        
        TipoEnlatado *tipo1 = [[TipoEnlatado alloc] init];
        tipo1.title = @"Abridores";
        tipo1.description = @"Abrir a una nena en cualquier situacion";
        
        tipo1.enlatados = items;
        
        self.enlatados = [[NSMutableArray alloc] initWithObjects:tipo1, nil];
        if (!_expandedSections)
        {
            _expandedSections = [[NSMutableIndexSet alloc] init];
        }

        [self.tableView reloadData];
        NSLog(@"Data loaded , Numero de enlatados %i", tipo1.enlatados.count);
        [self.loadingView stopAnimating];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.enlatados.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([_expandedSections containsIndex:section])
        { 
            TipoEnlatado *objectAtIndex = [self.enlatados objectAtIndex:section];
            return objectAtIndex.enlatados.count+1;
            // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showEnlatado"])
    {
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        EnlatadoDetailViewController *projectViewController = segue.destinationViewController;
        TipoEnlatado *project = [enlatados objectAtIndex:indexPath.section];
        int iRow = indexPath.row-1;
        Enlatado *enlatado = [project.enlatados objectAtIndex:iRow];
        [projectViewController setEnlatado:enlatado];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellOther";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    @try {
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        
        
        if ([self tableView:tableView  canCollapseSection:indexPath.section])
        {
            if (!indexPath.row)
            {
                TipoEnlatado *objectAtIndex = [enlatados objectAtIndex:indexPath.section];
                NSLog(@"explanable %d",indexPath.section);
                //cell.textLabel.text = @"Expandable";
                cell.textLabel.text = objectAtIndex.title;
                cell.detailTextLabel.text = objectAtIndex.description;
                if ([_expandedSections containsIndex:indexPath.section])
                {
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                }
                else
                {
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                }
            }
            else
            {
                //cell.textLabel.text = @"Some Detail";
                NSLog(@"detail %d rows %d",indexPath.section, indexPath.row);
                TipoEnlatado *objectAtIndex = [self.enlatados objectAtIndex:indexPath.section];
                Enlatado *enlatado = [objectAtIndex.enlatados objectAtIndex:indexPath.row-1];
                cell.textLabel.text = enlatado.title;
                cell.detailTextLabel.text = enlatado.resume;
                cell.accessoryView = nil;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        else
        {
            cell.accessoryView = nil;
            //cell.textLabel.text = @"normal cell";
            TipoEnlatado *objectAtIndex = [enlatados objectAtIndex:indexPath.section];
            cell.textLabel.text = objectAtIndex.title;
            cell.detailTextLabel.text = objectAtIndex.description;
        }

    }
    @catch (NSException *exception) {
        NSLog(exception.reason);
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            [self.tableView beginUpdates];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [_expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [_expandedSections removeIndex:section];
            }
            else
            {
                [_expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                
            }
            
            [self.tableView endUpdates];
            
        }
        else
        {
            [self performSegueWithIdentifier:@"showEnlatado" sender:indexPath];
        }
    }
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)dealloc {
    [self.enlatados release];
    [self.enlatadoService release];
    [_loadingView release];
    [super dealloc];
}
@end
