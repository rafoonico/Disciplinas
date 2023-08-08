clear all
set maxvar 30000 
set more off

global maindir "C:\Users\Adalto Althaus Jux\OneDrive - ufpr.br\Disciplinas-Docência\Econometria_Aplicada-UFPR_MestrProf-2023\Aula_1-BasicsOLS"


** Parte 1
use "$maindir\exemplo1.dta", clear

*graph tw scatter nota antes

summarize

reg nota antes
outreg2 using "$maindir\Resultados_exemplo.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, DESCARTAR) addtext(texto livre)

outreg2 using "$maindir\descritivas_exemplo.xls", ///
	replace sum(log) keep(nota antes apos)

reg nota apos
outreg2 using "$maindir\Resultados_exemplo.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, DESCARTAR) addtext(texto livre)	
	
reg nota antes apos
outreg2 using "$maindir\Resultados_exemplo.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, DESCARTAR) addtext(texto livre)

***********************************************************************************
** Parte 2
clear all
set maxvar 30000 
set more off

use "$maindir\exemplo2.dta", clear

reg  PIBPC ETOT
outreg2 using "$maindir\Resultados_exemplo2.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, item 1) addtext(texto livre)

reg  LNPIBPC ETOT
outreg2 using "$maindir\Resultados_exemplo2.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, item 2) addtext(texto livre)

reg   LNPIBPC1000 ETOT
outreg2 using "$maindir\Resultados_exemplo2.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, item 2) addtext(texto livre)

reg   LNPIBPC ETOT12
outreg2 using "$maindir\Resultados_exemplo2.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, item 2) addtext(texto livre)

reg   LNPIBPC ETOT ETOT12
outreg2 using "$maindir\Resultados_exemplo2.xls", ///
	append drop(_I*) nolabel nonotes bdec(3) tstat tdec(2) rdec(4) ///
	excel cttop(Modelo A, item 3) addtext(texto livre)
	



