//
//  GameAlfaService.h
//  GameAlfa
//
//  Created by lion carp on 1/9/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <Foundation/Foundation.h>


#pragma mark * Block Definitions


typedef void (^completionBlock) ();
typedef void (^completionWithIndexBlock) (NSUInteger index);
typedef void (^busyUpdateBlock) (BOOL busy);


#pragma mark * TodoService public interface


@interface GameAlfaService : NSObject


@property (nonatomic, strong)   NSMutableArray *enlatados;
// TODO - create an MSClient proeprty

- (void) refreshDataOnSuccess:(completionBlock) completion;

- (void) addItem:(NSDictionary *) item
      completion:(completionWithIndexBlock) completion;

- (void) completeItem: (NSDictionary *) item
           completion:(completionWithIndexBlock) completion;

//- (NSMutableArray*) getItems;

@end
