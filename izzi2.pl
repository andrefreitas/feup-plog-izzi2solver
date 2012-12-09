%   _ _____________ ___  
%  (_)___  /___  (_)__ \ 
%   _   / /   / / _   ) |
%  | | / /   / / | | / / 
%  | |/ /__ / /__| |/ /_ 
%  |_/_____/_____|_|____|
%

:- use_module(library(clpfd)).
:- use_module(library(lists)).
% Pieces database
% Example: for p1([y,r,g,b]): 
%   yr
%  yyrr
% yyyrrr
% gggbbb
%  ggbb
%   gb

p1([y,r,g,b]).
p2([y,r,b,g]).
p3([r,b,g,y]).
p4([r,b,y,g]).
p5([b,y,g,r]).
p6([b,y,r,g]).
p7([r,y,b,g]).
p8([r,y,g,b]).
p9([b,r,y,g]).
p10([b,r,g,y]).
p11([y,b,r,g]).
p12([y,b,g,r]).

% Get piece color
getColor(Piece,Index,Color):-
	Piece=[C1,C2,C3,C4],
	(
		Index#=1,
		Color#=C1;

		Index#=2,
		Color#=C2;

		Index#=3,
		Color#=C3;

		Index#=4,
		Color#=C4

	).

% Create Pieces List
createPieces(Pieces):-
	p1(P1),p2(P2),p3(P3),p4(P4),p5(P5),p6(P6),p7(P7),p8(P8),p9(P9),p10(P10),p11(P11),p12(P12),
	Pieces=[P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12].

% Get Piece from piece list
getPiece(Pieces,Index,Piece):-
	Pieces=[H|_],
	Index#=1,
	Piece=H.

getPiece(Pieces,Index,Piece):-
	Index#>1,
	NewIndex#= Index-1,
	Pieces=[_|T],
	getPiece(T,NewIndex,Piece).

% Connection
connect(Pieces,Connection):-
	Connection=[Piece1Index,Piece2Index,P1ColorIndex,P2ColorIndex,_,_],
	Piece1Index#\=Piece2Index,
	getPiece(Pieces,Piece1Index,Piece1),
	getPiece(Pieces,Piece2Index,Piece2),
	getColor(Piece1,P1ColorIndex,Piece1IndexColor),
	getColor(Piece2,P2ColorIndex,Piece2IndexColor),
	Piece1IndexColor#=Piece2IndexColor.

% Extract element from a list
unique([]).
unique(Connections):-
	Connections=[Connection|T],
	delete(Connections, _, WithoutList),
	connectionUnique(Connection,WithoutList),
	unique(T).

% Check if with existing connections can create a connection
connectionUnique(Connection,Connections):-
	Connection=[P1,P2,I1,I2,_,_],
	\+member([_,P2,_,I2,_,_],Connections),
	\+member([P2,_,I2,_,_,_],Connections),
	\+member([P1,P2,_,_,_,_],Connections),
	\+member([P2,P1,_,_,_,_],Connections),
	\+member([_,P1,_,I1,_,_],Connections),
	\+member([P1,_,I1,_,_,_],Connections).

%write vertical piece
printVPiece(P):-
	printPiece(P).
printPiece(P):-
	getColor(P,1,C1),
	getColor(P,2,C2),
	getColor(P,3,C3),
	getColor(P,4,C4),
	write('  '),write(C1),write(C2),nl,
	write(' '),write(C1),write(C1),write(C2),write(C2),nl,
	write(C1),write(C1),write(C1),write(C2),write(C2),write(C2),nl,
	write(C3),write(C3),write(C3),write(C4),write(C4),write(C4),nl,
	write(' '),write(C3),write(C3),write(C4),write(C4),nl,
	write('  '),write(C3),write(C4).

% Connection types
connectionSlashLeft(Connection):-
	Connection=[_,_,I1,I2,O1,O2],
	(
		(I1#=4, I2#=1, O1#=0,O2#=0);
		(I1#=4, I2#=4, O1#=0,O2#=1);
		(I1#=1, I2#=4, O1#=1,O2#=1);
		(I1#=1, I2#=1, O1#=1,O2#=0)
	).


connectionSlashRight(Connection):-
	Connection=[_,_,I1,I2,O1,O2],
	(
		(I1#=3, I2#=2, O1#=0,O2#=0);
		(I1#=3, I2#=3, O1#=0,O2#=1);
		(I1#=2, I2#=3, O1#=1,O2#=1);
		(I1#=2, I2#=2,  O1#=1,O2#=0)
	).

connectionCorner(Connection):-
	Connection=[_,_,I1,I2,O1,O2],
	(
		(I1#=2, I2#=1, O1#=0,O2#=0);
		(I1#=2, I2#=4, O1#=0,O2#=1);
		(I1#=3, I2#=1, O1#=1,O2#=1);
		(I1#=3, I2#=4, O1#=1,O2#=0)
	).

shapeSimpleSlash(Connections):-
	createPieces(Pieces),
	Connections=[C1,C2,C3,C4],

	C1=[P1,P2,C1I1,C1I2,O1,O2],
	C2=[P1,P3,C2I1,C2I2,O1,O3],
	C3=[P3,P4,C3I1,C3I2,O3,O4],
	C4=[P2,P4,C4I1,C4I2,O2,O4],

	connectionSlashRight(C1),
	connectionSlashLeft(C2),
	connectionSlashRight(C3),
	connectionSlashLeft(C4),

	connect(Pieces,C1),
	connect(Pieces,C2),
	connect(Pieces,C3),
	connect(Pieces,C4),

	domain([P1,P2,P3,P4],1,12),
	domain([C1I1,C1I2,C2I1,C2I2,C3I1,C3I2,C4I1,C4I2],1,4),
	domain([O1,O2,O3,O4],0,1),

	all_different([P1,P2,P3,P4]),
	unique(Connections),
	Sol=[P1,P2,P3,P4,C1I1,C1I2,C2I1,C2I2,C3I1,C3I2,C4I1,C4I2,O1,O2,O3,O4],
	labeling([],Sol).




shapeSimpleCorner(Connections):-
	createPieces(Pieces),
	Connections=[C1,C2],

	C1=[P1,P2,C1I1,C1I2,O1,O2],
	C2=[P2,P3,C2I1,C2I2,O2,O3],

	connectionCorner(C1),
	connectionSlashLeft(C2),



	connect(Pieces,C1),
	connect(Pieces,C2),

	domain([P1,P2,P3],1,12),
	domain([C1I1,C1I2,C2I1,C2I2],1,4),
	domain([O1,O2,O3],0,1),

	all_different([P1,P2,P3]),
	unique(Connections),
	Sol=[P1,P2,P3,C1I1,C1I2,C2I1,C2I2,O1,O2,O3],
	labeling([],Sol).

shape1(Connections):-
	createPieces(Pieces),
	Connections=[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12],

	C1=[P1,P3,C1I1,C1I2,O1,O3],
	C2=[P2,P3,C2I1,C2I2,O2,O3],
	C3=[P3,P4,C3I1,C3I2,O3,O4],
	C4=[P3,P5,C4I1,C4I2,O3,O5],
	C5=[P5,P7,C5I1,C5I2,O5,O7],
	C6=[P4,P6,C6I1,C6I2,O4,O6],
	C7=[P6,P8,C7I1,C7I2,O6,O8],
	C8=[P7,P9,C8I1,C8I2,O7,O9],
	C9=[P8,P10,C9I1,C9I2,O8,O10],
	C10=[P9,P10,C10I1,C10I2,O9,O10],
	C11=[P10,P11,C11I1,C11I2,O10,O11],
	C12=[P10,P12,C12I1,C12I2,O10,O12],

	connectionSlashLeft(C1),
	connectionSlashRight(C2),
	connectionSlashRight(C3),
	connectionSlashLeft(C4),
	connectionSlashLeft(C5),
	connectionSlashRight(C6),
	connectionSlashLeft(C7),
	connectionSlashRight(C8),
	connectionSlashLeft(C9),
	connectionSlashRight(C10),
	connectionSlashRight(C11),
	connectionSlashLeft(C12),

	connect(Pieces,C1),
	connect(Pieces,C2),
	connect(Pieces,C3),
	connect(Pieces,C4),
	connect(Pieces,C5),
	connect(Pieces,C6),
	connect(Pieces,C7),
	connect(Pieces,C8),
	connect(Pieces,C9),
	connect(Pieces,C10),
	connect(Pieces,C11),
	connect(Pieces,C12),

	domain([P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12],1,12),
	domain([C1I1,C1I2,C2I1,C2I2,C3I1,C3I2,C4I1,C4I2,C5I1,C5I2,C6I1,C6I2,C7I1,C7I2,C8I1,C8I2,C9I1,C9I2,C10I1,C10I2,C11I1,C11I2,C12I1,C12I2],1,4),
	domain([O1,O2,O3,O4,O5,O6,O7,O8,O9,O10,O11,O12],0,1),

	all_different([P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12]),
	unique(Connections),
	Sol=[P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,C1I1,C1I2,C2I1,C2I2,C3I1,C3I2,C4I1,C4I2,C5I1,C5I2,C6I1,C6I2,C7I1,C7I2,C8I1,C8I2,C9I1,C9I2,C10I1,C10I2,C11I1,C11I2,C12I1,C12I2,O1,O2,O3,O4,O5,O6,O7,O8,O9,O10,O11,O12],
	labeling([],Sol).
