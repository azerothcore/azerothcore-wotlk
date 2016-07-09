*----------------------*
||DBC Tool by TRX v2.7b||
*----------------------*

*-----------------*
Version 3.0 BETA! 
*-----------------*



Hello,

Here is the new version, but some stuff to be added is not there....  i only released this BETA to see if u guys find any bugs, so i can release a good working full version of 3.0....

Everything should work, i tested everything, but something may have slipped my fingers.... 

so here u go :

DBC Tool v3.0 BETA by TRX

So, here goes a list of functions that are in there :

- Open dbc file :D 
- Save dbc file :D 
- Edit Column types
- Clear the grid
- Notes window :D
- Hex to Decimal and Decimal to Hex Converter
- Copy Row
- Compare Rows (3 Options : Show entire rows in new grid, show only columns which have diffrent values in new grid, and show only columns which have same values in new window)
- Make DBC Tool default program to open dbc's (when u click on some dbc in explorer, it will open up in my tool....)
- Talent Editor (has some bugs allready, its not finished yet...)
- Import from DBC Patcher's format (working GREAT)
- Import from new patch format (looks like ini file)

- Added preset for 1.12.x spell.dbc, i simply parsed data from [url=http://www.sourcepeek.com/wiki/Spell.dbc]THIS[/url] site to definition ini.... so if its wrong dont blame me...

- Export to CSV
- Export to new patch format
- Export to DBC Patcher's format

NOTE : There is no longer that shity  Export queue, now u select rows by Shift + Left Click....
If you Shift + Click on some cell, it will select only that cell, but if u Shift + Click on spell ID it will select entire row!!

Things to add in final version :

- Compare DBC's
- Compare Patches
- Convert new patch format file to DBCPatcher's format file
- Convert DBCPatcher's format file to new patch format file
- More presets...
- And more, i can't remember now of more :(








*-------------*
Version 2.7b 
*-------------*
-Fixxed few minor bugs
-Added Talent Editor
-Added Import from DBC Patcher's format (can be used with params too: DBCTool /i [filetopatch] [patchfile])

Good thing about it is that it imports not only nubmers but text also,(unlike dbcpatcher who doesnt import text...)

there are two cases when u have text in row... one like this :
5:1=1,2=0,3=0,4=0,5=0,6=0,7=131072,8=67108864,9=0,10=0,11=0,12=0,13=0,14=0,15=0,16=1,17=0,18=0,19=0,20=0,21=0,22=0,23=101,24=0,25=0,26=0,27=0,28=0,29=0,30=0,31=0,32=0,33=0,34=6,35=0,36=0,37=0,38=0,39=0,40=0,41=0,42=0,43=0,44=0,45=0,46=0,47=0,48=0,49=0,50=0,51=0,52=0,53=0,54=0,55=0,56=-1,57=0,58=1,59=0,60=0,61=6,62=0,63=0,64=0,65=0,66=0,67=0,68=0,69=0,70=0,71=0,72=0,73=0,74=0,75=0,76=0,77=0,78=0,79=25,80=0,81=0,82=0,83=0,84=0,85=0,86=0,87=0,88=0,89=0,90=0,91=0,92=0,93=0,94=1065353216,95=0,96=0,97=0,98=0,99=0,100=0,101=0,102=0,103=0,104=0,105=0,106=0,107=0,108=0,109=0,110=0,111=0,112=0,113=0,114=1,115=0,116=50,117=Death Touch,118=0,119=0,120=0,121=0,122=0,123=0,124=0,125=2031678,126=,127=0,128=0,129=0,130=0,131=0,132=0,133=0,134=8323132,135=Instantly Kills the target.  I hope you feel good about yourself now.....,136=0,137=0,138=0,139=0,140=0,141=0,142=0,143=8323134,144=,145=0,146=0,147=0,148=0,149=0,150=0,151=0,152=2031676,153=0,154=0,155=0,156=0,157=0,158=0,159=0,160=0,161=0,162=-1,163=1,164=1,165=1,166=0,167=0,168=0,169=0

and one like this

17:1=1,2=56,3=0,4=1,5=19,6=329728,7=0,8=2621440,9=134217728,10=0,11=0,12=0,13=0,14=0,15=0,16=1,17=0,18=4000,19=8,20=0,21=0,22=0,23=101,24=0,25=11,26=6,27=6,28=9,29=0,30=45,31=0,32=0,33=0,34=5,35=0,36=0,37=0,38=0,39=0,40=0,41=0,42=0,43=0,44=0,45=0,46=0,47=0,48=0,49=0,50=0,51=0,52=0,53=0,54=0,55=0,56=-1,57=0,58=6,59=0,60=0,61=1,62=0,63=0,64=1,65=0,66=0,67=0,68=0,69=0,70=0.800000011920929,71=0,72=0,73=43,74=0,75=0,76=0,77=0,78=0,79=57,80=0,81=0,82=0,83=0,84=0,85=0,86=0,87=0,88=69,89=0,90=0,91=0,92=0,93=0,94=0,95=0,96=0,97=0,98=0,99=0,100=0,101=0,102=0,103=127,104=0,105=0,106=0,107=0,108=0,109=0,110=0,111=0,112=784,113=0,114=566,115=0,116=50,117=Power Word: Shield,118=0,119=0,120=0,121=0,122=0,123=0,124=0,125=2031678,126=Rank 1,127=0,128=0,129=0,130=0,131=0,132=0,133=0,134=2031678,135="Draws on the soul of the party member to shield them, absorbing $s1 damage.  Lasts $d.  While the shield holds, spellcasting will not be interrupted by damage.  Once shielded, the target cannot be shielded again for $6788d.",136=0,137=0,138=0,139=0,140=0,141=0,142=0,143=2031678,144=Absorbs damage.,145=0,146=0,147=0,148=0,149=0,150=0,151=0,152=2031678,153=0,154=133,155=1500,156=0,157=6,158=1,159=0,160=1,161=1,162=-1,163=1,164=1,165=1,166=0,167=0,168=0,169=0

u will notice that in case 2 there are two "text" thats because there is ',' in text...

so if u have ',' in spell text u need to put " at begining of text and at the end of text...

btw when u export using my tool, it automaticaly creates that, so u dont have to do it your self....

if anyone has any question, d6qwerty@yahoo.com (my mail...)