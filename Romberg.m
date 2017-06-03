function R = Romberg(func, a, b, err, maxk)
%   Computes the triangular extrapolation table for Romberg integration 
%   f: function name (either a name in quotes, or an inline function) 
%   a, b: lower and upper limits of integration
%	n: step size h = (b-a)/n
%   maxk: the number of extrapolation steps+1 (maxk = number of rows in R)
%   err: tolerance

    format long
    switch nargin
        case 4
            maxk = 8;
    end
    h = b-a;
    R = zeros(maxk,4);
    
    R(1,1) = h/2*(func(a) + func(b)); 
    for k = 2:maxk        
        for i = 1:2^(k-2)
            R(k,1) = R(k,1) + func(a + (2*i-1)*h/(2^(k-1))); 
        end
        R(k,1) = (R(k-1,1) + h/2^(k-2)*R(k,1))/2;
    end
    for j = 2:3
        for k = j:maxk 
            R(k,j) = (4^(j-1)*R(k,j-1)-R(k-1,j-1))/(4^(j-1)-1); 
        end    
    end
    
    k = 4;
    while  k==4 || k<=maxk
        R(k,4) = (4^(k-1)*R(k,3)-R(k-1,3))/(4^(k-1)-1); 
        if abs(R(k,4) - R(k-1,4)) < 255*err
            fprintf('Romberg: R%d = %0.8f\n', 2^(k-5), R(k,4));
            break;
        else
            k = k+1;
        end
    end
end