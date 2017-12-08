/* canonical correlation with sales data */
data sales;
input growth profit new create mech abs math;
datalines;
  93.0  96.0  97.8  9  12  9  20
  88.8  91.8  96.8  7  10  10  15
  95.0  100.3  99.0  8  12  9  26
  101.3  103.8  106.8  13  14  12  29
  102.0  107.8  103.0  10  15  12  32
  95.8  97.5  99.3  10  14  11  21
  95.5  99.5  99.0  9  12  9  25
  110.8  122.0  115.3  18  20  15  51
  102.8  108.3  103.8  10  17  13  31
  106.8  120.5  102.0  14  18  11  39
  103.3  109.8  104.0  12  17  12  32
  99.5  111.8  100.3  10  18  8  31
  103.5  112.5  107.0  16  17  11  34
  99.5  105.5  102.3  8  10  11  34
  100.0  107.0  102.8  13  10  8  34
  81.5  93.5  95.0  7  9  5  16
  101.3  105.3  102.8  11  12  11  32
  103.3  110.8  103.5  11  14  11  35
  95.3  104.3  103.0  5  14  13  30
  99.5  105.3  106.3  17  17  11  27
  88.5  95.3  95.8  10  12  7  15
  99.3  115.0  104.3  5  11  11  42
  87.5  92.5  95.8  9  9  7  16
  105.3  114.0  105.3  12  15  12  37
  107.0  121.0  109.0  16  19  12  39
  93.3  102.0  97.8  10  15  7  23
  106.8  118.0  107.3  14  16  12  39
  106.8  120.0  104.8  10  16  11  49
  92.3  90.8  99.8  8  10  13  17
  106.3  121.0  104.5  9  17  11  44
  106.0  119.5  110.5  18  15  10  43
  88.3  92.8  96.8  13  11  8  10
  96.0  103.3  100.5  7  15  11  27
  94.3  94.5  99.0  10  12  11  19
  106.5  121.5  110.5  18  17  10  42
  106.5  115.5  107.0  8  13  14  47
  92.0  99.5  103.5  18  16  8  18
  102.0  99.8  103.3  13  12  14  28
  108.3  122.3  108.5  15  19  12  41
  106.8  119.0  106.8  14  20  12  37
  102.5  109.3  103.8  9  17  13  32
  92.5  102.5  99.3  13  15  6  23
  102.8  113.8  106.8  17  20  10  32
  83.3  87.3  96.3  1  5  9  15
  94.8  101.8  99.8  7  16  11  24
  103.5  112.0  110.8  18  13  12  37
  89.5  96.0  97.3  7  15  11  14
  84.3  89.8  94.3  8  8  8  9
  104.3  109.5  106.5  14  12  12  36
  106.0  118.5  105.0  12  16  11  39
  ;
  run;
proc cancorr out = canout vprefix=sales vname="Sales Variables"
						  wprefix=scores wname="Test Scores";
var growth profit new;
with create mech abs math;
run;
/* plot the first canonical variate pair! */
/* v=J f=special specifices closed circles to plot data points*/
/* specifies a regression line be included in the plot */

proc gplot;
axis1 length=3 in;
axis2 length=4.5in;
plot sales1*scores1 /vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=r color=black;
run;
TITLE 'CANONICAL CORRELATION PLOT OF VARIATE PAIRS 2';
proc gplot;
axis1 length=3 in;
axis2 length=4.5in;
plot sales2*scores2 /vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=r color=black;
run;
/* CANONICAL CORRELATION PLOT OF VARIATE PAIRS 3 */
TITLE 'CANONICAL CORRELATION PLOT OF VARIATE PAIRS 3';
proc gplot;
axis1 length=3 in;
axis2 length=4.5in;
plot sales3*scores3 /vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=r color=black;
run;


proc glm;
CLASS species;
MODEL SEPALLEN SEPALWID PETALLEN PETALWID = species;
manova h = species/canonical;
run;
