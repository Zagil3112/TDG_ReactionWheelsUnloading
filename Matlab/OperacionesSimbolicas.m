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




A= [1 24 6 ;
    3 4 5;
    1 4 2];


R= skew(I*omega')-skew(omega')*I+skew(L')
