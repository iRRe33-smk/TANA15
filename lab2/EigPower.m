%EigPower: Compute the largest eigenvalue of a matrix A using the
% power method. Perform N iterations using x0 as a starting vector.
%
% Usage:
%
%   >>[x,rho]=EigPower(A,x0,N);
%
% where rho is the computed eigenvalue (Rayliegh quotient) and x is
% the approximate eigenvector. 
%
function [x,rho]=EigPower(A,x0,N); 
  
  % Normalize the starting vector

    q=x0/norm(x0);
  
 for k=1:N
 
   
   %
   % Perform one step of the power method. When doing
   % inverse iteration you need to use a matrix 
   % inv(A-s*I) instead of A. For the inverse iteration 
   % exercise you need to modify 
   % this part of the code. 
   %
   % Note that for inverse iteration we compute the eigenvalues
   % of inv(A-s*I) and not of A. So the computation of the
   % Rayleigh quitient needs to change accordingly.
   % 
   
    w=A*q;
    rho=q'*w;
    q=w/norm(w);
  
 end;
 

   
 % Return the eigenvector as x.
 x=q;
  
