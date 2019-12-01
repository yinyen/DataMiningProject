*------------------------------------------------------------*;
* Clus: Preliminary Clustering;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    G(ASC) IMP_markets_missing(ASC) NC17(ASC) NR(ASC) PG(ASC) PG_13(ASC) R(ASC)
   genre_Action(ASC) genre_Adventure(ASC) genre_AnimationManga(ASC)
   genre_ArthouseInter(ASC) genre_ClassicsCult(ASC) genre_Comedy(ASC)
   genre_DramaTele(ASC) genre_FamilyKids(ASC) genre_Fantasy(ASC)
   genre_FitnessSports(ASC) genre_HistDocument(ASC) genre_Horror(ASC)
   genre_MusicalPerfarts(ASC) genre_Romance(ASC) genre_Sci_fi(ASC)
   genre_Special_Interest(ASC) genre_ThrillMysSusp(ASC) genre_Western(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_domestic_gross IMP_domestic_opening IMP_foreign_gross IMP_runtime
   IMP_ss_count IMP_ss_mean IMP_ss_median IMP_ss_p25 IMP_ss_p75 IMP_ss_std
   IMP_total_gross IMP_user_rating_count tomatometer_count
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Impt_TRAIN
dmdbcat=WORK.Clus_DMDB
maxlevel = 513
out=WORK.Clus_DMDB
;
class %DMDBClass;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    IMP_domestic_gross IMP_domestic_opening IMP_foreign_gross IMP_runtime
   IMP_ss_count IMP_ss_mean IMP_ss_median IMP_ss_p25 IMP_ss_p75 IMP_ss_std
   IMP_total_gross IMP_user_rating_count tomatometer_count
%mend DMVQINTERVAL;
*------------------------------------------------------------* ;
* Clus: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQNOMINAL;
    G IMP_markets_missing NC17 NR PG PG_13 R genre_Action genre_Adventure
   genre_AnimationManga genre_ArthouseInter genre_ClassicsCult genre_Comedy
   genre_DramaTele genre_FamilyKids genre_Fantasy genre_FitnessSports
   genre_HistDocument genre_Horror genre_MusicalPerfarts genre_Romance
   genre_Sci_fi genre_Special_Interest genre_ThrillMysSusp genre_Western
%mend DMVQNOMINAL;
*------------------------------------------------------------*;
* Clus: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus_DMDB dmdbcat=WORK.Clus_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 50 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus_OUTVAR;
INITIAL radius=0
;
TRAIN tech=FORGY
;
SAVE outstat=WORK.Clus_OUTSTAT outmean=EMWS1.Clus_OUTMEAN;
code file="C:\Users\yinyen\Desktop\DataMiningProject3\SASEM_Project\Workspaces\EMWS1\Clus\DMVQSCORECODE.sas"
group=Clus
;
run;
quit;
*------------------------------------------------------------* ;
* Clus: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    IMP_domestic_gross IMP_domestic_opening IMP_foreign_gross IMP_runtime
   IMP_ss_count IMP_ss_mean IMP_ss_median IMP_ss_p25 IMP_ss_p75 IMP_ss_std
   IMP_total_gross IMP_user_rating_count tomatometer_count G0 G1
   IMP_markets_missing0 IMP_markets_missing1 NR0 NR1 PG0 PG1 PG_130 PG_131 R0 R1
   genre_Action0 genre_Action1 genre_Adventure0 genre_Adventure1
   genre_AnimationManga0 genre_AnimationManga1 genre_ArthouseInter0
   genre_ArthouseInter1 genre_ClassicsCult0 genre_ClassicsCult1 genre_Comedy0
   genre_Comedy1 genre_DramaTele0 genre_DramaTele1 genre_FamilyKids0
   genre_FamilyKids1 genre_Fantasy0 genre_Fantasy1 genre_FitnessSports0
   genre_FitnessSports1 genre_HistDocument0 genre_HistDocument1 genre_Horror0
   genre_Horror1 genre_MusicalPerfarts0 genre_MusicalPerfarts1 genre_Romance0
   genre_Romance1 genre_Sci_fi0 genre_Sci_fi1 genre_Special_Interest0
   genre_Special_Interest1 genre_ThrillMysSusp0 genre_ThrillMysSusp1
   genre_Western0 genre_Western1
%mend ;
*------------------------------------------------------------*;
* Clus: Determining the number of clusters;
*------------------------------------------------------------*;
proc cluster data=EMWS1.Clus_OUTMEAN method=WARD pseudo outtree=EMWS1.Clus_CLUSSEED
;
var %dmvqvars;
copy _SEGMENT_;
run;
quit;
proc sort data =EMWS1.Clus_CLUSSEED out=WORK._SEED_;
by _ncl_;
where (_ccc_ > -99999.0);
run;
data WORK._SEED2_;
retain oJump occc oncl;
set WORK._SEED_;
_lccc_=lag(_ccc_);
if _lccc_ > . then jump = _ccc_ - _lccc_;
if jump<0 and ojump>0 then do;
* Have a local Max;
numclus = oncl;
cccvalue = occc;
output;
end;
ojump = jump;
occc = _ccc_;
oncl = _ncl_;
run;
proc print data=WORK._SEED2_ label;
var numclus cccvalue;
label numclus="%sysfunc(sasmsg(sashelp.dmine, rpt_numclus_vlabel ,  NOQUOTE))";
label cccvalue="%sysfunc(sasmsg(sashelp.dmine, rpt_ccc_vlabel ,     NOQUOTE))";
title10 "%sysfunc(sasmsg(sashelp.dmine, rpt_OptClus_title, NOQUOTE))";
run;
title10;
data WORK._SEED2_;
length msg $200;
set WORK._SEED2_ end=eof;
retain select cccSelect 0 numSel;
if _N_=1 then numSel = numClus;
if cccvalue>=3 then do;
if 20>= numclus >= 2 and cccSelect<1 then do;
cccSelect = 1;
select =1;
numSel = numClus;
end;
end;
else if 20>= numclus >= 2 and select<1 then do;
select = 1;
numSel = numClus;
end;
if eof then do;
if ^(select=1 and cccselect=1) then do;
put "*------------------------------------------------------------*";
put '*;';
put "WARNING: The number of clusters selected based on the CCC values may not be valid.  Please refer to the documentation on the Cubic Clustering Criterion.";
put '*;';
put "*------------------------------------------------------------*";
end;
if select<1 then do;
msg = sasmsg('sashelp.dmine', 'rpt_noCCCclusternum_note', 'NOQUOTE');
put msg;
end;
if cccselect<1 then do;
msg = sasmsg('sashelp.dmine', 'rpt_noValidclusterNum_note', 'NOQUOTE');
put msg;
end;
call symput('em_maxC', strip(put(numSel,best.)));
end;
run;
*------------------------------------------------------------*;
* Clus: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Clus: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus_DMDB dmdbcat=WORK.Clus_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 3 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus_OUTVAR;
INITIAL radius=0
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus_OUTSTAT outmean=EMWS1.Clus_OUTMEAN;
code file="C:\Users\yinyen\Desktop\DataMiningProject3\SASEM_Project\Workspaces\EMWS1\Clus\DMVQSCORECODE.sas"
group=Clus
;
run;
quit;
