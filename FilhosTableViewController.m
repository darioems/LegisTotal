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
    
    //********************//
	//Celulas customizadas com XIB
	static NSString *CellIdentifier = @"CustomCell";
	
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell3" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCell *) currentObject;
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
				break;
			}
		}
	}
	
	// Configure the cell.
    
    LegisTotal *filhoAux = [allFilhos objectAtIndex:indexPath.row];
	
	if ((int) filhoAux.idTipo != 17) {
        
        NSMutableArray *allFilhosAux = [LegisTotal getAllFilhosWithIdLegis:filhoAux.idLegis];
        
        
        LegisTotal *firstFilhoAux = [allFilhosAux objectAtIndex:0];
        
        LegisTotal *lastFilhoAux = [allFilhosAux objectAtIndex:[allFilhosAux count]-1];
        
        TipoLeis *tipoLeiAux = [TipoLeis getTiposWithIdTipo:firstFilhoAux.idTipo];
        
		cell.titulo.text = filhoAux.descricao;
        cell.subtitulo.text = filhoAux.texto;
        
        switch ((int)firstFilhoAux.idTipo) {
            case 14:
                cell.conteudo.text = [[NSString alloc] initWithFormat: @"%@ do %@ ao %@", tipoLeiAux.tipo, [firstFilhoAux.descricao substringFromIndex:9], [lastFilhoAux.descricao substringFromIndex:9]];
                break;
                
            case 17:
                cell.conteudo.text = [[NSString alloc] initWithFormat: @"%@ do %@ ao %@", tipoLeiAux.tipo, [firstFilhoAux.descricao substringFromIndex:5], [lastFilhoAux.descricao substringFromIndex:5]];
                break;
            case 16:
                cell.conteudo.text = [[NSString alloc] initWithFormat: @"%@ de %@ à %@", tipoLeiAux.tipo, [firstFilhoAux.descricao substringFromIndex:6], [lastFilhoAux.descricao substringFromIndex:6]];
                break;
            default:
                cell.conteudo.text = @"" ;
                break;
        }
        
        
        /*cell.conteudo.text = [[NSString alloc] initWithFormat: @"%@: %@ - %@", tipoLeiAux.tipo, [firstFilhoAux.descricao substringFromIndex:5], [lastFilhoAux.descricao substringFromIndex:5]];*/
        
        
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

