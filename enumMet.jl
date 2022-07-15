#=
Programação Linear 
Instalar:  
#import Pkg 
#Pkg.add("LinearAlgebra")
#Pkg.add("Combinatorics")
#Pkg.add("Printf")
=#

using LinearAlgebra, Combinatorics, Printf

function eh_naoNegativo(x::Vector)
  return length( x[ x .< 0] ) == 0
end

function baseEnum(A,b,c) 
  iter = 0 
  m,n = size(A)
  comb = collect(combinations(1:n, m))
  for i in length(comb):-1:1
    B_idx = comb[i]    
    B = A[:, B_idx]
    c_B = c[B_idx] 
    x_B = inv(B) * b 
    z_B = dot(x_B,c_B)               
    iter+=1
    #println(B_idx,x_B,z_B)    
    @printf("\nBase")
    if eh_naoNegativo(x_B) 
      @printf("%4i).- ",iter)     
      map(x->@printf("%4i",x), B_idx)      
      @printf("\nSolução Basica Possivel 😃\n")
      map(x->@printf("%4.2f ",x),x_B)
      @printf("\nObj = %4.2f \n",z_B)
    else
      @printf("%4i ).-",iter)
      map(x->@printf("%4i ",x), B_idx)
      @printf("\nSolução Basica não  possivel 😈\n")
      map(x->@printf("%4.2f ",x),x_B)
      @printf("\n")            
    end     
  end  
  return @printf("\n FIM 😎 ")   
end


#=============================================# 

A = [7.0 3.0 4.0 1 1 0 0 ;
     2 1 1 5 0 1 0;
     1 4 5 2 0 0 1]

c = [-3.0;-2.0;-1.0;-5.0; 0.0; 0.0;0.0] 

b = [7.0;3.0;8.0]

baseEnum(A,b,c)

#=============================================# 


