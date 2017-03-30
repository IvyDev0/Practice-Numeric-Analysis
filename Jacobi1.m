function c = Jacobi1(A, b, x0, N, e)
% input:     A, b - 所求方程组的系数矩阵和常量向量；
%               x0 - 初始值；N - 迭代次数上限；e - 要求精度。
% output:   c - 迭代次数；x - 每一步的解
format long

c = 1; r =1;
x(:,c) = x0;
sizeOfA = size(A);
n = sizeOfA(1);  

while r >= e  % Jacobi 算法：
    for k = 1:n 
        x(k,c+1) = x(k,c) + ( b(k) -  dot( A(k,:), x(:,c) ) ) / A(k,k);
    end
    
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

