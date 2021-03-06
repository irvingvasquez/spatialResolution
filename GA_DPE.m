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

% 
clear;

%Setup the GA
ff = 'expectedNegFitnessDPE';
npar = 3; %number of variables
varhi = [20 200 20]; varlo=[0 0 1];%variable limits

%Stopping criteria
maxit = 500; %maxnumber of iterations
mincost = -9999999; %minimum cost

%%Genetic algorithm parameters
popsize = 20; %population size
mutrate = 0.1; %mutation rate
selection = 0.5; %fraction of population kept
Nt = npar; % continuos parameter GA Nt = #variables
keep = floor(selection*popsize); % #population members that survive
nmut =  ceil((popsize-1)*Nt*mutrate); % total number of mutations
M = ceil((popsize-keep)/2); % number of matings

%Time
tic;
    
% Create the initial population
iga = 0; %generation counter initialized
for i =1:Nt
    parvec = (varhi(1,i)-varlo(1,i))*rand(popsize,1)+varlo(1,i); %random
    % round the timelapse value 
    integer = round(parvec(3,1));
    parvec(3,1) = integer;
    par(:,i) = parvec;
end

Coords{1}=par;
cost = feval(ff,par); %calculates the population cost using ff
[cost,ind] = sort(cost); %mincost in element 1
par = par(ind,:); % sort continuos
minc(1) = min(cost); %minc containt min of
meanc(1) = mean(cost); %meanc contains the mean of the population

%Iterate trhough generations
while iga<maxit
    iga = iga +1;
    
    % ---------------------
    % Pair and mate
    M = ceil((popsize-keep)/2); %number of matings
    prob = flipud([1:keep]'/sum([1:keep])); %weight chromosomes
    odds = [0 cumsum(prob(1:keep))']; %probability distribution function
    pick1 = rand(1,M); % mate #1 (vector of length M with random #s between 0 and 1)
    pick2 = rand(1,M); % mate #2
    
    %ma and pa contain the indices of the chromosomes that will mate 
    %choosing integer k with probability p(k)
    % 
    ic = 1;
    while ic<=M
        for id = 2:keep+1
            if pick1(ic)<=odds(id) && pick1(ic)>odds(id-1)
                ma(ic)=id-1;
            end
            if pick2(ic)<=odds(id) && pick2(ic)>odds(id-1)
                pa(ic)=id-1;
            end
        end
        ic=ic+1;
    end
    
    % -------------------
    % Performs mating using single point crossover
    
    ix =1:2:keep; %index of mate1
    xp = ceil(rand(1,M)*Nt); %crossover point
    r= rand(1,M); %mixing parameter
    
    for ic=1:M
        xy=par(ma(ic),xp(ic))-par(pa(ic),xp(ic)); % ma and pa mate
        par(keep+ix(ic),:)=par(ma(ic),:); % 1st offspring
        par(keep+ix(ic)+1,:)=par(pa(ic),:); % 2nd offspring
        par(keep+ix(ic),xp(ic))=par(ma(ic),xp(ic))-r(ic).*xy; % 1st
        par(keep+ix(ic)+1,xp(ic))=par(pa(ic),xp(ic))+r(ic).*xy; % 2nd
              
        if xp(ic)<npar % crossover when last variable not selected
            temp = [par(keep+ix(ic),1:xp(ic)), par(keep+ix(ic)+1,xp(ic)+1:npar)];
            par(keep+ix(ic),:)= temp;
            par(keep+ix(ic)+1,:)=[par(keep+ix(ic)+1,1:xp(ic)), par(keep+ix(ic),xp(ic)+1:npar)];
        end % if
        
        %round the trigger time
        par(keep+ix(ic),3)= round(par(keep+ix(ic),3)); % 1st
        par(keep+ix(ic)+1,3)= round(par(keep+ix(ic)+1,3)); % 2nd
    end
    
    %---------------------
    % Mutate the population
    mrow=sort(ceil(rand(1,nmut)*(popsize-1))+1);
    mcol=ceil(rand(1,nmut)*Nt);
    for ii=1:nmut
        par(mrow(ii),mcol(ii))=(varhi(1,mcol(ii))-varlo(1,mcol(ii)))*rand+varlo(1,mcol(ii));
        % mutation
    end % ii

    %_______________________________________________________
    % The new offspring and mutated chromosomes are
    % evaluated
    cost=feval(ff,par);

    %_______________________________________________________
    % Sort the costs and associated parameters
    [cost,ind]=sort(cost);
    par=par(ind,:);
    Coords{iga+1}=par;
    
    %_______________________________________________________
    % Do statistics for a single nonaveraging run
    minc(iga+1)=min(cost);
    meanc(iga+1)=mean(cost);
    
    %_______________________________________________________
    % Stopping criteria
    if iga>maxit || cost(1)<mincost
        break
    end
    
    [iga cost(1)];
end %iga


toc

%% Displays the output
    day=clock;
    disp(datestr(datenum(day(1),day(2),day(3),day(4),day(5),day(6)),0))
    disp(['optimized function is ' ff])
    format short g
    disp(['popsize=' num2str(popsize) ' mutrate=' num2str(mutrate) ' # par=' num2str(npar)])
    disp(['#generations=' num2str(iga) ' best cost=' num2str(cost(1))])
    disp('best solution')
    disp(num2str(par(1,:)))
    disp('continuous genetic algorithm')
    
    figure(1)
    iters=0:length(minc)-1;

    %WARNING: this was included only for display purposes
    minc = -1 * minc;
    meanc = -1 * meanc;
    
    plot(iters,minc,iters,meanc,'-');
    xlabel('Generation');ylabel('Expected utility');
