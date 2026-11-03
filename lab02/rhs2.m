function ds = rhs2(t,s,m,S,Cd,rho0,g)
vx = s(3);
vy = s(4);
vm = sqrt(vx^2+vy^2);
a = Cd*rho0*S*vm/(2*m);
ds = [vx;vy;-a*vx;-a*vy-g];
