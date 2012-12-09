:- consult(izzi2).

shape4Corners(Connections):-
	createPieces(Pieces),
	Connections=[C1,C2,C3,C4],

	C1=[P1,P2,C1I1,C1I2,O1,O2],
	C2=[P1,P3,C2I1,C2I2,O1,O3],
	C3=[P2,P4,C3I1,C3I2,O2,O4],
	C4=[P3,P4,C4I1,C4I2,O3,O4],
	connectionCorner(C1),
	connectionSlashLeft(C2),
	connectionSlashRight(C3),
	connectionCorner(C4),

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

shape10(Connections):-
	createPieces(Pieces),
	Connections=[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12],

	C1=[P1,P2,C1I1,C1I2,O1,O2],
	C2=[P4,P3,C2I1,C2I2,O4,O3],
	C3=[P6,P5,C3I1,C3I2,O6,O5],
	C4=[P2,P3,C4I1,C4I2,O2,O3],
	C5=[P5,P2,C5I1,C5I2,O5,O2],
	C6=[P3,P8,C6I1,C6I2,O3,O8],
	C7=[P5,P10,C7I1,C7I2,O5,O10],
	C8=[P8,P7,C8I1,C8I2,O8,O7],
	C9=[P8,P9,C9I1,C9I2,O8,O9],
	C10=[P9,P11,C10I1,C10I2,O9,O11],
	C11=[P9,P10,C11I1,C11I2,O9,O10],
	C12=[P10,P12,C12I1,C12I2,O10,O12],
	
	connectionSlashRight(C1),
	connectionSlashRight(C2),
	connectionSlashRight(C3),
	connectionSlashRight(C10),
	connectionSlashRight(C8),
	connectionSlashRight(C12),
	connectionCorner(C11),
	connectionCorner(C4),
	connectionCorner(C5),
	connectionCorner(C6),
	connectionCorner(C7),	
	connectionCorner(C9),
	
	
	

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

