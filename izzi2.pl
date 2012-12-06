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
		Index=1,
		Color=C1;

		Index=2,
		Color=C2;

		Index=3,
		Color=C3;

		Index=4,
		Color=C4

	).

% Create Pieces List
createPieces(Pieces):-
	p1(P1),p2(P2),p3(P3),p4(P4),p5(P5),p6(P6),p7(P7),p8(P8),p9(P9),p10(P10),p11(P11),p12(P12),
	Pieces=[P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12].

% Get Piece from piece list
getPiece(Pieces,Index,Piece):-
	Pieces=[H|_],
	Index=1,
	Piece=H.

getPiece(Pieces,Index,Piece):-
	Index>1,
	NewIndex is Index-1,
	Pieces=[_|T],
	getPiece(T,NewIndex,Piece).

% Connection
connect(Pieces,Connection):-
	Connection=[Piece1Index,Piece2Index,P1ColorIndex,P2ColorIndex],
	getPiece(Pieces,Piece1Index,Piece1),
	getPiece(Pieces,Piece2Index,Piece2),
	getColor(Piece1,P1ColorIndex,Piece1IndexColor),
	getColor(Piece2,P2ColorIndex,Piece2IndexColor),
	Piece1IndexColor=Piece2IndexColor.

% Extract element from a list
unique([]).
unique(Connections):-
	Connections=[Connection|T],
	delete(Connections, H, WithoutList),
	connectionUnique(Connection,WithoutList),
	unique(T).

% Check if with existing connections can create a connection
connectionUnique(Connection,Connections):-
	Connection=[P1,P2,I1,I2],
	\+member([_,P2,_,I2],Connections),
	\+member([P2,_,I2,_],Connections),
	\+member([P1,P2,_,_],Connections),
	\+member([P2,P1,_,_],Connections),
	\+member([_,P1,_,I1],Connections),
	\+member([P1,_,I1,_],Connections).


solve(Connections,2):-
	Connections=[[1,2,I1,I2]],
	Indexes=[I1,I2],
	domain(Indexes,1,4),
	labeling([],Indexes).


solve(Connections,NPiece):-
	createPieces(Puzzle),
	NPiece>2,
	Connection=[NPiece,Piece,I1,I2],
	Pieces=[Piece],
	Indexes=[I1,I2],

	domain(Indexes,1,4),
	NPrev is NPiece -1,
	domain(Pieces,1,NPrev),
	labeling([],Indexes),
	labeling([],Pieces),

	% Indutive
	solve(ConnectionsP,NPrev),
	connect(Puzzle,Connection),
	connectionUnique(Connection,ConnectionsP),
	append([Connection],ConnectionsP,Connections).

