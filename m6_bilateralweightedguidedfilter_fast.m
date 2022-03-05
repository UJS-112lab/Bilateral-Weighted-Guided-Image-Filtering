function q = m6_bilateralweightedguidedfilter_fast(g, ps, eps, sigma_d, sigma_r, scale)

gs = imresize(g,1/scale);
% gs = imresize(g,size(ps));

xy = gs.*ps;
xx = gs.*gs;
y = ps;
x = gs;

wxy = m6_bilateralFilter(xy, x, min(gs(:)), max(gs(:)), sigma_d, sigma_r);
wxx = m6_bilateralFilter(xx, x, min(gs(:)), max(gs(:)), sigma_d, sigma_r);
wy = m6_bilateralFilter(y, x, min(gs(:)), max(gs(:)), sigma_d, sigma_r);
wx = m6_bilateralFilter(x, x, min(gs(:)), max(gs(:)), sigma_d, sigma_r);

a = (wxy - wy.*wx) ./ (wxx - wx.*wx + eps);     %去掉N，当sigma足够大时，WGF=GF
b = wy - a.*wx;

az = imresize(a, scale, 'bilinear');
bz = imresize(b, scale, 'bilinear');

q = az .* g + bz;

end