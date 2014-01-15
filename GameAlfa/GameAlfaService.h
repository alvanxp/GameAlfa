//
//  GameAlfaService.h
//  GameAlfa
//
//  Created by lion carp on 1/9/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <Foundation/Foundation.h>
#import "Enlatado.h"
#import "GameAlfaService.h"

#pragma mark * Block Definitions

typedef void (^completionEnlatados) (NSArray *enlatados);
typedef void (^completionBlock) ();
typedef void (^completionWithIndexBlock) (NSUInteger index);
typedef void (^busyUpdateBlock) (BOOL busy);
typedef void (^completionEnlatado) (Enlatado *enlatado);

#pragma mark * TodoService public interface


@interface GameAlfaService : NSObject


@property (nonatomic, strong)   NSMutableArray *enlatados;
// TODO - create an MSClient proeprty
-(void) retrieveEnlatado:(completionEnlatado) completion;

-(void) retrieveEnlatados:(completionEnlatados) completion;

- (void) refreshDataOnSuccess:(completionBlock) completion;

- (void) addItem:(NSDictionary *) item
      completion:(completionWithIndexBlock) completion;

- (void) completeItem: (NSDictionary *) item
           completion:(completionWithIndexBlock) completion;

+(GameAlfaService *)sharedInstance;
//- (NSMutableArray*) getItems;

@end
