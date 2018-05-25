function saveToExcel(logCov,row,label)
global g;
%row = (row-1)*6+1;
%row = row+45;
%g.row=row;
row = num2str(row);
colrow = strcat('A',row);
logCov = reshape( logCov, 1, []);
xlswrite('weizmann_testing_3.xlsx',logCov,label,colrow);
g.save = 1;