
disp("---------------------- Q2 ----------------")
% Testing our implementation compared to standard %
disp("ex. 2.4")
N = 25;

x = 50;
A = rand(x);

tic
for temp = 1:N

   HouseholderQR(A); 
    
end
toc


tic
for temp = 1:N
    qr(A);
end
toc
N = 1;

x = 2;
A = rand(x);
disp("our implementation is significantly slower than the standard one")

disp("ex. 2.4 + 2.5")
A = [
    [ 2 -5 3],
    [-1 8 5],
    [4 -1 7],
    [-1 3 2]
    ];

b = [3 5 -2 4]';


C = HouseholderQR( [ A,b]);


R = C(1:3,1:3); Qb = C(1:3,4);
x_QR = R\Qb;

%they are equal. C(4,4) is  ||alpha|| the norm of the residual
disp("norm a*x_QR -b")
norm(A*x_QR -b) 
disp("C(4,4)")
C(4,4)

%solution to system Ax =b
x_matlab = A\b;
%x2 == x1 our implementation works
disp("using X from A\b ")
disp(norm(A*x_matlab -b))


disp('------------------- Q3 ---------------')

R = HouseholderQR( [ A , b ] );
R = R(1:3,:);
X = R(:,1:3)\R(:,4);



R = [R; 1 2 6 5];
R = QRUpdate(R);
R = R(1:3,:);
X_new = R(:,1:3)\R(:,4);

x2 = [A; 1 2 6]\[b;5];

comp = [X';X_new';x2'];

disp(comp)

% The new data changes our solution. We get the same (new) answer using our
% QRUpdate and the inbuilt linsolve (\) function.

disp('---------------------- Q4 -----------------------')




