%TODO: Revisar que las muestras no varien en interv
clear;

% Experiment configuration

% Camera parameter: Cam = [f; h_s; s_pix, t0]
%GOPRO4 Silver parameters:
GOPRO4 = [1.6976; 4.65; 0.00155; 1];
MAPPIR = [3.97; 3.68; 0.00121; 3];

%Cam = MAPPIR;
Cam = GOPRO4;

% UAV parameters: UAV = [v0; v1; h0; h1]
% 3DR Solo parameters
UAV = [0; 16; 30; 120];

% Desired overlap: alpha
alpha = 0.6;

% number of samples: n
n = 250;

% Sigma = [sigma_spd; sigma_height; sigma_t]
Sigma = [1; 3; 0];

SPD = 0:0.25:16;
nn=size(SPD,2);

H = [30:2.5:100];
m = size(H,2);

interv = 3;

for(i=1:m)
    for(j=1:nn)
        EI(i,j) = expectedG(SPD(j),H(i),interv, Cam, UAV, alpha, n, Sigma);
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