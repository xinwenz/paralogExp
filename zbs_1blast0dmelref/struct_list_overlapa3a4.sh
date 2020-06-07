while read p ; do tmp=$(echo $p | cut -d" " -f4); grep $tmp a3AsRef/dmel6gen_a3.blast a4AsRef/dmel6gen_a4.blast  ;done < struct_list.bed2 > ans

