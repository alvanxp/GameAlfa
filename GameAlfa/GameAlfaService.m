//
//  GameAlfaService.m
//  GameAlfa
//
//  Created by lion carp on 1/9/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//
#import "Enlatado.h"
#import "CacheManager.h"
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

- (void) retrieveEnlatados:(completionEnlatados)completion
{
   
    CacheEntity *cacheManager = [[[CacheManager sharedInstance] entityManager] getCacheManagerByName:@"ENLATADO"];
    
    
    
    
    if ((cacheManager != nil) && ((int)[cacheManager.expirationDate timeIntervalSinceNow] >0))
    {
            NSArray *result=nil;
            result = [[[CacheManager sharedInstance] enlatadoManager] getEnlatados];
            completion(result);
    }else
    {
        [self.enlatadoTable readWithCompletion:^(NSArray *items, NSInteger totalCount, NSError *error) {
            if (error){
                NSLog(@"ERROR %@", error);
                completion(NULL);
            }else
            {
                [[[CacheManager sharedInstance] entityManager] DeleteItem:@"ENLATADO"];
                [[[CacheManager sharedInstance] enlatadoManager] deleteItems];
                
                CacheEntity *newCacheManager = [[CacheEntity alloc] init];
                newCacheManager.entity = @"ENLATADO";
                newCacheManager.downloadDate = [NSDate date];
                newCacheManager.expirationDate = [newCacheManager.downloadDate dateByAddingTimeInterval:(5*60)];
                int idEntity = [[[CacheManager sharedInstance] entityManager] AddNewCacheManagerItem:
                                newCacheManager];
                NSArray *result=nil;
                NSMutableArray *tempResult = [[NSMutableArray alloc]init];
                for (NSDictionary *item in items) {
                    Enlatado *enlatado = [[Enlatado alloc] init];
                    enlatado.title =[item objectForKey:@"title"];
                    enlatado.description =[item objectForKey:@"description"];
                    enlatado.resume = [item objectForKey:@"resume"];
                    enlatado.rating = [item objectForKey:@"rating"];
                    [tempResult addObject:enlatado];
                    [[[CacheManager sharedInstance] enlatadoManager] AddNewEnlatado:enlatado];
                }
                result = [NSArray arrayWithArray:tempResult];
                
                completion(result);
                // result = [[NSArray alloc] initWithArray:tempEnlatados];
            }
        }];
    }
}



- (void) refreshDataOnSuccess:(completionBlock)completion
{
    // TODO
    // Create a predicate that finds items where complete is false
    
    
    // TODO
    // Query the TodoItem table and update the items property with the results from the service
    

    
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

