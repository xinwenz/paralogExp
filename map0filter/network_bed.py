#!/bin/env/python3
import sys
import networkx as nx 
import re

def updt(x,y):
	if G.has_edge(x,y) == True:
		G[x][y]['size'] += 1 
	else:
		G.add_edge(x,y,size=1)


f=open(sys.argv[1],'r')
pre = f.readline().strip().split()
seq_start_pre = pre[1]
seq_pre = pre[3][11:]
gnode_pre = pre[23][1:-2]
#gnode_pre = re.search("g\d*", pre[20]).group(0)
#print(seq_pre,gnode_pre)

# build graph, and updating edge size 
G = nx.Graph()
for line in f:
	info = line.strip().split()
	seq_start_nex = info[1]
	seq_nex = info[3][11:]
	gnode_nex = info[23][1:-2]
	
	if seq_pre == seq_nex and seq_start_pre != seq_start_nex and gnode_pre != gnode_nex:
		updt(gnode_pre,gnode_nex)
	
	#print(seq_nex,gnode_nex)
	seq_start_pre = seq_start_nex
	gnode_pre = gnode_nex
	seq_pre = seq_nex 

f.close()

concom = nx.connected_components(G)
#for e in G.edges.data('size'):
#	if e[2] >= 1:
#		print(e)
#print(nx.cycle_basis(G))
for each in concom:
	print(each)
