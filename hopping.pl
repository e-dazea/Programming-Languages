% reads input from read_hopping_SUI.pl

read_input(File, N, K, B, Steps, Broken) :-
    open(File, read, Stream),
    read_line(Stream, [N, K, B]),
    read_line(Stream, Steps),
    read_line(Stream, Broken).
	
read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    ( Line = [] -> List = []
    ; atom_codes(A, Line),
      atomic_list_concat(As, ' ', A),
      maplist(atom_number, As, List)
    ).
	
% create association list 

fin(N, Lista) :-
	makes(N, [], Acc),
	assoc: ord_list_to_assoc(Acc, Lista).
	
makes(1, List, Acc) :- append([1-1], List, Acc).
makes(N, List, Acc) :- A is N-1,
	append([N-0], List, L),
	makes(A, L, Acc ), !.

modif([], Assoc, Assoc).
modif([B|[]], Assoc, Acc) :- assoc:put_assoc(B, Assoc, -1, Acc).
modif([B|Brok] , Assoc, Acc) :- assoc:put_assoc(B, Assoc, -1, Assoc2),
	modif(Brok, Assoc2, Acc), !.
	
change(Ar1, Ar2) :- (Ar1 > 1000000008 -> Ar2 is Ar1 - 1000000009
					; true -> Ar2 is Ar1
					).

for_each_step([], Assoc, _, _, _, Assoc).
for_each_step([S], Assoc, Pou, Proig, N, Acc) :- Tel is S + Pou,
	(Tel > N -> for_each_step([], Assoc, Pou, Proig, N, Acc)
	; true -> assoc:get_assoc(Tel, Assoc, Prev),
		(Prev == -1 -> for_each_step([], Assoc, Pou, Proig, N, Acc) 
		; true -> W is Proig + Prev,
		change(W, Next),
		assoc:put_assoc(Tel, Assoc, Next, Assoc2),
		for_each_step([], Assoc2, Pou, Proig, N, Acc)
		)
	), !.
for_each_step([S|Step], Assoc, Pou, Proig, N, Acc) :- Tel is S + Pou,
	(Tel > N -> for_each_step(Step, Assoc, Pou, Proig, N, Acc) 
	; true -> assoc:get_assoc(Tel, Assoc, Prev),
		(Prev == -1 -> for_each_step(Step, Assoc, Pou, Proig, N, Acc)
		; true -> W is Proig + Prev,
		change(W, Next),
		assoc:put_assoc(Tel, Assoc, Next, Assoc2),
		for_each_step(Step, Assoc2, Pou, Proig, N, Acc)
		)
	), !.
		
rec_fun(N, N, Assoc, _, Assoc).
rec_fun(N, Pou, Assoc, Steps, Acc) :- 	assoc:get_assoc(Pou, Assoc, Timi),
	Epomeno is Pou + 1,
	(Timi == -1 -> rec_fun(N, Epomeno, Assoc, Steps, Acc)
	; true -> for_each_step(Steps, Assoc, Pou, Timi, N, Assoc2),
	rec_fun(N, Epomeno, Assoc2, Steps, Acc)
	), !.
	
	
hopping(File, Answer) :- read_input(File, N, K, B, Steps, Broken),
	fin(N, Lista),
    modif(Broken, Lista, Lista2),
	assoc:get_assoc(1, Lista2, Arxi),
	assoc:get_assoc(N, Lista2, Telos),
	( ((Arxi == -1) ; (Telos == -1)) -> Answer is 0
	; true -> rec_fun(N, 1, Lista2, Steps, Res),
    assoc:get_assoc(N, Res, Answer)
	). 


	

	


	

