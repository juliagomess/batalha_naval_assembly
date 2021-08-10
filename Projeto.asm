;Julia Gomes     RA:20052387
;Rafael Dorta    RA:20032256
;Rafaela Medina  RA:20014346$'

TITLE Projeto_Final
.MODEL SMALL
.STACK 100h
.DATA 
    TABULEIRO1 DB 6 DUP(6 DUP ('0'))
    TABULEIRO2 DB 6 DUP(6 DUP ('0'))
    INFOS DB 00,'0','0',00,'0','0' 
    TIROS1 DB 36
    TIROS2 DB 36
    JOGADAS DB 36
    POSICIONAMENTOS DB 6
    COURACADO DB 3
    FRAGATA DB 2
    VERIFICA1 DB 0
    VERIFICA2 DB 0
    NUMEROS DB 10,13,'    1   2   3   4   5   6 $'
    TRACINHOS DB '  +---+---+---+---+---+---+ $'
    LINHA DB 13,10,'$'
    LETRA_NUMERO DB 2 DUP (?)
    MSG1 DB 10,13,'BEM VINDO AO BATALHA NAVAL',10,13,'Desenvolvido por: Julia Gomes     RA:20052387',10,13,'                  Rafael Dorta    RA:20032256',10,13,'                  Rafaela Medina  RA:20014346$'
    MSG2 DB 10,13,10,13,'Aperte <enter> para continuar... $'
    MSG3 DB 10,13,'JOGADOR 1 $'
    MSG4 DB 10,13,'Digite seu nome: $'
    MSG5 DB 10,13,'Voce pode colocar 6 navios neste tabuleiro:',10,13,'3 Destroiers (apenas 1 quadrado), 2 Fragatas (2 quadrados), e 1 Couracado (3 quadrados) $'
    MSG6 DB 10,13,10,13,'Digite as cordenadas do NAVIO (letra + numero): $'
    MSG7 DB 10,13,'Qual navio deseja colocar? Destroier(1), Fragata(2), ou Couracado(3) $'
    MSG8 DB 10,13,'Lembrando que o DESTROIER possui apenas um quadradinho $'
    MSG9 DB 10,13,'Lembrando que o FRAGATA possui dois quadradinhos (horizontal/vertical) $'
    MSG10 DB 10,13,'Lembrando que o COURACADO possui tres quadradinhos (horizontal/vertical) $'
    MSG11 DB 10,13,'JOGADOR 2 $'
    MSG12 DB 10,13,'Essas sao suas posicoes: $'
    MSG13 DB 10,13,'Tiros Restantes: $'
    MSG14 DB 10,13,'Acertos: $'
    MSG15 DB 10,13,'Ultimo Tiro: $'
    MSG16 DB 10,13,10,13,'Digite as cordenadas do TIRO (letra + numero): $'
    MSG17 DB 10,13,'Quando estiverem preparados para comecar o jogo aperte <enter>...$'
    MSG18 DB ' GANHOU!! PARABENS!! $'
    MSG19 DB 10,13,'Obrigado por jogar!$'
    MSG20 DB 10,13,'VEZ DO(A) $'
    MSG21 DB 10,13,'INSTRUCOES:',10,13,10,13,'Quando voce acertar uma parte de algum navio, aparecera " X "',10,13,'Caso acerte agua, aparecera " ~ "',10,13,10,13,'BOM JOGO $'
    NOME1 DB 15 DUP(?)
    NOME2 DB 15 DUP(?)
.CODE
MAIN PROC 
    ;acesso a data
    MOV AX,@DATA
    MOV DS,AX
    
    CALL APRESENTACAO
    
    CALL LIMPA_TELA
    
    CALL JOGADOR1
    
    CALL LIMPA_TELA
    
    CALL JOGADOR2
    
    CALL LIMPA_TELA
    
    CALL JOGO
    
    ;finaliza
    MOV AH,4Ch
    INT 21h
MAIN ENDP

PULA_LINHA PROC
    LEA DX, LINHA
    MOV AH,9
    INT 21H
    
    RET 
PULA_LINHA ENDP 

LIMPA_TELA PROC
    MOV AH, 0 
    MOV AL, 3 
    INT 10H
    
    RET
LIMPA_TELA ENDP

APRESENTACAO PROC
    ;exibe msg
    MOV AH,9
    LEA DX,MSG1
    INT 21h
    ;exibe msg
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    ;espera <enter>
    MOV AH,1
    INT 21h
    
    RET
APRESENTACAO ENDP

JOGADOR1 PROC
    ;exibe msg
    MOV AH,9
    LEA DX,MSG3
    INT 21h
    ;exibe msg
    MOV AH,9
    LEA DX,MSG4
    INT 21h
    ;zera di
    XOR DI,DI
    LEITURA1:
        ;le um caracter
        MOV AH,1
        INT 21h
        ;atribui o caracter digitado ao nome1
        MOV NOME1[DI],AL
        INC DI
        ;ve se nao eh <enter>
        CMP AL,13
        ;se nao for <enter> continua lendo
        JNZ LEITURA1
        XOR CX,CX
        MOV CX,10
        
    MOV POSICIONAMENTOS,6 ;posiciona os 6 navios
    POSICIONA_NAVIO2:
        CALL ESCOLHE_NAVIO
        CALL LIMPA_TELA

        DEC POSICIONAMENTOS
        JNZ POSICIONA_NAVIO2
    
    CALL LIMPA_TELA
    
    MOV AH,9
    LEA DX,MSG12
    INT 21h
    
    CALL IMPRIME1
    
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    
    MOV AH,1
    INT 21h
    
    RET
JOGADOR1 ENDP

JOGADOR2 PROC
    ;exibe msg
    MOV AH,9
    LEA DX,MSG11
    INT 21h
    ;exibe msg
    MOV AH,9
    LEA DX,MSG4
    INT 21h
    ;zera di
    XOR DI,DI
    LEITURA2:
        ;le um caracter
        MOV AH,1
        INT 21h
        ;atribui o caracter digitado ao nome1
        MOV NOME2[DI],AL
        INC DI
        ;ve se nao eh <enter>
        CMP AL,13
        ;se nao for <enter> continua lendo
        JNZ LEITURA2
        
    MOV POSICIONAMENTOS,6 ;posiciona os 6 navios
    POSICIONA_NAVIO1:
        CALL ESCOLHE_NAVIO2
        CALL LIMPA_TELA
        
        DEC POSICIONAMENTOS
        JNZ POSICIONA_NAVIO1
    
    CALL LIMPA_TELA
    
    MOV AH,9
    LEA DX,MSG12
    INT 21h
    
    CALL IMPRIME2
    
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    
    MOV AH,1
    INT 21h
    
    RET
JOGADOR2 ENDP

IMPRIME1 PROC
    ;zera SI
    XOR SI,SI
    ;linha
    MOV CH,6
    
    MOV AH,9
    LEA DX,NUMEROS
    INT 21h
    
    CALL PULA_LINHA
    LACO_FORA1:
        ;coluna
        MOV CL,6
        ;zera BX
        XOR BX,BX
        
        MOV AH,9
        LEA DX,TRACINHOS
        INT 21h
        
        CALL PULA_LINHA
        
        ;imprimir letras
        MOV AH,2
        MOV DL,6
        SUB DL,CH
        ADD DL,41h
        INT 21h
        
        ;espaco
        MOV DL,20h
        INT 21h
        
        MOV DL,'|'
        INT 21h
        LACO_DENTRO1:
            ;atribui a DL um dos elementos da matriz
            MOV DL, TABULEIRO1[SI+BX]
            
            CMP DL,'0' ;agua
            JZ ZERO1
            
            CMP DL,'1' ;navio
            JZ NAVIO1 
            
            JMP CONTINUA1
            
            ZERO1:
                ;espaco
                MOV DL,20h
                INT 21h
                ;Exibe espaco na tela
                MOV DL,20h
                INT 21h
                ;espaco
                MOV DL,20h
                INT 21h
                JMP CONTINUA1
                
            NAVIO1:
                ;espaco
                MOV DL,20h
                INT 21h
                ;Exibe X na tela
                MOV AH,2
                MOV DL,'X'
                INT 21h
                ;espaco
                MOV DL,20h
                INT 21h
                JMP CONTINUA1
                
            CONTINUA1:
            MOV DL,'|'
            INT 21h
            ;proxima coluna
            INC BX
            ;decrementa o contador cl
            DEC CL
            ;se CL nao for igual a zero, salta para laco_dentro1 
            JNZ LACO_DENTRO1
        
        CALL PULA_LINHA
        ;proxima linha
        ADD SI,6
        ;decrementa o contador ch
        DEC CH
        ;se ch nao for igual a zero, salta para laco_fora1
        JNZ LACO_FORA1
        
    MOV AH,9
    LEA DX,TRACINHOS
    INT 21h   
    
    RET
IMPRIME1 ENDP

IMPRIME2 PROC
    ;zera SI
    XOR SI,SI
    ;linha
    MOV CH,6
    
    MOV AH,9
    LEA DX,NUMEROS
    INT 21h
    
    CALL PULA_LINHA
    LACO_FORA2:
        ;coluna
        MOV CL,6
        ;zera BX
        XOR BX,BX
        
        MOV AH,9
        LEA DX,TRACINHOS
        INT 21h
        
        CALL PULA_LINHA
        
        ;imprimir letras
        MOV AH,2
        MOV DL,6
        SUB DL,CH
        ADD DL,41h
        INT 21h
        
        ;espaco
        MOV DL,20h
        INT 21h
        
        MOV DL,'|'
        INT 21h
        LACO_DENTRO2:
            ;atribui a DL um dos elementos da matriz
            MOV DL, TABULEIRO2[SI+BX]
            
            CMP DL,'0' ;agua
            JZ ZERO2
            
            CMP DL,'1' ;navio
            JZ NAVIO2 
            
            JMP CONTINUA3
            
            ZERO2:
                ;espaco
                MOV DL,20h
                INT 21h
                ;Exibe espaco na tela
                MOV DL,20h
                INT 21h
                ;espaco
                MOV DL,20h
                INT 21h
                JMP CONTINUA3
                
            NAVIO2:
                ;espaco
                MOV DL,20h
                INT 21h
                ;Exibe X na tela
                MOV AH,2
                MOV DL,'X'
                INT 21h
                ;espaco
                MOV DL,20h
                INT 21h
                JMP CONTINUA3
                
            CONTINUA3:
            MOV DL,'|'
            INT 21h
            ;proxima coluna
            INC BX
            ;decrementa o contador cl
            DEC CL
            ;se CL nao for igual a zero, salta para laco_dentro2 
            JNZ LACO_DENTRO2
        
        CALL PULA_LINHA
        ;proxima linha
        ADD SI,6
        ;decrementa o contador ch
        DEC CH
        ;se ch nao for igual a zero, salta para laco_fora2
        JNZ LACO_FORA2
        
    MOV AH,9
    LEA DX,TRACINHOS
    INT 21h   
    
    RET
IMPRIME2 ENDP

CORDENADAS PROC
    TENTA_DNV:
        MOV AH,9
        LEA DX,MSG6
        INT 21h
        
        MOV CX,2
        ;zera di
        XOR DI,DI
        LER_COO:
            ;le um caracter
            MOV AH,1
            INT 21h
        
            CMP DI,1
            JE VALIDA_NUM
        
            CMP AL,97 ;ve se eh letra minuscula
            JL VE_MAIUSCULA
            SUB AL,32 ;torna maiuscula
            
            VE_MAIUSCULA:
                CMP AL,65
                JL TENTA_DNV
                CMP AL,70
                JG TENTA_DNV
                JMP OK
                
            VALIDA_NUM:
                CMP AL,49
                JL TENTA_DNV
                CMP AL,54
                JG TENTA_DNV
                
            OK:
        
            MOV LETRA_NUMERO[DI],AL
            INC DI
        
            LOOP LER_COO
    
    RET
CORDENADAS ENDP

POSICIONA PROC
    XOR DI,DI
    XOR SI,SI
    XOR BX,BX
    XOR AH,AH
    
    MOV AL,LETRA_NUMERO[DI] ;pega a letra
    
    CMP AL,97 ;ve se eh minusculo
    JL CONTINUA2
    SUB AL,32 ;torna maiusculo
   
    CONTINUA2:
        ;para tornar numero
        SUB AL,65
        
        MOV CL,AL
        MOV BL,6
        MUL BL
        MOV SI,AX
      
        INC DI
        
        MOV AL,LETRA_NUMERO[DI] ;pega o numero
        SUB AL,49
        XOR BH,BH
        MOV BL,AL 
 
        MOV TABULEIRO1[SI+BX],'1'
        
    RET
POSICIONA ENDP

POSICIONA2 PROC
    XOR DI,DI
    XOR SI,SI
    XOR BX,BX
    XOR AH,AH
    
    MOV AL,LETRA_NUMERO[DI] ;pega a letra
    
    CMP AL,97
    JL CONTINUA4
    SUB AL,32
   
    CONTINUA4:
        ;para tornar numero
        SUB AL,65
        
        MOV CL,AL
        MOV BL,6
        MUL BL
        MOV SI,AX
      
        INC DI
        
        MOV AL,LETRA_NUMERO[DI] ;pega o numero
        SUB AL,49
        XOR BH,BH
        MOV BL,AL 
 
        MOV TABULEIRO2[SI+BX],'1'
        
    RET
POSICIONA2 ENDP

ESCOLHE_NAVIO PROC
    
    MOV AH,9
    LEA DX,MSG5
    INT 21h
    
    CALL PULA_LINHA
     
    CALL IMPRIME1
    
    INVALIDO1:
    
    MOV AH,9
    LEA DX,MSG7
    INT 21h
    
    MOV AH,1
    INT 21h
    
    CMP AL,'1' ;ve se eh o destroier
    JZ DEST
    
    CMP AL,'2' ;ve se eh fragata
    JZ FRAG
    
    CMP AL,'3' ;ve se eh couracado
    JZ COUR
    
    JMP INVALIDO1
    
    COUR:
        CALL LIMPA_TELA
        
        MOV COURACADO,3 ;as tres partes do navio
        
        LOOP1:
            CALL PULA_LINHA
        
            MOV AH,9
            LEA DX,MSG10
            INT 21h
            
            CALL PULA_LINHA
            CALL IMPRIME1
            CALL CORDENADAS
            CALL POSICIONA
            
            DEC COURACADO
            JNZ LOOP1  
            
            JMP CONTINUANDO
    
    FRAG:
        CALL LIMPA_TELA
        
        MOV FRAGATA,2 ;as duas partes do navio
        
        LOOP2:
            CALL PULA_LINHA
            
            MOV AH,9
            LEA DX,MSG9
            INT 21h 
        
            CALL PULA_LINHA
            CALL IMPRIME1
            CALL CORDENADAS
            CALL POSICIONA 
            
            DEC FRAGATA
            JNZ LOOP2  
            
            JMP CONTINUANDO
    
    DEST:
        CALL LIMPA_TELA
        
        MOV AH,9
        LEA DX,MSG8
        INT 21h
        
        CALL PULA_LINHA
        CALL IMPRIME1
        CALL CORDENADAS
        CALL POSICIONA 
        
    CONTINUANDO:

    RET
ESCOLHE_NAVIO ENDP

ESCOLHE_NAVIO2 PROC
    
    MOV AH,9
    LEA DX,MSG5
    INT 21h
    
    CALL PULA_LINHA
     
    CALL IMPRIME2
    
    INVALIDO2:
    
        MOV AH,9
        LEA DX,MSG7
        INT 21h
    
        MOV AH,1
        INT 21h
    
        CMP AL,'1' ;ve se eh o destroier
        JZ DEST2
    
        CMP AL,'2' ;ve se eh fragata
        JZ FRAG2
    
        CMP AL,'3' ;ve se eh couracado
        JZ COUR2
    
        JMP INVALIDO2
    
    COUR2:
        CALL LIMPA_TELA

        MOV COURACADO,3 ;as tres partes do navio
        
        LOOP3:
            CALL PULA_LINHA
        
            MOV AH,9
            LEA DX,MSG10
            INT 21h
            
            CALL PULA_LINHA
            CALL IMPRIME2
            CALL CORDENADAS
            CALL POSICIONA2

            DEC COURACADO
            JNZ LOOP3  
            
        JMP CONTINUANDO2
    
    FRAG2:
        CALL LIMPA_TELA
        
        MOV FRAGATA,2 ;as duas partes do navio
        
        LOOP4:
            CALL PULA_LINHA
            
            MOV AH,9
            LEA DX,MSG9
            INT 21h 
            
            CALL PULA_LINHA
            CALL IMPRIME2
            CALL CORDENADAS
            CALL POSICIONA2 
       
            DEC FRAGATA
            JNZ LOOP4  

        JMP CONTINUANDO2
    
    DEST2:
        CALL LIMPA_TELA
        
        MOV AH,9
        LEA DX,MSG8
        INT 21h

        CALL PULA_LINHA
        CALL IMPRIME2
        CALL CORDENADAS
        CALL POSICIONA2 
        
    CONTINUANDO2:

    RET
ESCOLHE_NAVIO2 ENDP

IMPRIME_NOME1 PROC
    XOR DI,DI
    
    IMPRESSAO1:
        MOV AH,2  
        MOV DL,NOME1[DI]  
        INT 21h
        
        INC DI
        CMP NOME1[DI],13
        JNZ IMPRESSAO1
    RET
IMPRIME_NOME1 ENDP

IMPRIME_NOME2 PROC
    XOR DI,DI
    
    IMPRESSAO2: 
        MOV AH,2  
        MOV DL,NOME2[DI]  
        INT 21h
        
        INC DI
        CMP NOME2[DI],13
        JNZ IMPRESSAO2
        
    RET
IMPRIME_NOME2 ENDP

IMPRIME1_INFOS PROC
    
    CALL IMPRIME_NOME1

    MOV AH,9
    LEA DX,MSG13
    INT 21h
        
    ;para imprimir dois caracteres   
    XOR AX,AX
    
    MOV AL,TIROS1
    MOV BL,10
    DIV BL ;guarda o quociente em al e resto em ah
    
    MOV DX,AX ;passa tudo pra dx
    ADD DL,30h ;para torna numero
    
    MOV AH,2 ;imprime o quociente
    INT 21h
    
    MOV DL,DH
    ADD DL,30h ;torna numero
    
    MOV AH,2 ;imprime o resto
    INT 21h
        
    MOV AH,9
    LEA DX,MSG14
    INT 21h
    
    ;para imprimir dois caracteres   
    XOR AX,AX
    
    MOV AL,INFOS[0]
    MOV BL,10
    DIV BL ;guarda o quociente em al e resto em ah
    
    MOV DX,AX ;passa tudo pra dx
    ADD DL,30h ;para torna numero
    
    MOV AH,2 ;imprime o quociente
    INT 21h
    
    MOV DL,DH
    ADD DL,30h ;torna numero
    
    MOV AH,2 ;imprime o resto
    INT 21h
        
    MOV AH,9
    LEA DX,MSG15
    INT 21h
    
    MOV AH,2
    MOV DL,INFOS[1]
    INT 21h 
    
    MOV AH,2
    MOV DL,INFOS[2]
    INT 21h
        
    RET
IMPRIME1_INFOS ENDP

IMPRIME2_INFOS PROC

    CALL IMPRIME_NOME2

    MOV AH,9
    LEA DX,MSG13
    INT 21h
    
    ;para imprimir dois caracteres   
    XOR AX,AX
    
    MOV AL,TIROS2
    MOV BL,10
    DIV BL ;guarda o quociente em al e resto em ah
    
    MOV DX,AX ;passa tudo pra dx
    ADD DL,30h ;para torna numero
    
    MOV AH,2 ;imprime o quociente
    INT 21h
    
    MOV DL,DH
    ADD DL,30h ;torna numero
    
    MOV AH,2 ;imprime o resto
    INT 21h  
        
    MOV AH,9
    LEA DX,MSG14
    INT 21h
        
    ;para imprimir dois caracteres   
    XOR AX,AX
    
    MOV AL,INFOS[3]
    MOV BL,10
    DIV BL ;guarda o quociente em al e resto em ah
    
    MOV DX,AX ;passa tudo pra dx
    ADD DL,30h ;para torna numero
    
    MOV AH,2 ;imprime o quociente
    INT 21h
    
    MOV DL,DH
    ADD DL,30h ;torna numero
    
    MOV AH,2 ;imprime o resto
    INT 21h
        
    MOV AH,9
    LEA DX,MSG15
    INT 21h
        
    MOV AH,2
    MOV DL,INFOS[4]
    INT 21h 
    
    MOV AH,2
    MOV DL,INFOS[5]
    INT 21h
        
    RET
IMPRIME2_INFOS ENDP

IMPRIME1_JOGO PROC

    MOV AH,9
    LEA DX,MSG20
    INT 21h
    
    CALL IMPRIME_NOME1
    
    CALL PULA_LINHA
    CALL PULA_LINHA
    CALL IMPRIME1_INFOS
    CALL PULA_LINHA
    
    XOR SI,SI
    
    MOV CH,6 ;linha
    
    MOV AH,9
    LEA DX,NUMEROS
    INT 21h
    
    CALL PULA_LINHA
    
    LACO_FORA3:
        MOV CL,6 ;coluna
        
        XOR BX,BX
        
        MOV AH,9
        LEA DX,TRACINHOS
        INT 21h
        
        CALL PULA_LINHA
        
        ;imprimir letras
        MOV AH,2
        MOV DL,6
        SUB DL,CH
        ADD DL,41h
        INT 21h
        
        MOV DL,20h ;espa?o
        INT 21h
        
        MOV DL,'|'
        INT 21h
        LACO_DENTRO3:
            ;atribui a DL um dos elementos da matriz
            MOV DL, TABULEIRO2[SI+BX]
            
            CMP DL,'2' ;acertou o tiro
            JZ ACERTO1
            
            CMP DL,'3' ;errou o tiro
            JZ ERROU1
            
            MOV DL,20h ;espaco
            INT 21h
            MOV DL,20h ;espaco
            INT 21h
            MOV DL,20h ;espaco
            INT 21h
            JMP CONTINUA5
            
            ACERTO1:
                
                MOV DL,20h ;espaco
                INT 21h
                MOV DL,'X' ;Exibe X na tela
                INT 21h
                MOV DL,20h ;espaco
                INT 21h
                JMP CONTINUA5
                
            ERROU1:
                MOV DL,20h ;espaco
                INT 21h
                MOV AH,2 ;Exibe VAZIO na tela
                MOV DL,'~'
                INT 21h
                MOV DL,20h ;espaco
                INT 21h
                JMP CONTINUA5
               
            CONTINUA5:
            MOV DL,'|'
            INT 21h
            ;proxima coluna
            INC BX
            ;decrementa o contador cl
            DEC CL
            JNZ LACO_DENTRO3
        
        CALL PULA_LINHA
        ;proxima linha
        ADD SI,6
        ;decrementa o contador ch
        DEC CH
        JNZ LACO_FORA3
        
    MOV AH,9
    LEA DX,TRACINHOS
    INT 21h   
    
    RET
IMPRIME1_JOGO ENDP

IMPRIME2_JOGO PROC
    MOV AH,9
    LEA DX,MSG20
    INT 21h
    
    CALL IMPRIME_NOME2
    
    CALL PULA_LINHA
    CALL PULA_LINHA
    CALL IMPRIME2_INFOS
    CALL PULA_LINHA
    
    XOR SI,SI
    
    MOV CH,6 ;linha
    
    MOV AH,9
    LEA DX,NUMEROS
    INT 21h
    
    CALL PULA_LINHA
    
    LACO_FORA4:
        MOV CL,6 ;coluna
        
        XOR BX,BX
        
        MOV AH,9
        LEA DX,TRACINHOS
        INT 21h
        
        CALL PULA_LINHA
        
        ;imprimir letras
        MOV AH,2
        MOV DL,6
        SUB DL,CH
        ADD DL,41h
        INT 21h
        
        MOV DL,20h ;espaco
        INT 21h
        
        MOV DL,'|'
        INT 21h
        LACO_DENTRO4:
            ;atribui a DL um dos elementos da matriz
            MOV DL, TABULEIRO1[SI+BX]
            
            CMP DL,'2' ;acertou o tiro
            JZ ACERTO2
            
            CMP DL,'3' ;errou o tiro
            JZ ERROU2
            
            MOV DL,20h ;espaco
            INT 21h
            MOV DL,20h ;espaco
            INT 21h
            MOV DL,20h ;espaco
            INT 21h
            JMP CONTINUA6
            
            ACERTO2:
            
            MOV DL,20h ;espaco
                INT 21h
                MOV DL,'X' ;Exibe X na tela
                INT 21h
                MOV DL,20h ;espaco
                INT 21h
                JMP CONTINUA6
                
            ERROU2:
                MOV DL,20h ;espaco
                INT 21h
                MOV AH,2 ;Exibe VAZIO na tela
                MOV DL,'~'
                INT 21h
                MOV DL,20h ;espaco
                INT 21h
                JMP CONTINUA6
               
            CONTINUA6:
            MOV DL,'|'
            INT 21h
            ;proxima coluna
            INC BX
            ;decrementa o contador cl
            DEC CL
            JNZ LACO_DENTRO4
        
        CALL PULA_LINHA
        ;proxima linha
        ADD SI,6
        ;decrementa o contador ch
        DEC CH
        JNZ LACO_FORA4
        
    MOV AH,9
    LEA DX,TRACINHOS
    INT 21h   
    
    RET
IMPRIME2_JOGO ENDP       

INCREMENTA1 PROC
    
    MOV AL,INFOS[0] ;acertos do jogador 1
    INC AL
    MOV INFOS[0],AL
    
    RET
INCREMENTA1 ENDP

INCREMENTA2 PROC
    
    MOV AL,INFOS[3] ;acertos do jogador 2
    INC AL
    MOV INFOS[3],AL
    
    RET
INCREMENTA2 ENDP
    
VISUALIZACAO1 PROC
    CALL IMPRIME1_JOGO 
    
    TENTA_DNV1:
        MOV AH,9
        LEA DX, MSG16
        INT 21h
    
        MOV SI,1
        MOV CX,2

        XOR DI,DI
        LER_COO1:
            ;le um caracter
            MOV AH,1
            INT 21h
            
            CMP DI,1
            JE VALIDA_NUM1
            
            CMP AL,97
            JL VE_MAIUSCULA1
            SUB AL,32
            
            VE_MAIUSCULA1:
                CMP AL,65
                JL TENTA_DNV1
                CMP AL,70
                JG TENTA_DNV1
                JMP OK1
                
            VALIDA_NUM1:
                CMP AL,49
                JL TENTA_DNV1
                CMP AL,54
                JG TENTA_DNV1
            
            OK1:
        
            MOV LETRA_NUMERO[DI],AL
            MOV INFOS[SI],AL
        
            INC DI
            INC SI
    
            LOOP LER_COO1
    DEC TIROS1
        
    CALL LIMPA_TELA
    
    CALL POSICIONA3
        
    CALL IMPRIME1_JOGO
    
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    
    MOV AH,1
    INT 21h
    
    RET
VISUALIZACAO1 ENDP

VISUALIZACAO2 PROC
    CALL IMPRIME2_JOGO 
    
    TENTA_DNV2:
        MOV AH,9
        LEA DX, MSG16
        INT 21h
    
        MOV SI,4
        MOV CX,2

        XOR DI,DI
        LER_COO2:
            ;le um caracter
            MOV AH,1
            INT 21h
            
            CMP DI,1
            JE VALIDA_NUM2
            
            CMP AL,97
            JL VE_MAIUSCULA2
            SUB AL,32
            
            VE_MAIUSCULA2:
                CMP AL,65
                JL TENTA_DNV2
                CMP AL,70
                JG TENTA_DNV2
                JMP OK2
                
            VALIDA_NUM2:
                CMP AL,49
                JL TENTA_DNV2
                CMP AL,54
                JG TENTA_DNV2
            
            OK2:
            
            MOV LETRA_NUMERO[DI],AL
            MOV INFOS[SI],AL
        
            INC DI
            INC SI
        
            LOOP LER_COO2
    DEC TIROS2
        
    CALL LIMPA_TELA
    
    CALL POSICIONA4
        
    CALL IMPRIME2_JOGO
    
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    
    MOV AH,1
    INT 21h
    
    RET
VISUALIZACAO2 ENDP

POSICIONA3 PROC
    XOR DI,DI
    XOR SI,SI
    XOR BX,BX
    XOR AH,AH
    
    MOV AL,LETRA_NUMERO[DI] ;pega a letra
    
    CMP AL,97
    JL CONTINUA_AI
    SUB AL,32
   
    CONTINUA_AI:
        ;para tornar numero
        SUB AL,65
        
        MOV CL,AL
        MOV BL,6
        MUL BL
        MOV SI,AX
      
        INC DI
        
        MOV AL,LETRA_NUMERO[DI] ;pega o numero
        SUB AL,49
        XOR BH,BH
        MOV BL,AL 
        
        CMP TABULEIRO2[SI+BX],'1'
        JZ ACERTOUU1
        
        CMP TABULEIRO2[SI+BX],'0'
        JZ ERROUU1
        
        ACERTOUU1:
            CALL INCREMENTA1
            MOV TABULEIRO2[SI+BX],'2'
            JMP ENFIM1
            
        ERROUU1:
            MOV TABULEIRO2[SI+BX],'3'
            JMP ENFIM1
        
        ENFIM1:
        
    RET
POSICIONA3 ENDP
    
POSICIONA4 PROC
    XOR DI,DI
    XOR SI,SI
    XOR BX,BX
    XOR AH,AH
    
    MOV AL,LETRA_NUMERO[DI] ;pega a letra
    
    CMP AL,97
    JL CONTINUA_AI2
    SUB AL,32
   
    CONTINUA_AI2:
        ;para tornar numero
        SUB AL,65
        
        MOV CL,AL
        MOV BL,6
        MUL BL
        MOV SI,AX
      
        INC DI
        
        MOV AL,LETRA_NUMERO[DI] ;pega o numero
        SUB AL,49
        XOR BH,BH
        MOV BL,AL 
        
        CMP TABULEIRO1[SI+BX],'1'
        JZ ACERTOUU2
        
        CMP TABULEIRO1[SI+BX],'0'
        JZ ERROUU2
        
        ACERTOUU2:
            CALL INCREMENTA2
            MOV TABULEIRO1[SI+BX],'2'
            JMP ENFIM2
            
        ERROUU2:
            MOV TABULEIRO1[SI+BX],'3'
            JMP ENFIM2
        
        ENFIM2:
        
    RET
POSICIONA4 ENDP

JOGO PROC
    MOV AH,9
    LEA DX,MSG21
    INT 21h

    MOV AH,9
    LEA DX,MSG17
    INT 21h
    
    MOV AH,1
    INT 21h
    
    JOGADA:
    
        CALL VISUALIZACAO1
        
        CALL VERIFICA_JOGO1
        
        CMP AL,1
        JE FINAL1
        JMP NAO_ACABOU1
        
        FINAL1:
            CALL LIMPA_TELA
            CALL PULA_LINHA
            CALL IMPRIME_NOME1
            
            MOV AH,9
            LEA DX,MSG18
            INT 21h
            JMP AGRADECIMENTOS
        
        NAO_ACABOU1:
    
        CALL LIMPA_TELA
    
        CALL VISUALIZACAO2
        
        CALL VERIFICA_JOGO2
        
        CMP AL,1
        JE FINAL2
        JMP NAO_ACABOU2
        
        FINAL2:
            CALL LIMPA_TELA
            CALL PULA_LINHA
            CALL IMPRIME_NOME2
            
            MOV AH,9
            LEA DX,MSG18
            INT 21h
            JMP AGRADECIMENTOS
            
        NAO_ACABOU2:
    
        CALL LIMPA_TELA

        DEC JOGADAS
        JNZ JOGADA
    
    AGRADECIMENTOS:
        CALL PULA_LINHA
        CALL PULA_LINHA
        
        MOV AH,9
        LEA DX,MSG19
        INT 21h
    
    RET
JOGO ENDP

VERIFICA_JOGO1 PROC
    XOR SI,SI
    
    MOV CH,6 ;linha
    
    MOV VERIFICA1,0
    
    LACO_FORAA:
        MOV CL,6 ;coluna
  
        XOR BX,BX
        
        LACO_DENTROO:
            ;atribui a DL um dos elementos da matriz
            MOV DL, TABULEIRO2[SI+BX]
            
            CMP DL,'2' ;acertou o tiro
            JZ SOMA1
            
            JMP SAI1
            
            SOMA1:
                INC VERIFICA1
                CMP VERIFICA1,10 ;somando todas as partes de cada navio
                JZ GANHADOR1 ;se chega a 10, jogador 1 ganhou
                JMP SAI1
                
            GANHADOR1:
                MOV AL,1
                JMP ACABOU1
                
            SAI1: 
               
            ;proxima coluna
            INC BX
            ;decrementa o contador cl
            DEC CL
            JNZ LACO_DENTROO
            
        ;proxima linha
        ADD SI,6
        ;decrementa o contador ch
        DEC CH
        JNZ LACO_FORAA
        
    ACABOU1:
        
    RET
VERIFICA_JOGO1 ENDP

VERIFICA_JOGO2 PROC
    ;zera SI
    XOR SI,SI
    
    MOV CH,6 ;linha
    
    MOV VERIFICA2,0
    
    LACO_FORAA2:
        MOV CL,6 ;coluna
        ;zera BX
        XOR BX,BX
        
        LACO_DENTRO02:
            ;atribui a DL um dos elementos da matriz
            MOV DL, TABULEIRO1[SI+BX]
            
            CMP DL,'2' ;acertou o tiro
            JZ SOMA2
            
            JMP SAI2
            
            SOMA2:
                INC VERIFICA2
                CMP VERIFICA2,10
                JZ GANHADOR2
                JMP SAI2
                
            GANHADOR2:
                MOV AL,1
                JMP ACABOU2
                
            SAI2: 
               
            ;proxima coluna
            INC BX
            ;decrementa o contador cl
            DEC CL
            JNZ LACO_DENTRO02
            
        ;proxima linha
        ADD SI,6
        ;decrementa o contador ch
        DEC CH
        JNZ LACO_FORAA2
        
    ACABOU2:
        
    RET
VERIFICA_JOGO2 ENDP

END MAIN
