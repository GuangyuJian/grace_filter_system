[nn,mm]=get_nnmm(60);
%%
 [sc]=storage_clm2sc([nn mm mm mm], 60);
 
clm= storage_cssc2clm(sc);

[sc2]=storage_clm2sc(clm, 60);


