function [s overlap] = resolution(spd, height, interv)
% Camera parameters
s_pix = 0.0032; % pixel resolution in mm
f = 8.43; %focal lenght in mm
h_s = 4.92; %sensor height

s = s_pix * height * 1000 / f;

d = spd * interv;
overlap = 1 - (d *1000 *f)/(h_s*height*1000);
end