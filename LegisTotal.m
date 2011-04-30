//
//  Legislacao.m
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LegisTotal.h"

#import "Conexao.h"


@implementation LegisTotal

@synthesize idLegis, idTipo, idPai;

@synthesize texto, descricao;


// Busca todas Legislações
+(NSMutableArray*)getAllLeis {
    
    Conexao *c = [[Conexao alloc] init];
	sqlite3 *database = [c getDatabase];
	[c release];
	
	NSMutableArray *allLeis = [[NSMutableArray alloc] init];
	
	if (database != nil) {
		
		const char *sqlStatement ="SELECT * FROM legisTotal where idPai IS NULL";
		
		sqlite3_stmt *compiledStatement;
        
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            
			LegisTotal *leis = nil;
            
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				int *idLegisAux = (int *) sqlite3_column_int(compiledStatement, 0);
   				int *idTipoAux = (int *) sqlite3_column_int(compiledStatement, 1);
                int *idPaiAux = (int *) sqlite3_column_int(compiledStatement, 2);
				NSString *descricaoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];	
				NSString *textoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];	
				
				leis = [[LegisTotal alloc] init];
                
				[leis setIdLegis:idLegisAux];
                [leis setIdTipo:idTipoAux];
                [leis setIdPai:idPaiAux];
                [leis setDescricao:descricaoAux];
                [leis setTexto:textoAux];
                
				[allLeis addObject:leis];
				
			}
			
		}
		sqlite3_finalize(compiledStatement);
		sqlite3_close(database);
		
	}
	
	return allLeis;
    
}

// Busca a Legislação pelo seu id
+(LegisTotal *)getLegisWithIdLegis:(int*)idLegisAux {
    
    Conexao *c = [[Conexao alloc] init];
	sqlite3 *database = [c getDatabase];
	[c release];
	
	LegisTotal *singleLei = nil;
	
	if (database != nil) {
		
		const char *sqlStatement = "SELECT * FROM legisTotal WHERE idLegis = ?";
		
		sqlite3_stmt *compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_int(compiledStatement, 1, (int)idLegisAux);
			
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
				
				int *idLegisAux = (int *) sqlite3_column_int(compiledStatement, 0);
   				int *idTipoAux = (int *) sqlite3_column_int(compiledStatement, 1);
                int *idPaiAux = (int *) sqlite3_column_int(compiledStatement, 2);
				NSString *descricaoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];	
				NSString *textoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];		
				
				singleLei = [[LegisTotal alloc] init];
                
                [singleLei setIdLegis:idLegisAux];
                [singleLei setIdTipo:idTipoAux];
                [singleLei setIdPai:idPaiAux];
                [singleLei setDescricao:descricaoAux];
                [singleLei setTexto:textoAux];
			}
		}
		
		sqlite3_finalize(compiledStatement);
		sqlite3_close(database);
    }
    
	return singleLei;

}

// Busca todos Filhos
+(NSMutableArray*)getAllFilhosWithIdLegis:(int *)idLegisAux  {
    
    Conexao *c = [[Conexao alloc] init];
	sqlite3 *database = [c getDatabase];
	[c release];
	
	NSMutableArray *allFilhos = [[NSMutableArray alloc] init];
	
	if (database != nil) {
		
		const char *sqlStatement ="SELECT * FROM legisTotal WHERE idPai = ?";
		
		sqlite3_stmt *compiledStatement;
        
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_int(compiledStatement, 1, (int)idLegisAux);
            
			LegisTotal *filho = nil;
			
            
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
		
				int *idLegisAux = (int *) sqlite3_column_int(compiledStatement, 0);
   				int *idTipoAux = (int *) sqlite3_column_int(compiledStatement, 1);
                int *idPaiAux = (int *) sqlite3_column_int(compiledStatement, 2);
				NSString *descricaoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];	
				NSString *textoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];	
				
				filho = [[LegisTotal alloc] init];
                
				[filho setIdLegis:idLegisAux];
                [filho setIdTipo:idTipoAux];
                [filho setIdPai:idPaiAux];
                [filho setDescricao:descricaoAux];
                [filho setTexto:textoAux];
                
				[allFilhos addObject:filho];
				
			}
			
		}
		sqlite3_finalize(compiledStatement);
		sqlite3_close(database);
		
	}
	
	return allFilhos;
    
}

// Busca pelo Tipo
+(NSMutableArray *) getAllWithIdTipo:(int *)idTipoAux {
    
    Conexao *c = [[Conexao alloc] init];
	sqlite3 *database = [c getDatabase];
	[c release];
	
	NSMutableArray *allLegisIdTipo = [[NSMutableArray alloc] init];
	
	if (database != nil) {
		
		const char *sqlStatement ="SELECT * FROM legisTotal WHERE idTipo = ?";
		
		sqlite3_stmt *compiledStatement;
        
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_int(compiledStatement, 1, (int)idTipoAux);
            
			LegisTotal *legis = nil;
			
            
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
				int *idLegisAux = (int *) sqlite3_column_int(compiledStatement, 0);
   				int *idTipoAux = (int *) sqlite3_column_int(compiledStatement, 1);
                int *idPaiAux = (int *) sqlite3_column_int(compiledStatement, 2);
				NSString *descricaoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];	
				NSString *textoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];	
				
				legis = [[LegisTotal alloc] init];
            
				[legis setIdLegis:idLegisAux];
                [legis setIdTipo:idTipoAux];
                [legis setIdPai:idPaiAux];
                [legis setDescricao:descricaoAux];
                [legis setTexto:textoAux];
                
				[allLegisIdTipo addObject:legis];
				
			}
			
		}
		sqlite3_finalize(compiledStatement);
		sqlite3_close(database);
		
	}
	
	return allLegisIdTipo;
    
}

// Monta o índice da Lei
+(NSMutableArray*)getIndiceWithIdLegis:(int *)idLegisAux {
    
    Conexao *c = [[Conexao alloc] init];
	sqlite3 *database = [c getDatabase];
	[c release];
	
	NSMutableArray *allLegisIdTipo = [[NSMutableArray alloc] init];
	
	if (database != nil) {
		
		const char *sqlStatement ="SELECT * FROM legisTotal WHERE idTipo = ?";
		
		sqlite3_stmt *compiledStatement;
        
		if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_int(compiledStatement, 1, (int)idLegisAux);
            
			LegisTotal *legis = nil;
			
            
			while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
				int *idLegisAux = (int *) sqlite3_column_int(compiledStatement, 0);
   				int *idTipoAux = (int *) sqlite3_column_int(compiledStatement, 1);
                int *idPaiAux = (int *) sqlite3_column_int(compiledStatement, 2);
				NSString *descricaoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];	
				NSString *textoAux = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];	
				
				legis = [[LegisTotal alloc] init];
                
				[legis setIdLegis:idLegisAux];
                [legis setIdTipo:idTipoAux];
                [legis setIdPai:idPaiAux];
                [legis setDescricao:descricaoAux];
                [legis setTexto:textoAux];
                
				[allLegisIdTipo addObject:legis];
				
			}
			
		}
		sqlite3_finalize(compiledStatement);
		sqlite3_close(database);
		
	}
	
	return allLegisIdTipo;
}

@end
