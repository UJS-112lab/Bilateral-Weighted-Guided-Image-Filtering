function q = bilateralweightedguidedfilter0(g, ps, r, eps, sigma_d, sigma_r, scale)

gs = imresize(g,1/scale);
% gs = imresize(g,size(ps));
[h,w] = size(gs);

xy = gs.*ps;
xx = gs.*gs;
y = ps;
x = gs;

[X,Y] = meshgrid(-r:r,-r:r);
D = exp(-(X.^2+Y.^2)/(2*sigma_d^2));    %domain
wxy = zeros(h,w);
wxx = zeros(h,w);
wx = zeros(h,w);
wy = zeros(h,w);
for i = 1:h
    for j = 1:w
        iMin = max(i-r,1);
        iMax = min(i+r,h);
        jMin = max(j-r,1);
        jMax = min(j+r,w);
        L = gs(iMin:iMax,jMin:jMax);
        R = exp(-(L-gs(i,j)).^2/(2*sigma_r^2));     %range
        W = R.*D((iMin:iMax)-i+r+1,(jMin:jMax)-j+r+1);  
        
        Lxy = xy(iMin:iMax,jMin:jMax);
        Lxx = xx(iMin:iMax,jMin:jMax);
        Ly = y(iMin:iMax,jMin:jMax);
        Lx = x(iMin:iMax,jMin:jMax);
        wxy(i,j) = sum(W(:).*Lxy(:))/sum(W(:));
        wxx(i,j) = sum(W(:).*Lxx(:))/sum(W(:));
        wy(i,j) = sum(W(:).*Ly(:))/sum(W(:));
        wx(i,j) = sum(W(:).*Lx(:))/sum(W(:));
    end
end

a = (wxy - wy.*wx) ./ (wxx - wx.*wx + eps);
b = wy - a.*wx;

az = imresize(a,scale,'bilinear'); 
bz = imresize(b,scale,'bilinear');

q = az .* g + bz;

end