load('shccostgDegia.mat')
gf=GaussFilter(90,500);

shcnew=gf.applyTo(shccostg);
%%
myf=sol_filter(90);
myf.set_filter('gauss',500);
%
shcnew2=myf.filtering(shccostg);
%%
shcdif=shcnew-shcnew2;

%
%%
mysf=shcdif.shc2ewh(1);
%%
for k=1:12
    next;
mysf.imagesc_tt(k);
caxis([-0.1 0.1])
end

%%
load('shccostgDegia.mat')
gf=FanFilter(90,10);
shcnew=gf.applyTo(shccostg);
%
myf=sol_filter(90);
myf.set_filter('fan',10);
%
shcnew2=myf.filtering(shccostg);
%
shcdif=shcnew-shcnew2;
mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
mysf.imagesc_tt(k);
caxis([-0.1 0.1])
end
next;
plot(myf.wnm-gf.computeWeights)
%%
%%
load('shccostgDegia.mat')
gf=FanFilter(90,10);
recgf=RecFilter(gf,3,0);
shcnew=recgf.applyTo(shccostg);
%
myf=sol_filter(90);
myf.set_filter('rec',3,'fan',10);
%
shcnew2=myf.filtering(shccostg);
%
shcdif=shcnew-shcnew2;


mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
    mysf.imagesc_tt(k);
    caxis([-0.1 0.1])
end
next;
plot(myf.wnm-recgf.computeWeights)

%%
%%
load('shccostgDegia.mat')
gf=FanFilter(90,100);
recgf=RecFilter(gf,3,1);
shcnew=recgf.applyTo(shccostg);
%
myf=sol_filter(90);
myf.set_filter('rec2',3,'fan',100);
%
shcnew2=myf.filtering(shccostg);
%
shcdif=shcnew-shcnew2;


mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
    mysf.imagesc_tt(k);
    caxis([-0.1 0.1])
end
next;
plot(myf.wnm-recgf.computeWeights)
%%
load('shccostgDegia.mat')
gf=GaussFilter(90,100);
recgf=RecFilter(gf,3,1);
shcnew=recgf.applyTo(shccostg);
%
myf=sol_filter(90);
myf.set_filter('rec2',3,'gauss',100);
%
shcnew2=myf.filtering(shccostg);
%
shcdif=shcnew-shcnew2;


mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
    mysf.imagesc_tt(k);
    caxis([-0.1 0.1])
end
next;
plot(myf.wnm-recgf.computeWeights)
%%
%%
load('shccostgDegia.mat')
gf=DDKFilter(5);
recgf=RecFilter(gf,3,1);
shcnew=recgf.applyTo(shccostg.extra(1:12));
%
myf=sol_filter(90);
myf.pre_destrip_recddk(5,3,'forward');
%
shcnew2=myf.filtering(shccostg.extra(1:12));
%
shcdif=shcnew-shcnew2;


mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
    mysf.imagesc_tt(k);
    caxis([-0.1 0.1])
end
% next;
% plot(myf.wnm-recgf.computeWeights)
%%
%%
load('shccostgDegia.mat')
gf=DDKFilter(90,3);
% recgf=RecFilter(gf,1,1);
shcnew=gf.applyTo(shccostg.extra(1:12));
%
myf=sol_filter(90);
myf.pre_destrip_ddk(3);
%
shcnew2=myf.filtering(shccostg.extra(1:12));
%
shcdif=shcnew-shcnew2;


mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
    mysf.imagesc_tt(k);
    caxis([-0.1 0.1]*50)
end
%%
%%
load('shccostgDegia.mat')
gf=DDKFilter(90,3);
recgf=RecFilter(gf,2,1);
shcnew=recgf.applyTo(shccostg.extra(1:12));
%
myf=sol_filter(90);
myf.pre_destrip_recddk(3,2,'forward');
%
shcnew2=myf.filtering(shccostg.extra(1:12));
%
shcdif=shcnew-shcnew2;


mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
    mysf.imagesc_tt(k);
    caxis([-0.1 0.1])
end

%%
load('shccostgDegia.mat')
gf=DDKFilter(90,3);
recgf=RecFilter(gf,2,0);
shcnew=recgf.applyTo(shccostg.extra(1:12));
%
myf=sol_filter(90);
myf.pre_destrip_recddk(3,2,'backward');
%
shcnew2=myf.filtering(shccostg.extra(1:12));
%
shcdif=shcnew-shcnew2;


mysf=shcdif.extra(1:12).shc2ewh(1);
%%
for k=1:12
    next;
    mysf.imagesc_tt(k);
    caxis([-0.1 0.1])
end