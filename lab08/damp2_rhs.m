function ds = damp2_rhs(t,s,m,k,kc)
y1 = s(1);
y2 = s(2);
v1 = s(3);
v2 = s(4);
a1 = (-k(1)*y1+k(2)*(y2-y1)-kc(1)*v1)/m(1);
a2 = (-k(2)*(y2-y1)-k(3)*y2-kc(2)*v2)/m(2);
ds = [v1;v2;a1;a2];
