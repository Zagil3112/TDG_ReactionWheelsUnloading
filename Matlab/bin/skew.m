function skw = skew(A)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
skw = [0 -A(3) A(2);
        A(3) 0 -A(1);
        -A(2) A(1) 0];
end