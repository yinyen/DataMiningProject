where
(
NAME in(
"IMP_domestic_gross"
"IMP_domestic_opening"
"IMP_foreign_gross"
"IMP_ss_count"
"IMP_ss_median"
"IMP_ss_p25"
"IMP_ss_p75"
"IMP_user_rating_count"
)
)
or
(ROLE ="REJECTED"
)
;
