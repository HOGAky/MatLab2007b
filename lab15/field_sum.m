function E = field_sum(X,Y,sx,sy,dS,A0,z,lam,phi0)
E = zeros(size(X));
for j = 1:length(sx)
    r = sqrt((X-sx(j)).^2+(Y-sy(j)).^2+z^2);
    E = E+A0*dS*z./r.^2.*cos(2*pi*r/lam-phi0);
end
