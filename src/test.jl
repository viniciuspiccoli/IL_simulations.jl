using IL_simulations, PDBTools


top_dir   = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/ITP"
pdb_dir   = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/PDB"
input_dir = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ubiquitin_files"


atoms   = readPDB("$input_dir/ubq.pdb")
MMP     = mass(atoms)
MM1     =  201.06
MMP     =  8560.
cation1 = "BMIM"
anion1  = "NO3"
c       =  2.50

data = IL_simulations.Data_il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation1, anion = anion1,MM = MM1,c=c)
nions, nwater, sides = prot_elec(data)
IL_simulations.top(dict, top_dir, input_dir, data, nions, nwater)
pack_input(data,pdb_dir,nions,nwater,sides)





