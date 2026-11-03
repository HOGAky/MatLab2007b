function dY = rhs1(t,Y,r,rho,rho0,mu,g)
dY = [g*(1-rho0/rho)-9*mu*Y(1)/(2*r^2*rho);Y(1)];
