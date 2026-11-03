function ds = lorentz_rhs(t,s,m,q,E,B)
vx = s(3);
vy = s(4);
ax = q*(E-B*vy)/m;
ay = q*B*vx/m;
ds = [vx;vy;ax;ay];
