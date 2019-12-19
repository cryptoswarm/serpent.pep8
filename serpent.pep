;---------------------------------------------------------------------
;                                                                   --
; Le program suivant peut verifie la description et le parcours de serpent 
; et le place a l'interieur de l'espace de jeu. 
; Le programme permet d'entrer plusieurs morceau du serpents

        ;-----------------------------------------------------------;
        ;     Explication de la description et la methode           ;
        ;      suivie pour obtenir la position initiale et final    ;
        ;-----------------------------------------------------------;

; Par la description on veut dire la position initiale qui est composeÈ 
; de la rangee et de la colonne. 
; Cette position a ete calculeÈ en utilisant la formule suivante :
; position initiale = Colonne + (nbDeColonne * rangee)
; par ex : la position a la case R5 est egale ‡  ASLA ('17' + [17*4])
; le programme determine sa fin si le serpent atteint la position  definit par la case R5
;
; le programme peut placer les serpents un par un dans la position correcte.
;
; Si une case du serpent se trouve ‡ une case adjacente de la queue d'un autre
; les deux se connectent et deviennent un
;   
;       ;-------------------------------------------------------;
;       ;             les erreurs d'entrees                     ;
;       ;-------------------------------------------------------;
;
; Si l'utilisateur entre une entree invalide,  le programme affiche un message d'erreur 
; specifique  la nature de l'erreur 
;
; Exemple1: si on entre X5------
; un message d'erreur serait affichÈ indiquannt que la colonne est incorrecte
;
; Exemple2: si on entre Az------
; un message d'erreur serait affichÈ indiquannt que la rangee  est incorrecte
;
; Exemple3: si on entre A5-----X---d
; un message d'erreur serait affichÈ indiquannt que les specifications du parcours 
; ne sont  pas valides. 
;
;
; Si la fin d'un serpent touche son debut ou une autre case de son corps, 
; le programme affiche que le serpeng est mort.
; 
; Si la tete du serpent se dirige vers une case qui est a l'exterieur de l'espace de jeu 
; Le programme s'arrete en affichant un message d'erreur disant que le serpent entrÈ 
; depasse l'espace de jeu. Puis, l'utilisateur pourrait recommencer s'il (elle) veut. 

;
;
; Vous trouverey une explication exsaustive des noms des variables et methodes.                                                                   
;-----------------------------------------------------------------------------------------     

main:            LDX 0,i 
                 LDA score, d
                 STX score, d  

                 LDX 1, i
                 LDA range, d
                 STX range, d
                      
                 STRO welMsg, d ; imprimer le msg de bienvenue 
                 CHARO '\n', i  ; imprimer saut de ligne
         
                 CALL display 
SnakeX:          CALL msgAsk    ; SnakeX --> apres serpent 1 on revenir ici 
                                ; pour permettre de rentrer  les details d'un autre serpent 
                              
                 

                      
Repeat:          LDX 0,i 
                 CHARI   serpCol,d ;getSerC,d ;CALL getposC  ; 4-->1 appel colonne

                 CHARI   serpRow, d ;CALL getposR  ; 4-->2 appel rangee
                 
                 BR      getSerC

                
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
         

 

         
jloop:   CPX     jSize,i
         BRGE    next_ix
         ADDX    ix,d
        
         CHARO   empty, i
         LDX     ix,d         
         LDA     matrix,x    ; rA <- address of ln1,ln2 or ln3
         STA     ptr,d
         LDX     ptr,d
         ADDX    jx,d
         
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
        

;--------------------------------------------------------------------------------
;                            print ask msg                                       ;                                     --
;--------------------------------------------------------------------------------
msgAsk:          STRO askMsg, d  ;(demader d'entrer les specifications du serpent)
                 RET0
;--------------------------------------------------------------------------------------
;------          la position de depart du serpent : colonne                       -----
;--------------------------------------------------------------------------------------
getSerC:        LDBYTEA serpCol,d ;CHARI   serpCol,d     ;LDBYTEA 0,i
             
                        
                CPA	'A', i
                    
                
                BRLT	erreur
   
                CPA	'R', i


                    
                BRGT   erreur 




                 STA   Spcolt, d
                 SUBA  'A', i   ; Enlever 'A' du matrixCol 
                 
                 STA   col, d   ; Colonne du depart du  serpent  col = matrixCol -'A'
                 
                 BR getposR 

erreur:          LDA 0,i 
                 CHARI charErr, d 
                 LDBYTEA charErr, d
                 CPA '\n', i
                 BRNE erAgain ; reste dans la boucle de l'erreur jusqu'a la fin de la ligne

                 STRO msgErrC, d        
                 STRO msgErr, d 
                 BR   Repeat 

erAgain:         BR erreur                 
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
                
                 STA   row, d  ; Store res dans variable row

                 BR charger      ; suivant


ErOr:            LDA 0,i 
                 CHARI charErr, d 
                 LDBYTEA charErr, d
                 CPA '\n', i
                 BRNE Rerreur ; reste dans la boucle de l'erreur jusqu'a la fin de la ligne

                 STRO msgErrR, d       
                 STRO msgErr, d 
                 BR   Repeat 

Rerreur:         BR ErOr;erreur 
                

;-------------------------------------------------------------------------------------
;---                                                                          --------
;---                         Compter la longueur du serpent                   --------                                                                      
;-------------------------------------------------------------------------------------

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
                 
                 BREQ    outt
                 
                 BR    specErr  ; les specification su serpent sont fausses
specErr:         LDA 0,i
                 CHARI specEr,d
                 LDBYTEA specEr,d
                 CPA '\n', i
                 BRNE specErr
                 STRO  msgErrL, d
                 STRO  msgErr, d
                 BR    Repeat  ; sinon char incorrecte ----> demander d'entrer nouvel char 
 
debut10:         LDA     mLength,i
                 CALL    new   ;   X = new Maillon(); #mVal #mNext 
                 STX     adrMail,d
                 LDA     100,i;LDBYTEA '>', i       ;LDA 62,i  100 pour droite 
                 STA     mVal,x ;STBYTEA mVal,x   
                 
                 LDA     0,i 
                 
                 STA     mNext, x
                 CPX     head,d 
                 BREQ    firstEl     ; if(X!=head){
                 SUBX    mLength,i   
                 
                 LDA     adrMail,d
                 STA     mNext, x
firstEl:         BR      suivant      ;golp_in


debut20:         LDA     mLength,i
                 CALL    new    ;   X = new Maillon(); #mVal #mNext 
                 STX     adrMail,d
                 LDA     103,i     ; 103 pour gauche 
                 STA     mVal,x 
                 
                 LDA     0,i   
                 
                 STA     mNext, x
                 CPX     head,d 
                 BREQ    secondEl     ; if(X!=head){
                 SUBX    mLength,i 
                 LDA     adrMail,d
                 STA     mNext, x
                 
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

                 
                 STA mNext, x
                 
               
thirdEl:         BR suivant;     golp_in





loop_out:        CPX     0,i         
                 
                 LDA     mVal, x     ;orient,x 
                 STBYTEA     CheKCar, d
                 
                 CHARO    CheKCar,d     
                 CHARO   ' ',i       ;   print(X.val + " ");

                 LDX     mNext,x     
                 BR      loop_out    ; } // fin for
 
outt:            BR  posInit
                 

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
;-------------------------------------------------------------------------------------

posInit:         LDA row, d
                

                 LDX nbCol, i ; number of colom  =18 ;LDX  18,i  ;
                 
                 BRGE commence ; if(nb2 < 0){

commence:        LDA 0,i ; A = 0;
addition:        ADDA row,d ; do{ A += nb1; ADDA rowtemp, d ; ADDA col, d ;
                 SUBX 1,i ; X--;
                 BRNE addition ; } while(X != 0);
                 
fini:            STA res1,d ; res1 = A;
                 LDA col,d
                 ADDA res1,d
                 ASLA
                 STA serpPos,d ; position initiale du serpent 
                 STA postem, d  
 
                 ;---------------------------;
                 ; Caccul de position de fin ;
                 ;---------------------------;

posFin:          LDX nbCol, i ; number of colom  =18 ;LDX  18,i  ;
debut:           LDA 0, i
plus:            ADDA 4, i
                 SUBX 1,i ; X--;
                 BRNE plus
end:             ADDA 17, i
                 ASLA
                 STA endPos, d 

;--------------------------------------------------------------------------------------
;-----------------------------mettre a jour la matrice   ------------------------------
;-----------------------------avec la position initiale du serpent --------------------
;--------------------------------------------------------------------------------------

                 ;--------------------------------------------------------;  
                 ;        on commennce par placer la tete du serpent      ;
                 ;--------------------------------------------------------;

        
LdpoIn:          LDX matrix,d   ;ldx matrix,i     load la position initiale du serpent
                 ADDX serpPos,d 
                 STX serpPos,d

                 LDX matrix, d
                 ADDX endPos, d
                 STX endPos, d  
              
                 LDA '>', i
                 STA serpPos,n
                 LDA score, d
                 ADDA 1, i
                 STA score, d
                 ;--------------------------------------------------------;               
                 ;     ensuite on place le parcours du serpent            ;
                 ;--------------------------------------------------------;

outtt:           LDX     head,d 
lop_outt:        CPX     0,i         
                 BREQ    finn         ; for (X=head; X!=null; X=X.next) { 
                 LDA     mVal, x     ;orient,x 
   
                 CPA 116, i     ; pour tout droit -----> char '-'
                 BREQ Alright   ; le serpent continue tout droit de la position de depart
                 ;CPA 100, i
                 ;BREQ goDown   ; a changer 
                 CPA 100, i     ; pour aller a  droite    ----> char 'd'
                 BREQ goDown    ; keepdr  ; a changer aussi
                 
                 CPA 103, i     ;aller a gauche   ------> char 'g'
                 BREQ GauchUp 

;;--------------------------------------------------------------------------------------
;-------------------- Si le parcours du serpent tourne a gauche et --------------------
;-------------------- qu'il continue tout droite  -------------------------------------
;--------------------------------------------------------------------------------------

GauchUp:         LDA serpPos, d 
                 SUBA 36, i       ;ADDA 36, i
                 
                 STA serpPos, d

                 CAll  IfSDead    ; Sous-programme vÈrifiant si la tete touche la queue 
                                  ; ou une case du son corps. 

                  
                                   ; la tete du serpent va vers l'exterieur de l'espace de jeu 
                                  ; donc erreur 
                 LDA '^', i
        
                 STA serpPos,n
     ;----------------------------------------
              ;Compter le score 

                 LDA score, d
                 ADDA 1, i
                 STA score, d
      ;----------------------------------------  
           
                 
                 lDX     head, d
                 LDX     mNext,x 
                 STX     head, d

                 LDA     mVal, x     
   
                 CPA     116, i   ; est ce qu'il continue tout droit ??
                 BREQ    keepS    ; keep straight ou continue tout droit 

                 CPA     100, i   ; char 'd'= 100
                 BREQ    turnD    ; pour tourner a droite 

                 BR      lop_outt

turnD:           LDA serpPos, d 
                 ADDA 2, i

                 STA serpPos, d
                 
                 LDA '>', i
                 STA serpPos,n
      ;----------------------------------------
              ;Compter le score 

                 LDA score, d
                 ADDA 1, i
                 STA score, d
      ;----------------------------------------  
      ;----------------------------------------  
     ; Verifier s'il ya connexion entres les cases A5 et R5
                 LDX serpPos, d
                 CPX endPos, d
                 BREQ gameOv
       ;---------------------------------------- 

    ;<------Verifier s'il tourne a droite encore ------>

                 lDX     head, d
                 LDX     mNext,x 
                 STX     head, d
                 CPX     0, i
                 BREQ    lop_outt
                 LDA     mVal, x
                 CPA     100, i   ;char 'd'= 100
                 BREQ    isGoinD   ; pour dire qu'il va en bas 
isGoinD:         BR      goDown    ; } Si changement de direction // fin for

keepS:           BR      GauchUp

;--------------------------------------------------------------------------------------
;--------------------         Si le parcours du serpent tourne a droite   -------------
;--------------------------------------------------------------------------------------

goDown:          LDA     serpPos, d 
                 ADDA    36, i
                 STA     serpPos, d
                 LDA     'v', i
        
                 STA    serpPos,n
      ;----------------------------------------
              ;Compter le score 

                 LDA score, d
                 ADDA 1, i
                 STA score, d
      ;----------------------------------------        

                 lDX     head, d
                 LDX     mNext,x 
                 STX     head, d

                 LDA     mVal, x     ;orient,x 
   
                 CPA     116, i   ; tout droit -----> char '-' est ce qu'il continue??
                 BREQ    ContDow  ; continue vers le bas 

                 CPA 103, i
                 BREQ turnDD 
                 
                 BR      lop_outt 
          
turnDD:          LDA serpPos, d 
                 ADDA 2, i
                 STA serpPos, d
                 LDA '>', i
                 STA serpPos,n
      ;----------------------------------------
              ;Compter le score 

                 LDA score, d
                 ADDA 1, i
                 STA score, d
      ;----------------------------------------  
     ; Verifier s'il ya connexion entres les cases A5 et R5
                 LDX serpPos, d
                 CPX endPos, d
                 BREQ gameOv
       ;----------------------------------------                    

;<------Verifier s'il tourne a gauche encore ------>
                 lDX     head, d
                 LDX     mNext,x 
                 STX     head, d
                 CPX     0, i
                 BREQ    lop_outt
                 LDA     mVal, x
                 CPA     103, i
                 BREQ    isGoinU  ; pour dire qu'il va en haut

isGoinU:         BR GauchUp 
                 
ContDow:         BR goDown

;;--------------------------------------------------------------------------------------
;-------------------- Si le parcours du serpent commnce par aller tout droit ------------
;-------------------- a partir de la position de depart --------------------------------
;--------------------------------------------------------------------------------------

Alright:         LDA serpPos, d 
                 ADDA 2, i
                 STA serpPos, d
                 
                
                 
                 ;BR extUp      ; SINON la TETE du SERPENT EST A l'exterieur de 
                               ; de l'espace de jeu ( n'est pas a l'interieur de 
                               ; de la colonne A et R) 
 

KepLoad:         LDA '>', i
        
                 STA serpPos,n
                 LDA score, d
                 ADDA 1, i
                 STA score, d

                 LDX serpPos, d
                 CPX endPos, d
                 BREQ gameOv
                            
           
                 
                 lDX     head, d
                 
                 LDX     mNext,x 
                 STX     head, d
                 CPX     0, i
                 BREQ    lop_outt

                 LDA     mVal, x     ;orient,x 
   
                 CPA     116, i   ; est ce qu'il continue tout droit ??
                 BREQ    keePS33 ;  keep straight continue tout droit 
                 CPA     103, i  ; est ce qu'il change ‡ gauche ? 
                 BREQ    GochUp1 
                 CPA     100, i   ; char d pour droite
                 BREQ    virDroi
              
                 BR      lop_outt    ; } Si changement de direction // fin for


GochUp1:         BR   VaGoch1 ;<---- s'il tourne a gauche apres qu'il etait tout droit 
virDroi:         BR   VaDroit1;<---- s'il tourne a droite

keePS33:         BR   Alright ;<---- s'il continue tout droit 

;;--------------------------------------------------------------------------------------
;-------------------- Si le parcours du serpent tourne a gauche et --------------------
;-------------------- qu'il continue tout droite  -------------------------------------
;--------------------------------------------------------------------------------------

VaGoch1:         LDA serpPos, d ; va a gauche 1
                 SUBA 36, i     ; enlever 36 pour aller vers la ranger en haut 
                 STA serpPos, d

                                   ; la tete du serpent va vers l'exterieur de l'espace de jeu 
                 CALL  teteHaut    ; donc erreur 

                 CALL IfSDead      ; Si la tete touche la queue ou une autre partie du 
                                   ; corps du serpent. 

                 LDA '^', i
        
                 STA serpPos,n

                 lDX     head, d   ;g---d
                 CPX     0, i
                 BREQ    lop_outt
                 LDX     mNext,x 
                 STX     head, d

                 LDA     mVal, x     
   
                 CPA     116, i   ; est ce qu'il continue tout droit ??
                 BREQ    stayS2 ;  keep straight ou continue tout droit 

                 CPA     100, i; char 'd'= 100
                 BREQ     tuRnD1 ; pour tourner a droite 

                 BR      lop_outt

stayS2:          BR     VaGoch1 ; continue tout droit mais vers le haut 

;-------------------------------------------------------------------------------------
;--------------- si le serpent tourn a droite et continue tout droit
;----------------- puis tourn a droit encore  ---------------------------------------
;---------------------------------------------------------------------------------------

tuRnD1:          LDA serpPos, d      ; tourner a droit 1
                 ADDA 2, i
                 STA serpPos, d
                 LDA '>', i
                 STA serpPos,n

                 lDX     head, d
                 LDX     mNext,x 
                 STX     head, d
                 CPX     0, i
                 BREQ    lop_outt
                 LDA     mVal, x    
                 CPA     116, i    ;char '-'= 116
                 BREQ    iSGoinS   ; pour dire qu'il continue tout droit 

                 CPA     100, i
                 BREQ    iSgooD

iSGoinS:         BR      tuRnD1 ;goS2    ; } Si changement de direction // fin for
;--------------------------------------------------------------------------------------
;----------   Si le serpent vir a droit apres qu'il a commence tout droit  -------------
;---------------------------------------------------------------------------------------
VaDroit1:        LDA     serpPos, d    
                 ADDA    36, i
                 STA     serpPos, d
                 
                 ;Test: si la tete du serpent va sortir de la rangee 9
                 ; serpent a va a l'exterieur de jeu 


                 LDA matrix, d
                 ADDA 288, i
                 CPA serpPos, d
                 BRGT kLoadV                 

                 LDA matrix, d
                 ADDA 288, i
                 CPA serpPos, d
                 BRLE grand11


grand11:         LDX  matrix, d
                 ADDX 322, i
                 CPX  serpPos, d 
                 BRGE kLoadV

                 BR      extUp 


kLoadV:           LDA     'v', i
        
                 STA    serpPos,n
           
                 
                 lDX     head, d   
                 CPX     0, i
                 BREQ    lop_outt
                 LDX     mNext,x 
                 STX     head, d

                 LDA     mVal, x     ;orient,x 
   
                 CPA     116, i   ; tout droit -----> char '-' est ce qu'il continue??
                 BREQ    kePPD2   ; continue tout droit vers le bas 

                 CPA    100, i    ; char d
                 BREQ   turND5    ; tourner a droit apres qu'il descendu vers la droite

                 CPA    103, i 
                 
                 BREQ     Alright
                 
                 BR      lop_outt 

kePPD2:          BR VaDroit1

;--------------------------------------------------------------------------------------
;---------------- le serpent  tourne a droit vers le bas------------------------------
;--------------------------------------------------------------------------------------

iSgooD:          LDA     serpPos, d    
                 ADDA    36, i
                 STA     serpPos, d
                 LDA     'v', i
        
                 STA    serpPos,n
           
                 
                 lDX     head, d   
                 CPX     0, i
                 BREQ    lop_outt
                 LDX     mNext,x 
                 STX     head, d

                 LDA     mVal, x     ;orient,x 
   
                 CPA     116, i   ; tout droit -----> char '-' est ce qu'il continue??
                 BREQ    kePPD1   ; continue tout droit vers le bas 

                 CPA    100, i    ; char d
                 BREQ   turND5    ; tourner a droit apres qu'il descendu vers la droite 
                 
                 CPA   103, i
                 BREQ  Alright
                  
                 
                 BR      lop_outt 

kePPD1:          BR     iSgooD 

;---------------------------------------------------------------------------------------
;-------------------- le serpent change son parcours vers la droit apres 
;--------------------- qu'il a descendu vers la droite -------------------------------
;-----------------------------------------------------------------------------------------


turND5:          LDA serpPos, d    ; tourner a droit 
                 SUBA 2, i   
                 STA serpPos, d
                 LDA '<', i
        
                 STA serpPos,n
           
                 
                 lDX     head, d
                 CPX     0, i
                 BREQ    lop_outt
                 LDX     mNext,x 
                 STX     head, d

                 LDA     mVal, x     ;orient,x 
   
                 CPA     116, i   ; est ce qu'il continue tout droit ??
                 BREQ    KEepS7 ;  keep straight continue tout droit 
                 CPA     103, i  ; est ce qu'il change ‡ gauche ?  
                 BREQ    iSgooD  ; Godown8 ; il va vers le bas : go down 8
                 CPA     100, i  ; est ce qu'il change ‡ droite 
                 BREQ    VaGoch1 ; pour dire qu'il va droite vers le haut

KEepS7:          BR turND5

;--------------------------------------------------------------------------------------
;-------------------------   display  position intiale              ---------------------
;-------------------------   et aprcours du serpent      ---------------------------------
;--------------------------------------------------------------------------------------


finn:             BR  display2

                 
;-----------------------------------------------------------------------------------
;   --
;    --Affichahe de la position initiale du serpent 
;       et du parcours du serpent ensuite afficher un message 
;        qui demande au joueur d'entrer un nouveau morceau d'un nouveau serpent
;                                                                          
;------------------------------------------------------------------------------------

display2:CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop2:   CPX     iSize,i
         
         BRGE    ret ; Si on a terminÈ l'affiuchage du tableau avec position initiale
                     ; et parcours dedans on demande ‡  l'utilisateur de faire 
                     ; une nouvelle entree.
 
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         
jloop2:   CPX     jSize,i
         BRGE    next_ix2
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
  
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

ret:     STRO    ALPHA2,d 
         CHARO '\n', i
         BR      SnakeX    ; permet a l'utilisateur d'entrer 
                            ;les pecifications d'un nouveau serpent

;BR      SnakeX 
CALL    headHit
CALL    count
CALL    Shead
;CALL    chaine 
        BR      SnakeX 
;
;-----------------------------------
headHit: LDA serpPos, d
         CPA endPos, d
         BRNE goback1
goback1: RET0
;-----------------------------------
;       
;
count:  LDA nbTete, d
        ADDA 1, i
        STA nbTete, d
        RET0
;-------------------------------------
;        
Shead:  LDX nbTete, d
        CPX 1, i
        BREQ Shead1

        CPX 2, i
        BREQ Shead2

         CPX 3, i
        BREQ Shead3

         CPX 4, i
        BREQ Shead4

         CPX 5, i
        BREQ Shead5

Shead1: LDA serpPos, d
        STA head1, d 
        RET0
         
Shead2: LDA serpPos, d
        STA head2, d
        RET0
        
Shead3: LDA serpPos, d
        STA head3, d
        RET0
        
Shead4: LDA serpPos, d
        STA head4, d
         RET0        
        
Shead5: LDA serpPos, d
        STA head5, d 
         RET0       
        ;BRNE goback2
;goback2: RET0
         
;----------------------------------- 
;chaine: 
                           

;-------------------------------------------------------------------------------------------
           ;-------  Afficher la position initiale du serpent  ---------
           ;------ son parcours puis le score et le message de fin ----
           ;-------               -----------------
;-------------------------------------------------------------------------------------------

gameOv:  CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop3:   CPX     iSize,i
         
         BRGE    endend      ; Si on a terminÈ l'affichage du tableau avec position initiale
                             ; et parcours dedans on demande ‡  l'utilisateur de faire 
                             ; une nouvelle entree.
 
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         
          
jloop3:   CPX     jSize,i
         BRGE    next_ix3
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
         

         ADDX    jx,d
         LDX     jx,d
         ADDX    2,i         
         STX     jx,d 
         BR      jloop3

next_ix3:CHARO   '|',i
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop3

endend:  STRO    ALPHA2,d 
         CHARO '\n', i
        
         
         STRO MsgEnd,d
       
         DECO score, d 

         CHARO '\n', i
         STRO MsAgain, d 
         CHARI JEncor, d     ; jouer encore 
         LDBYTEA  JEncor, d
         CPA '\n', i
         BREQ main

         STRO realEnd, d
         BR toSTOP 
 
;---------------------------------------------------------------------------------------
;          Dans le cas o˘ les specifications du serpent entrÈes sont correctes
;          mais menent ‡ ce que le serpent se trouve a l'exterieur de l'espace de jeu
;                
;---------------------------------------------------------------------------------------

extUp:   CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop4:   CPX     iSize,i
         
         BRGE    enderr      ; Si on a terminÈ l'affichage du tableau avec position initiale
                             ; et parcours dedans on demande ‡  l'utilisateur de faire 
                             ; dans le cas ou le serpent est l'exterieur de l'espace de jeu
 
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         
          
jloop4:  CPX     jSize,i
         BRGE    next_ix4
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
         

         ADDX    jx,d
         LDX     jx,d
         ADDX    2,i         
         STX     jx,d 
         BR      jloop4

next_ix4:CHARO   '|',i
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop4

enderr:  STRO    ALPHA2,d 
         CHARO '\n', i
        
         
         STRO MsgExt, d
         CHARO '\n', i
         STRO MsgEnd, d
       
         DECO 0, i 

         CHARO '\n', i
         STRO MsAgain, d 
         CHARI JEncor, d     ; jouer encore 
         LDBYTEA  JEncor, d
         CPA '\n', i
         BRNE toSTOP2        ; Si different de ENTER on termine le jeu 

         BR main

;---------------------------------------------------------------------------------------
;   Sous- programme verifiant si la tete du serpent va depasser la rangee 1
;                  ( en haut de la rangee1)
;---------------------------------------------------------------------------------------


teteHaut:    LDA matrix, d
             ADDA 34, i
             STA  bigMatx1, d   ; la valeur est a l'exterieur de la matrix 
             
           
             LDX  serpPos, d
             CPx  bigMatx1, d
             BRGE retRET0


             LDX  serpPos, d
             CPx  bigMatx1, d   ; si la position est inferieur  ou egale que bigMatx
                                ; lancer erreur : tete serpent en dehors de la matrix 
             BRLE testmax       ; on entre ici 

testmax:     CPX  matrix, d     ; Si la position est inferieur a matrix=> en dehors de l'espace de jeu 
             BRGE  retRET0  
             
             BR extUp
                 
retRET0:     RET0

;---------------------------------------------------------------------------------------
;   Sous- programme verifiant si le serpent est mort 
;   Par mort on veut dire que sa tete touche la queue ou 
;   une autre partie de son corps             
;---------------------------------------------------------------------------------------

IfSDead:  LDA serpPos,n ;STA serpPos,n

          CPA  empty, i
          
          BRNE death

          RET0

;---------------------------------------------------------------------------------------
;                Imprimer le seroent avant d'annoncer  qu'il est mort            
;---------------------------------------------------------------------------------------



death:   CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop5:   CPX     iSize,i
         
         BRGE    Enderr      ; Si on a terminÈ l'affichage du tableau avec position initiale
                             ; et parcours dedans on demande ‡  l'utilisateur de faire 
                             ; dans le cas ou le serpent est l'exterieur de l'espace de jeu
 
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         
          
jloop5:  CPX     jSize,i
         BRGE    next_ix5
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
         

         ADDX    jx,d
         LDX     jx,d
         ADDX    2,i         
         STX     jx,d 
         BR      jloop5

next_ix5:CHARO   '|',i
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop5

Enderr:  STRO    ALPHA2,d 
         CHARO '\n', i
        
         
         STRO  snakeD, d
         CHARO '\n', i

         STRO MsAgain, d
         CHARI JEncor, d
         LDBYTEA  JEncor, d
         CPA '\n', i
         BRNE toSTOP2 
         BR main
         

;---------------------------------------------------------------------------------------
;                                  Fin du jeux                                          ;
;---------------------------------------------------------------------------------------



toSTOP2: STRO realEnd, d              
toSTOP:  STOP
;-------------------------------------------------------------------------
;------  Declaration, reservation espace memoire et  initialisation ------
;-------------------------------------------------------------------------

lnIndex: .WORD 0


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
         

ln1:              .BLOCK 36 ; #2d18a 
ln2:              .BLOCK 36 ; #2d18a 
ln3:              .BLOCK 36 ; #2d18a 
ln4:              .BLOCK 36 ; #2d18a 
ln5:              .BLOCK 36 ; #2d18a 
ln6:              .BLOCK 36 ; #2d18a 
ln7:              .BLOCK 36 ; #2d18a 
ln8:              .BLOCK 36 ; #2d18a 
ln9:              .BLOCK 36 ; #2d18a 
   
iSize:   .equate 18 ;18 parceque la matrice contien 9 lignes

nbRow: .equate 9
nbCol: .equate 18


jSize:   .equate 36       ;36 parceque la matrice contien 18 Colonne 

res1:    .BLOCK 2
res2:    .BLOCK 2
serpPos:     .BLOCK 2    ; position du serpent = [col- 'A' + nbColonne*(range-1)]*2
postem:  .BLOCK 2
endPos:  .BLOCK 2  

ress1:    .BLOCK 2


ptr:     .BLOCk 2 
score:   .BLOCk 2

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
bigMatx1:      .BLOCK 2
bigMatx2:      .BLOCK 2

coltemp:      .BLOCK 2
rowtemp:      .BLOCK 2

sizeT: .BLOCK 2  ; temporaire

col:       .WORD 0  ; la colonne du position initaile serpent
dir:       .WORD 0  ; direction du position initaile serpent 
row:       .WORD 0  ; la rangee du serpent

orient:    .BYTE 1  ; l'orientation du serpent

;                           serpCol
CheKCar:   .BLOCK 2
charErr:   .BLOCK 2
specEr:   .BLOCK 2  ; char stockÈ les entress si on detecte erreur dans les specifiaction du serpent
size:	.BYTE 1  ; la grandeur du bateau 
sizetem:  .BYTE 1 

serpRow:  .BLOCK 2

serpCol:  .BYTE 1  ;serpCol


var:     .BLOCK 1

Anychar: .BLOCK 2
nbCoup: .BLOCK 2
carVide: .BLOCK 2
JEncor: .BLOCK 2

Spcolt:  .BLOCK 2
Sprowt:  .BLOCK 2

nbTete:  .BLOCK 2
head1:  .BLOCK 2
head2:  .BLOCK 2
head3:  .BLOCK 2
head4:  .BLOCK 2
head5:  .BLOCK 2
head6:  .BLOCK 2



ix:      .BLOCK  2           ; #2d  reserv» 2 octet ? ix initialis» ? 0 // rangee ou line 
 
jx:      .BLOCK  2           ; #2d  reserv» 2 octet ? jx initialis» ? 0  // colonne 
range:   .WORD  1            ; nbr de rangee a imprimer 
rantemp:   .WORD  1  

temp:    .block  2           ;reserv» 2 octet ? temp

welMsg:  .ASCII "Bienvenue au serpentin!\n\x00"



askMsg:  .ASCII "Entrer un serpent qui part vers l'est: \n"
         .ASCII "{position initiale est parcours} \n"
         .ASCII "avec [-] (tout droit), [g] (virgae ‡ gauche), \n"
         .ASCII "[d] (virage ‡ droite)\n\x00" 

msgErr:  .ASCII  "Erreur d'entrÈe. Veuillez recommencer. \n"
         .ASCII  "\n"
         .ASCII  "Entrer un serpent qui part vers l'est: \n"
         .ASCII "{position initiale est parcours} \n"
         .ASCII "avec [-] (tout droit), [g] (virgae ‡ gauche), \n"
         .ASCII "[d] (virage ‡ droite)\n\x00" 

msgErrC:  .ASCII  "Colonne Invalide. \n\x00"
msgErrR:  .ASCII  "Rangee Invalide. \n\x00"
msgErrL:  .ASCII  "les specification du parcours: \n"
          .ASCII  "droit, gauche ou tout droit sont  Invalide. \n\x00"

MsgEnd:   .ASCII  "Fin! Score:     \x00"  
MsgExt:  .ASCII  "Le serpent entrÈ  depasse l'espace de jeu \x00"  
MsAgain: .ASCII  "Voulez-vous jouer encore?     \n"
         .ASCII  "Si oui, appuyez sur la touche ENTER. sinon,\n" 
         .ASCII  "appuyez sur n'importe quel autre touche du clavier.\n\x00"

snakeD:  .ASCII     "Le serpent est mort! Fin du jeu \n\x00"
realEnd: .ASCII     "Au revoir! \n\x00"


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

;------------------------------------------------------------------------------------------
;------  DExplication des noms utilisÈ dans le chois des variables et methode         ------
;--------------------------------------------------------------------------------------------

; IfSDead  : if snake is dead : Verifie si la tete du serpent touche sa queue ou une case
;           qui fait partie de son corps. 

