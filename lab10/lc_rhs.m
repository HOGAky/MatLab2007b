function ds = lc_rhs(t,s,L,C,R,E0,Om)
I = s(1);
q = s(2);
dI = -R*I/L-q/(L*C)+E0*cos(Om*t)/L;
dq = I;
dU = I/C;
ds = [dI;dq;dU];
