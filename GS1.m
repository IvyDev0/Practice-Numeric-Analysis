function c = GS1(A, b, x0, N, e)
format long

c = 1; r =1;
x(:,c) = x0;
sizeOfA = size(A);
n = sizeOfA(1);  

while r >= e  % Gauss-Seidel 算法：
    % x(c+1) 的每个分量的计算充分利用其已计算出的分量
    x(1,c+1) = ( b(1) - dot( A(1,2:n), x(2:n,c)) ) / A(1,1);  
    for k = 2:n-1 
        a1 = dot( A(k,1:k-1), x(1:k-1,c+1) );
        a2 = dot( A(k,k+1:n), x(k+1:n,c) );
        x(k,c+1) = ( b(k) -  a1 - a2 ) / A(k,k);
    end
    x(n,c+1) = ( b(n) - dot( A(n,1:n-1), x(1:n-1,c+1) ) ) / A(n,n);
    
    r = norm(x(:,c+1)-x(:,c),inf);  % 两向量之差的无穷范数，小于精度要求时停机
    c = c+1;
    if c >= N
        c = c-1;
        save solution x
        return
    end
end
c = c-1;
save solution x
end