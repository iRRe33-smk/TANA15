%HessEigQR: Compute all eigenvalues of a matrix using the QR algorithm
% and deflation. The matrix is first reduced to Hessenberg form and the 
% QR step is implemented using Givens rotations.
%
% Usage:
% >> D=HessEigQR(A);
%
% Note that this code only works if all the eigenvalues of the matrix are
% real. For a genrally safe code the QZ algorithm should be used but the
% changes needed are minor.
%
function [D]=HessEigQR(A);
  
%  
% Initial transformation to Hessenberg form.
%  
[A]=Hessenberg(A);
 
 
%
%  Create a diagonal matrix D that is used for storing the 
%  eigenvalues.
%
 D=zeros(size(A)); 

%
% Compute one eigenvalue at a time. Reduce the size of the matrix until
% we have all the eigenvalues.
%
while prod(size(A))>1
  
 [n,m]=size(A);
 
 done=0;nSteps=0; % nSteps is used as a progress counter. 
 while ~done
  % 
  % Perform one QR step. Note that shifts preserve the Hessenberg
  % form so we could for instance implement shifted QR the same way.
  %
  
   A=OneQRStep(A);
   
   nSteps=nSteps+1;
 
  %
  % We terminate the iterations when the elements on the last row 
  % are close to zero. That means A(n,n) is a good approximation of an
  % eigenvalue. 
  %
  
   tol=10^-15;
   done=(norm(A(n,1:n-1),1)<tol*abs(A(n,n)));
 
 end;
 
 %
 % Save the eigenvalue A(n,n) and do deflation.
 %
 
  D(n,n)=A(n,n);
  A=A(1:n-1,1:n-1);
  fprintf(1,'Eigenvalue %8.3f found. Number of QR steps is %i.\n',D(n,n),nSteps);
end;
D(1,1)=A; % A has now been reduced to a scalar.
 

 
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% LOCAL SUBROUTINES 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
%OneQRStep: Computes one QR step on a Hessenberg matrix A using
% Givens rotations.
%
function [A]=OneQRStep(A); 

 [n,m]=size(A);
 %
 % Save original elements that are used to determine the Givens rotations
 % from the left. 
 %
  SavedElements=A(1:2,1); 
 
 % 
 % Perform one QR step using Givens rotations from the left and
 % right respectively.
 %
  for k=1:n-1  
   % 
   % Find Givens rotation between the rows k and k+1 that zero the
   % element A(k,k+1). Note that this information isn't available
   % in the matrix A anymore since previous rotations from the right 
   % changed these elements.
   %   

     x1=SavedElements(1);x2=SavedElements(2);
     r = norm(SavedElements);

     c= x1 / r;
     s= -x2/r;
     G=[c , -s ; s , c]; 
     %disp(G)
   %
   % Apply the Givens rotation from the left to the rows k and k+1.
   %
   A(k:k+1,k)= G * A(k:k+1,k);
   disp("från vänster")
   disp(A)
   
   % 2*1            2*2 x 2*1

   %
   % Save the elements that are to be used for finding the next Givens 
   % rotation before overwriting them.
   %disp(A)
   %
    if (k<n-1),SavedElements=A(k+1:k+2,k+1);,end;
    
    A(k,k:k+1) = A(k,k:k+1)*G';
    disp("från höger")
    disp(A)
  
   %1,2                     2,2     2,2
   %
   % Apply the same Givens rotation from the right to the columns k and k+1.
   % Note that this overwrites the elements we saved above.
   %
    
   
  end;
  
   
   
   
   
   
