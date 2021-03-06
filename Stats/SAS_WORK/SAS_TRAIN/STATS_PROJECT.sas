PROC IMPORT OUT = NBA
DATAFILE = '\\Client\C$\Users\patrickcorynichols\Desktop\nba2.csv'
DBMS = CSV REPLACE;
GETNAMES = YES;
DATAROW = 2;
RUN;

DATA NBA2;
SET NBA;
TWOPM = FGM-TPM;
TWOPA = FGA-TPA;
TWOPCT = TWOPM/TWOPA;
TWOPE = TWOPM*TWOPCT;
TPE = TPM*TPCT;
FGE = FGM*FGPCT;
int1 = AST*TPE;
GPACE = (FGA+TOV)/MIN;
IF conf = 'W' THEN conf2 = 1; ELSE conf2= 0;
RUN;

PROC CORR DATA = NBA2;
VAR PTS AST DREB OREB STL FTM TPE TWOPE FGE CONF2 GPACE PFD;
RUN;

PROC SGSCATTER DATA = NBA2;
MATRIX PTS AST DREB OREB STL  / GROUP = conf2;
RUN;

Symbol1 color=blue interpol=join line=1 value=dot; 
Symbol2 color=red interpol=join line=2 value=star;
PROC SGSCATTER DATA = NBA2;
PLOT PTS*W / GROUP = conf2;
LEGEND across = 1 down = 2;
RUN;

PROC GPLOT DATA = NBA2;
PLOT PTS*W / group = conf2;
RUN;

PROC SGSCATTER DATA = NBA2;
MATRIX PTS PFD;
RUN;

PROC REG DATA = NBA2;
MODEL PTS = TPE CONF2 AST FTM GPACE /  CLB CLM CLI R VIF;
RUN;

PROC REG DATA = NBA2;
MODEL PTS =  TPE CONF2 AST FTM GPACE DREB PFD /  VIF;
RUN;
QUIT;
