*------------------------------------------------------------*;
* Reg2: Create decision matrix;
*------------------------------------------------------------*;
data WORK.audience_score_positive;
  length   audience_score_positive          $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="TRUE"
           DECISION2="FALSE"
           ;
  format   COUNT 10.
           ;
audience_score_positive="TRUE"; COUNT=1159; DATAPRIOR=0.47538966365873; TRAINPRIOR=0.47538966365873; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
audience_score_positive="FALSE"; COUNT=1279; DATAPRIOR=0.52461033634126; TRAINPRIOR=0.52461033634126; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify audience_score_positive(type=PROFIT label=audience_score_positive);
label DECISION1= 'TRUE';
label DECISION2= 'FALSE';
run;
quit;
data EM_DMREG / view=EM_DMREG;
set EMWS1.Drop_TRAIN(keep=
G IMP_markets_missing IMP_runtime IMP_ss_mean IMP_ss_std IMP_total_gross NC17
NR PG PG_13 R audience_score_positive genre_Action genre_Adventure
genre_AnimationManga genre_ArthouseInter genre_ClassicsCult genre_Comedy
genre_DramaTele genre_FamilyKids genre_Fantasy genre_FitnessSports
genre_HistDocument genre_Horror genre_MusicalPerfarts genre_Romance
genre_Sci_fi genre_Special_Interest genre_ThrillMysSusp genre_Western
tomatometer_count );
run;
*------------------------------------------------------------* ;
* Reg2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    G(ASC) IMP_markets_missing(ASC) NC17(ASC) NR(ASC) PG(ASC) PG_13(ASC) R(ASC)
   audience_score_positive(DESC) genre_Action(ASC) genre_Adventure(ASC)
   genre_AnimationManga(ASC) genre_ArthouseInter(ASC) genre_ClassicsCult(ASC)
   genre_Comedy(ASC) genre_DramaTele(ASC) genre_FamilyKids(ASC) genre_Fantasy(ASC)
   genre_FitnessSports(ASC) genre_HistDocument(ASC) genre_Horror(ASC)
   genre_MusicalPerfarts(ASC) genre_Romance(ASC) genre_Sci_fi(ASC)
   genre_Special_Interest(ASC) genre_ThrillMysSusp(ASC) genre_Western(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_runtime IMP_ss_mean IMP_ss_std IMP_total_gross tomatometer_count
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg2_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
audience_score_positive
;
run;
quit;
*------------------------------------------------------------*;
* Reg2: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg2_DMDB
validata = EMWS1.Drop_VALIDATE
outest = EMWS1.Reg2_EMESTIMATE
outterms = EMWS1.Reg2_OUTTERMS
outmap= EMWS1.Reg2_MAPDS namelen=200
;
class
audience_score_positive
G
IMP_markets_missing
NC17
NR
PG
PG_13
R
genre_Action
genre_Adventure
genre_AnimationManga
genre_ArthouseInter
genre_ClassicsCult
genre_Comedy
genre_DramaTele
genre_FamilyKids
genre_Fantasy
genre_FitnessSports
genre_HistDocument
genre_Horror
genre_MusicalPerfarts
genre_Romance
genre_Sci_fi
genre_Special_Interest
genre_ThrillMysSusp
genre_Western
;
model audience_score_positive =
G
IMP_markets_missing
IMP_runtime
IMP_ss_mean
IMP_ss_std
IMP_total_gross
NC17
NR
PG
PG_13
R
genre_Action
genre_Adventure
genre_AnimationManga
genre_ArthouseInter
genre_ClassicsCult
genre_Comedy
genre_DramaTele
genre_FamilyKids
genre_Fantasy
genre_FitnessSports
genre_HistDocument
genre_Horror
genre_MusicalPerfarts
genre_Romance
genre_Sci_fi
genre_Special_Interest
genre_ThrillMysSusp
genre_Western
tomatometer_count
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=VERROR
Hierarchy=CLASS
Rule=NONE
SlEntry=0.1
SlStay=0.1
Start=0
Stop=0
include=0
MaxStep=20
;
;
code file="C:\Users\yinyen\Desktop\DataMiningProject3\SASEM_Project\Workspaces\EMWS1\Reg2\EMPUBLISHSCORE.sas"
group=Reg2
;
code file="C:\Users\yinyen\Desktop\DataMiningProject3\SASEM_Project\Workspaces\EMWS1\Reg2\EMFLOWSCORE.sas"
group=Reg2
residual
;
run;
quit;
