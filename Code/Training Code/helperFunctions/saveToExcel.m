function saveToExcel(logCov,row,label)
%row = (row-1)*6+1;
row = row+45;
row = num2str(row);
colrow = strcat('A',row);
logCov = reshape( logCov, 1, []);
xlswrite('training.xlsx',logCov,label,colrow);