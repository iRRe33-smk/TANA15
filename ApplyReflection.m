%ApplyReflection: Compute the product H*A where H is the 
% Householder reflection matrix that creates zeros elememts
% below the diagonal in the first column. 
%
function [HA]=ApplyReflection(A);
  
% Select the vector x to used for constructing the reflection
    m=max(size(A));
    k = 1;

    x=A(k:m,k); 


    %
    % Find the vector v so that H(v)*x=alpha*e1. 
    %

    v=x;
    v(1) = v(1) + sign(x(1))*norm(x);


    H =eye(m);
    H(k:m,k:m) = eye(length(v)) - 2 * v*v' / (v'*v);


    A= H*A;

   HA = A; 
 
 
 
 
 % Compute the product  H*A. Treat one column at a time, i.e. 
 % (HA)(:,k)=H*A(:,k).
 %
 %  HA=zeros(size(A));
   
   %y = HA
   
   
  %[m,M] * [m,n] = [m,n]
   
