//
//  GameAlfaService.m
//  GameAlfa
//
//  Created by lion carp on 1/9/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//
#import "Enlatado.h"
#import "GameAlfaService.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>


#pragma mark * Private interace


@interface GameAlfaService()

@property (strong, nonatomic) MSClient *client;

@property (strong, nonatomic) MSTable *enlatadoTable;
// TODO - create an MSTable property for your items
@property (nonatomic)           NSInteger busyCount;


@end


#pragma mark * Implementation


@implementation GameAlfaService

@synthesize enlatados;

-(GameAlfaService *) init
{
    self.client = [MSClient clientWithApplicationURLString:@"https://gamealfa.azure-mobile.net/" applicationKey:@"YVDcMAHRYdiquUdaQzYNOTNKcMLUFb50"];
    
    // TODO
    // Create an MSTable instance to allow us to work with the TodoItem table
    self.enlatadoTable = [self.client tableWithName:@"Enlatado"];
    
    self.enlatados = [[NSMutableArray alloc] init];
    
    self.busyCount = 0;
    
    return self;
}

- (void) refreshDataOnSuccess:(completionBlock)completion
{
    // TODO
    // Create a predicate that finds items where complete is false
    
    
    // TODO
    // Query the TodoItem table and update the items property with the results from the service
    [self.enlatadoTable readWithCompletion:^(NSArray *items, NSInteger totalCount, NSError *error) {
        if (error){
            NSLog(@"ERROR %@", error);
        }else
        {
            for (NSDictionary *item in items) {
                Enlatado *enlatado = [[Enlatado alloc] init];
                enlatado.title =[item objectForKey:@"title"];
                enlatado.Description =[item objectForKey:@"description"];
                enlatado.resume = [item objectForKey:@"resume"];
                enlatado.rating = [item objectForKey:@"rating"];
                [enlatados addObject:enlatado];
            }
        }
    }];

    
    completion();
}

-(void) addItem:(NSDictionary *)item completion:(completionWithIndexBlock)completion
{
    // TODO
    // Insert the item into the TodoItem table and add to the items array on completion
    [self.enlatadoTable insert:item completion:^(NSDictionary *insertedItem, NSError *error)
    {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
        }
    }];
    
    NSUInteger index = [enlatados count];
    [(NSMutableArray *)enlatados insertObject:item atIndex:index];
    
    // Let the caller know that we finished
    completion(index);
    
}




-(void) completeItem:(NSDictionary *)item completion:(completionWithIndexBlock)completion
{
    // Cast the public items property to the mutable type (it was created as mutable)
    NSMutableArray *mutableItems = (NSMutableArray *) enlatados;
    
    // Set the item to be complete (we need a mutable copy)
    NSMutableDictionary *mutable = [item mutableCopy];
    [mutable setObject:@(YES) forKey:@"complete"];
    
    // Replace the original in the items array
    NSUInteger index = [enlatados indexOfObjectIdenticalTo:item];
    [mutableItems replaceObjectAtIndex:index withObject:mutable];
    
    // TODO
    // Update the item in the TodoItem table and remove from the items array on completion
    
    
    // TODO
    // Get a fresh index in case the list has changed
    
    
    [mutableItems removeObjectAtIndex:index];
    
    // Let the caller know that we have finished
    completion(index);
    
}

- (void) logErrorIfNotNil:(NSError *) error
{
    if (error) {
        NSLog(@"ERROR %@", error);
    }
}

@end

