;---------------------------------------------------------------------
;                                                                   --
; Le program suivant peut verifie la description de serpent 
; peut placer les serpents un par un dans la position correcte
; Si un serpent touche un autre, les deux se connectent et deviennent un
; Si l'utilisateur entre une entree invalide, le programme affiche message d'erreur 
; puis demande a l'utilisateur de rentrer  de nouveau les specification du serpent.  
; Si la fin d'un serpent touche son debut, le programme affiche que le serpeng est mort.
;
;                                                                   --
;---------------------------------------------------------------------     

main:            LDX 0,i         
                 STRO welMsg, d ; imprimer le msg de bienvenue 
                 CHARO '\n', i  ; imprimer saut de ligne
         
                 CALL display 
                 CALL msgAsk 
                 

                      
Repeat:          CHARI   serpCol,d ;getSerC,d ;CALL getposC  ; 4-->1 appel colonne

                 CHARI   serpRow, d ;CALL getposR  ; 4-->2 appel rangee
                 
                 BR      getSerC

                ; CALL posInit  ; 4-->3 placer le debut du serpent ; premier noeud
                 ;CALL LdpoIn   ; 4-->4 load position initiale dans le tableau

                 ;CALL suivant   ;golp_in

                 ;CALL placerS  ; 4-->5 placer serpent dans la matrix

                 ;CALL display2 ; 4-->6 print le debut du serpent dans la atrix
                 

                 ;CALL loadSer ; 

;:                ;STRO msgErr, d    ; si erreur 
                 ;LDX 0,i
                 ;LDA 0,i
                 ;CALL getSep
                 ;RET0
;Sierr:          STRO  msgErr, d 
                ;BR repeate               
                 
;---------------------------------------------------------------------------
;                                                                         --
;   --
;    --A partir d'ici, le code traite le parcours du serpent 
;                                                                          --
;----------------------------------------------------------------------------                
                



;---------------------------------------------------------------------
;                                                                   --
; Methode pour print l'espace du jeu   initialemt remplis avec '~'  --
;                                                                   --
;---------------------------------------------------------------------
display: STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 


iloop:   CPX     iSize,i
         
         BRGE    findisp      ; 
         
         LDX     0,i         ; 
         STX     jx,d        ; 
         DECO    range,d
         ;CHARO  '|',i 

 

         
jloop:   CPX     jSize,i
         BRGE    next_ix
         ADDX    ix,d
         ;CHARO   tild,i
         ;CHARO   ' ',i
         CHARO   empty, i
         LDX     ix,d         
         LDA     matrix,x    ; rA <- address of ln1,ln2 or ln3
         STA     ptr,d
         LDX     ptr,d
         ADDX    jx,d
         ;LDA     tild,i
         ;LDA     ' ',i 
         LDA     empty, i
     
         STA     0,x 
         LDX     jx,d
         ADDX    2,i ;ADDX    2,i 
        
         STX     jx,d 
         BR      jloop 

next_ix: CHARO   '|',i
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i ;ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop
findisp: STRO    ALPHA2,d ;CHARO   '\n',i 
         CHARO '\n', i
         RET0             
        

;---------------------------------------------------------------------------
;                                                                         --
;   --
;    --print ask msg 
;                                                                          --
;----------------------------------------------------------------------------
msgAsk:          STRO askMsg, d 
                 RET0
;--------------------------------------------------------------------------------------
;------          la position de depart du serpent : colonne                       -----
;--------------------------------------------------------------------------------------
getSerC:        LDBYTEA serpCol,d ;CHARI   serpCol,d     ;LDBYTEA 0,i
               ; LDA 0,i  
                
                ;STBYTEA serpCol,d
                        
                CPA	'A', i
                    
                
                BRLT	erreur;Sierr 
   
                CPA	'R', i

;err0:           STRO  msgErr, d
                ;BR    Sierr ; Si inferieur ? A : msg d'erreur 
                    
                BRGT   erreur ;Sierr
;err01:          STRO  msgErr, d
               ; BR    Sierr  ; Si grand que R : msg d'erreur



                 STA   Spcolt, d
                 SUBA  'A', i   ; Enlever 'A' du matrixCol 
                 ;ASLA           ; here i get my position at y
                 STA   col, d   ; Colonne du depart du  serpent  col = matrixCol -'A'
                 
                 BR getposR 

erreur:          STRO msgErrC, d        
                 STRO msgErr, d 
                 BR   Repeat 

                 
;--------------------------------------------------------------------------------------
;----                         la position de depart du serpent :  rangee          -----
;--------------------------------------------------------------------------------------

               
getposR:         LDBYTEA  serpRow, d

                
                 CPA	49, i     
                 BRLT ErOr 

                 CPA	57, i

                 STA Sprowt, d
		 
                 
                 BRGT	ErOr 


                 SUBA 48,i
                 STA rowtemp, d


                 SUBA  1, i  ; on commence ?  0
                 ;ADDA  1, i
                 ;ASLA
                 STA   row, d  ; Store res dans variable row

                 BR charger      ; suivant

ErOr:            STRO msgErrR, d
                 STRO msgErr, d 
                 BR Repeat
                 CHARO '\n', i
                

;-------------------------------------------------------------------------------------
;---                                                                          --------
;---                         Compter la longueur du serpent                   --------
;---                                                                          --------
;---                                                                          --------
;---                                                                          --------
;---                                                                          --------
;-------------------------------------------------------------------------------------


;tan que le char est different de '\n' on continue la lecture 
; si le char est diffrent de 'd' ou 'g' ou '-' , l'entree est invalide 

;loadSer:         lDA cpt, d
                 
                 ;CALL golp_in
                 ;RET0 
                 ;STA     cpt,d 
                 ;LDA 18, i
                 ;STA cpt, d 

charger:         LDA     hpPtr,d     
                 STA     head,d 





                
                 
suivant:         LDA 0,i
                 CHARI orient,d 
                 
                 LDBYTEA  orient,d 
                
                 
            

                 
                 CPA   'd', i
                 BREQ debut10  ; si char = 'd' on ajoute 1 ‡ registre A

                 
                 CPA   'g', i
                 BREQ debut20 ; si char = 'g' 

                 CPA   '-', i
                 BREQ debut30 ; si char = '-' pour tout droit

                
                 CPA '\n', i
                 ;BREQ loop_out 
                 BREQ    outt
                 
                 STRO  msgErrL, d
                 STRO  msgErr, d
                 BR    Repeat  ; sinon char incorrecte ----> demander d'entrer nouvel char 
 


;path:            golp_in  
;golp_in:         LDA     mLength,i ;CPA     '\n',i  ;CPA     0,i         
                 ;BRLE    outt         ; for(cpt=10; cpt>0; cpt--) {
                    
            ;     CALL    new         ;   X = new Maillon(); #mVal #mNext 





debut10:         LDA     mLength,i
                 CALL    new   ;   X = new Maillon(); #mVal #mNext 
                 STX     adrMail,d
                 LDA     100,i;LDBYTEA '>', i       ;LDA 62,i  100 pour droite 
                 STA     mVal,x ;STBYTEA mVal,x   
                 ;STA     mVal,x 
                 LDA     0,i 
                 ;LDA     head, d
                 STA     mNext, x
                 CPX     head,d 
                 BREQ    firstEl     ; if(X!=head){
                 SUBX    mLength,i   
                 ;STX     head, d
                 LDA     adrMail,d
                 STA     mNext, x
firstEl:         BR      suivant      ;golp_in


debut20:         LDA     mLength,i
                 CALL    new    ;   X = new Maillon(); #mVal #mNext 
                 STX     adrMail,d
                 LDA     103,i     ; 103 pour gauche 
                 STA     mVal,x 
                 ;STA     mVal,x 
                 LDA     0,i   
                 ;LDA     head, d
                 STA     mNext, x
                 CPX     head,d 
                 BREQ    secondEl     ; if(X!=head){
                 SUBX    mLength,i 
                 LDA     adrMail,d
                 STA     mNext, x
                 ;STX     head, d
secondEl:        BR      suivant;  golp_in

debut30:         LDA     mLength,i
                 CALL    new    ;   X = new Maillon(); #mVal #mNext 
                 STX     adrMail,d
                 LDA     116,i       ; t 116 pour tout droit 
                 STA     mVal,x 
                 LDA     0,i 
                 STA     mNext,x     ;   X.next = 0; ;<----rendu ici 
                 CPX     head,d 
                 BREQ    thirdEl     ; if(X!=head){
                 SUBX    mLength,i 

                 LDA     adrMail,d

                 ;LDA head, d
                 STA mNext, x
                 ;STX head, d
               
thirdEl:         BR suivant;     golp_in




outt:            LDX     head,d
loop_out:        CPX     0,i         
                 BREQ    fin         ; for (X=head; X!=null; X=X.next) { 
                 LDA     mVal, x     ;orient,x 
                 STBYTEA     CheKCar, d
                 ;CHARO    mVal,x
                 CHARO    CheKCar,d     
                 CHARO   ' ',i       ;   print(X.val + " ");

                 LDX     mNext,x     
                 BR      loop_out    ; } // fin for


fin:             BR  posInit ;RET0 
                 

head:    .BLOCK  2           ; #2h tÍte de liste (null (aka 0) si liste vide)
adrMail: .BLOCK  2           ; #2h

;******* Structure de liste d'entiers
; Une liste est constituÈe d'une chaÓne de maillons.
; Chaque maillon contient une valeur et l'adresse du maillon suivant
; La fin de la liste est marquÈe arbitrairement par l'adresse 0

mVal:    .EQUATE 0           ; #2d valeur de l'ÈlÈment dans le maillon
mNext:   .EQUATE 2           ; #2h maillon suivant (null (aka 0) pour fin de liste) 
mLength: .EQUATE 4           ; taille d'un maillon en octets


             



;-------------------------------------------------------------------------------------
;---                                                                          --------
;---                    Obtenir la position initiale du serpent               --------
;---                                                                          --------
;---                                                                          --------
;---                                                                          --------
;---                                                                          --------
;-------------------------------------------------------------------------------------



posInit:         LDA row, d
                 ;DECO row, d
             
                 
                 LDX nbCol, i ; number of colom  =18 ;LDX  18,i  ;
                 
                 BRGE commence ; if(nb2 < 0){

                 LDA row,d ; maybe it is iSize,d
                 
                 ;LDA rowtemp,d
                 NEGA ;
                 STA row,d ; A = nb1 = -nb1;
                 
                 
              

commence:        LDA 0,i ; A = 0;
addition:        ADDA row,d ; do{ A += nb1; ADDA rowtemp, d ; ADDA col, d ;
                 SUBX 1,i ; X--;
                 BRNE addition ; } while(X != 0);
                 ;ASLA 
fini:            STA res1,d ; res1 = A;
                 LDA col,d
                 ADDA res1,d
                 ASLA
                 STA serpPos,d ; position initiale du serpent 
                 STA postem, d ; position de bateau 
                 
                 ;CHARO 'z',i
                 ;DECO pos,d     ; position du bateau bateau[rangee][colonne] = pos
                 CHARO '\n', i 
                ; STRO "nbColone*row = \x00", i 
                 ;DECO res1,d ; cout << res;
                 ;DECO postem, d 

                  

                
                 ;RET0



;--------------------------------------------------------------------------------------
;-----------------------------mettre a jour la matrice   ------------------------------
;-----------------------------avec la position initiale du serpent --------------------
;--------------------------------------------------------------------------------------

;on commennce par placer la tete du serpent 

        
LdpoIn:          LDX matrix,d   ;ldx matrix,i     load la position initiale du serpent
                 ADDX serpPos,d 
                 STX serpPos,d
               ;--------------
                 ;deco pos,i
                 
               ;--------------
                 ;LDX pos,d    ; position du bateau xy = (pos 'col' - 'A' + long*(rang-1))*2 
                 ;LDA orient,d  ; maybe it is d
                

                 LDA '>', i
                 STA serpPos,n
                 ADDX 2,i
                 STX serpPos,d

; ensuite on place le parcours du serpent


outtt:           LDX     head,d 
lop_outt:        CPX     0,i         
                 BREQ    finn         ; for (X=head; X!=null; X=X.next) { 
                 LDA     mVal, x     ;orient,x 
                 STBYTEA     CheKCar, d
                 ;CHARO    mVal,x
                 CHARO    CheKCar,d     
                 CHARO   ' ',i       ;   print(X.val + " ");
                 
                 CPA 116, i
                 BREQ godroit





godroit:         LDA '>', i
        
                 STA serpPos,n
                 ADDX 2,i
                 STX serpPos,d
                 
                 SUBX 2, i

                 LDX     mNext,x     
                 BR      lop_outt    ; } // fin for


finn:             BR  display2

                 
                 

                 ;RET0  ; fin de loop placer debut du serpent

;---------------------------------------------------------------------------
;                                                                         --
;   --
;    --
;                                                                          --
;----------------------------------------------------------------------------




display2:CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop2:   CPX     iSize,i
         
         BRGE    ret ;FeuMsg ; Si on a terminÈ l'affiuchage du tableau avec les bateaux dedans
                        ; on demande ‡  l'utilisateur d'entrer les coups. 
         
                              
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         ;CHARO  '|',i 
          
jloop2:   CPX     jSize,i
         BRGE    next_ix2
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    ; 

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
         ;LDX     ptr,d

         ADDX    jx,d
         LDX     jx,d
         ADDX    2,i         
         STX     jx,d 
         BR      jloop2

next_ix2: CHARO   '|',i
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop2

ret:     RET0 ;


;---------------------------------------------------------------------------
;                                                                         --
;   --
;    --A partir d'ici, le code traite le parcours du serpent 
;                                                                          --
;----------------------------------------------------------------------------


               




    











         ;-----------------------------------------------------------------

         ;--imprimer msg demandant d'entrer les specification du serpent 
         ;--position initiale et parcours
         ;--

         ;-----------------------------------------------------------------








;--------------------------------------------------------------------------------------
;-----------------------------mettre a jour la matrice   ------------------------------
;-----------------------------avec la position initiale du serpent --------------------
;--------------------------------------------------------------------------------------


        
placerS:         LDX matrix,d   ;ldx matrix,i
                 ADDX serpPos,d 
                 STX serpPos,d
               ;--------------
                 ;deco pos,i
                 
               ;--------------
                 ;LDX pos,d    ; position du bateau xy = (pos 'col' - 'A' + long*(rang-1))*2 
                 ;LDA orient,d  ; maybe it is d
                 LDA dir,d
                 CPA 'h',i
                 BRNE placerVB   ; Si different de h donc c'est vertical 
                 


                 LDA size,d
                 STA size,d
loopPlac:        CPA 0,i 
                 BREQ finlpPl
                 LDA '>',i
                 
                 ;STA matrix,x 
                 STA serpPos,n
                 ADDX 2,i
                 STX serpPos,d
                 ;ADDX 1,i
                 LDA size,d
               ; STA sizetem, d 
                 SUBA 1,i
                 STA size,d
                 BR loopPlac






placerVB:        LDA size,d
                 STA size,d

                 
                 ;STA matrix,x 
                 ;ADDX 18, i
               
                 
                 
                 

loopPlcV:        CPA 0,i 
                 BREQ finlpPl
                 LDA 'V',i
                 
                 ;STA matrix,x 
                 STA serpPos,n
                 ;ADDX 2,i
                 ADDX 36, i
                 STX serpPos,d
                 ;ADDX 1,i
                 LDA size,d
               ; STA sizetem, d 
                 SUBA 1,i
                 STA size,d
                 BR loopPlcV

finlpPl:         RET0  ; fin de loop placer bateau

           ;-----------------------------------------------------------
           ;-------   A partir de cet endroit                    ------
           ;-------   le traitement des coups entres  commence   ------            
           ;-------   les coups a entrer              -----------------
           ;-----------------------------------------------------------

                 

                 

;--------------------------------------------------------------------------------------
;-----------------------------Validation du position de bateau   ---------------------
;--------------------------------------------------------------------------------------

         
;isValid:         LDA  
                ; CPA ; Verifier si la  position des bateaux est a l'interieur de la matrix 
                ; RET0


;---------------------------------------------------------------------------------------
;----------------Imprimer -----------------------------
;----------------------------------------------------------------------------------------


                 

KillEnd: STRO MsgEnd, d
         
         CHARI Anychar, d ; si on rentre '\n' on continue sinon on arrete le programme
         ;LDA 0,i
         LDBYTEA Anychar, d
         ;STA Anychar, d;LDA 0,i
          
         CPA '\n', i
         BREQ gomain 

         
         ;LDA carVide, d 
         
         CALL END
         
         
gomain:          LDA 0, i 
                 STA range, d 
                 CALL main
         
END:     STRO realEnd, d ;sinon le programme s'arrete


STOP
        

                       
 
;-------------------------------------------------------------------------
;------  Declaration, reservation espace memoire et  initialisation ------
;-------------------------------------------------------------------------
; Current line Index
lnIndex: .WORD 0

;Max line address = line start + 8
maxLnAdr:.WORD 0

nbLu:    .block 2

matrix:  .ADDRSS ln1         ; #2h
         .ADDRSS ln2         ; #2h
         .ADDRSS ln3         ; #2h
         .ADDRSS ln4         ;avant existe pas
         .ADDRSS ln5
         .ADDRSS ln6
         .ADDRSS ln7
         .ADDRSS ln8
         .ADDRSS ln9
         ;.ADDRSS ln10

ln1:              .BLOCK 36 ; #2d18a 
ln2:              .BLOCK 36 ; #2d18a 
ln3:              .BLOCK 36 ; #2d18a 
ln4:              .BLOCK 36 ; #2d18a 
ln5:              .BLOCK 36 ; #2d18a 
ln6:              .BLOCK 36 ; #2d18a 
ln7:              .BLOCK 36 ; #2d18a 
ln8:              .BLOCK 36 ; #2d18a 
ln9:              .BLOCK 36 ; #2d18a 


;totSize: .equate 48       ;CHANGER avant equate 24 pour 3x4 | critere pour taille de matrice (x2)

;iSize:   .BYTE 9       ;18 parceque la matrice contien 9 lignes
iSize:   .equate 18

nbRow: .equate 9
nbCol: .equate 18


jSize:   .equate 36       ;36 parceque la matrice contien 18 Colonne 
;jSize:   .BYTE 18  ; was 36
res1:    .BLOCK 2
res2:    .BLOCK 2
serpPos:     .BLOCK 2    ; position du serpent = [col- 'A' + nbColonne*(range-1)]*2
postem:  .BLOCK 2

ress1:    .BLOCK 2
posFeu:   .BLOCK 2  ; la position du feu 


ptr:     .BLOCk 2 

             .BLOCK 18 ; #2d18a 

ALPHA:        .ASCII " ABCDEFGHIJKLMNOPQR\n\x00" 
ALPHA2:       .ASCII " ------------------\n\x00"   

tild:         .EQUATE 0x007E   ; char ~
empty:        .EQUATE 0x0020   ;  char space
carVert:      .EQUATE 0x0076   ; char v
carHori:      .EQUATE 0x003E   ; char > 
emptyO:       .EQUATE 0x006F   ; char o , si aucune partie de boat n'est touche»
tempCol:      .BLOCK 2
tempRow:      .BLOCK 2

coltemp:      .BLOCK 2
rowtemp:      .BLOCK 2

sizeT: .BLOCK 2  ; temporaire

col:       .WORD 0  ; la colonne du position initaile serpent
dir:       .WORD 0  ; direction du position initaile serpent 
row:       .WORD 0  ; la rangee du serpent

orient:    .BYTE 1  ; l'orientation du serpent

;                           serpCol
CheKCar:   .BLOCK 2
size:	.BYTE 1  ; la grandeur du bateau 
sizetem:  .BYTE 1 
boatdir:  .BYTE 1
serpRow:  .BLOCK 2
boatSize: .BYTE 1 
serpCol:  .BYTE 1  ;serpCol
gap:      .BYTE 1
gapFeu:  .BYTE 1  ; espace entre chaque coup
var:     .BLOCK 1
colFeu:  .WORD 0 ; colonne du coup entr»
rowFeu:  .WORD 0 ; rangee du coup entr»
FeuColt: .WORD 0 ; colonne du coup entr» temporaire 
FeuRowt: .WORD 0 ; rangee du coup entr» temporaire 
Anychar: .BLOCK 2
nbCoup: .BLOCK 2
carVide: .BLOCK 2

;cpt:     .BLOCK  2           ; #2d compteur de boucle nombre de char moins la position initiale 
;cpt1:    .BLOCK  2           ; #2d compteur de boucle

;cpt:    .BLOCK  2           ; #2d compteur de boucle

Spcolt:  .BLOCK 2
Sprowt:  .BLOCK 2


nval: .BLOCK 2 ; #2d 


 
                
                   
    
     
                   
        
         

ix:      .BLOCK  2           ; #2d  reserv» 2 octet ? ix initialis» ? 0 // rangee ou line 
 
jx:      .BLOCK  2           ; #2d  reserv» 2 octet ? jx initialis» ? 0  // colonne 
range:   .WORD  1            ; nbr de rangee a imprimer 
rantemp:   .WORD  1  

temp:    .block  2           ;reserv» 2 octet ? temp
;temp:    .block  1           ;reserv» 2 octet ? temp
gapp:    .WORD ' '

welMsg:  .ASCII "Bienvenue au serpentin!\n\x00"



askMsg:  .ASCII "Entrer un serpent qui part vers l'est: \n"
         .ASCII "{position initiale est parcours} \n"
         .ASCII "avec [-] (tout droit), [g] (virgae ‡ gauche), \n"
         .ASCII "[d] (virage ‡ droite)\n\x00" 

msgErr:  .ASCII  "Erreur d'entrÈe. Veuillez recommencer. \n"
         .ASCII  "Entrer un serpent qui part vers l'est: \n"
         .ASCII "{position initiale est parcours} \n"
         .ASCII "avec [-] (tout droit), [g] (virgae ‡ gauche), \n"
         .ASCII "[d] (virage ‡ droite)\n\x00" 

msgErrC:  .ASCII  "Colonne Invalide. \n\x00"
msgErrR:  .ASCII  "Rangee Invalide. \n\x00"
msgErrL:  .ASCII  "les specification du parcours: \n"
          .ASCII  "droit, gauche ou tout droit sont  Invalide. \n\x00"


MsgFeu: .ASCII "Feu ? volont»!\n"
        .ASCII "(entrer les coups ? tirer: colonne [A-R] rang»e [1-9])\n"
        .ASCII "ex: A3 I5 M3 \n\x00"

MsgEnd: .ASCII     "Vous avez anÈanti la flotte! \n"
        .ASCII     "Appuyer sur <Enter> pour jouer ‡ nouveau ou \n"
        .ASCII      "n'importe quelle autre saisie pour quitter. \n" 
        .ASCII     "blabla \n\x00"
realEnd:.ASCII     "Au revoir! \n\x00"

;
;
;******* operator new
;        Precondition: A contains number of bytes
;        Postcondition: X contains pointer to bytes
new:     LDX     hpPtr,d     ;returned pointer
         ADDA    hpPtr,d     ;allocate from heap
         STA     hpPtr,d     ;update hpPtr
         RET0                
hpPtr:   .ADDRSS heap        ;address of next free byte
heap:    .BLOCK  1           ;first byte in the heap


                                  


                                  .END

;------------------------------------------------------------------------------------
;-----------------------la grandeur  du bateau -------------------------------------
;-------------------------------------------------------------------------------------

getsize:         CHARI boatSize, d 
                 LDBYTEA boatSize, d 
                 CPA   'g', i
                 BREQ casSize1    ; cas ou le bateau est grand 
                 CPA   'm', i
                 BREQ casSize2   ; cas ou le bateau est moyen 
                 CPA   'p', i
                 BREQ casSize3  ; cas ou le bateau est petit
                 
                 BR Sierr;BR    msgSrpt   ; brancher si le bateau ni grand, ni moyen ni petit. 
                  
casSize1:        LDA   5,i
                 CPA   5,i
                 BREQ finCasSz 
casSize2:        LDA   3,i
                 CPA   3,i
                 BREQ finCasSz
casSize3:        LDA   1,i
finCasSz:        STA sizeT,d
                 STA  size,d   ; la grandeur du bateau 
                  
                 ;DECO sizeT, d  
                 RET0


;-------------------------------------------------------------------------------------
;---------------------------l'orientation du Serpent ---------------------------------
;-------------------------------------------------------------------------------------
getOri:          CHARI orient,d
                 LDBYTEA orient,d   ; orientation du bateau 
                 STA dir, d   ; direction du bateau 
                 CPA   'd', i
                 BREQ finOrien  ; si char = 'd' retour a la methode 
                 CPA   'g', i
                 BREQ finOrien ; si char = 'g' 
                 CPA   '-', i
                 BREQ finOrien ; si char = '-' pour touit droit
                 BR Sierr ;BR   msgSrpt  ;  si char != 'd' ou 'g'  ou '-' 
finOrien:        RET0 ; retour a la methode 


;-------------------------------------------------------------------------------------
;---                                                                          --------
;---     Apres avoir obtenu la position initiale l'orientation du Serpent     --------
;---         on doit traiter le parcours suivi par le serpent                 --------
;---                         char 'd' pour droite                             --------
;---                         char 'g' pour gauche                             --------
;---                         char '-' pour tout droite                        --------
;-------------------------------------------------------------------------------------




Next:            CHARI orient,d               
                 LDBYTEA orient,d   ; orientation du serpent
                 STA dir, d   ; direction du serpent
                 CPA   'd', i
                 BREQ outOrien  ; si char = 'd' retour a la methode 
                 CPA   'g', i
                 BREQ finOrien ; si char = 'g' 
                 CPA   '-', i
                 BREQ finOrien ; si char = '-' pour tout droit
                 BR Repeat  ;  si char != 'd' ou 'g'  ou '-' 
outOrien:        RET0 ; retour a la methode 

