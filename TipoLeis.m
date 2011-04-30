//
//  TipoLegislacao.m
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TipoLeis.h"

#import "Conexao.h"

@implementation TipoLeis

@synthesize idTipo;
@synthesize tipo, descricao;

// Busca todos os Tipos de Legislação
+(NSMutableArray*)getAllTipo {
    
    Conexao *c = [[Conexao alloc] init];
	sqlite3 *database = [c getDatabase];
	[c release];
	
	NSMutableArray *allTipos = [[NSMutableArray alloc] init];
	
	if (database != nil) {
		
		const char *sqlStatement ="SELECT * FROM tipoLegislacao ORDER BY tipo";
		
		sqlite3_stmt *compiledStatement;
		        
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            
			TipoLeis *tipos = nil;
            
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				int *idTipoAux = (int *) sqlite3_column_int(compiledStatement, 0);
				NSString *tipoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];	
				NSString *descricaoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];	
				
				tipos = [[TipoLeis alloc] init];
                
				[tipos setIdTipo:idTipoAux];
                [tipos setTipo:tipoAux];
                [tipos setDescricao:descricaoAux];
				
				[allTipos addObject:tipos];
				
			}
			
		}
		sqlite3_finalize(compiledStatement);
		sqlite3_close(database);
		
	}
	
	
	return allTipos;
}

// Busca o Tipo de Legislação pelo seu id
+(TipoLeis *)getTiposWithIdTipo:(int*)idTipoAux {
    Conexao *c = [[Conexao alloc] init];
	sqlite3 *database = [c getDatabase];
	[c release];
	
	TipoLeis *singleTipo = nil;
	
	if (database != nil) {
		//const char *sqlStatement ="SELECT integrantes.nomeIntegrante, naipes.naipe 
		//FROM integrantes, naipes, integranteNaipe 
		//WHERE integranteNaipe.idNaipe = naipes.idNaipe 
		//AND integranteNaipe.idIntegrante = integrantes.idIntegrante 
		//AND naipes.idNaipe = ?";
		
		const char *sqlStatement = "SELECT * FROM tipoLegislacao WHERE idTipo = ?";
		
		sqlite3_stmt *compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_int(compiledStatement, 1, (int)idTipoAux);
			
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				
                int *idTipoAux = (int *) sqlite3_column_int(compiledStatement, 0);
				NSString *tipoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];	
				NSString *descricaoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];	
				
				singleTipo = [[TipoLeis alloc] init];
                
				[singleTipo setIdTipo:idTipoAux];
                [singleTipo setTipo:tipoAux];
                [singleTipo setDescricao:descricaoAux];
			}
		}
		
		sqlite3_finalize(compiledStatement);
		sqlite3_close(database);
    }
    
	return singleTipo;

}

@end

