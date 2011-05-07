//
//  LegislacaoTableViewController.m
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeisTableViewController.h"

#import "CustomCell.h"

#import "FilhosTableViewController.h"


@implementation LeisTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [allLeis release];
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
    
    allLeis = [LegisTotal getAllLeis];
    
    [super setTitle:@"Leis"];
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
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
    return [allLeis count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //**************//
	//Células Customizadas Default sem XIB
    /*static NSString *CellIdentifier = @"Cell";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
     }
     
     // Configure the cell.
     
     UIImage *image = [UIImage imageNamed:@"balance.png"];
     
     cell.imageView.image = image;
    
    LegisTotal *legisAux = [allLeis objectAtIndex:indexPath.row];
     
    cell.textLabel.text = legisAux.descricao;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.detailTextLabel.text = legisAux.texto;
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];

    return cell;*/
    
    //********************//
	//Celulas customizadas com XIB
	static NSString *CellIdentifier = @"CustomCell";
	
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell2" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (CustomCell *) currentObject;
                [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
				break;
			}
		}
	}
	
	// Configure the cell.
    
    LegisTotal *legisAux = [allLeis objectAtIndex:indexPath.row];
    
    NSMutableArray *allFilhos = [LegisTotal getAllFilhosWithIdLegis:legisAux.idLegis];
    
    LegisTotal *firstFilhoAux = [allFilhos objectAtIndex:0];
    
    LegisTotal *lastFilhoAux = [allFilhos objectAtIndex:[allFilhos count]-1];
    
    TipoLeis *tipoLeiAux = [TipoLeis getTiposWithIdTipo:firstFilhoAux.idTipo];
	
	cell.titulo.text = legisAux.descricao;
	cell.subtitulo.text = legisAux.texto;
    
    switch ((int)firstFilhoAux.idTipo) {
        case 14:
            cell.conteudo.text = [[NSString alloc] initWithFormat: @"%@ do %@ ao %@", tipoLeiAux.tipo, [firstFilhoAux.descricao substringFromIndex:9], [lastFilhoAux.descricao substringFromIndex:9]];
            break;
            
        case 17:
            cell.conteudo.text = [[NSString alloc] initWithFormat: @"%@ do %@ ao %@", tipoLeiAux.tipo, [firstFilhoAux.descricao substringFromIndex:5], [lastFilhoAux.descricao substringFromIndex:5]];
            break;
        default:
            cell.conteudo.text = @"" ;
            break;
    }
	cell.imagem.image = [UIImage imageNamed:@"listaleis.png"];
    
    return cell;
    
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegisTotal *legisAux = [allLeis objectAtIndex:indexPath.row];    
    
	FilhosTableViewController *filhosLegis = [[FilhosTableViewController alloc] initWithIdLegis:legisAux.idLegis];
	[self.navigationController pushViewController:filhosLegis animated:YES];
}

@end
