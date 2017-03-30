function c = Jacobi2(A, b, x0, N, e)
format long

D = diag(diag(A));  % A的对角矩阵D
L = -tril(A,-1);   % A的下三角矩阵L
U = -triu(A,1);  % A的上三角矩阵U

M = (inv(D))*(L+U);  % Jacobi 算法的迭代矩阵
g = (inv(D))*b;  


if vrho(M) >=1 % 收敛的充要条件：迭代矩阵的谱半径<1
    disp('not convergent')
    return
end

c = 1;  % 迭代次数c
x(:,c) = x0;  % 存放每个步骤的解的矩阵x
x(:,c+1) = M*x(:,c)+g;

while norm(x(:,c) - x(:,c+1),inf) >= e   % 两向量之差的无穷范数，小于精度要求时停机
    c = c+1;
    x(:,c+1) = M*x(:,c)+g;  % 迭代计算
    if c >= N
        save solution x
       return
    end
end
save solution x
end