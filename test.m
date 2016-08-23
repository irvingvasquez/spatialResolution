%TODO: Revisar que las muestras no varien en interv

clear;
%X = [0:0.01:1];
%X = X';
%n = size(X,1);
%Y = zeros(n,1);

alpha = 0.8;
SPD = 0:0.5:20;
n=size(SPD,2);

%for(i=1:n)
%    Y(i) = f(X(i),alpha);
%end

%plot(X,Y);

H = [0:5:200];
m = size(H,2);
spd = 1;
interv = 3;

for(i=1:m)
    [S(i), Overlap(i)] = resolution(spd, H(i), interv);
    %I(i) = 1/S(i);
    %W(i) = f(Overlap(i),alpha);
    %G(i) = W(i)*I(i);
    %F(i) = fitness(spd, H(i), interv);
    for(j=1:n)
        FF(i,j) = fitness(SPD(j),H(i),interv);
        EI(i,j) = ExpectedInfo(SPD(j),H(i),interv);
    end
end

%figure
%plot(H,S);
%figure
%plot(H,Overlap);
%figure
%plot(H,W);
%figure
%plot(H,G);
%figure
%plot(H,F);
figure
mesh(SPD,H,FF);

figure
mesh(SPD,H,EI);
