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
	Piece1IndexColor#=Piece2IndexColor.

% Solve puzzle
solvePuzzle(Connections):-
    createPieces(Pieces),
	member([1,A1,B1,C1],Connections),
	member([2,A2,B2,C2],Connections),
	member([3,A3,B3,C3],Connections),
	member([4,A4,B4,C4],Connections),
	member([5,A5,B5,C5],Connections),  
	member([6,A6,B6,C6],Connections),
	member([7,A7,B7,C7],Connections),
	member([8,A8,B8,C8],Connections),
	member([9,A9,B9,C9],Connections),
	member([10,A10,B10,C10],Connections),
	member([11,A11,B11,C11],Connections),
	member([12,A12,B12,C12],Connections),
	PiecesToFind=[A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12],
	ColorIndexes=[B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12],
	domain(ColorIndexes,1,4),
	domain(PiecesToFind, 1, 12), 
	A1#\=1,
	A2#\=2,
	A3#\=3,
	A4#\=4,
	A5#\=5,
	A6#\=6,
	A7#\=7,
	A8#\=8,
	A9#\=9,
	A10#\=10,
	A11#\=11,
	A12#\=12,
	labeling([],PiecesToFind),
	labeling([],ColorIndexes),
	unique(Connections),
	connect(Pieces,[1,A1,B1,C1]),
	connect(Pieces,[2,A2,B2,C2]),
	connect(Pieces,[3,A3,B3,C3]),
	connect(Pieces,[4,A4,B4,C4]),
	connect(Pieces,[5,A5,B5,C5]),
	connect(Pieces,[6,A6,B6,C6]),
	connect(Pieces,[7,A7,B7,C7]),
	connect(Pieces,[8,A8,B8,C8]),
	connect(Pieces,[9,A9,B9,C9]),
	connect(Pieces,[10,A10,B10,C10]),
	connect(Pieces,[11,A11,B11,C11]),
	connect(Pieces,[12,A12,B12,C12]).

% Extract element from a list
unique([]).
unique(Connections):-
	Connections=[H|T],
	delete(Connections, H, WithoutList),
	% Check that connection is unique in the remainder list
	H=[A,_,B,_],
	\+member([A,_,B,_],WithoutList),
	H=[_,A1,_,B1],
	\+member([A1,_,B1,_],WithoutList),
	unique(T).


