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
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_5 = PUT( audience_score_positive , $5.);
 %DMNORMCP( _ARBFMT_5, F_audience_score_positive );
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(IMP_ss_p25 ) AND
                 0.875 <= IMP_ss_p25  THEN DO;
  IF  NOT MISSING(IMP_user_rating_count ) AND
    IMP_user_rating_count  <                  548 THEN DO;
    _ARBFMT_12 = PUT( genre_HistDocument , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('1' ) THEN DO;
      _NODE_  =                   11;
      _LEAF_  =                   10;
      P_audience_score_positiveTrue  =      0.6860465116279;
      P_audience_score_positiveFalse  =     0.31395348837209;
      Q_audience_score_positiveTrue  =      0.6860465116279;
      Q_audience_score_positiveFalse  =     0.31395348837209;
      V_audience_score_positiveTrue  =     0.67816091954022;
      V_audience_score_positiveFalse  =     0.32183908045977;
      I_audience_score_positive  = 'TRUE' ;
      U_audience_score_positive  = 'True' ;
      END;
    ELSE DO;
      _ARBFMT_12 = PUT( genre_Horror , BEST12.);
       %DMNORMIP( _ARBFMT_12);
      IF _ARBFMT_12 IN ('1' ) THEN DO;
        _NODE_  =                   18;
        _LEAF_  =                    8;
        P_audience_score_positiveTrue  =     0.23809523809523;
        P_audience_score_positiveFalse  =     0.76190476190476;
        Q_audience_score_positiveTrue  =     0.23809523809523;
        Q_audience_score_positiveFalse  =     0.76190476190476;
        V_audience_score_positiveTrue  =     0.17241379310344;
        V_audience_score_positiveFalse  =     0.82758620689655;
        I_audience_score_positive  = 'FALSE' ;
        U_audience_score_positive  = 'False' ;
        END;
      ELSE DO;
        _NODE_  =                   19;
        _LEAF_  =                    9;
        P_audience_score_positiveTrue  =     0.52727272727272;
        P_audience_score_positiveFalse  =     0.47272727272727;
        Q_audience_score_positiveTrue  =     0.52727272727272;
        Q_audience_score_positiveFalse  =     0.47272727272727;
        V_audience_score_positiveTrue  =     0.52059925093632;
        V_audience_score_positiveFalse  =     0.47940074906367;
        I_audience_score_positive  = 'TRUE' ;
        U_audience_score_positive  = 'True' ;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   11;
    P_audience_score_positiveTrue  =     0.80507131537242;
    P_audience_score_positiveFalse  =     0.19492868462757;
    Q_audience_score_positiveTrue  =     0.80507131537242;
    Q_audience_score_positiveFalse  =     0.19492868462757;
    V_audience_score_positiveTrue  =     0.80442176870748;
    V_audience_score_positiveFalse  =     0.19557823129251;
    I_audience_score_positive  = 'TRUE' ;
    U_audience_score_positive  = 'True' ;
    END;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( genre_HistDocument , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('1' ) THEN DO;
    _NODE_  =                    4;
    _LEAF_  =                    1;
    P_audience_score_positiveTrue  =     0.63157894736842;
    P_audience_score_positiveFalse  =     0.36842105263157;
    Q_audience_score_positiveTrue  =     0.63157894736842;
    Q_audience_score_positiveFalse  =     0.36842105263157;
    V_audience_score_positiveTrue  =     0.71428571428571;
    V_audience_score_positiveFalse  =     0.28571428571428;
    I_audience_score_positive  = 'TRUE' ;
    U_audience_score_positive  = 'True' ;
    END;
  ELSE DO;
    IF  NOT MISSING(IMP_runtime ) AND
               103.9140625 <= IMP_runtime  THEN DO;
      IF  NOT MISSING(IMP_ss_std ) AND
        IMP_ss_std  <     0.46179765923036 THEN DO;
        _ARBFMT_12 = PUT( NR , BEST12.);
         %DMNORMIP( _ARBFMT_12);
        IF _ARBFMT_12 IN ('1' ) THEN DO;
          _NODE_  =                   28;
          _LEAF_  =                    3;
          P_audience_score_positiveTrue  =     0.25925925925925;
          P_audience_score_positiveFalse  =     0.74074074074074;
          Q_audience_score_positiveTrue  =     0.25925925925925;
          Q_audience_score_positiveFalse  =     0.74074074074074;
          V_audience_score_positiveTrue  =     0.36842105263157;
          V_audience_score_positiveFalse  =     0.63157894736842;
          I_audience_score_positive  = 'FALSE' ;
          U_audience_score_positive  = 'False' ;
          END;
        ELSE DO;
          _NODE_  =                   29;
          _LEAF_  =                    4;
          P_audience_score_positiveTrue  =                 0.75;
          P_audience_score_positiveFalse  =                 0.25;
          Q_audience_score_positiveTrue  =                 0.75;
          Q_audience_score_positiveFalse  =                 0.25;
          V_audience_score_positiveTrue  =     0.60227272727272;
          V_audience_score_positiveFalse  =     0.39772727272727;
          I_audience_score_positive  = 'TRUE' ;
          U_audience_score_positive  = 'True' ;
          END;
        END;
      ELSE DO;
        _ARBFMT_12 = PUT( genre_DramaTele , BEST12.);
         %DMNORMIP( _ARBFMT_12);
        IF _ARBFMT_12 IN ('0' ) THEN DO;
          IF  NOT MISSING(IMP_ss_count ) AND
                             286 <= IMP_ss_count  THEN DO;
            _NODE_  =                   45;
            _LEAF_  =                    7;
            P_audience_score_positiveTrue  =                 0.75;
            P_audience_score_positiveFalse  =                 0.25;
            Q_audience_score_positiveTrue  =                 0.75;
            Q_audience_score_positiveFalse  =                 0.25;
            V_audience_score_positiveTrue  =     0.71428571428571;
            V_audience_score_positiveFalse  =     0.28571428571428;
            I_audience_score_positive  = 'TRUE' ;
            U_audience_score_positive  = 'True' ;
            END;
          ELSE DO;
            _NODE_  =                   44;
            _LEAF_  =                    6;
            P_audience_score_positiveTrue  =      0.1551724137931;
            P_audience_score_positiveFalse  =     0.84482758620689;
            Q_audience_score_positiveTrue  =      0.1551724137931;
            Q_audience_score_positiveFalse  =     0.84482758620689;
            V_audience_score_positiveTrue  =     0.30172413793103;
            V_audience_score_positiveFalse  =     0.69827586206896;
            I_audience_score_positive  = 'FALSE' ;
            U_audience_score_positive  = 'False' ;
            END;
          END;
        ELSE DO;
          _NODE_  =                   30;
          _LEAF_  =                    5;
          P_audience_score_positiveTrue  =     0.39487179487179;
          P_audience_score_positiveFalse  =      0.6051282051282;
          Q_audience_score_positiveTrue  =     0.39487179487179;
          Q_audience_score_positiveFalse  =      0.6051282051282;
          V_audience_score_positiveTrue  =     0.32710280373831;
          V_audience_score_positiveFalse  =     0.67289719626168;
          I_audience_score_positive  = 'FALSE' ;
          U_audience_score_positive  = 'False' ;
          END;
        END;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    2;
      P_audience_score_positiveTrue  =     0.18181818181818;
      P_audience_score_positiveFalse  =     0.81818181818181;
      Q_audience_score_positiveTrue  =     0.18181818181818;
      Q_audience_score_positiveFalse  =     0.81818181818181;
      V_audience_score_positiveTrue  =     0.20443349753694;
      V_audience_score_positiveFalse  =     0.79556650246305;
      I_audience_score_positive  = 'FALSE' ;
      U_audience_score_positive  = 'False' ;
      END;
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
 
drop _LEAF_;
