#=
Programação Linear 
Instalar:  
import Pkg 
Pkg.add("LinearAlgebra")
Pkg.add("Combinatorics")
Pkg.add("Printf")
=#

using LinearAlgebra, Combinatorics, Printf


function eh_naoNegativo(x::Vector)      # definição da função     de não negatividade 
  return length( x[ x .< 0] ) == 0
end

# Ax = b, x>=0 

function baseEnum(A,b,c) 
  iter = 0  
  m,n = size(A)              
  comb = collect(combinations(1:n, m))

  for i in length(comb):-1:1    
    B_idx = comb[i]    
    B = A[:, B_idx]
    c_B = c[B_idx] 
    if det(B)!= 0
      x_B = inv(B) * b 
      z_B = dot(x_B,c_B)               
      iter+=1
        
      #println(B_idx,x_B,z_B)

      @printf("\nBase")
      if eh_naoNegativo(x_B) 
        @printf("%4i).- ",iter)     
        map(x->@printf("%4i",x), B_idx)      
        @printf("\nSolução Basica Possivel 😃\n")
        map(x->@printf("%4.2f ",x),x_B)              #  
        @printf("\nObj = %4.2f \n",z_B)
      else
        @printf("%4i ).-",iter)
        map(x->@printf("%4i ",x), B_idx)
        @printf("\nSolução Basica não  possivel 😈\n")
        map(x->@printf("%4.2f ",x),x_B)
        @printf("\n")            
      end     
    else
      println()
      println("Não é base")
      @printf("%4i).- ",iter) 
      println(B_idx)    
    end   
  end  
  return @printf("\n FIM 😎 ")   
end

#=============================================# 

A = [1  0   0   1/4  -8   -1    9 ;
     0  1   0   1/2  -12  -1/2  3 ;
     0  0   1    0    0    1    0]
c = [ 0; 0;  0;  -3/4; 20; -1/2; 6]
 
b = [0;0;1]


#A = [2 1 2; 3 3 1] 
#B_idx=  [4 ;3]
#c = [4;1;1] 

baseEnum(A,b,c)

#=============================================# 


