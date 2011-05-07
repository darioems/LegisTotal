//
//  LegislacaoTableViewController.m
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RemissivoTableViewController.h"

#import "ViewWithWebViewController.h"


@implementation RemissivoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Monta o índice da Lei
-(void)getIndiceWithIdLegis:(int *)idLegisAux {
    
    
    NSMutableArray *legisAux = [LegisTotal getAllFilhosWithIdLegis:idLegisAux];
    
    if (legisAux != nil) {
        for (int i = 0; i < [legisAux count]; i++) {
            
            LegisTotal *indiceAux = [legisAux objectAtIndex:i];
            
            [indiceCompleto addObject:indiceAux];
            
            [self getIndiceWithIdLegis:indiceAux.idLegis];
            
        }
        
    }
    
}

- (void)dealloc
{
    [indiceCompleto release];
    [remissivo release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    indiceCompleto = [[NSMutableArray alloc] init];
	
	LegisTotal *lei = [[LegisTotal alloc] init];
    
    remissivo = [LegisTotal getAllWithIdTipo:(int *)1];
    
    for (int i = 0; i < [remissivo count]; i++) {
        lei = [remissivo objectAtIndex:i];
        
        [indiceCompleto addObject:lei];
        
        [self getIndiceWithIdLegis:lei.idLegis];
    }
    
    NSLog(@"Indice Completo: %i", [indiceCompleto count]);  
    
    [super setTitle:@"Indice"];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

 - (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     LegisTotal *legisAux = [indiceCompleto objectAtIndex:indexPath.row];
         
     switch ((int)legisAux.idTipo) {
         case 14:
             return 2;
             break;
         case 16:
             return 4;
             break;
         case 17:
             return 6;
             break;
         default:
             return 0;
     }
 }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [indiceCompleto count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
        
    // Configure the cell...*/
    
    LegisTotal *legisAux = [indiceCompleto objectAtIndex:indexPath.row];
	
    if (legisAux.idTipo != (int*)17) {
        cell.textLabel.text = legisAux.descricao;
        cell.detailTextLabel.text = legisAux.texto;
    }
    else {
        cell.textLabel.text = legisAux.descricao;
        cell.detailTextLabel.text = @"";
    }
    
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegisTotal *legisAux = [indiceCompleto objectAtIndex:indexPath.row];
    
    if ((int) legisAux.idTipo == 17) {
		
		ViewWithWebViewController *view = [[ViewWithWebViewController alloc] initWithArtigoId:legisAux.idLegis];	
		
		[self.navigationController pushViewController:view animated:YES];
    }
   // LegisTotal *legisAux = [remissivo objectAtIndex:indexPath.row];    
    
	//FilhosTableViewController *filhosLegis = [[FilhosTableViewController alloc] initWithIdLegis:legisAux.idLegis];
	//[self.navigationController pushViewController:filhosLegis animated:YES];
}

@end
