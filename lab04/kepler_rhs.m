function ds = kepler_rhs(t,s,mu)
x = s(1);
y = s(2);
vx = s(3);
vy = s(4);
r3 = (x^2+y^2)^1.5;
ds = [vx;vy;-mu*x/r3;-mu*y/r3];
