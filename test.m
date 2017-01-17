% Copyright (c) 2016, J.I. Vasquez <ivasquez@ccc.inaoep.mx>
% Consejo Nacional de Ciencia y Tecnología
% Instiuto Politecnico Nacional
% Centro de Innovación y Desarrollo Tecnológico en Cómputo
% All rights reserved.
%   
% BSD License
%  
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%      * Redistributions of source code must retain the above copyright
%      notice, this list of conditions and the following disclaimer.
%      * Redistributions in binary form must reproduce the above copyright
%      notice, this list of conditions and the following disclaimer in the
%      documentation and/or other materials provided with the distribution.
%      * Neither the name of the <organization> nor the
%      names of its contributors may be used to endorse or promote products
%      derived from this software without specific prior written permission.
%  
%  THIS SOFTWARE IS PROVIDED BY <copyright holder> <email> ''AS IS'' AND ANY
%  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%  DISCLAIMED. IN NO EVENT SHALL <copyright holder> <email> BE LIABLE FOR ANY
%  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
%  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
