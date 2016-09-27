%TODO: Revisar que las muestras no varien en interv

clear;
%X = [0:0.01:1];
%X = X';
%n = size(X,1);
%Y = zeros(n,1);

alpha = 0.6;
SPD = 0:0.25:16;
n=size(SPD,2);

%for(i=1:n)
%    Y(i) = f(X(i),alpha);
%end

%plot(X,Y);

H = [30:2.5:100];
m = size(H,2);
spd = 1;
interv = 3;

for(i=1:m)
    %[S(i), Overlap(i)] = resolution(spd, H(i), interv);
    %I(i) = 1/S(i);
    %W(i) = f(Overlap(i),alpha);
    %G(i) = W(i)*I(i);
    %F(i) = fitness(spd, H(i), interv);
    for(j=1:n)
        %FF(i,j) = fitness(SPD(j),H(i),interv);
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
%figure
%mesh(SPD,H,FF);

figure
mesh(SPD,H,EI);

figure
contour(SPD,H,EI,10);
hold on
%plot3(5,35,-0.02698);
xlabel('Speed');ylabel('Height');