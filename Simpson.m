function [I] = Simpson(func, a, b, err, n)

    format long
    switch nargin
        case 4
            syms x
            fd2 = inline(diff(func(x),x,4),'x');
            x = a:0.01:b;            
            M = max(abs(fd2(x)));
            n = ceil(((b-a)^5 * M / (2880*err))^(1/4));
    end
   
    H = (b-a) / n;
    I = 0;
    for i = 1:n
        I = I + func(a+(i-1)*H) + 4* func(a + (i-0.5)*H) + func(a+i*H);
    end
    I = I * H/6;
    fprintf('Simpson: S%d = %0.7f\n', n, I);
end