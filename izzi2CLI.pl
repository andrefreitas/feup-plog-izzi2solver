

:- consult(izzi2puzzles).

%write vertical piece
printVPiece(P):-
	printPiece(P).
printPiece(P):-
	getColor(P,1,C1),
	getColor(P,2,C2),
	getColor(P,3,C3),
	getColor(P,4,C4),
	write('   '),write(C1),write(C2),nl,
	write('1 '),write(C1),write(C1),write(C2),write(C2),write(' 2'),nl,
	write(' '),write(C1),write(C1),write(C1),write(C2),write(C2),write(C2),nl,
	write(' '),write(C3),write(C3),write(C3),write(C4),write(C4),write(C4),nl,
	write('3 '),write(C3),write(C3),write(C4),write(C4),write(' 4'),nl,
	write('   '),write(C3),write(C4),nl.




izzi2 :-
	write('Escolha uma shape:'),nl,
	write('0 - LIST PEICES'),nl,
	write('1 - Shape 1'),nl,
	write('2 - Shape Simple Slash'),nl,
	write('3 - Shape Simple Corner'),nl,
	write('4 - shape 4 Corners'),nl,
	write('5 - shape 10 **WARNING: TAKES A LONG TIME!!**'),nl,
	read(Input),(
	Input = 1,(
		shape1(C),write(C)
		);
	Input = 2,(
		shapeSimpleSlash(C),write(C)
		);
	Input = 3,(
		shapeSimpleCorner(C),write(C)
		);
	Input = 4,(
		shape4Corners(C),write(C)
		);
	Input = 5,(
		shape10(C),write(C)
		);
	Input = 0,(
		write('---P1---'),nl,nl,
		p1(P1),printPiece(P1),nl,
		write('---P2---'),nl,nl,
		p2(P2),printPiece(P2),nl,
		write('---P3---'),nl,nl,
		p3(P3),printPiece(P3),nl,
		write('---P4---'),nl,nl,
		p4(P4),printPiece(P4),nl,
		write('---P5---'),nl,nl,
		p5(P5),printPiece(P5),nl,
		write('---P6---'),nl,nl,
		p6(P6),printPiece(P6),nl,
		write('---P7---'),nl,nl,
		p7(P7),printPiece(P7),nl,
		write('---P8---'),nl,nl,
		p8(P8),printPiece(P8),nl,
		write('---P9---'),nl,nl,
		p9(P9),printPiece(P9),nl,
		write('---P10---'),nl,nl,
		p10(P10),printPiece(P10),nl,
		write('---P11---'),nl,nl,
		p11(P11),printPiece(P11),nl,
		write('---P12---'),nl,nl,
		p12(P12),printPiece(P12),nl
		)
	).


	