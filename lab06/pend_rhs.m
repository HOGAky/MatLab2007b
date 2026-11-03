function ds = pend_rhs(t,s,m,g,l,J)
ds = [s(2);-(m*g*l/J)*sin(s(1))];
