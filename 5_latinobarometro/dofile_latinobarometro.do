cd "C:\Users\d57917il\Documents\GitHub\Chapter2-PhDthesis\5_latinobarometro"

use Latinobarometro_2023_Esp_Stata_v1_0

tab P37STCS_C 
tab P37STCS_C if idenpa==484 // 484 is the code for Mexico


clear 

use Latinobarometro_2009_datos_esp_v2014_06_27

tab p67st_c
tab p67st_c if idenpa==484