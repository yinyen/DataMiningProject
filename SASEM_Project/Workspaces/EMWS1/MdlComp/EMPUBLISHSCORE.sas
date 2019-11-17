drop _temp_;
if (P_audience_score_positiveTrue ge 0.80507131537242) then do;
_temp_ = dmran(1234);
b_audience_score_positive = floor(1 + 5*_temp_);
end;
else
if (P_audience_score_positiveTrue ge 0.6860465116279) then do;
_temp_ = dmran(1234);
b_audience_score_positive = floor(6 + 2*_temp_);
end;
else
if (P_audience_score_positiveTrue ge 0.63157894736842) then do;
b_audience_score_positive = 8;
end;
else
if (P_audience_score_positiveTrue ge 0.52727272727272) then do;
_temp_ = dmran(1234);
b_audience_score_positive = floor(9 + 2*_temp_);
end;
else
if (P_audience_score_positiveTrue ge 0.39487179487179) then do;
_temp_ = dmran(1234);
b_audience_score_positive = floor(11 + 2*_temp_);
end;
else
if (P_audience_score_positiveTrue ge 0.18181818181818) then do;
_temp_ = dmran(1234);
b_audience_score_positive = floor(13 + 7*_temp_);
end;
else
do;
b_audience_score_positive = 20;
end;
