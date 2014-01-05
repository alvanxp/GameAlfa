//
//  EnlatadosViewController.m
//  GameAlfa
//
//  Created by lion carp on 1/2/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "EnlatadosViewController.h"
#import "Enlatado.h"
#import "TipoEnlatado.h"
#import "DTCustomColoredAccessory.h"
@interface EnlatadosViewController ()

@end

@implementation EnlatadosViewController

@synthesize enlatados;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        TipoEnlatado *tipo1 = [[TipoEnlatado alloc] init];
        tipo1.title = @"Abridores";
        tipo1.description = @"Abrir a una nena en cualquier situacion";
        
        
        Enlatado *enlatado1 = [[Enlatado alloc] init];
        enlatado1.title = @"La dirección";
        enlatado1.description = @"En el supermercado abordar al Target en menos de 3 segundos con la frase...";
        
        
        
        NSMutableArray *enlatadotemp = [[NSMutableArray alloc] initWithObjects:enlatado1, nil];
        tipo1.enlatados = enlatadotemp;
        
        enlatados = [[NSMutableArray alloc] initWithObjects:tipo1, nil];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    // Custom initialization
    TipoEnlatado *tipo1 = [[TipoEnlatado alloc] init];
    tipo1.title = @"Abridores";
    tipo1.description = @"Abrir a una nena en cualquier situacion";
    
    
    Enlatado *enlatado1 = [[Enlatado alloc] init];
    enlatado1.title = @"La dirección";
    enlatado1.description = @"En el supermercado abordar al Target en menos de 3 segundos con la frase...";
    
    
    
    NSMutableArray *enlatadotemp = [[NSMutableArray alloc] initWithObjects:enlatado1, nil];
    tipo1.enlatados = enlatadotemp;
    
    enlatados = [[NSMutableArray alloc] initWithObjects:tipo1, nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    //if (section>0) return YES;
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
    //return enlatados.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            TipoEnlatado *objectAtIndex = [enlatados objectAtIndex:section];
            return objectAtIndex.enlatados.count+1;
            // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellOther";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    
    
    // Configure the cell...
    
    if ([self tableView:tableView  canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            TipoEnlatado *objectAtIndex = [enlatados objectAtIndex:indexPath.section];
            NSLog(@"explanable %d",indexPath.section);
            //cell.textLabel.text = @"Expandable";
            cell.textLabel.text = objectAtIndex.title;
            
            if ([expandedSections containsIndex:indexPath.section])
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
            TipoEnlatado *objectAtIndex = [enlatados objectAtIndex:indexPath.section];
            Enlatado *enlatado = [objectAtIndex.enlatados objectAtIndex:indexPath.row-1];
            cell.textLabel.text = enlatado.title;
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
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //tableView.can
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            [self.tableView beginUpdates];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
            }
            else
            {
                [expandedSections addIndex:section];
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

@end
