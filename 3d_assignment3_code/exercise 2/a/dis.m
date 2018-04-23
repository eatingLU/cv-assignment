function [d_best] = dis(il,ir,w,d_min,d_max)

[m,n] = size(il);

p = (w-1)/2;
q = p;
DMIN = d_min;
DMAX = d_max;

% add white edges for the oringinal images
le = zeros(m + 2*q, n + 2*(p+d_max));
ri = zeros(m + 2*q, n + 2*(p+d_max));
le(q+1:m+q, p+d_max+1:n+p+d_max) = il;
ri(q+1:m+q, p+d_max+1:n+p+d_max) = ir;

% SAD algorithm
for xl = q+1:m+q
    for yl = p+d_max+1:n+p+d_max
        c_min = inf;
        for drr = DMIN:DMAX
            s = 0;
            IL = le(xl-p:xl+p,yl-q:yl+q);
            IR = ri(xl-p:xl+p,yl-drr-q:yl-drr+q);
            C = abs(IR - IL);
            s = sum(C(:));
            % finding best match
            if s < c_min
                c_min = s;
               d_o = drr;
            end            
        end
        %store final result
         d_best(xl-q,yl-d_max-p) = d_o;
    end
end

%imshow(d_best);
end
