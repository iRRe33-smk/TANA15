%HouseholderQR: Compute the R in the factorization A=QR
% using Householder reflections. 
%
function [A]=HouseholderQR(A);
  
 [m,n]=size(A);
 
 %disp((A))
 
 for k=1:min(m,n);
   
    A(k:m,k:n)= ApplyReflection( A(k:m,k:n));
     
   %
   % We now want to apply a reflection to the part 
   % of the matrix given by A(k:m,k:n).
   %
    
 end;
