
A = diag(2:7) + -1*diag(ones(5,1),1) + -1*diag(ones(5,1),-1);
A

[vects,v] = eig(A);
vals = diag(v);
vals
vects

sum(vects(:,1).* vects(:,2)) %inner products == 0

%2.2
[x , rho] = EigPower(A, ones(6,1),30);

val_error = abs(rho - vals(6))
vect_residual  = sum(abs(x - vects(:,6)))




N = 5;
gk = zeros(1,N);    
lambda = vals(6)
error = inf;
rho = inf;
rhos= zeros(1,N);
for k  = 2:N
    [x, rho] = EigPower(A, ones(6,1) , k);
    
    rhos(1,k) = rho;
    
   
    gk(k) = abs(rho-lambda) / abs(error);
    error = abs(rho-lambda);
    
    
    
end
disp(gk)

%gk = gamma ^ k1;
%k1 = 2, gamma = (values(6) / values(5)) = gk.^(1/k1)


[x , rho] = EigPower(A, ones(6,1),30);

val_error = abs(rho - vals(6))
vect_residual  = sum(abs(x - vects(:,6)))

rho30 = rho;



%upper bound
cond(vects) * norm(A*x - rho30*x);


%% 2.3
s = 4;
B = inv(A - s*eye(size(A))); % B= A with shift of s

[x , mu]  = EigPower(B, ones(6,1), 3);

rhoa = 1 /mu +s; %
rhoa

gamma = abs((vals(3)-s)/(vals(2)-s));
gamma





N = 3;
gk = zeros(1,N);    
lambda = vals(3) % target lambda
error = inf;
mu = inf;
rhos= zeros(1,N);
for k  = 1:N
    
    [x, mu] = EigPower(B, ones(6,1) , k);
    rho = 1/mu +s;
    rhos(1,k) = rho; %saves approx of lambda aftereach number of iterations
    
    
   
    gk(k) = abs(rho -lambda) / abs(error);
    error = abs(rho -lambda);
    
    
    
end 

%gk(3)^.5 
%rhos

disp("----------------------------3---------------------")
%% 3.1
B = [ 1 2 3 4
      2 2 -1 -4
      3 -1 3 1
      4 -4 1 4];
ev = eig(B);
lambda = ev(2);
N=10;
B1 = B;
for k=1:N
    [Q,R] = qr(B1);
    B1 = R*Q;
    
    disp(B1)
end;
rho = B1(4,4);

error = abs(rho-lambda);
error %very low 2.85E-10

%% 3.2
%with shift
lambda = ev(3)
N=3;
B1 = B;

for k=1:N
    s = B1(4,4);
    [Q,R] = qr(B1-s*eye(4));
    B1 = R*Q;
    
    B1 = B1 + s*eye(4);
    
end;
rho = B1(4,4);
rho

error = abs(rho-lambda); %= 2.6645e-15
error

%eig(B1(1:3,1:3)) the other three in diag are getting close the the eigenvals






