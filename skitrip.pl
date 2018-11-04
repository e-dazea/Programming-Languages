read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    ( Line = [] -> List = []
    ; atom_codes(A, Line),
      atomic_list_concat(As, ' ', A),
      maplist(atom_number, As, List)
    ).
	
	
read_input(File, Plith, Lista) :-
    open(File, read, Stream),
	read_line(Stream, Plith),
    read_line(Stream, Lista).
	
skitrip(File, Answer)	:-
	read_input(File, [M], [H|T]),
	rev([H|T], [H1|T1], []),
	K is M - 1,
	createl([(H, 1)], K, M, T, Listal),
	creater([(H1, M)], K, T1, Listar),
	rev(Listar, Listar2, []),
	hitTheRoadJack(Listar2, Listal, 0, Answer).
	
	
	
% reverse function from stack overflow: https://stackoverflow.com/questions/19471778/reversing-a-list-in-prolog 
rev([],Z,Z).
rev([H|T],Z,Acc) :- rev(T,Z,[H|Acc]).

createl(Listal,0,_,_,Listal).
createl([(H1a,H2a)|T1],N,M,[H|T],Listal) :- 
	(H1a > H -> K is M - N + 1,
	L is N-1,
	append([(H,K)],[(H1a,H2a)|T1],A),
	createl(A,L,M,T,Listal)
	; 1 > 0 -> 
	L is N-1,
	createl([(H1a,H2a)|T1],L,M,T,Listal) 
	).
	
creater(Listar, 0, _, Listar).
creater([(H1a, H2a)|T1], N, [H|T], Listar) :- 
	(H1a < H -> L is N - 1,
	append([(H, N)], [(H1a, H2a)|T1], A),
	creater(A, L, T, Listar)
	; 1 > 0  -> 
	L is N - 1,
	creater([(H1a, H2a)|T1], L, T, Listar) 
	).
	
hitTheRoadJack([],_,A,Dis) :- Dis is A.
hitTheRoadJack(_,[],A,Dis) :- Dis is A.
hitTheRoadJack([(Hr,Jr)|Tr],[(Hl,Jl)|Tl],A,Dis) :-
	( Hl < Hr -> X is Jr - Jl,
		(X > A -> hitTheRoadJack([(Hr,Jr)|Tr],Tl,X,Dis)
		; 1 > 0 -> hitTheRoadJack([(Hr,Jr)|Tr],Tl,A,Dis)
		)
	; 1 > 0 -> hitTheRoadJack(Tr,[(Hl,Jl)|Tl],A,Dis)
	).
	
	

	
	
	