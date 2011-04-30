//
//  FilhosTableViewController.h
//  LegisTotal
//
//  Created by Dário on 07/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LegisTotal.h"

#import "TipoLeis.h"

@interface FilhosTableViewController : UITableViewController {
	
	NSMutableArray *allFilhos;
    

}

-(id)initWithIdLegis:(int *) idLegis;

@end
