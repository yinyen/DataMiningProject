*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_audience_score_positive $ 5;
label I_audience_score_positive = 'Into: audience_score_positive' ;
*** Target Values;
array REG2DRF [2] $5 _temporary_ ('TRUE' 'FALSE' );
label U_audience_score_positive = 
'Unnormalized Into: audience_score_positive' ;
format U_audience_score_positive $5.;
length U_audience_score_positive $ 5;
*** Unnormalized target values;
array REG2DRU[2] $ 5 _temporary_ ('True '  'False' );

drop _DM_BAD;
_DM_BAD=0;

*** Check IMP_runtime for missing values ;
if missing( IMP_runtime ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check IMP_ss_mean for missing values ;
if missing( IMP_ss_mean ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check tomatometer_count for missing values ;
if missing( tomatometer_count ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for R ;
drop _7_0 ;
if missing( R ) then do;
   _7_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( R , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _7_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _7_0 = -1;
   end;
   else do;
      _7_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for genre_AnimationManga ;
drop _10_0 ;
if missing( genre_AnimationManga ) then do;
   _10_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( genre_AnimationManga , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _10_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _10_0 = -1;
   end;
   else do;
      _10_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for genre_DramaTele ;
drop _14_0 ;
if missing( genre_DramaTele ) then do;
   _14_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( genre_DramaTele , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _14_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _14_0 = -1;
   end;
   else do;
      _14_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for genre_FitnessSports ;
drop _17_0 ;
if missing( genre_FitnessSports ) then do;
   _17_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( genre_FitnessSports , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _17_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _17_0 = -1;
   end;
   else do;
      _17_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for genre_HistDocument ;
drop _18_0 ;
if missing( genre_HistDocument ) then do;
   _18_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( genre_HistDocument , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _18_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _18_0 = -1;
   end;
   else do;
      _18_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for genre_Horror ;
drop _19_0 ;
if missing( genre_Horror ) then do;
   _19_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( genre_Horror , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _19_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _19_0 = -1;
   end;
   else do;
      _19_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for genre_Sci_fi ;
drop _22_0 ;
if missing( genre_Sci_fi ) then do;
   _22_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( genre_Sci_fi , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _22_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _22_0 = -1;
   end;
   else do;
      _22_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for genre_ThrillMysSusp ;
drop _24_0 ;
if missing( genre_ThrillMysSusp ) then do;
   _24_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( genre_ThrillMysSusp , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _24_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _24_0 = -1;
   end;
   else do;
      _24_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.4753896637;
   _P1 = 0.5246103363;
   goto REG2DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: IMP_runtime ;
_TEMP = IMP_runtime ;
_LP0 = _LP0 + (    0.01544285648813 * _TEMP);

***  Effect: IMP_ss_mean ;
_TEMP = IMP_ss_mean ;
_LP0 = _LP0 + (     5.1110060588214 * _TEMP);

***  Effect: R ;
_TEMP = 1;
_LP0 = _LP0 + (    0.20068489635027) * _TEMP * _7_0;

***  Effect: genre_AnimationManga ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.39987354449302) * _TEMP * _10_0;

***  Effect: genre_DramaTele ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.20910061918829) * _TEMP * _14_0;

***  Effect: genre_FitnessSports ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.91715651551748) * _TEMP * _17_0;

***  Effect: genre_HistDocument ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.59570098914074) * _TEMP * _18_0;

***  Effect: genre_Horror ;
_TEMP = 1;
_LP0 = _LP0 + (    0.22589336587767) * _TEMP * _19_0;

***  Effect: genre_Sci_fi ;
_TEMP = 1;
_LP0 = _LP0 + (    0.16871786277214) * _TEMP * _22_0;

***  Effect: genre_ThrillMysSusp ;
_TEMP = 1;
_LP0 = _LP0 + (    0.13771634058077) * _TEMP * _24_0;

***  Effect: tomatometer_count ;
_TEMP = tomatometer_count ;
_LP0 = _LP0 + (    0.00580919081027 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -4.50106198821231 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG2DR1:


*** Posterior Probabilities and Predicted Level;
label P_audience_score_positiveTrue = 
'Predicted: audience_score_positive=True' ;
label P_audience_score_positiveFalse = 
'Predicted: audience_score_positive=False' ;
P_audience_score_positiveTrue = _P0;
_MAXP = _P0;
_IY = 1;
P_audience_score_positiveFalse = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_audience_score_positive = REG2DRF[_IY];
U_audience_score_positive = REG2DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
