%All in 1 file
myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.mat'));             %gets all mat files in struct
for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  fprintf(1, 'Now reading %s\n', baseFileName);     %prints file being read
  
  data(k) = load([ myDir '\' myFiles(k).name ]);    %adds all Res files to structure called "data"
  res = data(k);                                    %selects Res file for analysis
  EPM_Results{1+k,1} = baseFileName; 
  
  EPM_Results{1,2} = 'total cms travelled';    
  EPM_Results{1+k,2} = res.Res.total_cms_travelled;     %extracts Res.total_cms_travelled from current Res file in loop and adds to 2nd row of structure
  
  EPM_Results{1,3} = 'mean_body_speed';
  EPM_Results{1+k,3} = res.Res.mean_body_speed;
  
  
for m = 1 : length(res.Res.totalFramesZPbody)
        EPM_Results{1,4} = 'zone_names';
        EPM_Results{1+k,3+m} =   cell2mat(transpose(res.Res.zone_names(m)));
end  
  
skip = length(res.Res.totalFramesZPbody);

   
 for m = 1 : length(res.Res.totalFramesZPbody)
     EPM_Results{1,(4+skip)} = 'totalFramesZPbody';
     EPM_Results{1+k,3+skip+m} =   transpose(res.Res.totalFramesZPbody(m));
 end  
  
     
  for m = 1 : length(res.Res.totalFramesZPbody)
     EPM_Results{1,(4+(2*skip))} = 'totalTimeZPbody';
     EPM_Results{1+k,3+(2*skip)+m} =   transpose(res.Res.totalTimeZPbody(m));
  end  
     
  
  for m = 1 : length(res.Res.totalFramesZPbody)
      EPM_Results{1,(4+(3*skip))} = 'totalTimeZPbody';
      EPM_Results{1+k,3+(3*skip)+m} = res.Res.totalTimeZPbody(m);
  end
  
  for m = 1 : length(res.Res.totalFramesZPbody)
        EPM_Results{1,(4+(4*skip))} = 'fractionTimeZPbody';
        EPM_Results{1+k,3+(4*skip)+m} =   res.Res.fractionTimeZPbody(m);
  end  
  
  
  for m = 1 : length(res.Res.totalFramesZPbody)
        EPM_Results{1,(4+(5*skip))} = 'totalZbody_enrichment';
        EPM_Results{1+k,3+(5*skip)+m} =   res.Res.totalZbody_enrichment(m);
  end
  
  
    for m = 1 : length(res.Res.totalFramesZPbody)
        EPM_Results{1,(4+(6*skip))} = 'body_zone_visits';
        EPM_Results{1+k,3+(6*skip)+m} =   length(res.Res.body_zone_visits{1,m});
    end

   transitions = 0;
    
    for m = 1 : length(res.Res.totalFramesZPbody)
        transitions = transitions + length(res.Res.body_zone_visits{1,m});
        OF_Results{1,(4+(7*skip))} = 'Total transitions';
        OF_Results{1+k,3+(7*skip)+1} =   transitions;
    end
    clear transitions;
    
    
    
end

%%
%saving all data in an excel file
nameOfVariable = 'EPM_Results_v2';
fullPath=fullfile([char(myDir)], [nameOfVariable '.xls']);
xlswrite(fullPath, EPM_Results);

clear

msgbox('Done!');


%%

