%QRUpdate: Given a matrix R with the structure [R1 ; a^T] where
% R1 is upper triangular and a^T is a new row. Use Givens rotations
% to zero the last row and obtain an upper triangular matrix.
%
function [R]=QRUpdate(R)

[m,n]=size(R);



for k=1:n
    %disp([ m k])
    
    G = givens(R(k,k),R(m,k));
    
    I = eye(m,m);
    
    I(k,k) = G(1,1);
    I(k,m) = G(1,2);
    I(m,k) = G(2,1);
    I(m,m) = G(2,2);
    
    %disp(I)
    R = I*R;

end
% 1,4 2,4 3,4
  % Use a givens rotation between rows k and m to zero 
  % the element R(m,k). The Givens rotation matrix G is a
  % 2x2 matrix constructed using the elements x1=R(k,k) and
  % x2=R(m,k). The rotation is applied to the rows k and m.
  %


%(2,2) 