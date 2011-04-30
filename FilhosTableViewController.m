//
//  FilhosTableViewController.m
//  LegisTotal
//
//  Created by Dário on 07/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilhosTableViewController.h"

#import "ViewWithWebViewController.h"

#import "CustomCell.h"


@implementation FilhosTableViewController


-(id)initWithIdLegis:(int *) idLegis{
	
	
	if (self == [super initWithStyle:UITableViewStylePlain]) {
		
		allFilhos = [LegisTotal getAllFilhosWithIdLegis:idLegis]; 
		
	}
	
	return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	LegisTotal *tipoFilho = [allFilhos objectAtIndex:0];
	
	TipoLeis *tipoLei = [TipoLeis getTiposWithIdTipo:tipoFilho.idTipo];
	
	[self setTitle:tipoLei.tipo];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [allFilhos count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	LegisTotal *filhoAux = [allFilhos objectAtIndex:indexPath.row];
	
	if ((int) filhoAux.idTipo != 17) {
		cell.textLabel.text = filhoAux.descricao;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.detailTextLabel.text = filhoAux.texto;
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];
        
	}
	else {
		cell.textLabel.text = filhoAux.descricao;
	}

    
    return cell;*/
    
    //********************//
	//Celulas customizadas com XIB
	static NSString *CellIdentifier = @"CustomCell";
	
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell3" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCell *) currentObject;
                [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
				break;
			}
		}
	}
	
	// Configure the cell.
    
    LegisTotal *filhoAux = [allFilhos objectAtIndex:indexPath.row];
	
	if ((int) filhoAux.idTipo != 17) {
        
        NSMutableArray *allFilhosAux = [LegisTotal getAllFilhosWithIdLegis:filhoAux.idLegis];
        
        
        LegisTotal *tipoFilhoAux = [allFilhosAux objectAtIndex:0];
        
        TipoLeis *tipoLeiAux = [TipoLeis getTiposWithIdTipo:tipoFilhoAux.idTipo];
        
		cell.titulo.text = filhoAux.descricao;
        cell.subtitulo.text = filhoAux.texto;
        cell.conteudo.text = [[NSString alloc] initWithFormat: @"%@ do 1 ao %i",tipoLeiAux.tipo, [allFilhos count]];
        
	}
	else {
        LegisTotal *leiArtAux = [LegisTotal getLegisWithIdLegis:filhoAux.idPai];
        
        while (leiArtAux.idPai != nil) {
            cell.conteudo.text = leiArtAux.texto;
            leiArtAux = [LegisTotal getLegisWithIdLegis:leiArtAux.idPai];
            
        }
        
		cell.titulo.text = filhoAux.descricao;
        cell.subtitulo.text = leiArtAux.descricao;
	}
    
    
    return cell;
	
    
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	LegisTotal *legisAux = [allFilhos objectAtIndex:indexPath.row];
	
	if ((int) legisAux.idTipo != 17) {
		FilhosTableViewController *filhosLegis = [[FilhosTableViewController alloc] initWithIdLegis:legisAux.idLegis];
		[self.navigationController pushViewController:filhosLegis animated:YES];
		
	}
	else {
		
		ViewWithWebViewController *view = [[ViewWithWebViewController alloc] initWithArtigoId:legisAux.idLegis];	
		
		[self.navigationController pushViewController:view animated:YES];
		
	}

    
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[allFilhos release];
    [super dealloc];
}


@end

