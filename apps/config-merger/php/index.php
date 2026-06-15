<?php
/*
 * Project Name: Config File Merge For Mangos/Trinity/AzerothCore Server
 * Date: 01.01.2010 inital version (0.0.1a)
 * Author: Paradox
 * Copyright: Paradox
 * Email: iamparadox@netscape.net (paypal email)
 * License: GNU General Public License v2(GPL)
 */
?>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<FORM enctype="multipart/form-data" ACTION="merge.php" METHOD="POST">
Dist File (.conf.dist)
<br />
<INPUT name="File1" TYPE="file">
<br />
<br />
Current Conf File (.conf)
<br />
<INPUT name="File2" TYPE="file">
<br />
<br />
<INPUT TYPE=RADIO NAME="eol" VALUE="0" CHECKED >Windows -
<INPUT TYPE=RADIO NAME="eol" VALUE="1"         >UNIX/Linux
<br />
<br />
<INPUT TYPE="submit" VALUE="Submit">
<br />
<br />
If you have any custom settings, such as from patches,
<br />
make sure they are at the bottom of the file following
<br />
this block (add it if it's not there)
<br />
###############################################################################
<br />
# Custom
<br />
###############################################################################
<br />
<br />

</FORM>
