function x = gauss_opt(A)

sizeOfA = size(A);
rowOfA = sizeOfA(1);
culOfA = sizeOfA(2);

for k = 1 : rowOfA-1
    [m n] = find(A==max(abs(A(k:rowOfA,k))));
    A([k,m],:)=A([m,k],:); 
    
    for i = k+1 : rowOfA
        x = A(i,k) / A(k,k);
        A(i,:) = A(i,:) - x*A(k,:);
    end
end
A

B = A(:,culOfA);
x = [];
x(rowOfA) = B(rowOfA) / A(rowOfA,rowOfA);
for i = 1:rowOfA-1
    k = rowOfA-i;
    s = 0;
    for j = k+1:rowOfA
        s = s + A(k,j)*x(j);
    end
    x(k) = (B(k) - s) / A(k,k);
end
x
end