function y = fitness(spd, height, interv)
% Constants
alpha = 0.8;

% Restrictions
v0 = 5;
v1 = 20;
t0 = 3;
h0 = 30;
h1 = 150;

if( spd<v0 || spd>v1 )
    y = 0;
else if(interv < t0)
        y = 0;
    else
        if(height < h0 || height > h1)
            y = 0;
        else
            [s, overlap] = resolution(spd, height, interv);
            w = f(overlap,alpha);
            I = 1/s;
            y = w * I;
        end
    end
end

end