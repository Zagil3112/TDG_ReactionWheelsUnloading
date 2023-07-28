% Paso 1: Definir los símbolos
syms w1 w2 w3;

syms I11 I12 I13;
syms I21 I22 I23;
syms I31 I32 I33;

syms h1 h2 h3;


% Paso 2: Crear la matriz A con los elementos simbólicos
omega = [w1 w2 w3];
I = [I11 I12 I13;
    I21 I22 I23;
    I31 I32 I33];

L = [h1 h2 h3];

R= skew(I*omega')-skew(omega')*I+skew(L');


Aww = skew(I*omega')-skew(omega')*I+skew(L');
Awh = -skew(omega');

A11 = (I^-1)*Aww;
A13 =(I^-1)*Awh;

A = [A11,zeros(3),A13;
    0.5*eye(3),zeros(3),zeros(3);
    zeros(3),zeros(3),zeros(3)]

