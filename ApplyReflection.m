%ApplyReflection: Compute the product H*A where H is the 
% Householder reflection matrix that creates zeros elememts
% below the diagonal in the first column. 
%


%http://pi.math.cornell.edu/~web6140/TopTenAlgorithms/Householder.html

function [HA]=ApplyReflection(A)
    [m,n] = size(A);
    e1 = zeros(n,1);
    e1(1,1) = 1;
    
    disp(e1)
    
    
    % Select the vector x to used for constructing the reflection
    
    x=A(:,1); 
    
    %
    % Find the vector v so that H(v)*x=alpha*e1. 
    %
    v = x;
    v(1) = v(1) + norm(x);
    disp(v')
    
    y = x- 2*(v'*x)/(v'*v)*v;
    disp(y')
    
    
    
    
    Hv = eye(n) - 2 * (v*v')/(v'*v);
    
    disp(Hv)
    
    %
    % Compute the product  H*A. Treat one column at a time, i.e. 
    % (HA)(:,k)=H*A(:,k).
    %
    HA=zeros(size(A));
    for k=1:n
        HA(:,k) = Hv * A(:,k);
    end


