#=
Name:Hector FC 
Simplex Method
=#


using LinearAlgebra, Printf          # 

"""
A     :: Matrix (m,n)  dimensional 
b     :: Matrix m dimensional
c     :: Matrix n dimensional
B_idx :: Array m dimensional
"""
function simplexSimple(A,b,c,B_idx)  #  
  iter = 0  
  m,n = size(A)  
 
  #while true 
  iter+=0
  z_val = 0
  while true  
    x_sol = zeros(n)
    d_fac = zeros(n)
    c_bar = zeros(n)
    B = A[:, B_idx]
    x_sol[B_idx] = inv(B) * b 
    z_val = dot(x_sol[B_idx],c[B_idx])               
    N_idx = setdiff(1:n,B_idx)  
    c_bar[N_idx] = c[N_idx]' - ((c[B_idx]')* inv(B))*A[:,N_idx]
    s_idx = argmin(c_bar) 
    if c_bar[s_idx]>= 0  
      @printf("\n Solução encontrada 😃\n")    
      for i in 1:n
        @printf("x[%i] = %4.2f\n",i,x_sol[i])
      end     
      @printf("obj= %4.2f",z_val)
      break
    end    
    d_fac[B_idx] = - inv(B)*A[:,s_idx]   
    r_ini = argmin(d_fac)
    if d_fac[r_ini]>=0 
      @printf("\n O problema é ilimitado 😱\n")    
      break 
    end  
    r_idx=findfirst(d_fac.<0)
    α = -x_sol[r_ini]/d_fac[r_idx]     
    
    for i in B_idx    
      if d_fac[i]< 0
        if α >= -x_sol[i]/d_fac[i]  
          α = -x_sol[i]/d_fac[i]
          r_idx = i 
        end   
      end         
    end 
    B_idx = union(setdiff(B_idx,Set([r_idx])),Set([s_idx]))
    iter+=1
    @printf("i=%4i  obj=%4.2f\n",iter,z_val)
  end   
  return @printf("\n Fim 😎\n")   
end
	
A = [7 3 4 1 1 0 0 ;
     2 1 1 5 0 1 0;
     1 4 5 2 0 0 1]

c = [-3.0;-2.0;-1.0;-5.0; 0.0; 0.0;0.0] 
b = [7.0;3.0;8.0]
B_idx = [5, 6, 7]

simplexSimple(A,b,c,B_idx)




