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

% Energy
velocity = [2 4 6 8 10 12 14 16];
power = [220  215 210  208 212 230 260 300];
%plot(velocity, power, 'o');
coef = polyfit(velocity,power,3);
power_mr = @(speed) polyval(coef, speed); 


Spd = 0:0.1:16;
for i=1:size(Spd,2)
    EperDist = power_mr(Spd(1,i)) / Spd(1,i);
    DistPerEner(i) = 1 / EperDist;
end

plot(Spd,DistPerEner);
