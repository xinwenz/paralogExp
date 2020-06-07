awk 'BEGIN { while (getline < "./a3AsRef/fz_dmel6Pgen_a3_suz.list") f[$1] = $2 } {print $1,f[$1] }' sheet10.list> pgene50l_a3.list

awk 'BEGIN { while (getline < "./a4AsRef/fz_dmel6Pgen_a4_suz.list") f[$1] = $2 } {print $1,f[$1] }' sheet10.list> pgene50l_a4.list

awk 'BEGIN { while (getline < "./RefAsRef/fz_dmel6Pgen_ref_suz.list") f[$1] = $2 } {print $1,f[$1] }' sheet10.list> pgene50l_ref.list

