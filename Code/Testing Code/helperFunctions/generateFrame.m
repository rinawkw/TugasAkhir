% Copyright: Stefan  M. Karlsson, Josef Bigun 2014
function [imNew, bEof] = generateFrame(vid, t, kindOfMovie)
%persistent iix iiy k prevT rotAn P0 inertia synt rotAnprev PtXprev PtYprev flowRes edgeTilt macroDat;
%global g;

%%%%%%%%%%%  FILE READING %%%%%%%%%%
if strcmp(kindOfMovie,'file')
    if isa(vid,'VideoReader')
        bEof = t == vid.NumberOfFrames;
         %in this case we have absolute time "t", use to bounce the video:
        t=varyT(round(t),vid.NumberOfFrames);
        imNew = single(rgb2gray(read(vid, t)));
    else %computer vision toolbox videoreader:
        imNew = 250*step(vid);
    end
end