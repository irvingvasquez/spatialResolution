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

% Experiment configuration

% Camera parameter: Cam = [f; h_s; s_pix, t0]
%GOPRO4 Silver parameters:
GOPRO4 = [1.6976; 4.65; 0.00155; 1];
MAPPIR = [3.97; 3.68; 0.00121; 3];
TETRACAM_MICRO = [8.43; 4.92; 0.0032; 3];

%Cam = MAPPIR;
Cam = GOPRO4;
%Cam = TETRACAM_MICRO;

% UAV parameters: UAV = [v0; v1; h0; h1]
% 3DR Solo parameters
UAV = [0; 24; 40; 120];

% Desired overlap: alpha
alpha = 0.8;

% number of samples: n
n = 250;

% Sigma = [sigma_spd; sigma_height; sigma_t]
Sigma = [1; 3; 0];

SPD = UAV(1):0.25:UAV(2);
nn=size(SPD,2);

H = UAV(3):2.5:UAV(4);
m = size(H,2);

interv = 3;

for(i=1:m)
    for(j=1:nn)
        Q = [SPD(j);H(i);interv];
        EI(i,j) = expectedG(Q, Cam, UAV, alpha, n, Sigma);
        %EI(i,j) = ExpectedInfo(SPD(j),H(i),interv);
    end
end

figure
mesh(SPD,H,EI);

figure
contour(SPD,H,EI,10);
hold on
%plot3(5,35,-0.02698);
xlabel('Speed');ylabel('Height');
