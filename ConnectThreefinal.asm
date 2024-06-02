INCLUDE Irvine32.inc

.data
; the game boards and menu screens
    Gameboard       db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                              1      2     3     4                                                      ",0
                    db "                                            --------------------------                                                  ",0
                    db "                                            |     |     |     |     |o                                                  ",0
                    db "                                            --------------------------                                                  ",0
                    db "                                            |     |     |     |     |o                                                  ",0
                    db "                                            --------------------------                                                  ",0
                    db "                                            |     |     |     |     |o                                                  ",0
                    db "                                            --------------------------                                                  ",0
                    db "                                            |     |     |     |     |o                                                  ",0
                    db "                                            --------------------------                                                  ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0

Menu                db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                 }-- CONNECT THREE --{                                                  ",0
                    db "                                                 1. PLAYER VS PLAYER                                                    ",0
                    db "                                                 2. PLAYER VS COMPUTER                                                  ",0
                    db "                                                 3. COMPUTER VS COMPUTER                                                ",0
                    db "                                                 4. RULES                                                               ",0
                    db "                                                 5. EXIT                                                                ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    

Rules               db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                             THIS IS CLASSICAL CONNECT 3 GAME.                                                          ",0
                    db "                             IN THE 4X4 GRID TRY TO CONNECT YOUR 3 COLORS TO WIN                                        ",0
                    db "                             DONT LET OTHER PLAYER CONNECT THEIR COLORS FIRST!                                          ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db " PRESS any key TO GO BACK                                                                                               ",0



colorr              db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                     select color                                                                       ",0
                    db "                                      1. blue                                                                           ",0
                    db "                                      2. green                                                                          ",0
                    db "                                      3. cyan                                                                           ",0
                    db "                                      4. red                                                                            ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                    db "                                                                                                                        ",0
                   

; some data variables
    ;gamearr db 80 dup(1)
    playerarr db 16 dup(0)
    count dd 0
    winMessagep2 db "Player2 Win!          Press any key to continue",0
    winMessagep1 db "Player1 Win!          Press any key to continue",0
    loop_count db 0
    curplayer db 0
    playerchoice db 0
    invalid db "Invalid input Enter again                                 ",0
    invalidcolor db "Color already selected by another player, Enter again",0

    input db "Enter your choice: ",0
    pl1 db "Player 1",0
    pl2 db "Player 2",0
    computerplayer db 0
    drawmessage db "Game ended in a DRAW!              Press any key to continue ",0
    menuchoice db 0
    p1color dd 0
    p2color dd 0
    p1colormsg db "Player 1, select your color",0
    p2colormsg db "Player 2, select your color",0
   


.code

; function prototypes ;

displayMenu PROTO, menuu:PTR BYTE, menuch:PTR BYTE
displayColorp1 PROTO, color:PTR BYTE, p1col:PTR BYTE, p2col:PTR BYTE
displayColorp2 PROTO, color:PTR BYTE, p1col:PTR BYTE, p2col:PTR BYTE
displayRules PROTO, rules:PTR BYTE
displayGameBoard PROTO, board:PTR BYTE, count:DWORD, player:BYTE
TakePlayerInput PROTO, choice: PTR byte, playerr:ptr BYTE
TakeComputerInput PROTO, choice: PTR byte, playerr:ptr BYTE
ImplementPlayerMove PROTO, playerarray:PTR BYTE, player:BYTE , choice:BYTE
CheckWinRow PROTO playerArry:PTR BYTE
CheckWinCol PROTO playerArry:PTR BYTE
CheckWinDiagonal Proto playerArry:PTR BYTE
Displayanimation proto position:byte




; main program ;
main PROC
; display the menu and get the choice from the user ;

men:
; reset all registers and variables for new game
    mov count, 0
    mov loop_count, 0
    mov curplayer, 0
    mov playerchoice, 0
    mov menuchoice, 0
    mov p1color, 0
    mov p2color, 0
    mov computerplayer, 0
    mov ecx,16
    mov esi, 0
clearplayerarr:
    mov playerarr[esi],0
    inc esi
    loop clearplayerarr
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    mov esi, 0
    mov edi, 0

; display menu and get the choice
invoke displayMenu, OFFSET Menu, OFFSET menuchoice
; check the choice and jump to the appropriate section
    cmp menuchoice, 1
    je playerVsPlayer
    cmp menuchoice, 2
    je playerVsComputer
    cmp menuchoice, 3
    je computerVsComputer
    cmp menuchoice, 4
    jne oth
; display rules on choice 4
invoke displayRules, OFFSET Rules
    jmp men
oth:
; exit the program on choice 5
    cmp menuchoice, 5
    exit


; player vs player game ;
playerVsPlayer:
    call clrscr
; get color choice for player 1 and player 2
invoke displayColorp1, OFFSET colorr, OFFSET p1color, OFFSET p2color
invoke displayColorp2, OFFSET colorr, OFFSET p1color, OFFSET p2color
	mov computerplayer, 0
	jmp startGame           ; start the game



; player vs computer game ;
playerVsComputer:
	call clrscr
; get color choice for player 1
invoke displayColorp1, OFFSET colorr,  OFFSET p1color, OFFSET p2color
	mov computerplayer, 1
    mov p2color,5
	jmp startGame           ; start the game




; computer vs computer game ;
computerVsComputer:
    mov computerplayer, 2
    mov p1color,5
    mov p2color,6
    jmp startGame


; start game ;    
startGame:    
    INVOKE displayGameBoard, OFFSET Gameboard, count, curplayer             ;display game board

    ; randomly select player who will start
    ; i used 2 methods to randomize the turn to make it more random
    mov eax,30           ; get random from 0 to 30
    call randomize
    call RandomRange
    inc eax             ; make it 1 to 31
    mov ecx,eax
    mov eax,1
    ; this loop will run for random duration to ensure random selection
    loopRandomizeTurn:
    cmp eax,1
    jne s1
    mov eax,2
    jmp go
    s1:
    mov eax,1
    go:
    loop loopRandomizeTurn
    mov curplayer, al
     

;;;;;;;;;;;;;;;;;;
; THE GAME LOOP ;
;;;;;;;;;;;;;;;;

gameloop :
   ; display player name
   mov dl,0
   mov dh, 0
   call gotoxy
   cmp curplayer,1
   jne p2
   mov edx, offset pl1
   call writestring
   jmp cont
  p2:
   mov edx, offset pl2
   call writestring

  cont:
    mov edx, 0
    mov ecx, 0
	mov eax, 0
    mov ebx,0
 
; TURNS ;
    
    ; check if computer is playing
    cmp computerplayer, 1
    je computerplay                 ;player 2 is computer
    cmp computerplayer, 2
    je onlyComputerplay             ;both players are computer
    jmp playerplay                  ;both players are human

onlyComputerplay:
    invoke TakeComputerInput, offset playerchoice, offset playerarr         ; computer turns in computer vs computer
    jmp gamelogic
                                                                            
computerplay:
    cmp curplayer, 1
    je p1turn
    invoke TakeComputerInput, offset playerchoice, offset playerarr         ;cumputer's turn in player vs computer
    jmp gamelogic
    p1turn:
    invoke TakePlayerInput, offset playerchoice, offset playerarr           ;player's turn in player vs computer
    jmp gamelogic

playerplay:
    invoke TakePlayerInput, offset playerchoice, offset playerarr           ;players turn in player vs player


; implement player's move and check for win ;

gamelogic:                                                                  ;game functionality starts here
    invoke ImplementPlayerMove, OFFSET playerarr, curplayer, playerchoice       ;place player's choice in the game array
    invoke Displayanimation, playerchoice
    INVOKE displayGameBoard, OFFSET Gameboard, count, curplayer                 ;display game board
    INVOKE CheckWinRow, OFFSET playerarr                                        ;check matches in rows
    INVOKE CheckWinCol, OFFSET playerarr                                        ;check matches in cols
    INVOKE CheckWinDiagonal, OFFSET playerarr                                   ;check diagonal matches

    ; change player turn
    mov al, curplayer
    cmp al, 1
    je player2
    mov curplayer, 1
    jmp gameloop
    player2:
    mov curplayer, 2

jmp gameloop

; if game draw, control jumps here and display draw message ;    
gameDraw::
    mov dl,0
    mov dh,24
    call gotoxy
    mov edx, offset drawmessage
    call writestring

; if game end control jums here ;    
gameover::

call readchar
call clrscr
jmp men
    
    exit

main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;
; function definitions ;
;;;;;;;;;;;;;;;;;;;;;;;;



; color menu choice for player 1 and player 2
displayColorp1 proc color:PTR BYTE, p1col:PTR BYTE, p2col:PTR BYTE

    jmp againchose

againchoseinv:
	mov dl,0
	mov dh,15
	call gotoxy
	mov edx, offset invalid
	call writestring

againchose:
    mov dl,0
	mov dh,0
	call gotoxy
	mov edx, color
	mov ecx, 125 * 12   
	 lp1:
	   mov eax, White + (16 * Black)
	   call SetTextColor
	   mov al, byte ptr [edx]
	   call WriteChar
	   inc edx
	 loop lp1
    mov dl,0
	mov dh,13
	call gotoxy
    mov edx, offset p1colormsg
    call writestring
	call crlf
    mov eax,0
	call readint
    cmp al,1
	jl againchoseinv
	cmp al,4
	jg againchoseinv
    mov ebx, p2col
    cmp eax, [ebx]
	je againchose
    mov ebx, p1col
	mov [ebx], eax
	call clrscr
ret
displayColorp1 endp

displayColorp2 proc color:PTR BYTE, p1col:PTR BYTE, p2col:PTR BYTE
        
    jmp choose

againchose:
    mov dl,0
	mov dh,15
	call gotoxy
    mov edx, offset invalidcolor
	call writestring
    jmp choose 

againchoseinv:
	mov dl,0
	mov dh,15
	call gotoxy
	mov edx, offset invalid
	call writestring

choose:
    mov dl,0
	mov dh,0
	call gotoxy
	mov edx, color
	mov ecx, 125 * 12   
	 lp1:
	   mov eax, White + (16 * Black)
	   call SetTextColor
	   mov al, byte ptr [edx]
	   call WriteChar
	   inc edx
	 loop lp1

    mov dl,0
	mov dh,13
	call gotoxy
    mov edx, offset p2colormsg
    call writestring
	call crlf
    mov eax,0
	call readint
    cmp al,1
	jl againchoseinv
	cmp al,4
	jg againchoseinv
    mov ebx, p1col
    cmp eax, [ebx]
	je againchose
    mov ebx, p2col
	mov [ebx], eax
	call clrscr

ret
displayColorp2 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; display menu on the screen and get the choice ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DisplayMenu PROC menuu:PTR BYTE, menuch:PTR BYTE

jmp chose
againchose:
    mov dl,0
	mov dh,17
	call gotoxy
    mov edx, offset invalid
    call writestring

chose:
    mov dl,0
	mov dh,0
	call gotoxy
	mov edx, menuu
    mov ecx, 125 * 16   
	 lp1:
	   mov eax, White + (16 * Black)
	   call SetTextColor
	   mov al, byte ptr [edx]
	   call WriteChar
	   inc edx
	 loop lp1

	call crlf
	mov dl,0
	mov dh, 16
	call gotoxy
    mov edx, offset input
	call WriteString
    call readint
    cmp al,1
	jl againchose
	cmp al,5
	jg againchose
	mov ebx, menuch
	mov [ebx], al
	call clrscr

ret
DisplayMenu ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; display rules on the screen and get the choice ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DisplayRules PROC ruless:PTR BYTE
	mov dl,0
	mov dh,0
	call gotoxy
	mov edx, ruless
    mov ecx, 125 * 25   
	 lp1:
	   mov eax, White + (16 * Black)
	   call SetTextColor
	   mov al, byte ptr [edx]
	   call WriteChar
	   inc edx
	 loop lp1

	call crlf
    call readchar
	call clrscr

ret
DisplayRules ENDP




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; display animation on the screen ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Displayanimation proc position:byte
    mov eax, 45 ;x
    mov edx,0
    mov dl, position
    dec edx
    mov ebx, 6
    imul ebx, edx
    add eax, ebx

    mov dh,0
    mov dl, al
animationloop:
    call gotoxy
    mov ecx,5
    lp2:
	   mov eax, White + (16 * White)
	   call SetTextColor
	   mov al, ' '
	   call WriteChar
	 loop lp2

    mov eax,100
    call Delay
    call gotoxy
    mov ecx,5
    lp3:
	   mov eax, White + (16 * Black)
	   call SetTextColor
	   mov al, ' '
	   call WriteChar
	loop lp3

    inc dh
    cmp dh, 9
    jne animationloop
ret
Displayanimation endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; display game board on the screen ;
; this procedure displays the game board on the screen
displayGameBoard PROC board:PTR BYTE, coun:DWORD, player:BYTE
    mov dl,0
    mov dh,0
    call gotoxy
    mov ecx, 125 * 25                   ; Set the loop counter to the size of the game board
    mov esi, board
    mov ebx, 0 
    dec ebx
    mov coun, 0         
 ; Loop to display each cell of the game board with colors in players positions ;
displayLoop:
    movzx eax, byte ptr [esi]  ; Load a single byte into eax
    cmp al,'o'
    jne draw
    mov al, ' '
    draw:
    call WriteChar
    inc esi
    cmp al, '|'
    jne cont
    movzx eax, byte ptr [esi]
    cmp al, 'o'
    je cont
    inc ebx
    movzx eax, playerarr[ebx]
    cmp al,0
    je cont
    dec edx
    mov coun, ecx
    mov ecx,5
    colorloop:
    jmp setPlayerColor
    back:
    mov al,' '
    call WriteChar
    mov eax, White + (16 * Black)
	call SetTextColor
    dec coun
    inc esi
	loop colorloop
    mov ecx,coun
    cont:
  
    loop displayLoop
    jmp en


setPlayerColor:
    cmp playerarr[ebx], 1
    jne player2
    mov eax, 16 
    imul eax,p1color ; Set the background color
    add eax, p1color
    call settextcolor
    jmp back

player2:
	mov eax, 16 
    imul eax,p2color ; Set the background color
    add eax, p2color
    call settextcolor
    jmp back

en:
ret
displayGameBoard ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this procedure reads an integer from the player 
TakePlayerInput PROC, choice:PTR BYTE, playerr:PTR BYTE
	mov esi, choice
retake:	
	mov dl, 0
	mov dh, 24
    call gotoxy
    mov edx, OFFSET input
	call WriteString
    mov edx, 0
	mov ecx, 0
	mov eax, 0
	mov ebx,0

	call Readint
    ; check if the input is valid
    cmp al, 1
    jl iinvalid
    cmp al, 4
    jg iinvalid
    mov ebx, playerr
    add ebx, eax
    dec ebx
    cmp byte ptr[ebx], 0
    jne iinvalid
    mov [esi], al
    
    jmp en

    iinvalid:
    mov dl, 0
	mov dh, 23
	call gotoxy
	mov edx, OFFSET invalid
	call WriteString
    jmp retake
    en:


	ret
TakePlayerInput ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this procedure reads an integer from the computer(randomly) ;)
TakeComputerInput PROC, choice:ptr BYTE, playerr:ptr BYTE

    mov  eax,1000 ;delay 1 sec
    call Delay


mov esi, choice
retake:	
       mov  eax,3     ;get random 0 to 3
       call randomize
       call RandomRange ;
       inc  eax         ;make range 1 to 4
       ; check if the input is valid
        cmp al, 1
        jl iinvalid
        cmp al, 4
        jg iinvalid
        mov ebx, playerr
        add ebx, eax
        dec ebx
        cmp byte ptr[ebx], 0
        jne iinvalid
        mov [esi], al
        jmp en

iinvalid:
    jmp retake
en:

ret
TakeComputerInput ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this procedure places a number in the player array at the available column;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ImplementPlayerMove PROC playerarray:PTR BYTE, player:BYTE, choice:BYTE
    ; Procedure to place a dot in the specified column
    mov eax, 0
    mov al, choice
    ;mov to the last row
    mov edx,4
    imul edx, 3 
    ; add column number to the last row
    add edx,eax
    ; 0 based index set
    sub edx,1

    
    
findEmptyRow:
    mov ebx, 0
    mov esi, playerarray
    add esi, edx
    mov ebx, [esi]          ; Load the value at the current cell
    cmp bl, 0               ; Check if the cell is empty
    jne nextRow             ; If not empty, move to the next row
    ; Place the player's number in the empty cell
    cmp player, 1
	jne player2
    mov ebx, 1 
    jmp co
player2:
	mov ebx, 2
co:
    mov  [esi], bl   ; Store player's number in the game array
    ret

nextRow:
    ;dec ecx                 
    sub edx, 4              ; Move to the previous row
    jge findEmptyRow


ret
ImplementPlayerMove ENDP





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this procedure checks if the player has won the game by connecting 3 dots in a row;
CheckWinRow PROC playerArry:PTR BYTE

    mov ebx, 1
rows:
    mov ecx, 4
    mov esi, playerArry
    mov eax, 0
    mov edx, 0
; loop through the player array to check for 3 consecutive dots in a row
    loop1:
        mov edx, ecx
        mov ecx,4
        mov al, 0

            loop2:
                mov ah, byte ptr [esi]
                cmp ah, bl
                jne setnull
                inc al
                cmp al, 3
                je win
                jmp next
               setnull:
                mov al,0
               next:
                add esi,1
            
            loop loop2
        mov ecx, edx
    loop loop1
    cmp bl, 1
    jne en
    mov bl, 2
    jmp rows

; if player has won, display the win message and exit gameloop
win:
    cmp bl, 1
	je p1win
    mov dl, 0
	mov dh, 24
	call gotoxy
	mov edx, OFFSET winMessagep2
	call WriteString
    jmp gameover
p1win:
	mov dl, 0
	mov dh, 24
	call gotoxy
	mov edx, OFFSET winMessagep1
	call WriteString
	jmp gameover
en:
ret
CheckWinRow ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
; this procedure checks if the player has won the game by connecting 3 dots in a column;

CheckWinCol PROC playerArry:PTR BYTE
    mov ebx, 1
cols:
    mov ecx, 4
    mov esi, playerArry
    mov eax, 0
    mov edx, 0
; loop through the player array to check for 3 consecutive dots in a column
    loop1:
        mov edx, ecx
        mov ecx,4
        mov al, 0
        mov esi, playerArry
        add esi, edx
        dec esi

        loop2:
                mov ah, byte ptr [esi]
                cmp ah, bl
                jne setnull
                inc al
                cmp al, 3
                je win
                jmp next
              setnull:
                mov al,0
              next:
                add esi,4
        loop loop2
        mov ecx, edx
     loop loop1
        cmp bl, 1
        jne en
        mov bl, 2
        jmp cols


; if player has won, display the win message and exit gameloop
win:
    cmp bl, 1
	je p1win
    mov dl, 0
	mov dh, 24
	call gotoxy
	mov edx, OFFSET winMessagep2
	call WriteString
    jmp gameover
p1win:
	mov dl, 0
	mov dh, 24
	call gotoxy
	mov edx, OFFSET winMessagep1
	call WriteString
	jmp gameover

en:
ret
CheckWinCol ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
; this procedure checks if the player has won the game by connecting 3 dots in a diagonal;

CheckWinDiagonal PROC playerArry:PTR BYTE
; there will be 3 diagonals to check(from both directions(total 6 checking loops)), main diagonal, upper diagonal and lower diagonal

; main diagonals
mov ebx, 1
players:
; left to right main diagonal
mov esi, playerArry
mov eax, 0
mov ecx,4
mov al, 0
mov esi, playerArry
    loop1:
            mov ah, byte ptr [esi]
            cmp ah, bl
            jne setnull
            inc al
            cmp al, 3
            je win
            jmp next
           setnull:
            mov al, 0
           next:
            add esi,5
    loop loop1
; right to left main diagonal
mov esi, playerArry
mov eax, 0
mov ecx,4
mov al, 0
mov esi, playerArry
add esi, 3
    loop2:
            mov ah, byte ptr [esi]
            cmp ah, bl
            jne setnull1
            inc al
            cmp al, 3
            je win
            jmp nextt
           setnull1:
            mov al, 0
           nextt:
            add esi,3
    loop loop2


; upper diagonals
; left to right upper diagonal
mov esi, playerArry
inc esi
mov eax, 0
mov ecx,3
mov al, 0
    loop3:
        mov ah, byte ptr [esi]
        cmp ah, bl
        jne next1
        inc al
        cmp al, 3
        je win
        add esi,5
    loop loop3
next1:

; right to left upper diagonal
mov esi, playerArry
add esi,2
mov eax, 0
mov ecx,3
mov al, 0
    loop4:
        mov ah, byte ptr [esi]
        cmp ah, bl
        jne next2
        inc al
        cmp al, 3
        je win
        add esi,3
    loop loop4
next2:

; lower diagonals
; left to right lower diagonal
mov esi, playerArry
add esi,4
mov eax, 0
mov ecx,3
mov al, 0
    loop5:
	    mov ah, byte ptr [esi]
	    cmp ah, bl
	    jne next3
	    inc al
	    cmp al, 3
	    je win
	    add esi,5
    loop loop5
next3:

; right to left lower diagonal
mov esi, playerArry
add esi,7
mov eax, 0
mov ecx,3
mov al, 0
    loop6:
	    mov ah, byte ptr [esi]
	    cmp ah, bl
	    jne next4
	    inc al
	    cmp al, 3
	    je win
	    add esi,3
    loop loop6
next4:

; check for player 2
cmp bl, 1
jne en
mov bl, 2
jmp players



; if player has won, display the win message and exit gameloop
win:
    cmp bl, 1
	je p1win
    mov dl, 0
	mov dh, 24
	call gotoxy
	mov edx, OFFSET winMessagep2
	call WriteString
    jmp gameover
p1win:
	mov dl, 0
	mov dh, 24
	call gotoxy
	mov edx, OFFSET winMessagep1
	call WriteString
	jmp gameover

en:

; as this function is called last, well check draw logic here ;
; if all cells are filled and no player has won, then its a draw ;
    mov esi, playerArry
    mov eax,0
    mov ecx, 16
drawloop:
    mov al,byte ptr[esi]
    cmp al,0
    je outt
    inc esi
loop drawloop

    jmp gameDraw



outt:
	ret
CheckWinDiagonal ENDP



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    end of the prograM :)	;;

END main