###############################################################################
#Calculation of the number of the ions given a concentration and the MM of the# 
###############################################################################

#
# Ainda preciso checar como fazer para o caso em que carga é diferente de zero
#



# checar diferente métodos para calcular a concentração


export number_of_ions

# One IL + Protein + Water
function number_of_ions(data; cube=false, charge=false)

  protein = data.protein
  MMP = data.MMP 

  cation1 = data.cation 
  anion1  = data.anion

  MM1  = data.MM
  c    = data.c

  vprot = (MMP / 6.02e23) * 1e-3 
  if cube==false
    lx,ly,lz = measure_prot(protein,30)  
  elseif cube==true
    lx = 90
    ly = 90 
    lz = 90
  end    

  sides = [lx, ly, lz]

  vtotal = lx*ly*lz*1.e-27                                      # volume in L
  vsol = - vprot + vtotal                                         # solution volume = volume of the box  - volume of the protein / L   
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = nions * MM1 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  if charge==false 
    return nions, nwater, sides
  else 
    return nions, nwater, charge, sides
  end

end



# One IL + Water
function number_of_ions(data)

  cation1 = data.cation 
  anion1  = data.anion

  MM1  = data.MM
  c    = data.c

  lx = 50
  ly = 50 
  lz = 50

  sides = [lx, ly, lz]

  vsol   = lx*ly*lz*1.e-27                                        # Volume (total=solution) / L  
  nions  = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions  = nions * MM1 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  return nions, nwater, sides

end



# two IL + Protein + Water
function number_of_ions(data; cube=false, charge=false)

  protein = data.protein
  MMP = data.MMP 

  cation1 = data.cation 
  anion1  = data.anion1
  anion2  = data.anion2 

  MM1  = data.MM1
  MM2  = data.MM2
  c    = data.c

  vprot = (MMP / 6.02e23) * 1e-3 
  if cube==false
    lx,ly,lz = measure_prot(protein,30)  
  elseif cube==true
    lx = 90
    ly = 90 
    lz = 90
  end    

  sides = [lx, ly, lz]

  vtotal = lx*ly*lz*1.e-27                                      # volume in L
  vsol = - vprot + vtotal                                         # solution volume = volume of the box  - volume of the protein / L   
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = nions * MM1 * 1.e-3 / (6.02e23) + nions * MM2 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  ncat = nions
  nan = round(Int,(nions/2)) # same number of molecules for each anion = ncation/2


  if charge==false 
    return ncat, nan, nwater, sides
  else 
    return ncat, nan, charge, nwater, sides
  end

end


# two IL +  Water
function number_of_ions(data; cube=false, charge=false)
  cation1 = data.cation 
  anion1  = data.anion1
  anion2  = data.anion2 

  MM1  = data.MM1
  MM2  = data.MM2
  c    = data.c

  lx = 50
  ly = 50 
  lz = 50

  sides = [lx, ly, lz]

  vsol = lx*ly*lz*1.e-27                                      # volume in L
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = nions * MM1 * 1.e-3 / (6.02e23) + nions * MM2 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  ncat = nions
  nan = round(Int,(nions/2)) # same number of molecules for each anion = ncation/2

  return ncat, nan, nwater, sides

end


