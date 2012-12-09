def createCode(connections,shape,filename):
    fo = open(filename+".pl", "a")
    fo.write("shape"+str(shape)+"(Connections):-\n")
    fo.write("\tcreatePieces(Pieces),\n")
    
    # Write List of connections
    fo.write("\tConnections=[")
    for i in range(1,len(connections)+1):
        fo.write("C"+str(i))
        if(i!=(len(connections))):
            fo.write(",")

    fo.write("],\n\n")

    #Write connections
    for i in range(len(connections)):
        p1=connections[i][0]
        p2=connections[i][1]
        istr=str(i+1)
        fo.write("\tC"+istr+"=[P"+str(p1)+",P"+str(p2)+",C"+istr+"I1,C"+istr+"I2,O"+str(p1)+",O"+str(p2)+"],\n")

    # Write topology
    for i in range(len(connections)):
        top=connections[i][2]
        istr=str(i+1)
        if(top=="SR"):
            fo.write("\tconnectionSlashRight(C"+istr+"),\n")
        if(top=="SL"):
            fo.write("\tconnectionSlashLeft(C"+istr+"),\n")
        if(top=="CR"):
            fo.write("\tconnectionCorner(C"+istr+"),\n")

    #Write connnect
    fo.write("\n")
    for i in range(1,len(connections)+1):
        fo.write("\tconnect(Pieces,C"+str(i)+"),\n")
        
    #Write pieces
    fo.write("\n\tdomain([P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12],1,12),\n")
    #  Write Indexes
    fo.write("\tdomain([")
    for i in range(1,len(connections)+1):
        fo.write("C"+str(i)+"I1,C"+str(i)+"I2")
        if(i!=(len(connections))):
            fo.write(",")
    fo.write("],1,4),\n")

    fo.write("\tdomain([O1,O2,O3,O4,O5,O6,O7,O8,O9,O10,O11,O12],0,1),\n")
    fo.write("\n\tall_different([P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12]),\n")
    fo.write("\tunique(Connections),\n")
    # Write sol to labeling
    fo.write("\tSol=[P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,")
    for i in range(1,len(connections)+1):
        fo.write("C"+str(i)+"I1,C"+str(i)+"I2")
        if(i!=(len(connections))):
            fo.write(",")
    fo.write(",O1,O2,O3,O4,O5,O6,O7,O8,O9,O10,O11,O12],\n")
    
    fo.write("\tlabeling([],Sol).\n")
    fo.close()
    
