function [I] = Trapezoid(func, a, b, err, n)

    format long
    switch nargin
        case 4
            syms x
            fd2 = inline(diff(func(x),x,2),'x');
            x = a:0.01:b;            
            M = max(abs(fd2(x)));
            n = ceil(sqrt((b-a)^3 * M / (12*err)));
    end
   
    H = (b-a) / n;
    I =  func(a) + func(b);
    for i = 1:n-1
        I = I + 2* func(a + i * H);
    end
    I = I * H/2;
    fprintf('Trapezoid: T%d = %0.7f\n', n, I);
end