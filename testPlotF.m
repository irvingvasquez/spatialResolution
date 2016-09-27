clear

x=0:0.01:1;
alpha = 0.6;
for i=1:size(x,2);
    y(i) = functionF(x(1,i), alpha);
end

plot(x,y);