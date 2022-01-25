N = 5§  ;
A = rand(N,N);

for i = 1:N
    A(i:N,i:N) = ApplyReflection(A(i:N,i:N));
    disp(A)
end


