//
//  LegislacaoTableViewController.h
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LegisTotal.h"


@interface RemissivoTableViewController : UITableViewController {
    
    NSMutableArray *remissivo;
    NSMutableArray *allFilhos;
    NSMutableArray *indiceCompleto;
}

// Monta o índice da Lei
-(void)getIndiceWithIdLegis:(int *)idLegisAux;

@end
