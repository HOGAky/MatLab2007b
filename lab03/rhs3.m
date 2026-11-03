function ds = rhs3(t,s,rho0,r,m,Cd,kk,adec,g)
vx = s(4);
vy = s(5);
vz = s(6);
V = sqrt(vx^2+vy^2+vz^2);
Vxy = sqrt(vx^2+vy^2);
c = rho0*pi*r^2/(2*m);
ds = [vx;vy;vz;-c*(Cd*vx*V+kk*vy*exp(-adec*t)*Vxy);-c*(Cd*vy*V-kk*vx*exp(-adec*t)*Vxy);-c*Cd*vz*V-g];
