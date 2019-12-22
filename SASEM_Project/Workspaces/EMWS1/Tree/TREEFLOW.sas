****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_audience_score_positive  $    5; 
LENGTH I_audience_score_positive  $    5; 
LENGTH U_audience_score_positive  $    5; 
LENGTH _WARN_  $    4; 

******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_audience_score_positiveTrue = 
'Predicted: audience_score_positive=True' ;
label P_audience_score_positiveFalse = 
'Predicted: audience_score_positive=False' ;
label Q_audience_score_positiveTrue = 
'Unadjusted P: audience_score_positive=True' ;
label Q_audience_score_positiveFalse = 
'Unadjusted P: audience_score_positive=False' ;
label V_audience_score_positiveTrue = 
'Validated: audience_score_positive=True' ;
label V_audience_score_positiveFalse = 
'Validated: audience_score_positive=False' ;
label R_audience_score_positiveTrue = 
'Residual: audience_score_positive=True' ;
label R_audience_score_positiveFalse = 
'Residual: audience_score_positive=False' ;
label F_audience_score_positive = 'From: audience_score_positive' ;
label I_audience_score_positive = 'Into: audience_score_positive' ;
label U_audience_score_positive = 
'Unnormalized Into: audience_score_positive' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_5 $      5; DROP _ARBFMT_5; 
_ARBFMT_5 = ' '; /* Initialize to avoid warning. */


_ARBFMT_5 = PUT( audience_score_positive , $5.);
 %DMNORMCP( _ARBFMT_5, F_audience_score_positive );

******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(IMP_ss_mean ) AND 
                  0.77 <= IMP_ss_mean  THEN DO;
  IF  NOT MISSING(tomatometer_count ) AND 
    tomatometer_count  <                   19 THEN DO;
    IF  NOT MISSING(IMP_user_rating_count ) AND 
                       390 <= IMP_user_rating_count  THEN DO;
      _NODE_  =                   74;
      _LEAF_  =                    5;
      P_audience_score_positiveTrue  =     0.72941176470588;
      P_audience_score_positiveFalse  =     0.27058823529411;
      Q_audience_score_positiveTrue  =     0.72941176470588;
      Q_audience_score_positiveFalse  =     0.27058823529411;
      V_audience_score_positiveTrue  =     0.65346534653465;
      V_audience_score_positiveFalse  =     0.34653465346534;
      I_audience_score_positive  = 'TRUE' ;
      U_audience_score_positive  = 'True' ;
      END;
    ELSE DO;
      _NODE_  =                   73;
      _LEAF_  =                    4;
      P_audience_score_positiveTrue  =     0.49632352941176;
      P_audience_score_positiveFalse  =     0.50367647058823;
      Q_audience_score_positiveTrue  =     0.49632352941176;
      Q_audience_score_positiveFalse  =     0.50367647058823;
      V_audience_score_positiveTrue  =     0.52669039145907;
      V_audience_score_positiveFalse  =     0.47330960854092;
      I_audience_score_positive  = 'FALSE' ;
      U_audience_score_positive  = 'False' ;
      END;
    END;
  ELSE DO;
    _NODE_  =                   62;
    _LEAF_  =                    6;
    P_audience_score_positiveTrue  =     0.80851063829787;
    P_audience_score_positiveFalse  =     0.19148936170212;
    Q_audience_score_positiveTrue  =     0.80851063829787;
    Q_audience_score_positiveFalse  =     0.19148936170212;
    V_audience_score_positiveTrue  =     0.77723577235772;
    V_audience_score_positiveFalse  =     0.22276422764227;
    I_audience_score_positive  = 'TRUE' ;
    U_audience_score_positive  = 'True' ;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(IMP_runtime ) AND 
                     102 <= IMP_runtime  THEN DO;
    IF  NOT MISSING(IMP_user_rating_count ) AND 
                    149650 <= IMP_user_rating_count  THEN DO;
      _NODE_  =                   87;
      _LEAF_  =                    3;
      P_audience_score_positiveTrue  =                    1;
      P_audience_score_positiveFalse  =                    0;
      Q_audience_score_positiveTrue  =                    1;
      Q_audience_score_positiveFalse  =                    0;
      V_audience_score_positiveTrue  =     0.76190476190476;
      V_audience_score_positiveFalse  =     0.23809523809523;
      I_audience_score_positive  = 'TRUE' ;
      U_audience_score_positive  = 'True' ;
      END;
    ELSE DO;
      _NODE_  =                   86;
      _LEAF_  =                    2;
      P_audience_score_positiveTrue  =           0.40234375;
      P_audience_score_positiveFalse  =           0.59765625;
      Q_audience_score_positiveTrue  =           0.40234375;
      Q_audience_score_positiveFalse  =           0.59765625;
      V_audience_score_positiveTrue  =      0.4090909090909;
      V_audience_score_positiveFalse  =     0.59090909090909;
      I_audience_score_positive  = 'FALSE' ;
      U_audience_score_positive  = 'False' ;
      END;
    END;
  ELSE DO;
    _NODE_  =                   84;
    _LEAF_  =                    1;
    P_audience_score_positiveTrue  =     0.23496659242761;
    P_audience_score_positiveFalse  =     0.76503340757238;
    Q_audience_score_positiveTrue  =     0.23496659242761;
    Q_audience_score_positiveFalse  =     0.76503340757238;
    V_audience_score_positiveTrue  =     0.26510067114093;
    V_audience_score_positiveFalse  =     0.73489932885906;
    I_audience_score_positive  = 'FALSE' ;
    U_audience_score_positive  = 'False' ;
    END;
  END;

*****  RESIDUALS R_ *************;
IF  F_audience_score_positive  NE 'TRUE' 
AND F_audience_score_positive  NE 'FALSE'  THEN DO; 
        R_audience_score_positiveTrue  = .;
        R_audience_score_positiveFalse  = .;
 END;
 ELSE DO;
       R_audience_score_positiveTrue  =  -P_audience_score_positiveTrue ;
       R_audience_score_positiveFalse  =  -P_audience_score_positiveFalse ;
       SELECT( F_audience_score_positive  );
          WHEN( 'TRUE'  ) R_audience_score_positiveTrue  = 
        R_audience_score_positiveTrue  +1;
          WHEN( 'FALSE'  ) R_audience_score_positiveFalse  = 
        R_audience_score_positiveFalse  +1;
       END;
 END;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

