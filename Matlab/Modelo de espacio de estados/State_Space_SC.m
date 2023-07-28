
% velocidad angular 
w1 = realp('w1',0);
w2 = realp('w2',0);
w3 = realp('w3',0);

omega = [w1 w2 w3];


% I11 = realp('I11', 0);
% I12 = realp('I12', 0);
% I13 = realp('I13', 0);
% 
% I21 = realp('I21', 0);
% I22 = realp('I22', 0);
% I23 = realp('I23', 0);
% 
% I31 = realp('I31', 0);
% I32 = realp('I32', 0);
% I33 = realp('I33', 0);
% matriz de inercia SC

I =1e-7*[336109.715 0 0 ;
        0 308250.765 0; 
        0 0 271714.972];

% Momentos angulares 

h1 = realp('h1', 0);
h2 = realp('h2', 0);
h3 = realp('h3', 0);

L = [h1 h2 h3];

% Matrices de espacio de estados


Aww = skew(I*omega')-skew(omega')*I+skew(L');
Awh = -skew(omega');


A11 = (I^-1)*Aww;
A13 =(I^-1)*Awh;

A = [A11 zeros(3) A13;
    0.5*eye(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3)];

B = [I^-1 I^-1 I^-1;
    zeros(3) zeros(3) zeros(3);
    -eye(3) zeros(3) zeros(3)];

C = [eye(3) zeros(3) zeros(3);
    zeros(3) eye(3) zeros(3);
    zeros(3) zeros(3) eye(3)];

D = [zeros(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3)];

sys = ss(A,B,C,D)
P = pole(sys)
% step(sys)
h = pzplot(sys)