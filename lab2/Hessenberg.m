%Hessenberg: Transform a square matrix B into Hessenberg form using
% Householder reflections. 
%
% Usage:
%   >> H = Hessenberg(B);
%
function [B]=Hessenberg(B);
  B
  [N,M]=size(B);
  
  for k=1:N-2
      
      x = B(k+1:N,k);
      HB = ApplyReflection(B,x);
      
      B = ApplyReflection(HB',x)';
     
    % eig(Hessenberg(M)) == eig(M) for all tested matricies
    %however.
    %   Hessenberg(M) != hess(M) for some matricies. For ohers, they are equal
    
    %
    % Select a Householder reflection such that H*B(k+1:N,1)=alpha*e1. 
    % This Householder reflection needs to be applied from the left
    % and from the right to the appropriate part of the matrix B.
    %
    %
    % Note: Even though the ApplyReflection subroutine is written to
    % apply the reflection from the left its possible to use the same
    % subroutine to apply the reflection from the right. How?
    %
    
  end;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% LOCAL SUBROUTINES 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%ApplyReflection: Compute the product H*A where H is a 
% Householder reflection matrix such that H*x=norm(x)*e1.
%
function [HA]=ApplyReflection(A,x);
    %A
    %x
    m=max(size(A));
    
    
    
    
    k = m-length(x)+1;

    %x=A(k:m,k); 


    %
    % Find the vector v so that H(v)*x=alpha*e1. 
    %

    v=x;
    v(1) = v(1) + sign(x(1))*norm(x);


    H =eye(m);
    H(k:m,k:m) = eye(length(v)) - 2 * v*v' / (v'*v);

    %A
    A= H*A;

   HA = A; 
% 
% Find the vector v so that H(v)*x=alpha*e1. 
%
  
%(4x4) * (3x4) * (4x4)     
%(3*4)*(4x3)
%3x3
%
% Apply the reflection H to all the columns A(:,k) one at a time.
% A*H' = (H*A')'
    
    



%H*A*H'
%H*A*H' = H*(H*A')'
%x = A[:,1]


