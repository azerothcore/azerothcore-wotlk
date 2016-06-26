<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" /> 

<xsl:template match="/">
	<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Sunwell Realm</title>
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Cache-Control" content="no-cache"/>
		<style type="text/css" media="screen">@import url(server_stats.css);</style>

	</head>
	<body>
		<center><div style="width: 98%;"><br />
		<xsl:apply-templates/>

		</div></center>
	</body>

	</html>
</xsl:template>



<xsl:template match="status">
	<table width="100%" border="0" cellspacing="1" cellpadding="3">
		<tr class="head"><th colspan="4">Sunwell Realm</th></tr>
		<tr>
			<th>Platform: </th><td><xsl:value-of select="platform"/></td>
			<th>Uptime: </th><td><xsl:value-of select="uptime"/></td>
		</tr>
		<tr>
			<th>Online Players: </th><td><xsl:value-of select="oplayers"/></td>
			<th>Queued Players: </th><td><xsl:value-of select="qplayers"/></td>
		</tr>
		<tr>
			<th>Average Latency: </th><td><xsl:value-of select="avglat"/> ms</td>
			<th>Last Update: </th><td><xsl:value-of select="lastupdate"/></td>

		</tr>
		<tr>

            <th>Alliance Online: </th><td><xsl:value-of select="alliance"/></td>
			<th>Horde Online: </th><td><xsl:value-of select="horde"/></td>
			
		</tr>
        <tr>
			<th>Connection Peak: </th><td><xsl:value-of select="peakcount"/></td>
        </tr>
	<xsl:apply-templates/>

	</table>
</xsl:template>

<xsl:template match="platform">
</xsl:template>
<xsl:template match="uptime">
</xsl:template>
<xsl:template match="oplayers">
</xsl:template>
<xsl:template match="qplayers">
</xsl:template>
<xsl:template match="avglat">
</xsl:template>

<xsl:template match="gmcount">
</xsl:template>
<xsl:template match="lastupdate">
</xsl:template>
<xsl:template match="alliance">
</xsl:template>
<xsl:template match="horde">
</xsl:template>
<xsl:template match="peakcount">
</xsl:template>


<xsl:template match="statsummary">
	<table cellspacing="0" cellpadding="0" border="0" style="border: 0;">
	<tr>
	<td valign="top">
		<table border="0" cellspacing="1" cellpadding="3">
		<tr class="head"><th colspan="4">Race Summary</th></tr>
		<tr>
			<th width="120px">Human: </th><td width="50px"><xsl:value-of select="human"/></td>
			<th width="120px">Orc: </th><td width="50px"><xsl:value-of select="orc"/></td>
		</tr>
		<tr>
			<th>Dwarf: </th><td><xsl:value-of select="dwarf"/></td>
			<th>Undead: </th><td><xsl:value-of select="undead"/></td>
		</tr>
		<tr>
			<th>Night Elf: </th><td><xsl:value-of select="nightelf"/></td>
			<th>Tauren: </th><td><xsl:value-of select="tauren"/></td>
		</tr>
		<tr>
			<th>Gnome: </th><td><xsl:value-of select="gnome"/></td>
			<th>Troll: </th><td><xsl:value-of select="troll"/></td>
		</tr>
		<tr>
			<th>Draenei: </th><td><xsl:value-of select="draenei"/></td>
			<th>Blood Elf: </th><td><xsl:value-of select="bloodelf"/></td>
		</tr>
		</table>
	</td>
	<td width="20px"></td>
	<td valign="top">
		<table border="0" cellspacing="1" cellpadding="3">
		<tr class="head"><th colspan="4">Class Summary</th></tr>
		<tr>
			<th width="120px">Warrior: </th><td width="50px"><xsl:value-of select="warrior"/></td>
			<th width="120px">Paladin: </th><td width="50px"><xsl:value-of select="paladin"/></td>
		</tr>
		<tr>
			<th>Hunter: </th><td><xsl:value-of select="hunter"/></td>
			<th>Rogue: </th><td><xsl:value-of select="rogue"/></td>
		</tr>
		<tr>
			<th>Priest: </th><td><xsl:value-of select="priest"/></td>
			<th>Shaman: </th><td><xsl:value-of select="shaman"/></td>
		</tr>
		<tr>
			<th>Mage: </th><td><xsl:value-of select="mage"/></td>
			<th>Druid: </th><td><xsl:value-of select="druid"/></td>
		</tr>
		<tr>
			<th>Warlock: </th><td><xsl:value-of select="warlock"/></td>
			<th>Death Knight: </th><td><xsl:value-of select="deathknight"/></td>
		</tr>
		</table>
	</td>
	</tr>

	<xsl:apply-templates/>

	</table>

</xsl:template>

<xsl:template match="instances">
	<table width="49%" border="0" cellspacing="1" cellpadding="2" style="float: right;">
		<tr class="head"><th colspan="9">Active instances</th></tr>
		<tr>
		<th>Map Name</th>
		<th>Map ID</th>
		<th>Active Players</th>
		<th>Instances Count</th>
		</tr>
	    <xsl:for-each select="info">
			<xsl:sort select="mapid" data-type="number" order="descending" />
				<tr>
					<td><b><xsl:value-of select="name"/></b></td>
					<td><xsl:value-of select="mapid"/></td>
					<td><xsl:value-of select="plrcount"/></td>
					<td><xsl:value-of select="maxcount"/></td>
				</tr>
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template match="battlegrounds">
	<table width="49%" border="0" cellspacing="1" cellpadding="2" style="float: left;">
		<tr class="head"><th colspan="9">Active battlegrounds</th></tr>
		<tr>
		<th>Map Name</th>
		<th>Active Players</th>
		</tr>
	    <xsl:for-each select="info">
			<xsl:sort select="mapid" data-type="number" order="descending" />
				<tr>
					<td><b><xsl:value-of select="name"/></b></td>
					<td><xsl:value-of select="plrcount"/></td>
				</tr>
		</xsl:for-each>
	</table>
</xsl:template>
			
<xsl:template match="human">
</xsl:template>
<xsl:template match="orc">
</xsl:template>
<xsl:template match="dwarf">
</xsl:template>
<xsl:template match="nightelf">
</xsl:template>
<xsl:template match="undead">
</xsl:template>
<xsl:template match="tauren">
</xsl:template>
<xsl:template match="gnome">
</xsl:template>
<xsl:template match="troll">
</xsl:template>
<xsl:template match="bloodelf">
</xsl:template>
<xsl:template match="draenei">
</xsl:template>

<xsl:template match="warrior">
</xsl:template>
<xsl:template match="paladin">
</xsl:template>
<xsl:template match="hunter">
</xsl:template>
<xsl:template match="rogue">
</xsl:template>
<xsl:template match="priest">
</xsl:template>
<xsl:template match="shaman">
</xsl:template>
<xsl:template match="mage">
</xsl:template>
<xsl:template match="druid">
</xsl:template>
<xsl:template match="warlock">
</xsl:template>
<xsl:template match="deathknight">
</xsl:template>


<xsl:template match="sessions">
<br style="clear: both;" />
	<table width="100%" border="0" cellspacing="1" cellpadding="2">
<tr class="head"><th colspan="9">Online Players</th></tr>
<tr>
<th width="19px"></th>
<th>Name</th>
<th>Race</th>
<th>Class</th>
<th>Level</th>
<th>Map</th>
<th>Zone</th>
<th>Latency</th>
</tr>

      <xsl:for-each select="plr">

      <xsl:sort select="level" data-type="number" order="descending" />
      <tr>
         <td><img src="pvp_icons/rank1.gif" /></td>
         <td><b><xsl:value-of select="name"/></b></td>
		 
          <td>
	       <xsl:choose>
               <xsl:when test="race = 1">Human</xsl:when>
               <xsl:when test="race = 2">Orc</xsl:when>
               <xsl:when test="race = 3">Dwarf</xsl:when>

               <xsl:when test="race = 4">Night Elf</xsl:when>
               <xsl:when test="race = 5">Undead</xsl:when>
               <xsl:when test="race = 6">Tauren</xsl:when>
               <xsl:when test="race = 7">Gnome</xsl:when>
               <xsl:when test="race = 8">Troll</xsl:when>
               <xsl:when test="race = 10">Blood Elf</xsl:when>

               <xsl:when test="race = 11">Draenei</xsl:when>
               
               </xsl:choose>
         </td>

         <td>
               <xsl:choose>
               <xsl:when test="class = 1">Warrior</xsl:when>
               <xsl:when test="class = 2">Paladin</xsl:when>

               <xsl:when test="class = 3">Hunter</xsl:when>
               <xsl:when test="class = 4">Rogue</xsl:when>
               <xsl:when test="class = 5">Priest</xsl:when>
			   <xsl:when test="class = 6">Death Knight</xsl:when>
               <xsl:when test="class = 7">Shaman</xsl:when>
               <xsl:when test="class = 8">Mage</xsl:when>
               <xsl:when test="class = 9">Warlock</xsl:when>

               <xsl:when test="class = 11">Druid</xsl:when>
               </xsl:choose>
         </td>
		 
         <td>
            <xsl:value-of select="level"/>
	     </td>

         <td>
			<xsl:choose>

<xsl:when test="map = 0">Eastern Kingdoms</xsl:when>
<xsl:when test="map = 1">Kalimdor</xsl:when>
<xsl:when test="map = 13">Testing</xsl:when>
<xsl:when test="map = 25">Scott Test</xsl:when>
<xsl:when test="map = 29">CashTest</xsl:when>
<xsl:when test="map = 30">Alterac Valley</xsl:when>
<xsl:when test="map = 33">Shadowfang Keep</xsl:when>
<xsl:when test="map = 34">Stormwind Stockade</xsl:when>
<xsl:when test="map = 35">StormwindPrison</xsl:when>
<xsl:when test="map = 36">Deadmines</xsl:when>
<xsl:when test="map = 37">Azshara Crater</xsl:when>
<xsl:when test="map = 42">Collin's Test</xsl:when>
<xsl:when test="map = 43">Wailing Caverns</xsl:when>
<xsl:when test="map = 44">Monastery</xsl:when>
<xsl:when test="map = 47">Razorfen Kraul</xsl:when>
<xsl:when test="map = 48">Blackfathom Deeps</xsl:when>
<xsl:when test="map = 70">Uldaman</xsl:when>
<xsl:when test="map = 90">Gnomeregan</xsl:when>
<xsl:when test="map = 109">Sunken Temple</xsl:when>
<xsl:when test="map = 129">Razorfen Downs</xsl:when>
<xsl:when test="map = 169">Emerald Dream</xsl:when>
<xsl:when test="map = 189">Scarlet Monastery</xsl:when>
<xsl:when test="map = 209">Zul'Farrak</xsl:when>
<xsl:when test="map = 229">Blackrock Spire</xsl:when>
<xsl:when test="map = 230">Blackrock Depths</xsl:when>
<xsl:when test="map = 249">Onyxia's Lair</xsl:when>
<xsl:when test="map = 269">Opening of the Dark Portal</xsl:when>
<xsl:when test="map = 289">Scholomance</xsl:when>
<xsl:when test="map = 309">Zul'Gurub</xsl:when>
<xsl:when test="map = 329">Stratholme</xsl:when>
<xsl:when test="map = 349">Maraudon</xsl:when>
<xsl:when test="map = 369">Deeprun Tram</xsl:when>
<xsl:when test="map = 389">Ragefire Chasm</xsl:when>
<xsl:when test="map = 409">Molten Core</xsl:when>
<xsl:when test="map = 429">Dire Maul</xsl:when>
<xsl:when test="map = 449">Alliance PVP Barracks</xsl:when>
<xsl:when test="map = 450">Horde PVP Barracks</xsl:when>
<xsl:when test="map = 451">Development Land</xsl:when>
<xsl:when test="map = 469">Blackwing Lair</xsl:when>
<xsl:when test="map = 489">Warsong Gulch</xsl:when>
<xsl:when test="map = 509">Ruins of Ahn'Qiraj</xsl:when>
<xsl:when test="map = 529">Arathi Basin</xsl:when>
<xsl:when test="map = 530">Outland</xsl:when>
<xsl:when test="map = 531">Ahn'Qiraj Temple</xsl:when>
<xsl:when test="map = 532">Karazhan</xsl:when>
<xsl:when test="map = 533">Naxxramas</xsl:when>
<xsl:when test="map = 534">The Battle for Mount Hyjal</xsl:when>
<xsl:when test="map = 540">Hellfire Citadel: The Shattered Halls</xsl:when>
<xsl:when test="map = 542">Hellfire Citadel: The Blood Furnace</xsl:when>
<xsl:when test="map = 543">Hellfire Citadel: Ramparts</xsl:when>
<xsl:when test="map = 544">Magtheridon's Lair</xsl:when>
<xsl:when test="map = 545">Coilfang: The Steamvault</xsl:when>
<xsl:when test="map = 546">Coilfang: The Underbog</xsl:when>
<xsl:when test="map = 547">Coilfang: The Slave Pens</xsl:when>
<xsl:when test="map = 548">Coilfang: Serpentshrine Cavern</xsl:when>
<xsl:when test="map = 550">Tempest Keep</xsl:when>
<xsl:when test="map = 552">Tempest Keep: The Arcatraz</xsl:when>
<xsl:when test="map = 553">Tempest Keep: The Botanica</xsl:when>
<xsl:when test="map = 554">Tempest Keep: The Mechanar</xsl:when>
<xsl:when test="map = 555">Auchindoun: Shadow Labyrinth</xsl:when>
<xsl:when test="map = 556">Auchindoun: Sethekk Halls</xsl:when>
<xsl:when test="map = 557">Auchindoun: Mana-Tombs</xsl:when>
<xsl:when test="map = 558">Auchindoun: Auchenai Crypts</xsl:when>
<xsl:when test="map = 559">Nagrand Arena</xsl:when>
<xsl:when test="map = 560">The Escape From Durnholde</xsl:when>
<xsl:when test="map = 562">Blade's Edge Arena</xsl:when>
<xsl:when test="map = 564">Black Temple</xsl:when>
<xsl:when test="map = 565">Gruul's Lair</xsl:when>
<xsl:when test="map = 566">Eye of the Storm</xsl:when>
<xsl:when test="map = 568">Zul'Aman</xsl:when>
<xsl:when test="map = 571">Northrend</xsl:when>
<xsl:when test="map = 572">Ruins of Lordaeron</xsl:when>
<xsl:when test="map = 573">ExteriorTest</xsl:when>
<xsl:when test="map = 574">Utgarde Keep</xsl:when>
<xsl:when test="map = 575">Utgarde Pinnacle</xsl:when>
<xsl:when test="map = 576">The Nexus</xsl:when>
<xsl:when test="map = 578">The Oculus</xsl:when>
<xsl:when test="map = 580">The Sunwell</xsl:when>
<xsl:when test="map = 582">Transport: Rut'theran to Auberdine</xsl:when>
<xsl:when test="map = 584">Transport: Menethil to Theramore</xsl:when>
<xsl:when test="map = 585">Magister's Terrace</xsl:when>
<xsl:when test="map = 586">Transport: Exodar to Auberdine</xsl:when>
<xsl:when test="map = 587">Transport: Feathermoon Ferry</xsl:when>
<xsl:when test="map = 588">Transport: Menethil to Auberdine</xsl:when>
<xsl:when test="map = 589">Transport: Orgrimmar to Grom'Gol</xsl:when>
<xsl:when test="map = 590">Transport: Grom'Gol to Undercity</xsl:when>
<xsl:when test="map = 591">Transport: Undercity to Orgrimmar</xsl:when>
<xsl:when test="map = 592">Transport: Borean Tundra Test</xsl:when>
<xsl:when test="map = 593">Transport: Booty Bay to Ratchet</xsl:when>
<xsl:when test="map = 594">Transport: Howling Fjord Sister Mercy (Quest)</xsl:when>
<xsl:when test="map = 595">The Culling of Stratholme</xsl:when>
<xsl:when test="map = 596">Transport: Naglfar</xsl:when>
<xsl:when test="map = 597">Craig Test</xsl:when>
<xsl:when test="map = 598">Sunwell Fix (Unused)</xsl:when>
<xsl:when test="map = 599">Halls of Stone</xsl:when>
<xsl:when test="map = 600">Drak'Tharon Keep</xsl:when>
<xsl:when test="map = 601">Azjol-Nerub</xsl:when>
<xsl:when test="map = 602">Halls of Lightning</xsl:when>
<xsl:when test="map = 603">Ulduar</xsl:when>
<xsl:when test="map = 604">Gundrak</xsl:when>
<xsl:when test="map = 605">Development Land (non-weighted textures)</xsl:when>
<xsl:when test="map = 606">QA and DVD</xsl:when>
<xsl:when test="map = 607">Strand of the Ancients</xsl:when>
<xsl:when test="map = 608">Violet Hold</xsl:when>
<xsl:when test="map = 609">Ebon Hold</xsl:when>
<xsl:when test="map = 610">Transport: Tirisfal to Vengeance Landing</xsl:when>
<xsl:when test="map = 612">Transport: Menethil to Valgarde</xsl:when>
<xsl:when test="map = 613">Transport: Orgrimmar to Warsong Hold</xsl:when>
<xsl:when test="map = 614">Transport: Stormwind to Valiance Keep</xsl:when>
<xsl:when test="map = 615">The Obsidian Sanctum</xsl:when>
<xsl:when test="map = 616">The Eye of Eternity</xsl:when>
<xsl:when test="map = 617">Dalaran Sewers</xsl:when>
<xsl:when test="map = 618">The Ring of Valor</xsl:when>
<xsl:when test="map = 619">Ahn'kahet: The Old Kingdom</xsl:when>
<xsl:when test="map = 620">Transport: Moa'ki to Unu'pe</xsl:when>
<xsl:when test="map = 621">Transport: Moa'ki to Kamagua</xsl:when>
<xsl:when test="map = 622">Transport: Orgrim's Hammer</xsl:when>
<xsl:when test="map = 623">Transport: The Skybreaker</xsl:when>
<xsl:when test="map = 624">Vault of Archavon</xsl:when>
<xsl:when test="map = 628">Isle of Conquest</xsl:when>
            </xsl:choose>
         </td>


         <td>
			<xsl:choose>
				<xsl:when test="areaid = 1">Dun Morogh</xsl:when>
				<xsl:when test="areaid = 2">Longshore</xsl:when>
				<xsl:when test="areaid = 3">Badlands</xsl:when>
				<xsl:when test="areaid = 4">Blasted Lands</xsl:when>
				<xsl:when test="areaid = 7">Blackwater Cove</xsl:when>
				<xsl:when test="areaid = 8">Swamp of Sorrows</xsl:when>
				<xsl:when test="areaid = 9">Northshire Valley</xsl:when>
				<xsl:when test="areaid = 10">Duskwood</xsl:when>
				<xsl:when test="areaid = 11">Wetlands</xsl:when>
				<xsl:when test="areaid = 12">Elwynn Forest</xsl:when>
				<xsl:when test="areaid = 13">The World Tree</xsl:when>
				<xsl:when test="areaid = 14">Durotar</xsl:when>
				<xsl:when test="areaid = 15">Dustwallow Marsh</xsl:when>
				<xsl:when test="areaid = 16">Azshara</xsl:when>
				<xsl:when test="areaid = 17">The Barrens</xsl:when>
				<xsl:when test="areaid = 18">Crystal Lake</xsl:when>
				<xsl:when test="areaid = 19">Zul'Gurub</xsl:when>
				<xsl:when test="areaid = 20">Moonbrook</xsl:when>
				<xsl:when test="areaid = 21">Kul Tiras</xsl:when>
				<xsl:when test="areaid = 22">Programmer Isle</xsl:when>
				<xsl:when test="areaid = 23">Northshire River</xsl:when>
				<xsl:when test="areaid = 24">Northshire Abbey</xsl:when>
				<xsl:when test="areaid = 25">Blackrock Mountain</xsl:when>
				<xsl:when test="areaid = 26">Lighthouse</xsl:when>
				<xsl:when test="areaid = 28">Western Plaguelands</xsl:when>
				<xsl:when test="areaid = 30">Nine</xsl:when>
				<xsl:when test="areaid = 32">The Cemetary</xsl:when>
				<xsl:when test="areaid = 33">Stranglethorn Vale</xsl:when>
				<xsl:when test="areaid = 34">Echo Ridge Mine</xsl:when>
				<xsl:when test="areaid = 35">Booty Bay</xsl:when>
				<xsl:when test="areaid = 36">Alterac Mountains</xsl:when>
				<xsl:when test="areaid = 37">Lake Nazferiti</xsl:when>
				<xsl:when test="areaid = 38">Loch Modan</xsl:when>
				<xsl:when test="areaid = 40">Westfall</xsl:when>
				<xsl:when test="areaid = 41">Deadwind Pass</xsl:when>
				<xsl:when test="areaid = 42">Darkshire</xsl:when>
				<xsl:when test="areaid = 43">Wild Shore</xsl:when>
				<xsl:when test="areaid = 44">Redridge Mountains</xsl:when>
				<xsl:when test="areaid = 45">Arathi Highlands</xsl:when>
				<xsl:when test="areaid = 46">Burning Steppes</xsl:when>
				<xsl:when test="areaid = 47">The Hinterlands</xsl:when>
				<xsl:when test="areaid = 49">Dead Man's Hole</xsl:when>
				<xsl:when test="areaid = 51">Searing Gorge</xsl:when>
				<xsl:when test="areaid = 53">Thieves Camp</xsl:when>
				<xsl:when test="areaid = 54">Jasperlode Mine</xsl:when>
				<xsl:when test="areaid = 55">Valley of Heroes UNUSED</xsl:when>
				<xsl:when test="areaid = 56">Heroes' Vigil</xsl:when>
				<xsl:when test="areaid = 57">Fargodeep Mine</xsl:when>
				<xsl:when test="areaid = 59">Northshire Vineyards</xsl:when>
				<xsl:when test="areaid = 60">Forest's Edge</xsl:when>
				<xsl:when test="areaid = 61">Thunder Falls</xsl:when>
				<xsl:when test="areaid = 62">Brackwell Pumpkin Patch</xsl:when>
				<xsl:when test="areaid = 63">The Stonefield Farm</xsl:when>
				<xsl:when test="areaid = 64">The Maclure Vineyards</xsl:when>
				<xsl:when test="areaid = 65">Dragonblight</xsl:when>
				<xsl:when test="areaid = 66">Zul'Drak</xsl:when>
				<xsl:when test="areaid = 67">The Storm Peaks</xsl:when>
				<xsl:when test="areaid = 68">Lake Everstill</xsl:when>
				<xsl:when test="areaid = 69">Lakeshire</xsl:when>
				<xsl:when test="areaid = 70">Stonewatch</xsl:when>
				<xsl:when test="areaid = 71">Stonewatch Falls</xsl:when>
				<xsl:when test="areaid = 72">The Dark Portal</xsl:when>
				<xsl:when test="areaid = 73">The Tainted Scar</xsl:when>
				<xsl:when test="areaid = 74">Pool of Tears</xsl:when>
				<xsl:when test="areaid = 75">Stonard</xsl:when>
				<xsl:when test="areaid = 76">Fallow Sanctuary</xsl:when>
				<xsl:when test="areaid = 77">Anvilmar</xsl:when>
				<xsl:when test="areaid = 80">Stormwind Mountains</xsl:when>
				<xsl:when test="areaid = 81">Jeff NE Quadrant Changed</xsl:when>
				<xsl:when test="areaid = 82">Jeff NW Quadrant</xsl:when>
				<xsl:when test="areaid = 83">Jeff SE Quadrant</xsl:when>
				<xsl:when test="areaid = 84">Jeff SW Quadrant</xsl:when>
				<xsl:when test="areaid = 85">Tirisfal Glades</xsl:when>
				<xsl:when test="areaid = 86">Stone Cairn Lake</xsl:when>
				<xsl:when test="areaid = 87">Goldshire</xsl:when>
				<xsl:when test="areaid = 88">Eastvale Logging Camp</xsl:when>
				<xsl:when test="areaid = 89">Mirror Lake Orchard</xsl:when>
				<xsl:when test="areaid = 91">Tower of Azora</xsl:when>
				<xsl:when test="areaid = 92">Mirror Lake</xsl:when>
				<xsl:when test="areaid = 93">Vul'Gol Ogre Mound</xsl:when>
				<xsl:when test="areaid = 94">Raven Hill</xsl:when>
				<xsl:when test="areaid = 95">Redridge Canyons</xsl:when>
				<xsl:when test="areaid = 96">Tower of Ilgalar</xsl:when>
				<xsl:when test="areaid = 97">Alther's Mill</xsl:when>
				<xsl:when test="areaid = 98">Rethban Caverns</xsl:when>
				<xsl:when test="areaid = 99">Rebel Camp</xsl:when>
				<xsl:when test="areaid = 100">Nesingwary's Expedition</xsl:when>
				<xsl:when test="areaid = 101">Kurzen's Compound</xsl:when>
				<xsl:when test="areaid = 102">Ruins of Zul'Kunda</xsl:when>
				<xsl:when test="areaid = 103">Ruins of Zul'Mamwe</xsl:when>
				<xsl:when test="areaid = 104">The Vile Reef</xsl:when>
				<xsl:when test="areaid = 105">Mosh'Ogg Ogre Mound</xsl:when>
				<xsl:when test="areaid = 106">The Stockpile</xsl:when>
				<xsl:when test="areaid = 107">Saldean's Farm</xsl:when>
				<xsl:when test="areaid = 108">Sentinel Hill</xsl:when>
				<xsl:when test="areaid = 109">Furlbrow's Pumpkin Farm</xsl:when>
				<xsl:when test="areaid = 111">Jangolode Mine</xsl:when>
				<xsl:when test="areaid = 113">Gold Coast Quarry</xsl:when>
				<xsl:when test="areaid = 115">Westfall Lighthouse</xsl:when>
				<xsl:when test="areaid = 116">Misty Valley</xsl:when>
				<xsl:when test="areaid = 117">Grom'gol Base Camp</xsl:when>
				<xsl:when test="areaid = 118">Whelgar's Excavation Site</xsl:when>
				<xsl:when test="areaid = 120">Westbrook Garrison</xsl:when>
				<xsl:when test="areaid = 121">Tranquil Gardens Cemetery</xsl:when>
				<xsl:when test="areaid = 122">Zuuldaia Ruins</xsl:when>
				<xsl:when test="areaid = 123">Bal'lal Ruins</xsl:when>
				<xsl:when test="areaid = 125">Kal'ai Ruins</xsl:when>
				<xsl:when test="areaid = 126">Tkashi Ruins</xsl:when>
				<xsl:when test="areaid = 127">Balia'mah Ruins</xsl:when>
				<xsl:when test="areaid = 128">Ziata'jai Ruins</xsl:when>
				<xsl:when test="areaid = 129">Mizjah Ruins</xsl:when>
				<xsl:when test="areaid = 130">Silverpine Forest</xsl:when>
				<xsl:when test="areaid = 131">Kharanos</xsl:when>
				<xsl:when test="areaid = 132">Coldridge Valley</xsl:when>
				<xsl:when test="areaid = 133">Gnomeregan</xsl:when>
				<xsl:when test="areaid = 134">Gol'Bolar Quarry</xsl:when>
				<xsl:when test="areaid = 135">Frostmane Hold</xsl:when>
				<xsl:when test="areaid = 136">The Grizzled Den</xsl:when>
				<xsl:when test="areaid = 137">Brewnall Village</xsl:when>
				<xsl:when test="areaid = 138">Misty Pine Refuge</xsl:when>
				<xsl:when test="areaid = 139">Eastern Plaguelands</xsl:when>
				<xsl:when test="areaid = 141">Teldrassil</xsl:when>
				<xsl:when test="areaid = 142">Ironband's Excavation Site</xsl:when>
				<xsl:when test="areaid = 143">Mo'grosh Stronghold</xsl:when>
				<xsl:when test="areaid = 144">Thelsamar</xsl:when>
				<xsl:when test="areaid = 145">Algaz Gate</xsl:when>
				<xsl:when test="areaid = 146">Stonewrought Dam</xsl:when>
				<xsl:when test="areaid = 147">The Farstrider Lodge</xsl:when>
				<xsl:when test="areaid = 148">Darkshore</xsl:when>
				<xsl:when test="areaid = 149">Silver Stream Mine</xsl:when>
				<xsl:when test="areaid = 150">Menethil Harbor</xsl:when>
				<xsl:when test="areaid = 151">Designer Island</xsl:when>
				<xsl:when test="areaid = 152">The Bulwark</xsl:when>
				<xsl:when test="areaid = 153">Ruins of Lordaeron</xsl:when>
				<xsl:when test="areaid = 154">Deathknell</xsl:when>
				<xsl:when test="areaid = 155">Night Web's Hollow</xsl:when>
				<xsl:when test="areaid = 156">Solliden Farmstead</xsl:when>
				<xsl:when test="areaid = 157">Agamand Mills</xsl:when>
				<xsl:when test="areaid = 158">Agamand Family Crypt</xsl:when>
				<xsl:when test="areaid = 159">Brill</xsl:when>
				<xsl:when test="areaid = 160">Whispering Gardens</xsl:when>
				<xsl:when test="areaid = 161">Terrace of Repose</xsl:when>
				<xsl:when test="areaid = 162">Brightwater Lake</xsl:when>
				<xsl:when test="areaid = 163">Gunther's Retreat</xsl:when>
				<xsl:when test="areaid = 164">Garren's Haunt</xsl:when>
				<xsl:when test="areaid = 165">Balnir Farmstead</xsl:when>
				<xsl:when test="areaid = 166">Cold Hearth Manor</xsl:when>
				<xsl:when test="areaid = 167">Crusader Outpost</xsl:when>
				<xsl:when test="areaid = 168">The North Coast</xsl:when>
				<xsl:when test="areaid = 169">Whispering Shore</xsl:when>
				<xsl:when test="areaid = 170">Lordamere Lake</xsl:when>
				<xsl:when test="areaid = 172">Fenris Isle</xsl:when>
				<xsl:when test="areaid = 173">Faol's Rest</xsl:when>
				<xsl:when test="areaid = 186">Dolanaar</xsl:when>
				<xsl:when test="areaid = 187">Darnassus UNUSED</xsl:when>
				<xsl:when test="areaid = 188">Shadowglen</xsl:when>
				<xsl:when test="areaid = 189">Steelgrill's Depot</xsl:when>
				<xsl:when test="areaid = 190">Hearthglen</xsl:when>
				<xsl:when test="areaid = 192">Northridge Lumber Camp</xsl:when>
				<xsl:when test="areaid = 193">Ruins of Andorhal</xsl:when>
				<xsl:when test="areaid = 195">School of Necromancy</xsl:when>
				<xsl:when test="areaid = 196">Uther's Tomb</xsl:when>
				<xsl:when test="areaid = 197">Sorrow Hill</xsl:when>
				<xsl:when test="areaid = 198">The Weeping Cave</xsl:when>
				<xsl:when test="areaid = 199">Felstone Field</xsl:when>
				<xsl:when test="areaid = 200">Dalson's Tears</xsl:when>
				<xsl:when test="areaid = 201">Gahrron's Withering</xsl:when>
				<xsl:when test="areaid = 202">The Writhing Haunt</xsl:when>
				<xsl:when test="areaid = 203">Mardenholde Keep</xsl:when>
				<xsl:when test="areaid = 204">Pyrewood Village</xsl:when>
				<xsl:when test="areaid = 205">Dun Modr</xsl:when>
				<xsl:when test="areaid = 206">Utgarde Keep</xsl:when>
				<xsl:when test="areaid = 207">The Great Sea</xsl:when>
				<xsl:when test="areaid = 208">Unused Ironcladcove</xsl:when>
				<xsl:when test="areaid = 209">Shadowfang Keep</xsl:when>
				<xsl:when test="areaid = 210">Icecrown</xsl:when>
				<xsl:when test="areaid = 211">Iceflow Lake</xsl:when>
				<xsl:when test="areaid = 212">Helm's Bed Lake</xsl:when>
				<xsl:when test="areaid = 213">Deep Elem Mine</xsl:when>
				<xsl:when test="areaid = 214">The Great Sea</xsl:when>
				<xsl:when test="areaid = 215">Mulgore</xsl:when>
				<xsl:when test="areaid = 219">Alexston Farmstead</xsl:when>
				<xsl:when test="areaid = 220">Red Cloud Mesa</xsl:when>
				<xsl:when test="areaid = 221">Camp Narache</xsl:when>
				<xsl:when test="areaid = 222">Bloodhoof Village</xsl:when>
				<xsl:when test="areaid = 223">Stonebull Lake</xsl:when>
				<xsl:when test="areaid = 224">Ravaged Caravan</xsl:when>
				<xsl:when test="areaid = 225">Red Rocks</xsl:when>
				<xsl:when test="areaid = 226">The Skittering Dark</xsl:when>
				<xsl:when test="areaid = 227">Valgan's Field</xsl:when>
				<xsl:when test="areaid = 228">The Sepulcher</xsl:when>
				<xsl:when test="areaid = 229">Olsen's Farthing</xsl:when>
				<xsl:when test="areaid = 230">The Greymane Wall</xsl:when>
				<xsl:when test="areaid = 231">Beren's Peril</xsl:when>
				<xsl:when test="areaid = 232">The Dawning Isles</xsl:when>
				<xsl:when test="areaid = 233">Ambermill</xsl:when>
				<xsl:when test="areaid = 235">Fenris Keep</xsl:when>
				<xsl:when test="areaid = 236">Shadowfang Keep</xsl:when>
				<xsl:when test="areaid = 237">The Decrepit Ferry</xsl:when>
				<xsl:when test="areaid = 238">Malden's Orchard</xsl:when>
				<xsl:when test="areaid = 239">The Ivar Patch</xsl:when>
				<xsl:when test="areaid = 240">The Dead Field</xsl:when>
				<xsl:when test="areaid = 241">The Rotting Orchard</xsl:when>
				<xsl:when test="areaid = 242">Brightwood Grove</xsl:when>
				<xsl:when test="areaid = 243">Forlorn Rowe</xsl:when>
				<xsl:when test="areaid = 244">The Whipple Estate</xsl:when>
				<xsl:when test="areaid = 245">The Yorgen Farmstead</xsl:when>
				<xsl:when test="areaid = 246">The Cauldron</xsl:when>
				<xsl:when test="areaid = 247">Grimesilt Dig Site</xsl:when>
				<xsl:when test="areaid = 249">Dreadmaul Rock</xsl:when>
				<xsl:when test="areaid = 250">Ruins of Thaurissan</xsl:when>
				<xsl:when test="areaid = 251">Flame Crest</xsl:when>
				<xsl:when test="areaid = 252">Blackrock Stronghold</xsl:when>
				<xsl:when test="areaid = 253">The Pillar of Ash</xsl:when>
				<xsl:when test="areaid = 254">Blackrock Mountain</xsl:when>
				<xsl:when test="areaid = 255">Altar of Storms</xsl:when>
				<xsl:when test="areaid = 256">Aldrassil</xsl:when>
				<xsl:when test="areaid = 257">Shadowthread Cave</xsl:when>
				<xsl:when test="areaid = 258">Fel Rock</xsl:when>
				<xsl:when test="areaid = 259">Lake Al'Ameth</xsl:when>
				<xsl:when test="areaid = 260">Starbreeze Village</xsl:when>
				<xsl:when test="areaid = 261">Gnarlpine Hold</xsl:when>
				<xsl:when test="areaid = 262">Ban'ethil Barrow Den</xsl:when>
				<xsl:when test="areaid = 263">The Cleft</xsl:when>
				<xsl:when test="areaid = 264">The Oracle Glade</xsl:when>
				<xsl:when test="areaid = 265">Wellspring River</xsl:when>
				<xsl:when test="areaid = 266">Wellspring Lake</xsl:when>
				<xsl:when test="areaid = 267">Hillsbrad Foothills</xsl:when>
				<xsl:when test="areaid = 268">Azshara Crater</xsl:when>
				<xsl:when test="areaid = 269">Dun Algaz</xsl:when>
				<xsl:when test="areaid = 271">Southshore</xsl:when>
				<xsl:when test="areaid = 272">Tarren Mill</xsl:when>
				<xsl:when test="areaid = 275">Durnholde Keep</xsl:when>
				<xsl:when test="areaid = 276">UNUSED Stonewrought Pass</xsl:when>
				<xsl:when test="areaid = 277">The Foothill Caverns</xsl:when>
				<xsl:when test="areaid = 278">Lordamere Internment Camp</xsl:when>
				<xsl:when test="areaid = 279">Dalaran Crater</xsl:when>
				<xsl:when test="areaid = 280">Strahnbrad</xsl:when>
				<xsl:when test="areaid = 281">Ruins of Alterac</xsl:when>
				<xsl:when test="areaid = 282">Crushridge Hold</xsl:when>
				<xsl:when test="areaid = 283">Slaughter Hollow</xsl:when>
				<xsl:when test="areaid = 284">The Uplands</xsl:when>
				<xsl:when test="areaid = 285">Southpoint Tower</xsl:when>
				<xsl:when test="areaid = 286">Hillsbrad Fields</xsl:when>
				<xsl:when test="areaid = 287">Hillsbrad</xsl:when>
				<xsl:when test="areaid = 288">Azurelode Mine</xsl:when>
				<xsl:when test="areaid = 289">Nethander Stead</xsl:when>
				<xsl:when test="areaid = 290">Dun Garok</xsl:when>
				<xsl:when test="areaid = 293">Thoradin's Wall</xsl:when>
				<xsl:when test="areaid = 294">Eastern Strand</xsl:when>
				<xsl:when test="areaid = 295">Western Strand</xsl:when>
				<xsl:when test="areaid = 296">South Seas UNUSED</xsl:when>
				<xsl:when test="areaid = 297">Jaguero Isle</xsl:when>
				<xsl:when test="areaid = 298">Baradin Bay</xsl:when>
				<xsl:when test="areaid = 299">Menethil Bay</xsl:when>
				<xsl:when test="areaid = 300">Misty Reed Strand</xsl:when>
				<xsl:when test="areaid = 301">The Savage Coast</xsl:when>
				<xsl:when test="areaid = 302">The Crystal Shore</xsl:when>
				<xsl:when test="areaid = 303">Shell Beach</xsl:when>
				<xsl:when test="areaid = 305">North Tide's Run</xsl:when>
				<xsl:when test="areaid = 306">South Tide's Run</xsl:when>
				<xsl:when test="areaid = 307">The Overlook Cliffs</xsl:when>
				<xsl:when test="areaid = 308">The Forbidding Sea</xsl:when>
				<xsl:when test="areaid = 309">Ironbeard's Tomb</xsl:when>
				<xsl:when test="areaid = 310">Crystalvein Mine</xsl:when>
				<xsl:when test="areaid = 311">Ruins of Aboraz</xsl:when>
				<xsl:when test="areaid = 312">Janeiro's Point</xsl:when>
				<xsl:when test="areaid = 313">Northfold Manor</xsl:when>
				<xsl:when test="areaid = 314">Go'Shek Farm</xsl:when>
				<xsl:when test="areaid = 315">Dabyrie's Farmstead</xsl:when>
				<xsl:when test="areaid = 316">Boulderfist Hall</xsl:when>
				<xsl:when test="areaid = 317">Witherbark Village</xsl:when>
				<xsl:when test="areaid = 318">Drywhisker Gorge</xsl:when>
				<xsl:when test="areaid = 320">Refuge Pointe</xsl:when>
				<xsl:when test="areaid = 321">Hammerfall</xsl:when>
				<xsl:when test="areaid = 322">Blackwater Shipwrecks</xsl:when>
				<xsl:when test="areaid = 323">O'Breen's Camp</xsl:when>
				<xsl:when test="areaid = 324">Stromgarde Keep</xsl:when>
				<xsl:when test="areaid = 325">The Tower of Arathor</xsl:when>
				<xsl:when test="areaid = 326">The Sanctum</xsl:when>
				<xsl:when test="areaid = 327">Faldir's Cove</xsl:when>
				<xsl:when test="areaid = 328">The Drowned Reef</xsl:when>
				<xsl:when test="areaid = 330">Thandol Span</xsl:when>
				<xsl:when test="areaid = 331">Ashenvale</xsl:when>
				<xsl:when test="areaid = 332">The Great Sea</xsl:when>
				<xsl:when test="areaid = 333">Circle of East Binding</xsl:when>
				<xsl:when test="areaid = 334">Circle of West Binding</xsl:when>
				<xsl:when test="areaid = 335">Circle of Inner Binding</xsl:when>
				<xsl:when test="areaid = 336">Circle of Outer Binding</xsl:when>
				<xsl:when test="areaid = 337">Apocryphan's Rest</xsl:when>
				<xsl:when test="areaid = 338">Angor Fortress</xsl:when>
				<xsl:when test="areaid = 339">Lethlor Ravine</xsl:when>
				<xsl:when test="areaid = 340">Kargath</xsl:when>
				<xsl:when test="areaid = 341">Camp Kosh</xsl:when>
				<xsl:when test="areaid = 342">Camp Boff</xsl:when>
				<xsl:when test="areaid = 343">Camp Wurg</xsl:when>
				<xsl:when test="areaid = 344">Camp Cagg</xsl:when>
				<xsl:when test="areaid = 345">Agmond's End</xsl:when>
				<xsl:when test="areaid = 346">Hammertoe's Digsite</xsl:when>
				<xsl:when test="areaid = 347">Dustbelch Grotto</xsl:when>
				<xsl:when test="areaid = 348">Aerie Peak</xsl:when>
				<xsl:when test="areaid = 349">Wildhammer Keep</xsl:when>
				<xsl:when test="areaid = 350">Quel'Danil Lodge</xsl:when>
				<xsl:when test="areaid = 351">Skulk Rock</xsl:when>
				<xsl:when test="areaid = 352">Zun'watha</xsl:when>
				<xsl:when test="areaid = 353">Shadra'Alor</xsl:when>
				<xsl:when test="areaid = 354">Jintha'Alor</xsl:when>
				<xsl:when test="areaid = 355">The Altar of Zul</xsl:when>
				<xsl:when test="areaid = 356">Seradane</xsl:when>
				<xsl:when test="areaid = 357">Feralas</xsl:when>
				<xsl:when test="areaid = 358">Brambleblade Ravine</xsl:when>
				<xsl:when test="areaid = 359">Bael Modan</xsl:when>
				<xsl:when test="areaid = 360">The Venture Co. Mine</xsl:when>
				<xsl:when test="areaid = 361">Felwood</xsl:when>
				<xsl:when test="areaid = 362">Razor Hill</xsl:when>
				<xsl:when test="areaid = 363">Valley of Trials</xsl:when>
				<xsl:when test="areaid = 364">The Den</xsl:when>
				<xsl:when test="areaid = 365">Burning Blade Coven</xsl:when>
				<xsl:when test="areaid = 366">Kolkar Crag</xsl:when>
				<xsl:when test="areaid = 367">Sen'jin Village</xsl:when>
				<xsl:when test="areaid = 368">Echo Isles</xsl:when>
				<xsl:when test="areaid = 369">Thunder Ridge</xsl:when>
				<xsl:when test="areaid = 370">Drygulch Ravine</xsl:when>
				<xsl:when test="areaid = 371">Dustwind Cave</xsl:when>
				<xsl:when test="areaid = 372">Tiragarde Keep</xsl:when>
				<xsl:when test="areaid = 373">Scuttle Coast</xsl:when>
				<xsl:when test="areaid = 374">Bladefist Bay</xsl:when>
				<xsl:when test="areaid = 375">Deadeye Shore</xsl:when>
				<xsl:when test="areaid = 377">Southfury River</xsl:when>
				<xsl:when test="areaid = 378">Camp Taurajo</xsl:when>
				<xsl:when test="areaid = 379">Far Watch Post</xsl:when>
				<xsl:when test="areaid = 380">The Crossroads</xsl:when>
				<xsl:when test="areaid = 381">Boulder Lode Mine</xsl:when>
				<xsl:when test="areaid = 382">The Sludge Fen</xsl:when>
				<xsl:when test="areaid = 383">The Dry Hills</xsl:when>
				<xsl:when test="areaid = 384">Dreadmist Peak</xsl:when>
				<xsl:when test="areaid = 385">Northwatch Hold</xsl:when>
				<xsl:when test="areaid = 386">The Forgotten Pools</xsl:when>
				<xsl:when test="areaid = 387">Lushwater Oasis</xsl:when>
				<xsl:when test="areaid = 388">The Stagnant Oasis</xsl:when>
				<xsl:when test="areaid = 390">Field of Giants</xsl:when>
				<xsl:when test="areaid = 391">The Merchant Coast</xsl:when>
				<xsl:when test="areaid = 392">Ratchet</xsl:when>
				<xsl:when test="areaid = 393">Darkspear Strand</xsl:when>
				<xsl:when test="areaid = 394">Grizzly Hills</xsl:when>
				<xsl:when test="areaid = 395">Grizzlemaw</xsl:when>
				<xsl:when test="areaid = 396">Winterhoof Water Well</xsl:when>
				<xsl:when test="areaid = 397">Thunderhorn Water Well</xsl:when>
				<xsl:when test="areaid = 398">Wildmane Water Well</xsl:when>
				<xsl:when test="areaid = 399">Skyline Ridge</xsl:when>
				<xsl:when test="areaid = 400">Thousand Needles</xsl:when>
				<xsl:when test="areaid = 401">The Tidus Stair</xsl:when>
				<xsl:when test="areaid = 403">Shady Rest Inn</xsl:when>
				<xsl:when test="areaid = 404">Bael'dun Digsite</xsl:when>
				<xsl:when test="areaid = 405">Desolace</xsl:when>
				<xsl:when test="areaid = 406">Stonetalon Mountains</xsl:when>
				<xsl:when test="areaid = 407">Orgrimmar UNUSED</xsl:when>
				<xsl:when test="areaid = 408">Gillijim's Isle</xsl:when>
				<xsl:when test="areaid = 409">Island of Doctor Lapidis</xsl:when>
				<xsl:when test="areaid = 410">Razorwind Canyon</xsl:when>
				<xsl:when test="areaid = 411">Bathran's Haunt</xsl:when>
				<xsl:when test="areaid = 412">The Ruins of Ordil'Aran</xsl:when>
				<xsl:when test="areaid = 413">Maestra's Post</xsl:when>
				<xsl:when test="areaid = 414">The Zoram Strand</xsl:when>
				<xsl:when test="areaid = 415">Astranaar</xsl:when>
				<xsl:when test="areaid = 416">The Shrine of Aessina</xsl:when>
				<xsl:when test="areaid = 417">Fire Scar Shrine</xsl:when>
				<xsl:when test="areaid = 418">The Ruins of Stardust</xsl:when>
				<xsl:when test="areaid = 419">The Howling Vale</xsl:when>
				<xsl:when test="areaid = 420">Silverwind Refuge</xsl:when>
				<xsl:when test="areaid = 421">Mystral Lake</xsl:when>
				<xsl:when test="areaid = 422">Fallen Sky Lake</xsl:when>
				<xsl:when test="areaid = 424">Iris Lake</xsl:when>
				<xsl:when test="areaid = 425">Moonwell</xsl:when>
				<xsl:when test="areaid = 426">Raynewood Retreat</xsl:when>
				<xsl:when test="areaid = 427">The Shady Nook</xsl:when>
				<xsl:when test="areaid = 428">Night Run</xsl:when>
				<xsl:when test="areaid = 429">Xavian</xsl:when>
				<xsl:when test="areaid = 430">Satyrnaar</xsl:when>
				<xsl:when test="areaid = 431">Splintertree Post</xsl:when>
				<xsl:when test="areaid = 432">The Dor'Danil Barrow Den</xsl:when>
				<xsl:when test="areaid = 433">Falfarren River</xsl:when>
				<xsl:when test="areaid = 434">Felfire Hill</xsl:when>
				<xsl:when test="areaid = 435">Demon Fall Canyon</xsl:when>
				<xsl:when test="areaid = 436">Demon Fall Ridge</xsl:when>
				<xsl:when test="areaid = 437">Warsong Lumber Camp</xsl:when>
				<xsl:when test="areaid = 438">Bough Shadow</xsl:when>
				<xsl:when test="areaid = 439">The Shimmering Flats</xsl:when>
				<xsl:when test="areaid = 440">Tanaris</xsl:when>
				<xsl:when test="areaid = 441">Lake Falathim</xsl:when>
				<xsl:when test="areaid = 442">Auberdine</xsl:when>
				<xsl:when test="areaid = 443">Ruins of Mathystra</xsl:when>
				<xsl:when test="areaid = 444">Tower of Althalaxx</xsl:when>
				<xsl:when test="areaid = 445">Cliffspring Falls</xsl:when>
				<xsl:when test="areaid = 446">Bashal'Aran</xsl:when>
				<xsl:when test="areaid = 447">Ameth'Aran</xsl:when>
				<xsl:when test="areaid = 448">Grove of the Ancients</xsl:when>
				<xsl:when test="areaid = 449">The Master's Glaive</xsl:when>
				<xsl:when test="areaid = 450">Remtravel's Excavation</xsl:when>
				<xsl:when test="areaid = 452">Mist's Edge</xsl:when>
				<xsl:when test="areaid = 453">The Long Wash</xsl:when>
				<xsl:when test="areaid = 454">Wildbend River</xsl:when>
				<xsl:when test="areaid = 455">Blackwood Den</xsl:when>
				<xsl:when test="areaid = 456">Cliffspring River</xsl:when>
				<xsl:when test="areaid = 457">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 458">Gold Road</xsl:when>
				<xsl:when test="areaid = 459">Scarlet Watch Post</xsl:when>
				<xsl:when test="areaid = 460">Sun Rock Retreat</xsl:when>
				<xsl:when test="areaid = 461">Windshear Crag</xsl:when>
				<xsl:when test="areaid = 463">Cragpool Lake</xsl:when>
				<xsl:when test="areaid = 464">Mirkfallon Lake</xsl:when>
				<xsl:when test="areaid = 465">The Charred Vale</xsl:when>
				<xsl:when test="areaid = 466">Valley of the Bloodfuries</xsl:when>
				<xsl:when test="areaid = 467">Stonetalon Peak</xsl:when>
				<xsl:when test="areaid = 468">The Talon Den</xsl:when>
				<xsl:when test="areaid = 469">Greatwood Vale</xsl:when>
				<xsl:when test="areaid = 470">Thunder Bluff UNUSED</xsl:when>
				<xsl:when test="areaid = 471">Brave Wind Mesa</xsl:when>
				<xsl:when test="areaid = 472">Fire Stone Mesa</xsl:when>
				<xsl:when test="areaid = 473">Mantle Rock</xsl:when>
				<xsl:when test="areaid = 474">Hunter Rise UNUSED</xsl:when>
				<xsl:when test="areaid = 475">Spirit RiseUNUSED</xsl:when>
				<xsl:when test="areaid = 476">Elder RiseUNUSED</xsl:when>
				<xsl:when test="areaid = 477">Ruins of Jubuwal</xsl:when>
				<xsl:when test="areaid = 478">Pools of Arlithrien</xsl:when>
				<xsl:when test="areaid = 479">The Rustmaul Dig Site</xsl:when>
				<xsl:when test="areaid = 480">Camp E'thok</xsl:when>
				<xsl:when test="areaid = 481">Splithoof Crag</xsl:when>
				<xsl:when test="areaid = 482">Highperch</xsl:when>
				<xsl:when test="areaid = 483">The Screeching Canyon</xsl:when>
				<xsl:when test="areaid = 484">Freewind Post</xsl:when>
				<xsl:when test="areaid = 485">The Great Lift</xsl:when>
				<xsl:when test="areaid = 486">Galak Hold</xsl:when>
				<xsl:when test="areaid = 487">Roguefeather Den</xsl:when>
				<xsl:when test="areaid = 488">The Weathered Nook</xsl:when>
				<xsl:when test="areaid = 489">Thalanaar</xsl:when>
				<xsl:when test="areaid = 490">Un'Goro Crater</xsl:when>
				<xsl:when test="areaid = 491">Razorfen Kraul</xsl:when>
				<xsl:when test="areaid = 492">Raven Hill Cemetery</xsl:when>
				<xsl:when test="areaid = 493">Moonglade</xsl:when>
				<xsl:when test="areaid = 495">Howling Fjord</xsl:when>
				<xsl:when test="areaid = 496">Brackenwall Village</xsl:when>
				<xsl:when test="areaid = 497">Swamplight Manor</xsl:when>
				<xsl:when test="areaid = 498">Bloodfen Burrow</xsl:when>
				<xsl:when test="areaid = 499">Darkmist Cavern</xsl:when>
				<xsl:when test="areaid = 500">Moggle Point</xsl:when>
				<xsl:when test="areaid = 501">Beezil's Wreck</xsl:when>
				<xsl:when test="areaid = 502">Witch Hill</xsl:when>
				<xsl:when test="areaid = 503">Sentry Point</xsl:when>
				<xsl:when test="areaid = 504">North Point Tower</xsl:when>
				<xsl:when test="areaid = 505">West Point Tower</xsl:when>
				<xsl:when test="areaid = 506">Lost Point</xsl:when>
				<xsl:when test="areaid = 507">Bluefen</xsl:when>
				<xsl:when test="areaid = 508">Stonemaul Ruins</xsl:when>
				<xsl:when test="areaid = 509">The Den of Flame</xsl:when>
				<xsl:when test="areaid = 510">The Dragonmurk</xsl:when>
				<xsl:when test="areaid = 511">Wyrmbog</xsl:when>
				<xsl:when test="areaid = 512">Blackhoof Village</xsl:when>
				<xsl:when test="areaid = 513">Theramore Isle</xsl:when>
				<xsl:when test="areaid = 514">Foothold Citadel</xsl:when>
				<xsl:when test="areaid = 515">Ironclad Prison</xsl:when>
				<xsl:when test="areaid = 516">Dustwallow Bay</xsl:when>
				<xsl:when test="areaid = 517">Tidefury Cove</xsl:when>
				<xsl:when test="areaid = 518">Dreadmurk Shore</xsl:when>
				<xsl:when test="areaid = 536">Addle's Stead</xsl:when>
				<xsl:when test="areaid = 537">Fire Plume Ridge</xsl:when>
				<xsl:when test="areaid = 538">Lakkari Tar Pits</xsl:when>
				<xsl:when test="areaid = 539">Terror Run</xsl:when>
				<xsl:when test="areaid = 540">The Slithering Scar</xsl:when>
				<xsl:when test="areaid = 541">Marshal's Refuge</xsl:when>
				<xsl:when test="areaid = 542">Fungal Rock</xsl:when>
				<xsl:when test="areaid = 543">Golakka Hot Springs</xsl:when>
				<xsl:when test="areaid = 556">The Loch</xsl:when>
				<xsl:when test="areaid = 576">Beggar's Haunt</xsl:when>
				<xsl:when test="areaid = 596">Kodo Graveyard</xsl:when>
				<xsl:when test="areaid = 597">Ghost Walker Post</xsl:when>
				<xsl:when test="areaid = 598">Sar'theris Strand</xsl:when>
				<xsl:when test="areaid = 599">Thunder Axe Fortress</xsl:when>
				<xsl:when test="areaid = 600">Bolgan's Hole</xsl:when>
				<xsl:when test="areaid = 602">Mannoroc Coven</xsl:when>
				<xsl:when test="areaid = 603">Sargeron</xsl:when>
				<xsl:when test="areaid = 604">Magram Village</xsl:when>
				<xsl:when test="areaid = 606">Gelkis Village</xsl:when>
				<xsl:when test="areaid = 607">Valley of Spears</xsl:when>
				<xsl:when test="areaid = 608">Nijel's Point</xsl:when>
				<xsl:when test="areaid = 609">Kolkar Village</xsl:when>
				<xsl:when test="areaid = 616">Hyjal</xsl:when>
				<xsl:when test="areaid = 618">Winterspring</xsl:when>
				<xsl:when test="areaid = 636">Blackwolf River</xsl:when>
				<xsl:when test="areaid = 637">Kodo Rock</xsl:when>
				<xsl:when test="areaid = 638">Hidden Path</xsl:when>
				<xsl:when test="areaid = 639">Spirit Rock</xsl:when>
				<xsl:when test="areaid = 640">Shrine of the Dormant Flame</xsl:when>
				<xsl:when test="areaid = 656">Lake Elune'ara</xsl:when>
				<xsl:when test="areaid = 657">The Harborage</xsl:when>
				<xsl:when test="areaid = 676">Outland</xsl:when>
				<xsl:when test="areaid = 696">Craftsmen's Terrace UNUSED</xsl:when>
				<xsl:when test="areaid = 697">Tradesmen's Terrace UNUSED</xsl:when>
				<xsl:when test="areaid = 698">The Temple Gardens UNUSED</xsl:when>
				<xsl:when test="areaid = 699">Temple of Elune UNUSED</xsl:when>
				<xsl:when test="areaid = 700">Cenarion Enclave UNUSED</xsl:when>
				<xsl:when test="areaid = 701">Warrior's Terrace UNUSED</xsl:when>
				<xsl:when test="areaid = 702">Rut'theran Village</xsl:when>
				<xsl:when test="areaid = 716">Ironband's Compound</xsl:when>
				<xsl:when test="areaid = 717">The Stockade</xsl:when>
				<xsl:when test="areaid = 718">Wailing Caverns</xsl:when>
				<xsl:when test="areaid = 719">Blackfathom Deeps</xsl:when>
				<xsl:when test="areaid = 720">Fray Island</xsl:when>
				<xsl:when test="areaid = 721">Gnomeregan</xsl:when>
				<xsl:when test="areaid = 722">Razorfen Downs</xsl:when>
				<xsl:when test="areaid = 736">Ban'ethil Hollow</xsl:when>
				<xsl:when test="areaid = 796">Scarlet Monastery</xsl:when>
				<xsl:when test="areaid = 797">Jerod's Landing</xsl:when>
				<xsl:when test="areaid = 798">Ridgepoint Tower</xsl:when>
				<xsl:when test="areaid = 799">The Darkened Bank</xsl:when>
				<xsl:when test="areaid = 800">Coldridge Pass</xsl:when>
				<xsl:when test="areaid = 801">Chill Breeze Valley</xsl:when>
				<xsl:when test="areaid = 802">Shimmer Ridge</xsl:when>
				<xsl:when test="areaid = 803">Amberstill Ranch</xsl:when>
				<xsl:when test="areaid = 804">The Tundrid Hills</xsl:when>
				<xsl:when test="areaid = 805">South Gate Pass</xsl:when>
				<xsl:when test="areaid = 806">South Gate Outpost</xsl:when>
				<xsl:when test="areaid = 807">North Gate Pass</xsl:when>
				<xsl:when test="areaid = 808">North Gate Outpost</xsl:when>
				<xsl:when test="areaid = 809">Gates of Ironforge</xsl:when>
				<xsl:when test="areaid = 810">Stillwater Pond</xsl:when>
				<xsl:when test="areaid = 811">Nightmare Vale</xsl:when>
				<xsl:when test="areaid = 812">Venomweb Vale</xsl:when>
				<xsl:when test="areaid = 813">The Bulwark</xsl:when>
				<xsl:when test="areaid = 814">Southfury River</xsl:when>
				<xsl:when test="areaid = 815">Southfury River</xsl:when>
				<xsl:when test="areaid = 816">Razormane Grounds</xsl:when>
				<xsl:when test="areaid = 817">Skull Rock</xsl:when>
				<xsl:when test="areaid = 818">Palemane Rock</xsl:when>
				<xsl:when test="areaid = 819">Windfury Ridge</xsl:when>
				<xsl:when test="areaid = 820">The Golden Plains</xsl:when>
				<xsl:when test="areaid = 821">The Rolling Plains</xsl:when>
				<xsl:when test="areaid = 836">Dun Algaz</xsl:when>
				<xsl:when test="areaid = 837">Dun Algaz</xsl:when>
				<xsl:when test="areaid = 838">North Gate Pass</xsl:when>
				<xsl:when test="areaid = 839">South Gate Pass</xsl:when>
				<xsl:when test="areaid = 856">Twilight Grove</xsl:when>
				<xsl:when test="areaid = 876">GM Island</xsl:when>
				<xsl:when test="areaid = 877">Delete ME</xsl:when>
				<xsl:when test="areaid = 878">Southfury River</xsl:when>
				<xsl:when test="areaid = 879">Southfury River</xsl:when>
				<xsl:when test="areaid = 880">Thandol Span</xsl:when>
				<xsl:when test="areaid = 881">Thandol Span</xsl:when>
				<xsl:when test="areaid = 896">Purgation Isle</xsl:when>
				<xsl:when test="areaid = 916">The Jansen Stead</xsl:when>
				<xsl:when test="areaid = 917">The Dead Acre</xsl:when>
				<xsl:when test="areaid = 918">The Molsen Farm</xsl:when>
				<xsl:when test="areaid = 919">Stendel's Pond</xsl:when>
				<xsl:when test="areaid = 920">The Dagger Hills</xsl:when>
				<xsl:when test="areaid = 921">Demont's Place</xsl:when>
				<xsl:when test="areaid = 922">The Dust Plains</xsl:when>
				<xsl:when test="areaid = 923">Stonesplinter Valley</xsl:when>
				<xsl:when test="areaid = 924">Valley of Kings</xsl:when>
				<xsl:when test="areaid = 925">Algaz Station</xsl:when>
				<xsl:when test="areaid = 926">Bucklebree Farm</xsl:when>
				<xsl:when test="areaid = 927">The Shining Strand</xsl:when>
				<xsl:when test="areaid = 928">North Tide's Hollow</xsl:when>
				<xsl:when test="areaid = 936">Grizzlepaw Ridge</xsl:when>
				<xsl:when test="areaid = 956">The Verdant Fields</xsl:when>
				<xsl:when test="areaid = 976">Gadgetzan</xsl:when>
				<xsl:when test="areaid = 977">Steamwheedle Port</xsl:when>
				<xsl:when test="areaid = 978">Zul'Farrak</xsl:when>
				<xsl:when test="areaid = 979">Sandsorrow Watch</xsl:when>
				<xsl:when test="areaid = 980">Thistleshrub Valley</xsl:when>
				<xsl:when test="areaid = 981">The Gaping Chasm</xsl:when>
				<xsl:when test="areaid = 982">The Noxious Lair</xsl:when>
				<xsl:when test="areaid = 983">Dunemaul Compound</xsl:when>
				<xsl:when test="areaid = 984">Eastmoon Ruins</xsl:when>
				<xsl:when test="areaid = 985">Waterspring Field</xsl:when>
				<xsl:when test="areaid = 986">Zalashji's Den</xsl:when>
				<xsl:when test="areaid = 987">Land's End Beach</xsl:when>
				<xsl:when test="areaid = 988">Wavestrider Beach</xsl:when>
				<xsl:when test="areaid = 989">Uldum</xsl:when>
				<xsl:when test="areaid = 990">Valley of the Watchers</xsl:when>
				<xsl:when test="areaid = 991">Gunstan's Post</xsl:when>
				<xsl:when test="areaid = 992">Southmoon Ruins</xsl:when>
				<xsl:when test="areaid = 996">Render's Camp</xsl:when>
				<xsl:when test="areaid = 997">Render's Valley</xsl:when>
				<xsl:when test="areaid = 998">Render's Rock</xsl:when>
				<xsl:when test="areaid = 999">Stonewatch Tower</xsl:when>
				<xsl:when test="areaid = 1000">Galardell Valley</xsl:when>
				<xsl:when test="areaid = 1001">Lakeridge Highway</xsl:when>
				<xsl:when test="areaid = 1002">Three Corners</xsl:when>
				<xsl:when test="areaid = 1016">Direforge Hill</xsl:when>
				<xsl:when test="areaid = 1017">Raptor Ridge</xsl:when>
				<xsl:when test="areaid = 1018">Black Channel Marsh</xsl:when>
				<xsl:when test="areaid = 1019">The Green Belt</xsl:when>
				<xsl:when test="areaid = 1020">Mosshide Fen</xsl:when>
				<xsl:when test="areaid = 1021">Thelgen Rock</xsl:when>
				<xsl:when test="areaid = 1022">Bluegill Marsh</xsl:when>
				<xsl:when test="areaid = 1023">Saltspray Glen</xsl:when>
				<xsl:when test="areaid = 1024">Sundown Marsh</xsl:when>
				<xsl:when test="areaid = 1025">The Green Belt</xsl:when>
				<xsl:when test="areaid = 1036">Angerfang Encampment</xsl:when>
				<xsl:when test="areaid = 1037">Grim Batol</xsl:when>
				<xsl:when test="areaid = 1038">Dragonmaw Gates</xsl:when>
				<xsl:when test="areaid = 1039">The Lost Fleet</xsl:when>
				<xsl:when test="areaid = 1056">Darrow Hill</xsl:when>
				<xsl:when test="areaid = 1057">Thoradin's Wall</xsl:when>
				<xsl:when test="areaid = 1076">Webwinder Path</xsl:when>
				<xsl:when test="areaid = 1097">The Hushed Bank</xsl:when>
				<xsl:when test="areaid = 1098">Manor Mistmantle</xsl:when>
				<xsl:when test="areaid = 1099">Camp Mojache</xsl:when>
				<xsl:when test="areaid = 1100">Grimtotem Compound</xsl:when>
				<xsl:when test="areaid = 1101">The Writhing Deep</xsl:when>
				<xsl:when test="areaid = 1102">Wildwind Lake</xsl:when>
				<xsl:when test="areaid = 1103">Gordunni Outpost</xsl:when>
				<xsl:when test="areaid = 1104">Mok'Gordun</xsl:when>
				<xsl:when test="areaid = 1105">Feral Scar Vale</xsl:when>
				<xsl:when test="areaid = 1106">Frayfeather Highlands</xsl:when>
				<xsl:when test="areaid = 1107">Idlewind Lake</xsl:when>
				<xsl:when test="areaid = 1108">The Forgotten Coast</xsl:when>
				<xsl:when test="areaid = 1109">East Pillar</xsl:when>
				<xsl:when test="areaid = 1110">West Pillar</xsl:when>
				<xsl:when test="areaid = 1111">Dream Bough</xsl:when>
				<xsl:when test="areaid = 1112">Jademir Lake</xsl:when>
				<xsl:when test="areaid = 1113">Oneiros</xsl:when>
				<xsl:when test="areaid = 1114">Ruins of Ravenwind</xsl:when>
				<xsl:when test="areaid = 1115">Rage Scar Hold</xsl:when>
				<xsl:when test="areaid = 1116">Feathermoon Stronghold</xsl:when>
				<xsl:when test="areaid = 1117">Ruins of Solarsal</xsl:when>
				<xsl:when test="areaid = 1118">Lower Wilds UNUSED</xsl:when>
				<xsl:when test="areaid = 1119">The Twin Colossals</xsl:when>
				<xsl:when test="areaid = 1120">Sardor Isle</xsl:when>
				<xsl:when test="areaid = 1121">Isle of Dread</xsl:when>
				<xsl:when test="areaid = 1136">High Wilderness</xsl:when>
				<xsl:when test="areaid = 1137">Lower Wilds</xsl:when>
				<xsl:when test="areaid = 1156">Southern Barrens</xsl:when>
				<xsl:when test="areaid = 1157">Southern Gold Road</xsl:when>
				<xsl:when test="areaid = 1176">Zul'Farrak</xsl:when>
				<xsl:when test="areaid = 1196">Utgarde Pinnacle</xsl:when>
				<xsl:when test="areaid = 1216">Timbermaw Hold</xsl:when>
				<xsl:when test="areaid = 1217">Vanndir Encampment</xsl:when>
				<xsl:when test="areaid = 1218">TESTAzshara</xsl:when>
				<xsl:when test="areaid = 1219">Legash Encampment</xsl:when>
				<xsl:when test="areaid = 1220">Thalassian Base Camp</xsl:when>
				<xsl:when test="areaid = 1221">Ruins of Eldarath</xsl:when>
				<xsl:when test="areaid = 1222">Hetaera's Clutch</xsl:when>
				<xsl:when test="areaid = 1223">Temple of Zin-Malor</xsl:when>
				<xsl:when test="areaid = 1224">Bear's Head</xsl:when>
				<xsl:when test="areaid = 1225">Ursolan</xsl:when>
				<xsl:when test="areaid = 1226">Temple of Arkkoran</xsl:when>
				<xsl:when test="areaid = 1227">Bay of Storms</xsl:when>
				<xsl:when test="areaid = 1228">The Shattered Strand</xsl:when>
				<xsl:when test="areaid = 1229">Tower of Eldara</xsl:when>
				<xsl:when test="areaid = 1230">Jagged Reef</xsl:when>
				<xsl:when test="areaid = 1231">Southridge Beach</xsl:when>
				<xsl:when test="areaid = 1232">Ravencrest Monument</xsl:when>
				<xsl:when test="areaid = 1233">Forlorn Ridge</xsl:when>
				<xsl:when test="areaid = 1234">Lake Mennar</xsl:when>
				<xsl:when test="areaid = 1235">Shadowsong Shrine</xsl:when>
				<xsl:when test="areaid = 1236">Haldarr Encampment</xsl:when>
				<xsl:when test="areaid = 1237">Valormok</xsl:when>
				<xsl:when test="areaid = 1256">The Ruined Reaches</xsl:when>
				<xsl:when test="areaid = 1276">The Talondeep Path</xsl:when>
				<xsl:when test="areaid = 1277">The Talondeep Path</xsl:when>
				<xsl:when test="areaid = 1296">Rocktusk Farm</xsl:when>
				<xsl:when test="areaid = 1297">Jaggedswine Farm</xsl:when>
				<xsl:when test="areaid = 1316">Razorfen Downs</xsl:when>
				<xsl:when test="areaid = 1336">Lost Rigger Cove</xsl:when>
				<xsl:when test="areaid = 1337">Uldaman</xsl:when>
				<xsl:when test="areaid = 1338">Lordamere Lake</xsl:when>
				<xsl:when test="areaid = 1339">Lordamere Lake</xsl:when>
				<xsl:when test="areaid = 1357">Gallows' Corner</xsl:when>
				<xsl:when test="areaid = 1377">Silithus</xsl:when>
				<xsl:when test="areaid = 1397">Emerald Forest</xsl:when>
				<xsl:when test="areaid = 1417">Sunken Temple</xsl:when>
				<xsl:when test="areaid = 1437">Dreadmaul Hold</xsl:when>
				<xsl:when test="areaid = 1438">Nethergarde Keep</xsl:when>
				<xsl:when test="areaid = 1439">Dreadmaul Post</xsl:when>
				<xsl:when test="areaid = 1440">Serpent's Coil</xsl:when>
				<xsl:when test="areaid = 1441">Altar of Storms</xsl:when>
				<xsl:when test="areaid = 1442">Firewatch Ridge</xsl:when>
				<xsl:when test="areaid = 1443">The Slag Pit</xsl:when>
				<xsl:when test="areaid = 1444">The Sea of Cinders</xsl:when>
				<xsl:when test="areaid = 1445">Blackrock Mountain</xsl:when>
				<xsl:when test="areaid = 1446">Thorium Point</xsl:when>
				<xsl:when test="areaid = 1457">Garrison Armory</xsl:when>
				<xsl:when test="areaid = 1477">The Temple of Atal'Hakkar</xsl:when>
				<xsl:when test="areaid = 1497">Undercity</xsl:when>
				<xsl:when test="areaid = 1517">Uldaman</xsl:when>
				<xsl:when test="areaid = 1518">Not Used Deadmines</xsl:when>
				<xsl:when test="areaid = 1519">Stormwind City</xsl:when>
				<xsl:when test="areaid = 1537">Ironforge</xsl:when>
				<xsl:when test="areaid = 1557">Splithoof Hold</xsl:when>
				<xsl:when test="areaid = 1577">The Cape of Stranglethorn</xsl:when>
				<xsl:when test="areaid = 1578">Southern Savage Coast</xsl:when>
				<xsl:when test="areaid = 1579">Unused The Deadmines 002</xsl:when>
				<xsl:when test="areaid = 1580">Unused Ironclad Cove 003</xsl:when>
				<xsl:when test="areaid = 1581">The Deadmines</xsl:when>
				<xsl:when test="areaid = 1582">Ironclad Cove</xsl:when>
				<xsl:when test="areaid = 1583">Blackrock Spire</xsl:when>
				<xsl:when test="areaid = 1584">Blackrock Depths</xsl:when>
				<xsl:when test="areaid = 1597">Raptor Grounds UNUSED</xsl:when>
				<xsl:when test="areaid = 1598">Grol'dom Farm UNUSED</xsl:when>
				<xsl:when test="areaid = 1599">Mor'shan Base Camp</xsl:when>
				<xsl:when test="areaid = 1600">Honor's Stand UNUSED</xsl:when>
				<xsl:when test="areaid = 1601">Blackthorn Ridge UNUSED</xsl:when>
				<xsl:when test="areaid = 1602">Bramblescar UNUSED</xsl:when>
				<xsl:when test="areaid = 1603">Agama'gor UNUSED</xsl:when>
				<xsl:when test="areaid = 1617">Valley of Heroes</xsl:when>
				<xsl:when test="areaid = 1637">Orgrimmar</xsl:when>
				<xsl:when test="areaid = 1638">Thunder Bluff</xsl:when>
				<xsl:when test="areaid = 1639">Elder Rise</xsl:when>
				<xsl:when test="areaid = 1640">Spirit Rise</xsl:when>
				<xsl:when test="areaid = 1641">Hunter Rise</xsl:when>
				<xsl:when test="areaid = 1657">Darnassus</xsl:when>
				<xsl:when test="areaid = 1658">Cenarion Enclave</xsl:when>
				<xsl:when test="areaid = 1659">Craftsmen's Terrace</xsl:when>
				<xsl:when test="areaid = 1660">Warrior's Terrace</xsl:when>
				<xsl:when test="areaid = 1661">The Temple Gardens</xsl:when>
				<xsl:when test="areaid = 1662">Tradesmen's Terrace</xsl:when>
				<xsl:when test="areaid = 1677">Gavin's Naze</xsl:when>
				<xsl:when test="areaid = 1678">Sofera's Naze</xsl:when>
				<xsl:when test="areaid = 1679">Corrahn's Dagger</xsl:when>
				<xsl:when test="areaid = 1680">The Headland</xsl:when>
				<xsl:when test="areaid = 1681">Misty Shore</xsl:when>
				<xsl:when test="areaid = 1682">Dandred's Fold</xsl:when>
				<xsl:when test="areaid = 1683">Growless Cave</xsl:when>
				<xsl:when test="areaid = 1684">Chillwind Point</xsl:when>
				<xsl:when test="areaid = 1697">Raptor Grounds</xsl:when>
				<xsl:when test="areaid = 1698">Bramblescar</xsl:when>
				<xsl:when test="areaid = 1699">Thorn Hill</xsl:when>
				<xsl:when test="areaid = 1700">Agama'gor</xsl:when>
				<xsl:when test="areaid = 1701">Blackthorn Ridge</xsl:when>
				<xsl:when test="areaid = 1702">Honor's Stand</xsl:when>
				<xsl:when test="areaid = 1703">The Mor'shan Rampart</xsl:when>
				<xsl:when test="areaid = 1704">Grol'dom Farm</xsl:when>
				<xsl:when test="areaid = 1717">Razorfen Kraul</xsl:when>
				<xsl:when test="areaid = 1718">The Great Lift</xsl:when>
				<xsl:when test="areaid = 1737">Mistvale Valley</xsl:when>
				<xsl:when test="areaid = 1738">Nek'mani Wellspring</xsl:when>
				<xsl:when test="areaid = 1739">Bloodsail Compound</xsl:when>
				<xsl:when test="areaid = 1740">Venture Co. Base Camp</xsl:when>
				<xsl:when test="areaid = 1741">Gurubashi Arena</xsl:when>
				<xsl:when test="areaid = 1742">Spirit Den</xsl:when>
				<xsl:when test="areaid = 1757">The Crimson Veil</xsl:when>
				<xsl:when test="areaid = 1758">The Riptide</xsl:when>
				<xsl:when test="areaid = 1759">The Damsel's Luck</xsl:when>
				<xsl:when test="areaid = 1760">Venture Co. Operations Center</xsl:when>
				<xsl:when test="areaid = 1761">Deadwood Village</xsl:when>
				<xsl:when test="areaid = 1762">Felpaw Village</xsl:when>
				<xsl:when test="areaid = 1763">Jaedenar</xsl:when>
				<xsl:when test="areaid = 1764">Bloodvenom River</xsl:when>
				<xsl:when test="areaid = 1765">Bloodvenom Falls</xsl:when>
				<xsl:when test="areaid = 1766">Shatter Scar Vale</xsl:when>
				<xsl:when test="areaid = 1767">Irontree Woods</xsl:when>
				<xsl:when test="areaid = 1768">Irontree Cavern</xsl:when>
				<xsl:when test="areaid = 1769">Timbermaw Hold</xsl:when>
				<xsl:when test="areaid = 1770">Shadow Hold</xsl:when>
				<xsl:when test="areaid = 1771">Shrine of the Deceiver</xsl:when>
				<xsl:when test="areaid = 1777">Itharius's Cave</xsl:when>
				<xsl:when test="areaid = 1778">Sorrowmurk</xsl:when>
				<xsl:when test="areaid = 1779">Draenil'dur Village</xsl:when>
				<xsl:when test="areaid = 1780">Splinterspear Junction</xsl:when>
				<xsl:when test="areaid = 1797">Stagalbog</xsl:when>
				<xsl:when test="areaid = 1798">The Shifting Mire</xsl:when>
				<xsl:when test="areaid = 1817">Stagalbog Cave</xsl:when>
				<xsl:when test="areaid = 1837">Witherbark Caverns</xsl:when>
				<xsl:when test="areaid = 1857">Thoradin's Wall</xsl:when>
				<xsl:when test="areaid = 1858">Boulder'gor</xsl:when>
				<xsl:when test="areaid = 1877">Valley of Fangs</xsl:when>
				<xsl:when test="areaid = 1878">The Dustbowl</xsl:when>
				<xsl:when test="areaid = 1879">Mirage Flats</xsl:when>
				<xsl:when test="areaid = 1880">Featherbeard's Hovel</xsl:when>
				<xsl:when test="areaid = 1881">Shindigger's Camp</xsl:when>
				<xsl:when test="areaid = 1882">Plaguemist Ravine</xsl:when>
				<xsl:when test="areaid = 1883">Valorwind Lake</xsl:when>
				<xsl:when test="areaid = 1884">Agol'watha</xsl:when>
				<xsl:when test="areaid = 1885">Hiri'watha</xsl:when>
				<xsl:when test="areaid = 1886">The Creeping Ruin</xsl:when>
				<xsl:when test="areaid = 1887">Bogen's Ledge</xsl:when>
				<xsl:when test="areaid = 1897">The Maker's Terrace</xsl:when>
				<xsl:when test="areaid = 1898">Dustwind Gulch</xsl:when>
				<xsl:when test="areaid = 1917">Shaol'watha</xsl:when>
				<xsl:when test="areaid = 1937">Noonshade Ruins</xsl:when>
				<xsl:when test="areaid = 1938">Broken Pillar</xsl:when>
				<xsl:when test="areaid = 1939">Abyssal Sands</xsl:when>
				<xsl:when test="areaid = 1940">Southbreak Shore</xsl:when>
				<xsl:when test="areaid = 1941">Caverns of Time</xsl:when>
				<xsl:when test="areaid = 1942">The Marshlands</xsl:when>
				<xsl:when test="areaid = 1943">Ironstone Plateau</xsl:when>
				<xsl:when test="areaid = 1957">Blackchar Cave</xsl:when>
				<xsl:when test="areaid = 1958">Tanner Camp</xsl:when>
				<xsl:when test="areaid = 1959">Dustfire Valley</xsl:when>
				<xsl:when test="areaid = 1977">Zul'Gurub</xsl:when>
				<xsl:when test="areaid = 1978">Misty Reed Post</xsl:when>
				<xsl:when test="areaid = 1997">Bloodvenom Post </xsl:when>
				<xsl:when test="areaid = 1998">Talonbranch Glade </xsl:when>
				<xsl:when test="areaid = 2017">Stratholme</xsl:when>
				<xsl:when test="areaid = 2037">Quel'thalas</xsl:when>
				<xsl:when test="areaid = 2057">Scholomance</xsl:when>
				<xsl:when test="areaid = 2077">Twilight Vale</xsl:when>
				<xsl:when test="areaid = 2078">Twilight Shore</xsl:when>
				<xsl:when test="areaid = 2079">Alcaz Island</xsl:when>
				<xsl:when test="areaid = 2097">Darkcloud Pinnacle</xsl:when>
				<xsl:when test="areaid = 2098">Dawning Wood Catacombs</xsl:when>
				<xsl:when test="areaid = 2099">Stonewatch Keep</xsl:when>
				<xsl:when test="areaid = 2100">Maraudon</xsl:when>
				<xsl:when test="areaid = 2101">Stoutlager Inn</xsl:when>
				<xsl:when test="areaid = 2102">Thunderbrew Distillery</xsl:when>
				<xsl:when test="areaid = 2103">Menethil Keep</xsl:when>
				<xsl:when test="areaid = 2104">Deepwater Tavern</xsl:when>
				<xsl:when test="areaid = 2117">Shadow Grave</xsl:when>
				<xsl:when test="areaid = 2118">Brill Town Hall</xsl:when>
				<xsl:when test="areaid = 2119">Gallows' End Tavern</xsl:when>
				<xsl:when test="areaid = 2137">The Pools of VisionUNUSED</xsl:when>
				<xsl:when test="areaid = 2138">Dreadmist Den</xsl:when>
				<xsl:when test="areaid = 2157">Bael'dun Keep</xsl:when>
				<xsl:when test="areaid = 2158">Emberstrife's Den</xsl:when>
				<xsl:when test="areaid = 2159">Onyxia's Lair</xsl:when>
				<xsl:when test="areaid = 2160">Windshear Mine</xsl:when>
				<xsl:when test="areaid = 2161">Roland's Doom</xsl:when>
				<xsl:when test="areaid = 2177">Battle Ring</xsl:when>
				<xsl:when test="areaid = 2197">The Pools of Vision</xsl:when>
				<xsl:when test="areaid = 2198">Shadowbreak Ravine</xsl:when>
				<xsl:when test="areaid = 2217">Broken Spear Village</xsl:when>
				<xsl:when test="areaid = 2237">Whitereach Post</xsl:when>
				<xsl:when test="areaid = 2238">Gornia</xsl:when>
				<xsl:when test="areaid = 2239">Zane's Eye Crater</xsl:when>
				<xsl:when test="areaid = 2240">Mirage Raceway</xsl:when>
				<xsl:when test="areaid = 2241">Frostsaber Rock</xsl:when>
				<xsl:when test="areaid = 2242">The Hidden Grove</xsl:when>
				<xsl:when test="areaid = 2243">Timbermaw Post</xsl:when>
				<xsl:when test="areaid = 2244">Winterfall Village</xsl:when>
				<xsl:when test="areaid = 2245">Mazthoril</xsl:when>
				<xsl:when test="areaid = 2246">Frostfire Hot Springs</xsl:when>
				<xsl:when test="areaid = 2247">Ice Thistle Hills</xsl:when>
				<xsl:when test="areaid = 2248">Dun Mandarr</xsl:when>
				<xsl:when test="areaid = 2249">Frostwhisper Gorge</xsl:when>
				<xsl:when test="areaid = 2250">Owl Wing Thicket</xsl:when>
				<xsl:when test="areaid = 2251">Lake Kel'Theril</xsl:when>
				<xsl:when test="areaid = 2252">The Ruins of Kel'Theril</xsl:when>
				<xsl:when test="areaid = 2253">Starfall Village</xsl:when>
				<xsl:when test="areaid = 2254">Ban'Thallow Barrow Den</xsl:when>
				<xsl:when test="areaid = 2255">Everlook</xsl:when>
				<xsl:when test="areaid = 2256">Darkwhisper Gorge</xsl:when>
				<xsl:when test="areaid = 2257">Deeprun Tram</xsl:when>
				<xsl:when test="areaid = 2258">The Fungal Vale</xsl:when>
				<xsl:when test="areaid = 2259">UNUSEDThe Marris Stead</xsl:when>
				<xsl:when test="areaid = 2260">The Marris Stead</xsl:when>
				<xsl:when test="areaid = 2261">The Undercroft</xsl:when>
				<xsl:when test="areaid = 2262">Darrowshire</xsl:when>
				<xsl:when test="areaid = 2263">Crown Guard Tower</xsl:when>
				<xsl:when test="areaid = 2264">Corin's Crossing</xsl:when>
				<xsl:when test="areaid = 2265">Scarlet Base Camp</xsl:when>
				<xsl:when test="areaid = 2266">Tyr's Hand</xsl:when>
				<xsl:when test="areaid = 2267">The Scarlet Basilica</xsl:when>
				<xsl:when test="areaid = 2268">Light's Hope Chapel</xsl:when>
				<xsl:when test="areaid = 2269">Browman Mill</xsl:when>
				<xsl:when test="areaid = 2270">The Noxious Glade</xsl:when>
				<xsl:when test="areaid = 2271">Eastwall Tower</xsl:when>
				<xsl:when test="areaid = 2272">Northdale</xsl:when>
				<xsl:when test="areaid = 2273">Zul'Mashar</xsl:when>
				<xsl:when test="areaid = 2274">Mazra'Alor</xsl:when>
				<xsl:when test="areaid = 2275">Northpass Tower</xsl:when>
				<xsl:when test="areaid = 2276">Quel'Lithien Lodge</xsl:when>
				<xsl:when test="areaid = 2277">Plaguewood</xsl:when>
				<xsl:when test="areaid = 2278">Scourgehold</xsl:when>
				<xsl:when test="areaid = 2279">Stratholme</xsl:when>
				<xsl:when test="areaid = 2280">DO NOT USE</xsl:when>
				<xsl:when test="areaid = 2297">Darrowmere Lake</xsl:when>
				<xsl:when test="areaid = 2298">Caer Darrow</xsl:when>
				<xsl:when test="areaid = 2299">Darrowmere Lake</xsl:when>
				<xsl:when test="areaid = 2300">Caverns of Time</xsl:when>
				<xsl:when test="areaid = 2301">Thistlefur Village</xsl:when>
				<xsl:when test="areaid = 2302">The Quagmire</xsl:when>
				<xsl:when test="areaid = 2303">Windbreak Canyon</xsl:when>
				<xsl:when test="areaid = 2317">South Seas</xsl:when>
				<xsl:when test="areaid = 2318">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2319">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2320">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2321">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2322">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 2323">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 2324">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 2325">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 2326">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 2337">Razor Hill Barracks</xsl:when>
				<xsl:when test="areaid = 2338">South Seas</xsl:when>
				<xsl:when test="areaid = 2339">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2357">Bloodtooth Camp</xsl:when>
				<xsl:when test="areaid = 2358">Forest Song</xsl:when>
				<xsl:when test="areaid = 2359">Greenpaw Village</xsl:when>
				<xsl:when test="areaid = 2360">Silverwing Outpost</xsl:when>
				<xsl:when test="areaid = 2361">Nighthaven</xsl:when>
				<xsl:when test="areaid = 2362">Shrine of Remulos</xsl:when>
				<xsl:when test="areaid = 2363">Stormrage Barrow Dens</xsl:when>
				<xsl:when test="areaid = 2364">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2365">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2366">The Black Morass</xsl:when>
				<xsl:when test="areaid = 2367">Old Hillsbrad Foothills</xsl:when>
				<xsl:when test="areaid = 2368">Tarren Mill</xsl:when>
				<xsl:when test="areaid = 2369">Southshore</xsl:when>
				<xsl:when test="areaid = 2370">Durnholde Keep</xsl:when>
				<xsl:when test="areaid = 2371">Dun Garok</xsl:when>
				<xsl:when test="areaid = 2372">Hillsbrad Fields</xsl:when>
				<xsl:when test="areaid = 2373">Eastern Strand</xsl:when>
				<xsl:when test="areaid = 2374">Nethander Stead</xsl:when>
				<xsl:when test="areaid = 2375">Darrow Hill</xsl:when>
				<xsl:when test="areaid = 2376">Southpoint Tower</xsl:when>
				<xsl:when test="areaid = 2377">Thoradin's Wall</xsl:when>
				<xsl:when test="areaid = 2378">Western Strand</xsl:when>
				<xsl:when test="areaid = 2379">Azurelode Mine</xsl:when>
				<xsl:when test="areaid = 2397">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2398">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2399">The Great Sea</xsl:when>
				<xsl:when test="areaid = 2400">The Forbidding Sea</xsl:when>
				<xsl:when test="areaid = 2401">The Forbidding Sea</xsl:when>
				<xsl:when test="areaid = 2402">The Forbidding Sea</xsl:when>
				<xsl:when test="areaid = 2403">The Forbidding Sea</xsl:when>
				<xsl:when test="areaid = 2404">Tethris Aran</xsl:when>
				<xsl:when test="areaid = 2405">Ethel Rethor</xsl:when>
				<xsl:when test="areaid = 2406">Ranazjar Isle</xsl:when>
				<xsl:when test="areaid = 2407">Kormek's Hut</xsl:when>
				<xsl:when test="areaid = 2408">Shadowprey Village</xsl:when>
				<xsl:when test="areaid = 2417">Blackrock Pass</xsl:when>
				<xsl:when test="areaid = 2418">Morgan's Vigil</xsl:when>
				<xsl:when test="areaid = 2419">Slither Rock</xsl:when>
				<xsl:when test="areaid = 2420">Terror Wing Path</xsl:when>
				<xsl:when test="areaid = 2421">Draco'dar</xsl:when>
				<xsl:when test="areaid = 2437">Ragefire Chasm</xsl:when>
				<xsl:when test="areaid = 2457">Nightsong Woods</xsl:when>
				<xsl:when test="areaid = 2477">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 2478">Morlos'Aran</xsl:when>
				<xsl:when test="areaid = 2479">Emerald Sanctuary</xsl:when>
				<xsl:when test="areaid = 2480">Jadefire Glen</xsl:when>
				<xsl:when test="areaid = 2481">Ruins of Constellas</xsl:when>
				<xsl:when test="areaid = 2497">Bitter Reaches</xsl:when>
				<xsl:when test="areaid = 2517">Rise of the Defiler</xsl:when>
				<xsl:when test="areaid = 2518">Lariss Pavilion</xsl:when>
				<xsl:when test="areaid = 2519">Woodpaw Hills</xsl:when>
				<xsl:when test="areaid = 2520">Woodpaw Den</xsl:when>
				<xsl:when test="areaid = 2521">Verdantis River</xsl:when>
				<xsl:when test="areaid = 2522">Ruins of Isildien</xsl:when>
				<xsl:when test="areaid = 2537">Grimtotem Post</xsl:when>
				<xsl:when test="areaid = 2538">Camp Aparaje</xsl:when>
				<xsl:when test="areaid = 2539">Malaka'jin</xsl:when>
				<xsl:when test="areaid = 2540">Boulderslide Ravine</xsl:when>
				<xsl:when test="areaid = 2541">Sishir Canyon</xsl:when>
				<xsl:when test="areaid = 2557">Dire Maul</xsl:when>
				<xsl:when test="areaid = 2558">Deadwind Ravine</xsl:when>
				<xsl:when test="areaid = 2559">Diamondhead River</xsl:when>
				<xsl:when test="areaid = 2560">Ariden's Camp</xsl:when>
				<xsl:when test="areaid = 2561">The Vice</xsl:when>
				<xsl:when test="areaid = 2562">Karazhan</xsl:when>
				<xsl:when test="areaid = 2563">Morgan's Plot</xsl:when>
				<xsl:when test="areaid = 2577">Dire Maul</xsl:when>
				<xsl:when test="areaid = 2597">Alterac Valley</xsl:when>
				<xsl:when test="areaid = 2617">Scrabblescrew's Camp</xsl:when>
				<xsl:when test="areaid = 2618">Jadefire Run</xsl:when>
				<xsl:when test="areaid = 2619">Thondroril River</xsl:when>
				<xsl:when test="areaid = 2620">Thondroril River</xsl:when>
				<xsl:when test="areaid = 2621">Lake Mereldar</xsl:when>
				<xsl:when test="areaid = 2622">Pestilent Scar</xsl:when>
				<xsl:when test="areaid = 2623">The Infectis Scar</xsl:when>
				<xsl:when test="areaid = 2624">Blackwood Lake</xsl:when>
				<xsl:when test="areaid = 2625">Eastwall Gate</xsl:when>
				<xsl:when test="areaid = 2626">Terrorweb Tunnel</xsl:when>
				<xsl:when test="areaid = 2627">Terrordale</xsl:when>
				<xsl:when test="areaid = 2637">Kargathia Keep</xsl:when>
				<xsl:when test="areaid = 2657">Valley of Bones</xsl:when>
				<xsl:when test="areaid = 2677">Blackwing Lair</xsl:when>
				<xsl:when test="areaid = 2697">Deadman's Crossing</xsl:when>
				<xsl:when test="areaid = 2717">Molten Core</xsl:when>
				<xsl:when test="areaid = 2737">The Scarab Wall</xsl:when>
				<xsl:when test="areaid = 2738">Southwind Village</xsl:when>
				<xsl:when test="areaid = 2739">Twilight Base Camp</xsl:when>
				<xsl:when test="areaid = 2740">The Crystal Vale</xsl:when>
				<xsl:when test="areaid = 2741">The Scarab Dais</xsl:when>
				<xsl:when test="areaid = 2742">Hive'Ashi</xsl:when>
				<xsl:when test="areaid = 2743">Hive'Zora</xsl:when>
				<xsl:when test="areaid = 2744">Hive'Regal</xsl:when>
				<xsl:when test="areaid = 2757">Shrine of the Fallen Warrior</xsl:when>
				<xsl:when test="areaid = 2777">UNUSED Alterac Valley</xsl:when>
				<xsl:when test="areaid = 2797">Blackfathom Deeps</xsl:when>
				<xsl:when test="areaid = 2817">Crystalsong Forest</xsl:when>
				<xsl:when test="areaid = 2837">The Master's Cellar</xsl:when>
				<xsl:when test="areaid = 2838">Stonewrought Pass</xsl:when>
				<xsl:when test="areaid = 2839">Alterac Valley</xsl:when>
				<xsl:when test="areaid = 2857">The Rumble Cage</xsl:when>
				<xsl:when test="areaid = 2877">Chunk Test</xsl:when>
				<xsl:when test="areaid = 2897">Zoram'gar Outpost</xsl:when>
				<xsl:when test="areaid = 2917">Hall of Legends</xsl:when>
				<xsl:when test="areaid = 2918">Champions' Hall</xsl:when>
				<xsl:when test="areaid = 2937">Grosh'gok Compound</xsl:when>
				<xsl:when test="areaid = 2938">Sleeping Gorge</xsl:when>
				<xsl:when test="areaid = 2957">Irondeep Mine</xsl:when>
				<xsl:when test="areaid = 2958">Stonehearth Outpost</xsl:when>
				<xsl:when test="areaid = 2959">Dun Baldar</xsl:when>
				<xsl:when test="areaid = 2960">Icewing Pass</xsl:when>
				<xsl:when test="areaid = 2961">Frostwolf Village</xsl:when>
				<xsl:when test="areaid = 2962">Tower Point</xsl:when>
				<xsl:when test="areaid = 2963">Coldtooth Mine</xsl:when>
				<xsl:when test="areaid = 2964">Winterax Hold</xsl:when>
				<xsl:when test="areaid = 2977">Iceblood Garrison</xsl:when>
				<xsl:when test="areaid = 2978">Frostwolf Keep</xsl:when>
				<xsl:when test="areaid = 2979">Tor'kren Farm</xsl:when>
				<xsl:when test="areaid = 3017">Frost Dagger Pass</xsl:when>
				<xsl:when test="areaid = 3037">Ironstone Camp</xsl:when>
				<xsl:when test="areaid = 3038">Weazel's Crater</xsl:when>
				<xsl:when test="areaid = 3039">Tahonda Ruins</xsl:when>
				<xsl:when test="areaid = 3057">Field of Strife</xsl:when>
				<xsl:when test="areaid = 3058">Icewing Cavern</xsl:when>
				<xsl:when test="areaid = 3077">Valor's Rest</xsl:when>
				<xsl:when test="areaid = 3097">The Swarming Pillar</xsl:when>
				<xsl:when test="areaid = 3098">Twilight Post</xsl:when>
				<xsl:when test="areaid = 3099">Twilight Outpost</xsl:when>
				<xsl:when test="areaid = 3100">Ravaged Twilight Camp</xsl:when>
				<xsl:when test="areaid = 3117">Shalzaru's Lair</xsl:when>
				<xsl:when test="areaid = 3137">Talrendis Point</xsl:when>
				<xsl:when test="areaid = 3138">Rethress Sanctum</xsl:when>
				<xsl:when test="areaid = 3139">Moon Horror Den</xsl:when>
				<xsl:when test="areaid = 3140">Scalebeard's Cave</xsl:when>
				<xsl:when test="areaid = 3157">Boulderslide Cavern</xsl:when>
				<xsl:when test="areaid = 3177">Warsong Labor Camp</xsl:when>
				<xsl:when test="areaid = 3197">Chillwind Camp</xsl:when>
				<xsl:when test="areaid = 3217">The Maul</xsl:when>
				<xsl:when test="areaid = 3237">The Maul UNUSED</xsl:when>
				<xsl:when test="areaid = 3257">Bones of Grakkarond</xsl:when>
				<xsl:when test="areaid = 3277">Warsong Gulch</xsl:when>
				<xsl:when test="areaid = 3297">Frostwolf Graveyard</xsl:when>
				<xsl:when test="areaid = 3298">Frostwolf Pass</xsl:when>
				<xsl:when test="areaid = 3299">Dun Baldar Pass</xsl:when>
				<xsl:when test="areaid = 3300">Iceblood Graveyard</xsl:when>
				<xsl:when test="areaid = 3301">Snowfall Graveyard</xsl:when>
				<xsl:when test="areaid = 3302">Stonehearth Graveyard</xsl:when>
				<xsl:when test="areaid = 3303">Stormpike Graveyard</xsl:when>
				<xsl:when test="areaid = 3304">Icewing Bunker</xsl:when>
				<xsl:when test="areaid = 3305">Stonehearth Bunker</xsl:when>
				<xsl:when test="areaid = 3306">Wildpaw Ridge</xsl:when>
				<xsl:when test="areaid = 3317">Revantusk Village</xsl:when>
				<xsl:when test="areaid = 3318">Rock of Durotan</xsl:when>
				<xsl:when test="areaid = 3319">Silverwing Grove</xsl:when>
				<xsl:when test="areaid = 3320">Warsong Lumber Mill</xsl:when>
				<xsl:when test="areaid = 3321">Silverwing Hold</xsl:when>
				<xsl:when test="areaid = 3337">Wildpaw Cavern</xsl:when>
				<xsl:when test="areaid = 3338">The Veiled Cleft</xsl:when>
				<xsl:when test="areaid = 3357">Yojamba Isle</xsl:when>
				<xsl:when test="areaid = 3358">Arathi Basin</xsl:when>
				<xsl:when test="areaid = 3377">The Coil</xsl:when>
				<xsl:when test="areaid = 3378">Altar of Hir'eek</xsl:when>
				<xsl:when test="areaid = 3379">Shadra'zaar</xsl:when>
				<xsl:when test="areaid = 3380">Hakkari Grounds</xsl:when>
				<xsl:when test="areaid = 3381">Naze of Shirvallah</xsl:when>
				<xsl:when test="areaid = 3382">Temple of Bethekk</xsl:when>
				<xsl:when test="areaid = 3383">The Bloodfire Pit</xsl:when>
				<xsl:when test="areaid = 3384">Altar of the Blood God</xsl:when>
				<xsl:when test="areaid = 3397">Zanza's Rise</xsl:when>
				<xsl:when test="areaid = 3398">Edge of Madness</xsl:when>
				<xsl:when test="areaid = 3417">Trollbane Hall</xsl:when>
				<xsl:when test="areaid = 3418">Defiler's Den</xsl:when>
				<xsl:when test="areaid = 3419">Pagle's Pointe</xsl:when>
				<xsl:when test="areaid = 3420">Farm</xsl:when>
				<xsl:when test="areaid = 3421">Blacksmith</xsl:when>
				<xsl:when test="areaid = 3422">Lumber Mill</xsl:when>
				<xsl:when test="areaid = 3423">Gold Mine</xsl:when>
				<xsl:when test="areaid = 3424">Stables</xsl:when>
				<xsl:when test="areaid = 3425">Cenarion Hold</xsl:when>
				<xsl:when test="areaid = 3426">Staghelm Point</xsl:when>
				<xsl:when test="areaid = 3427">Bronzebeard Encampment</xsl:when>
				<xsl:when test="areaid = 3428">Ahn'Qiraj</xsl:when>
				<xsl:when test="areaid = 3429">Ruins of Ahn'Qiraj</xsl:when>
				<xsl:when test="areaid = 3430">Eversong Woods</xsl:when>
				<xsl:when test="areaid = 3431">Sunstrider Isle</xsl:when>
				<xsl:when test="areaid = 3432">Shrine of Dath'Remar</xsl:when>
				<xsl:when test="areaid = 3433">Ghostlands</xsl:when>
				<xsl:when test="areaid = 3434">Scarab Terrace</xsl:when>
				<xsl:when test="areaid = 3435">General's Terrace</xsl:when>
				<xsl:when test="areaid = 3436">The Reservoir</xsl:when>
				<xsl:when test="areaid = 3437">The Hatchery</xsl:when>
				<xsl:when test="areaid = 3438">The Comb</xsl:when>
				<xsl:when test="areaid = 3439">Watchers' Terrace</xsl:when>
				<xsl:when test="areaid = 3440">Scarab Terrace</xsl:when>
				<xsl:when test="areaid = 3441">General's Terrace</xsl:when>
				<xsl:when test="areaid = 3442">The Reservoir</xsl:when>
				<xsl:when test="areaid = 3443">The Hatchery</xsl:when>
				<xsl:when test="areaid = 3444">The Comb</xsl:when>
				<xsl:when test="areaid = 3445">Watchers' Terrace</xsl:when>
				<xsl:when test="areaid = 3446">Twilight's Run</xsl:when>
				<xsl:when test="areaid = 3447">Ortell's Hideout</xsl:when>
				<xsl:when test="areaid = 3448">Scarab Terrace</xsl:when>
				<xsl:when test="areaid = 3449">General's Terrace</xsl:when>
				<xsl:when test="areaid = 3450">The Reservoir</xsl:when>
				<xsl:when test="areaid = 3451">The Hatchery</xsl:when>
				<xsl:when test="areaid = 3452">The Comb</xsl:when>
				<xsl:when test="areaid = 3453">Watchers' Terrace</xsl:when>
				<xsl:when test="areaid = 3454">Ruins of Ahn'Qiraj</xsl:when>
				<xsl:when test="areaid = 3455">The North Sea</xsl:when>
				<xsl:when test="areaid = 3456">Naxxramas</xsl:when>
				<xsl:when test="areaid = 3457">Karazhan</xsl:when>
				<xsl:when test="areaid = 3459">City</xsl:when>
				<xsl:when test="areaid = 3460">Golden Strand</xsl:when>
				<xsl:when test="areaid = 3461">Sunsail Anchorage</xsl:when>
				<xsl:when test="areaid = 3462">Fairbreeze Village</xsl:when>
				<xsl:when test="areaid = 3463">Magisters Gate</xsl:when>
				<xsl:when test="areaid = 3464">Farstrider Retreat</xsl:when>
				<xsl:when test="areaid = 3465">North Sanctum</xsl:when>
				<xsl:when test="areaid = 3466">West Sanctum</xsl:when>
				<xsl:when test="areaid = 3467">East Sanctum</xsl:when>
				<xsl:when test="areaid = 3468">Saltheril's Haven</xsl:when>
				<xsl:when test="areaid = 3469">Thuron's Livery</xsl:when>
				<xsl:when test="areaid = 3470">Stillwhisper Pond</xsl:when>
				<xsl:when test="areaid = 3471">The Living Wood</xsl:when>
				<xsl:when test="areaid = 3472">Azurebreeze Coast</xsl:when>
				<xsl:when test="areaid = 3473">Lake Elrendar</xsl:when>
				<xsl:when test="areaid = 3474">The Scorched Grove</xsl:when>
				<xsl:when test="areaid = 3475">Zeb'Watha</xsl:when>
				<xsl:when test="areaid = 3476">Tor'Watha</xsl:when>
				<xsl:when test="areaid = 3477">Azjol-Nerub</xsl:when>
				<xsl:when test="areaid = 3478">Gates of Ahn'Qiraj</xsl:when>
				<xsl:when test="areaid = 3479">The Veiled Sea</xsl:when>
				<xsl:when test="areaid = 3480">Duskwither Grounds</xsl:when>
				<xsl:when test="areaid = 3481">Duskwither Spire</xsl:when>
				<xsl:when test="areaid = 3482">The Dead Scar</xsl:when>
				<xsl:when test="areaid = 3483">Hellfire Peninsula</xsl:when>
				<xsl:when test="areaid = 3484">The Sunspire</xsl:when>
				<xsl:when test="areaid = 3485">Falthrien Academy</xsl:when>
				<xsl:when test="areaid = 3486">Ravenholdt Manor</xsl:when>
				<xsl:when test="areaid = 3487">Silvermoon City</xsl:when>
				<xsl:when test="areaid = 3488">Tranquillien</xsl:when>
				<xsl:when test="areaid = 3489">Suncrown Village</xsl:when>
				<xsl:when test="areaid = 3490">Goldenmist Village</xsl:when>
				<xsl:when test="areaid = 3491">Windrunner Village</xsl:when>
				<xsl:when test="areaid = 3492">Windrunner Spire</xsl:when>
				<xsl:when test="areaid = 3493">Sanctum of the Sun</xsl:when>
				<xsl:when test="areaid = 3494">Sanctum of the Moon</xsl:when>
				<xsl:when test="areaid = 3495">Dawnstar Spire</xsl:when>
				<xsl:when test="areaid = 3496">Farstrider Enclave</xsl:when>
				<xsl:when test="areaid = 3497">An'daroth</xsl:when>
				<xsl:when test="areaid = 3498">An'telas</xsl:when>
				<xsl:when test="areaid = 3499">An'owyn</xsl:when>
				<xsl:when test="areaid = 3500">Deatholme</xsl:when>
				<xsl:when test="areaid = 3501">Bleeding Ziggurat</xsl:when>
				<xsl:when test="areaid = 3502">Howling Ziggurat</xsl:when>
				<xsl:when test="areaid = 3503">Shalandis Isle</xsl:when>
				<xsl:when test="areaid = 3504">Toryl Estate</xsl:when>
				<xsl:when test="areaid = 3505">Underlight Mines</xsl:when>
				<xsl:when test="areaid = 3506">Andilien Estate</xsl:when>
				<xsl:when test="areaid = 3507">Hatchet Hills</xsl:when>
				<xsl:when test="areaid = 3508">Amani Pass</xsl:when>
				<xsl:when test="areaid = 3509">Sungraze Peak</xsl:when>
				<xsl:when test="areaid = 3510">Amani Catacombs</xsl:when>
				<xsl:when test="areaid = 3511">Tower of the Damned</xsl:when>
				<xsl:when test="areaid = 3512">Zeb'Sora</xsl:when>
				<xsl:when test="areaid = 3513">Lake Elrendar</xsl:when>
				<xsl:when test="areaid = 3514">The Dead Scar</xsl:when>
				<xsl:when test="areaid = 3515">Elrendar River</xsl:when>
				<xsl:when test="areaid = 3516">Zeb'Tela</xsl:when>
				<xsl:when test="areaid = 3517">Zeb'Nowa</xsl:when>
				<xsl:when test="areaid = 3518">Nagrand</xsl:when>
				<xsl:when test="areaid = 3519">Terokkar Forest</xsl:when>
				<xsl:when test="areaid = 3520">Shadowmoon Valley</xsl:when>
				<xsl:when test="areaid = 3521">Zangarmarsh</xsl:when>
				<xsl:when test="areaid = 3522">Blade's Edge Mountains</xsl:when>
				<xsl:when test="areaid = 3523">Netherstorm</xsl:when>
				<xsl:when test="areaid = 3524">Azuremyst Isle</xsl:when>
				<xsl:when test="areaid = 3525">Bloodmyst Isle</xsl:when>
				<xsl:when test="areaid = 3526">Ammen Vale</xsl:when>
				<xsl:when test="areaid = 3527">Crash Site</xsl:when>
				<xsl:when test="areaid = 3528">Silverline Lake</xsl:when>
				<xsl:when test="areaid = 3529">Nestlewood Thicket</xsl:when>
				<xsl:when test="areaid = 3530">Shadow Ridge</xsl:when>
				<xsl:when test="areaid = 3531">Skulking Row</xsl:when>
				<xsl:when test="areaid = 3532">Dawning Lane</xsl:when>
				<xsl:when test="areaid = 3533">Ruins of Silvermoon</xsl:when>
				<xsl:when test="areaid = 3534">Feth's Way</xsl:when>
				<xsl:when test="areaid = 3535">Hellfire Citadel</xsl:when>
				<xsl:when test="areaid = 3536">Thrallmar</xsl:when>
				<xsl:when test="areaid = 3537">Borean Tundra</xsl:when>
				<xsl:when test="areaid = 3538">Honor Hold</xsl:when>
				<xsl:when test="areaid = 3539">The Stair of Destiny</xsl:when>
				<xsl:when test="areaid = 3540">Twisting Nether</xsl:when>
				<xsl:when test="areaid = 3541">Forge Camp: Mageddon</xsl:when>
				<xsl:when test="areaid = 3542">The Path of Glory</xsl:when>
				<xsl:when test="areaid = 3543">The Great Fissure</xsl:when>
				<xsl:when test="areaid = 3544">Plain of Shards</xsl:when>
				<xsl:when test="areaid = 3545">Hellfire Citadel</xsl:when>
				<xsl:when test="areaid = 3546">Expedition Armory</xsl:when>
				<xsl:when test="areaid = 3547">Throne of Kil'jaeden</xsl:when>
				<xsl:when test="areaid = 3548">Forge Camp: Rage</xsl:when>
				<xsl:when test="areaid = 3549">Invasion Point: Annihilator</xsl:when>
				<xsl:when test="areaid = 3550">Borune Ruins</xsl:when>
				<xsl:when test="areaid = 3551">Ruins of Sha'naar</xsl:when>
				<xsl:when test="areaid = 3552">Temple of Telhamat</xsl:when>
				<xsl:when test="areaid = 3553">Pools of Aggonar</xsl:when>
				<xsl:when test="areaid = 3554">Falcon Watch</xsl:when>
				<xsl:when test="areaid = 3555">Mag'har Post</xsl:when>
				<xsl:when test="areaid = 3556">Den of Haal'esh</xsl:when>
				<xsl:when test="areaid = 3557">The Exodar</xsl:when>
				<xsl:when test="areaid = 3558">Elrendar Falls</xsl:when>
				<xsl:when test="areaid = 3559">Nestlewood Hills</xsl:when>
				<xsl:when test="areaid = 3560">Ammen Fields</xsl:when>
				<xsl:when test="areaid = 3561">The Sacred Grove</xsl:when>
				<xsl:when test="areaid = 3562">Hellfire Ramparts</xsl:when>
				<xsl:when test="areaid = 3563">Hellfire Citadel</xsl:when>
				<xsl:when test="areaid = 3564">Emberglade</xsl:when>
				<xsl:when test="areaid = 3565">Cenarion Refuge</xsl:when>
				<xsl:when test="areaid = 3566">Moonwing Den</xsl:when>
				<xsl:when test="areaid = 3567">Pod Cluster</xsl:when>
				<xsl:when test="areaid = 3568">Pod Wreckage</xsl:when>
				<xsl:when test="areaid = 3569">Tides' Hollow</xsl:when>
				<xsl:when test="areaid = 3570">Wrathscale Point</xsl:when>
				<xsl:when test="areaid = 3571">Bristlelimb Village</xsl:when>
				<xsl:when test="areaid = 3572">Stillpine Hold</xsl:when>
				<xsl:when test="areaid = 3573">Odesyus' Landing</xsl:when>
				<xsl:when test="areaid = 3574">Valaar's Berth</xsl:when>
				<xsl:when test="areaid = 3575">Silting Shore</xsl:when>
				<xsl:when test="areaid = 3576">Azure Watch</xsl:when>
				<xsl:when test="areaid = 3577">Geezle's Camp</xsl:when>
				<xsl:when test="areaid = 3578">Menagerie Wreckage</xsl:when>
				<xsl:when test="areaid = 3579">Traitor's Cove</xsl:when>
				<xsl:when test="areaid = 3580">Wildwind Peak</xsl:when>
				<xsl:when test="areaid = 3581">Wildwind Path</xsl:when>
				<xsl:when test="areaid = 3582">Zeth'Gor</xsl:when>
				<xsl:when test="areaid = 3583">Beryl Coast</xsl:when>
				<xsl:when test="areaid = 3584">Blood Watch</xsl:when>
				<xsl:when test="areaid = 3585">Bladewood</xsl:when>
				<xsl:when test="areaid = 3586">The Vector Coil</xsl:when>
				<xsl:when test="areaid = 3587">The Warp Piston</xsl:when>
				<xsl:when test="areaid = 3588">The Cryo-Core</xsl:when>
				<xsl:when test="areaid = 3589">The Crimson Reach</xsl:when>
				<xsl:when test="areaid = 3590">Wrathscale Lair</xsl:when>
				<xsl:when test="areaid = 3591">Ruins of Loreth'Aran</xsl:when>
				<xsl:when test="areaid = 3592">Nazzivian</xsl:when>
				<xsl:when test="areaid = 3593">Axxarien</xsl:when>
				<xsl:when test="areaid = 3594">Blacksilt Shore</xsl:when>
				<xsl:when test="areaid = 3595">The Foul Pool</xsl:when>
				<xsl:when test="areaid = 3596">The Hidden Reef</xsl:when>
				<xsl:when test="areaid = 3597">Amberweb Pass</xsl:when>
				<xsl:when test="areaid = 3598">Wyrmscar Island</xsl:when>
				<xsl:when test="areaid = 3599">Talon Stand</xsl:when>
				<xsl:when test="areaid = 3600">Bristlelimb Enclave</xsl:when>
				<xsl:when test="areaid = 3601">Ragefeather Ridge</xsl:when>
				<xsl:when test="areaid = 3602">Kessel's Crossing</xsl:when>
				<xsl:when test="areaid = 3603">Tel'athion's Camp</xsl:when>
				<xsl:when test="areaid = 3604">The Bloodcursed Reef</xsl:when>
				<xsl:when test="areaid = 3605">Hyjal Past</xsl:when>
				<xsl:when test="areaid = 3606">Hyjal Summit</xsl:when>
				<xsl:when test="areaid = 3607">Serpentshrine Cavern</xsl:when>
				<xsl:when test="areaid = 3608">Vindicator's Rest</xsl:when>
				<xsl:when test="areaid = 3609">Unused3</xsl:when>
				<xsl:when test="areaid = 3610">Burning Blade Ruins</xsl:when>
				<xsl:when test="areaid = 3611">Clan Watch</xsl:when>
				<xsl:when test="areaid = 3612">Bloodcurse Isle</xsl:when>
				<xsl:when test="areaid = 3613">Garadar</xsl:when>
				<xsl:when test="areaid = 3614">Skysong Lake</xsl:when>
				<xsl:when test="areaid = 3615">Throne of the Elements</xsl:when>
				<xsl:when test="areaid = 3616">Laughing Skull Ruins</xsl:when>
				<xsl:when test="areaid = 3617">Warmaul Hill</xsl:when>
				<xsl:when test="areaid = 3618">Gruul's Lair</xsl:when>
				<xsl:when test="areaid = 3619">Auren Ridge</xsl:when>
				<xsl:when test="areaid = 3620">Auren Falls</xsl:when>
				<xsl:when test="areaid = 3621">Lake Sunspring</xsl:when>
				<xsl:when test="areaid = 3622">Sunspring Post</xsl:when>
				<xsl:when test="areaid = 3623">Aeris Landing</xsl:when>
				<xsl:when test="areaid = 3624">Forge Camp: Fear</xsl:when>
				<xsl:when test="areaid = 3625">Forge Camp: Hate</xsl:when>
				<xsl:when test="areaid = 3626">Telaar</xsl:when>
				<xsl:when test="areaid = 3627">Northwind Cleft</xsl:when>
				<xsl:when test="areaid = 3628">Halaa</xsl:when>
				<xsl:when test="areaid = 3629">Southwind Cleft</xsl:when>
				<xsl:when test="areaid = 3630">Oshu'gun</xsl:when>
				<xsl:when test="areaid = 3631">Spirit Fields</xsl:when>
				<xsl:when test="areaid = 3632">Shamanar</xsl:when>
				<xsl:when test="areaid = 3633">Ancestral Grounds</xsl:when>
				<xsl:when test="areaid = 3634">Windyreed Village</xsl:when>
				<xsl:when test="areaid = 3635">Unused2</xsl:when>
				<xsl:when test="areaid = 3636">Elemental Plateau</xsl:when>
				<xsl:when test="areaid = 3637">Kil'sorrow Fortress</xsl:when>
				<xsl:when test="areaid = 3638">The Ring of Trials</xsl:when>
				<xsl:when test="areaid = 3639">Silvermyst Isle</xsl:when>
				<xsl:when test="areaid = 3640">Daggerfen Village</xsl:when>
				<xsl:when test="areaid = 3641">Umbrafen Village</xsl:when>
				<xsl:when test="areaid = 3642">Feralfen Village</xsl:when>
				<xsl:when test="areaid = 3643">Bloodscale Enclave</xsl:when>
				<xsl:when test="areaid = 3644">Telredor</xsl:when>
				<xsl:when test="areaid = 3645">Zabra'jin</xsl:when>
				<xsl:when test="areaid = 3646">Quagg Ridge</xsl:when>
				<xsl:when test="areaid = 3647">The Spawning Glen</xsl:when>
				<xsl:when test="areaid = 3648">The Dead Mire</xsl:when>
				<xsl:when test="areaid = 3649">Sporeggar</xsl:when>
				<xsl:when test="areaid = 3650">Ango'rosh Grounds</xsl:when>
				<xsl:when test="areaid = 3651">Ango'rosh Stronghold</xsl:when>
				<xsl:when test="areaid = 3652">Funggor Cavern</xsl:when>
				<xsl:when test="areaid = 3653">Serpent Lake</xsl:when>
				<xsl:when test="areaid = 3654">The Drain</xsl:when>
				<xsl:when test="areaid = 3655">Umbrafen Lake</xsl:when>
				<xsl:when test="areaid = 3656">Marshlight Lake</xsl:when>
				<xsl:when test="areaid = 3657">Portal Clearing</xsl:when>
				<xsl:when test="areaid = 3658">Sporewind Lake</xsl:when>
				<xsl:when test="areaid = 3659">The Lagoon</xsl:when>
				<xsl:when test="areaid = 3660">Blades' Run</xsl:when>
				<xsl:when test="areaid = 3661">Blade Tooth Canyon</xsl:when>
				<xsl:when test="areaid = 3662">Commons Hall</xsl:when>
				<xsl:when test="areaid = 3663">Derelict Manor</xsl:when>
				<xsl:when test="areaid = 3664">Huntress of the Sun</xsl:when>
				<xsl:when test="areaid = 3665">Falconwing Square</xsl:when>
				<xsl:when test="areaid = 3666">Halaani Basin</xsl:when>
				<xsl:when test="areaid = 3667">Hewn Bog</xsl:when>
				<xsl:when test="areaid = 3668">Boha'mu Ruins</xsl:when>
				<xsl:when test="areaid = 3669">The Stadium</xsl:when>
				<xsl:when test="areaid = 3670">The Overlook</xsl:when>
				<xsl:when test="areaid = 3671">Broken Hill</xsl:when>
				<xsl:when test="areaid = 3672">Mag'hari Procession</xsl:when>
				<xsl:when test="areaid = 3673">Nesingwary Safari</xsl:when>
				<xsl:when test="areaid = 3674">Cenarion Thicket</xsl:when>
				<xsl:when test="areaid = 3675">Tuurem</xsl:when>
				<xsl:when test="areaid = 3676">Veil Shienor</xsl:when>
				<xsl:when test="areaid = 3677">Veil Skith</xsl:when>
				<xsl:when test="areaid = 3678">Veil Shalas</xsl:when>
				<xsl:when test="areaid = 3679">Skettis</xsl:when>
				<xsl:when test="areaid = 3680">Blackwind Valley</xsl:when>
				<xsl:when test="areaid = 3681">Firewing Point</xsl:when>
				<xsl:when test="areaid = 3682">Grangol'var Village</xsl:when>
				<xsl:when test="areaid = 3683">Stonebreaker Hold</xsl:when>
				<xsl:when test="areaid = 3684">Allerian Stronghold</xsl:when>
				<xsl:when test="areaid = 3685">Bonechewer Ruins</xsl:when>
				<xsl:when test="areaid = 3686">Veil Lithic</xsl:when>
				<xsl:when test="areaid = 3687">Olembas</xsl:when>
				<xsl:when test="areaid = 3688">Auchindoun</xsl:when>
				<xsl:when test="areaid = 3689">Veil Reskk</xsl:when>
				<xsl:when test="areaid = 3690">Blackwind Lake</xsl:when>
				<xsl:when test="areaid = 3691">Lake Ere'Noru</xsl:when>
				<xsl:when test="areaid = 3692">Lake Jorune</xsl:when>
				<xsl:when test="areaid = 3693">Skethyl Mountains</xsl:when>
				<xsl:when test="areaid = 3694">Misty Ridge</xsl:when>
				<xsl:when test="areaid = 3695">The Broken Hills</xsl:when>
				<xsl:when test="areaid = 3696">The Barrier Hills</xsl:when>
				<xsl:when test="areaid = 3697">The Bone Wastes</xsl:when>
				<xsl:when test="areaid = 3698">Nagrand Arena</xsl:when>
				<xsl:when test="areaid = 3699">Laughing Skull Courtyard</xsl:when>
				<xsl:when test="areaid = 3700">The Ring of Blood</xsl:when>
				<xsl:when test="areaid = 3701">Arena Floor</xsl:when>
				<xsl:when test="areaid = 3702">Blade's Edge Arena</xsl:when>
				<xsl:when test="areaid = 3703">Shattrath City</xsl:when>
				<xsl:when test="areaid = 3704">The Shepherd's Gate</xsl:when>
				<xsl:when test="areaid = 3705">Telaari Basin</xsl:when>
				<xsl:when test="areaid = 3706">The Dark Portal</xsl:when>
				<xsl:when test="areaid = 3707">Alliance Base</xsl:when>
				<xsl:when test="areaid = 3708">Horde Encampment</xsl:when>
				<xsl:when test="areaid = 3709">Night Elf Village</xsl:when>
				<xsl:when test="areaid = 3710">Nordrassil</xsl:when>
				<xsl:when test="areaid = 3711">Sholazar Basin</xsl:when>
				<xsl:when test="areaid = 3712">Area 52</xsl:when>
				<xsl:when test="areaid = 3713">The Blood Furnace</xsl:when>
				<xsl:when test="areaid = 3714">The Shattered Halls</xsl:when>
				<xsl:when test="areaid = 3715">The Steamvault</xsl:when>
				<xsl:when test="areaid = 3716">The Underbog</xsl:when>
				<xsl:when test="areaid = 3717">The Slave Pens</xsl:when>
				<xsl:when test="areaid = 3718">Swamprat Post</xsl:when>
				<xsl:when test="areaid = 3719">Bleeding Hollow Ruins</xsl:when>
				<xsl:when test="areaid = 3720">Twin Spire Ruins</xsl:when>
				<xsl:when test="areaid = 3721">The Crumbling Waste</xsl:when>
				<xsl:when test="areaid = 3722">Manaforge Ara</xsl:when>
				<xsl:when test="areaid = 3723">Arklon Ruins</xsl:when>
				<xsl:when test="areaid = 3724">Cosmowrench</xsl:when>
				<xsl:when test="areaid = 3725">Ruins of Enkaat</xsl:when>
				<xsl:when test="areaid = 3726">Manaforge B'naar</xsl:when>
				<xsl:when test="areaid = 3727">The Scrap Field</xsl:when>
				<xsl:when test="areaid = 3728">The Vortex Fields</xsl:when>
				<xsl:when test="areaid = 3729">The Heap</xsl:when>
				<xsl:when test="areaid = 3730">Manaforge Coruu</xsl:when>
				<xsl:when test="areaid = 3731">The Tempest Rift</xsl:when>
				<xsl:when test="areaid = 3732">Kirin'Var Village</xsl:when>
				<xsl:when test="areaid = 3733">The Violet Tower</xsl:when>
				<xsl:when test="areaid = 3734">Manaforge Duro</xsl:when>
				<xsl:when test="areaid = 3735">Voidwind Plateau</xsl:when>
				<xsl:when test="areaid = 3736">Manaforge Ultris</xsl:when>
				<xsl:when test="areaid = 3737">Celestial Ridge</xsl:when>
				<xsl:when test="areaid = 3738">The Stormspire</xsl:when>
				<xsl:when test="areaid = 3739">Forge Base: Oblivion</xsl:when>
				<xsl:when test="areaid = 3740">Forge Base: Gehenna</xsl:when>
				<xsl:when test="areaid = 3741">Ruins of Farahlon</xsl:when>
				<xsl:when test="areaid = 3742">Socrethar's Seat</xsl:when>
				<xsl:when test="areaid = 3743">Legion Hold</xsl:when>
				<xsl:when test="areaid = 3744">Shadowmoon Village</xsl:when>
				<xsl:when test="areaid = 3745">Wildhammer Stronghold</xsl:when>
				<xsl:when test="areaid = 3746">The Hand of Gul'dan</xsl:when>
				<xsl:when test="areaid = 3747">The Fel Pits</xsl:when>
				<xsl:when test="areaid = 3748">The Deathforge</xsl:when>
				<xsl:when test="areaid = 3749">Coilskar Cistern</xsl:when>
				<xsl:when test="areaid = 3750">Coilskar Point</xsl:when>
				<xsl:when test="areaid = 3751">Sunfire Point</xsl:when>
				<xsl:when test="areaid = 3752">Illidari Point</xsl:when>
				<xsl:when test="areaid = 3753">Ruins of Baa'ri</xsl:when>
				<xsl:when test="areaid = 3754">Altar of Sha'tar</xsl:when>
				<xsl:when test="areaid = 3755">The Stair of Doom</xsl:when>
				<xsl:when test="areaid = 3756">Ruins of Karabor</xsl:when>
				<xsl:when test="areaid = 3757">Ata'mal Terrace</xsl:when>
				<xsl:when test="areaid = 3758">Netherwing Fields</xsl:when>
				<xsl:when test="areaid = 3759">Netherwing Ledge</xsl:when>
				<xsl:when test="areaid = 3760">The Barrier Hills</xsl:when>
				<xsl:when test="areaid = 3761">The High Path</xsl:when>
				<xsl:when test="areaid = 3762">Windyreed Pass</xsl:when>
				<xsl:when test="areaid = 3763">Zangar Ridge</xsl:when>
				<xsl:when test="areaid = 3764">The Twilight Ridge</xsl:when>
				<xsl:when test="areaid = 3765">Razorthorn Trail</xsl:when>
				<xsl:when test="areaid = 3766">Orebor Harborage</xsl:when>
				<xsl:when test="areaid = 3767">Blades' Run</xsl:when>
				<xsl:when test="areaid = 3768">Jagged Ridge</xsl:when>
				<xsl:when test="areaid = 3769">Thunderlord Stronghold</xsl:when>
				<xsl:when test="areaid = 3770">Blade Tooth Canyon</xsl:when>
				<xsl:when test="areaid = 3771">The Living Grove</xsl:when>
				<xsl:when test="areaid = 3772">Sylvanaar</xsl:when>
				<xsl:when test="areaid = 3773">Bladespire Hold</xsl:when>
				<xsl:when test="areaid = 3774">Gruul's Lair</xsl:when>
				<xsl:when test="areaid = 3775">Circle of Blood</xsl:when>
				<xsl:when test="areaid = 3776">Bloodmaul Outpost</xsl:when>
				<xsl:when test="areaid = 3777">Bloodmaul Camp</xsl:when>
				<xsl:when test="areaid = 3778">Draenethyst Mine</xsl:when>
				<xsl:when test="areaid = 3779">Trogma's Claim</xsl:when>
				<xsl:when test="areaid = 3780">Blackwing Coven</xsl:when>
				<xsl:when test="areaid = 3781">Grishnath</xsl:when>
				<xsl:when test="areaid = 3782">Veil Lashh</xsl:when>
				<xsl:when test="areaid = 3783">Veil Vekh</xsl:when>
				<xsl:when test="areaid = 3784">Forge Camp: Terror</xsl:when>
				<xsl:when test="areaid = 3785">Forge Camp: Wrath</xsl:when>
				<xsl:when test="areaid = 3786">Ogri'la</xsl:when>
				<xsl:when test="areaid = 3787">Forge Camp: Anger</xsl:when>
				<xsl:when test="areaid = 3788">The Low Path</xsl:when>
				<xsl:when test="areaid = 3789">Shadow Labyrinth</xsl:when>
				<xsl:when test="areaid = 3790">Auchenai Crypts</xsl:when>
				<xsl:when test="areaid = 3791">Sethekk Halls</xsl:when>
				<xsl:when test="areaid = 3792">Mana-Tombs</xsl:when>
				<xsl:when test="areaid = 3793">Felspark Ravine</xsl:when>
				<xsl:when test="areaid = 3794">Valley of Bones</xsl:when>
				<xsl:when test="areaid = 3795">Sha'naari Wastes</xsl:when>
				<xsl:when test="areaid = 3796">The Warp Fields</xsl:when>
				<xsl:when test="areaid = 3797">Fallen Sky Ridge</xsl:when>
				<xsl:when test="areaid = 3798">Haal'eshi Gorge</xsl:when>
				<xsl:when test="areaid = 3799">Stonewall Canyon</xsl:when>
				<xsl:when test="areaid = 3800">Thornfang Hill</xsl:when>
				<xsl:when test="areaid = 3801">Mag'har Grounds</xsl:when>
				<xsl:when test="areaid = 3802">Void Ridge</xsl:when>
				<xsl:when test="areaid = 3803">The Abyssal Shelf</xsl:when>
				<xsl:when test="areaid = 3804">The Legion Front</xsl:when>
				<xsl:when test="areaid = 3805">Zul'Aman</xsl:when>
				<xsl:when test="areaid = 3806">Supply Caravan</xsl:when>
				<xsl:when test="areaid = 3807">Reaver's Fall</xsl:when>
				<xsl:when test="areaid = 3808">Cenarion Post</xsl:when>
				<xsl:when test="areaid = 3809">Southern Rampart</xsl:when>
				<xsl:when test="areaid = 3810">Northern Rampart</xsl:when>
				<xsl:when test="areaid = 3811">Gor'gaz Outpost</xsl:when>
				<xsl:when test="areaid = 3812">Spinebreaker Post</xsl:when>
				<xsl:when test="areaid = 3813">The Path of Anguish</xsl:when>
				<xsl:when test="areaid = 3814">East Supply Caravan</xsl:when>
				<xsl:when test="areaid = 3815">Expedition Point</xsl:when>
				<xsl:when test="areaid = 3816">Zeppelin Crash</xsl:when>
				<xsl:when test="areaid = 3817">Testing</xsl:when>
				<xsl:when test="areaid = 3818">Bloodscale Grounds</xsl:when>
				<xsl:when test="areaid = 3819">Darkcrest Enclave</xsl:when>
				<xsl:when test="areaid = 3820">Eye of the Storm</xsl:when>
				<xsl:when test="areaid = 3821">Warden's Cage</xsl:when>
				<xsl:when test="areaid = 3822">Eclipse Point</xsl:when>
				<xsl:when test="areaid = 3823">Isle of Tribulations</xsl:when>
				<xsl:when test="areaid = 3824">Bloodmaul Ravine</xsl:when>
				<xsl:when test="areaid = 3825">Dragons' End</xsl:when>
				<xsl:when test="areaid = 3826">Daggermaw Canyon</xsl:when>
				<xsl:when test="areaid = 3827">Vekhaar Stand</xsl:when>
				<xsl:when test="areaid = 3828">Ruuan Weald</xsl:when>
				<xsl:when test="areaid = 3829">Veil Ruuan</xsl:when>
				<xsl:when test="areaid = 3830">Raven's Wood</xsl:when>
				<xsl:when test="areaid = 3831">Death's Door</xsl:when>
				<xsl:when test="areaid = 3832">Vortex Pinnacle</xsl:when>
				<xsl:when test="areaid = 3833">Razor Ridge</xsl:when>
				<xsl:when test="areaid = 3834">Ridge of Madness</xsl:when>
				<xsl:when test="areaid = 3835">Dustquill Ravine</xsl:when>
				<xsl:when test="areaid = 3836">Magtheridon's Lair</xsl:when>
				<xsl:when test="areaid = 3837">Sunfury Hold</xsl:when>
				<xsl:when test="areaid = 3838">Spinebreaker Mountains</xsl:when>
				<xsl:when test="areaid = 3839">Abandoned Armory</xsl:when>
				<xsl:when test="areaid = 3840">The Black Temple</xsl:when>
				<xsl:when test="areaid = 3841">Darkcrest Shore</xsl:when>
				<xsl:when test="areaid = 3842">Tempest Keep</xsl:when>
				<xsl:when test="areaid = 3844">Mok'Nathal Village</xsl:when>
				<xsl:when test="areaid = 3845">Tempest Keep</xsl:when>
				<xsl:when test="areaid = 3846">The Arcatraz</xsl:when>
				<xsl:when test="areaid = 3847">The Botanica</xsl:when>
				<xsl:when test="areaid = 3848">The Arcatraz</xsl:when>
				<xsl:when test="areaid = 3849">The Mechanar</xsl:when>
				<xsl:when test="areaid = 3850">Netherstone</xsl:when>
				<xsl:when test="areaid = 3851">Midrealm Post</xsl:when>
				<xsl:when test="areaid = 3852">Tuluman's Landing</xsl:when>
				<xsl:when test="areaid = 3854">Protectorate Watch Post</xsl:when>
				<xsl:when test="areaid = 3855">Circle of Blood Arena</xsl:when>
				<xsl:when test="areaid = 3856">Elrendar Crossing</xsl:when>
				<xsl:when test="areaid = 3857">Ammen Ford</xsl:when>
				<xsl:when test="areaid = 3858">Razorthorn Shelf</xsl:when>
				<xsl:when test="areaid = 3859">Silmyr Lake</xsl:when>
				<xsl:when test="areaid = 3860">Raastok Glade</xsl:when>
				<xsl:when test="areaid = 3861">Thalassian Pass</xsl:when>
				<xsl:when test="areaid = 3862">Churning Gulch</xsl:when>
				<xsl:when test="areaid = 3863">Broken Wilds</xsl:when>
				<xsl:when test="areaid = 3864">Bash'ir Landing</xsl:when>
				<xsl:when test="areaid = 3865">Crystal Spine</xsl:when>
				<xsl:when test="areaid = 3866">Skald</xsl:when>
				<xsl:when test="areaid = 3867">Bladed Gulch</xsl:when>
				<xsl:when test="areaid = 3868">Gyro-Plank Bridge</xsl:when>
				<xsl:when test="areaid = 3869">Mage Tower</xsl:when>
				<xsl:when test="areaid = 3870">Blood Elf Tower</xsl:when>
				<xsl:when test="areaid = 3871">Draenei Ruins</xsl:when>
				<xsl:when test="areaid = 3872">Fel Reaver Ruins</xsl:when>
				<xsl:when test="areaid = 3873">The Proving Grounds</xsl:when>
				<xsl:when test="areaid = 3874">Eco-Dome Farfield</xsl:when>
				<xsl:when test="areaid = 3875">Eco-Dome Skyperch</xsl:when>
				<xsl:when test="areaid = 3876">Eco-Dome Sutheron</xsl:when>
				<xsl:when test="areaid = 3877">Eco-Dome Midrealm</xsl:when>
				<xsl:when test="areaid = 3878">Ethereum Staging Grounds</xsl:when>
				<xsl:when test="areaid = 3879">Chapel Yard</xsl:when>
				<xsl:when test="areaid = 3880">Access Shaft Zeon</xsl:when>
				<xsl:when test="areaid = 3881">Trelleum Mine</xsl:when>
				<xsl:when test="areaid = 3882">Invasion Point: Destroyer</xsl:when>
				<xsl:when test="areaid = 3883">Camp of Boom</xsl:when>
				<xsl:when test="areaid = 3884">Spinebreaker Pass</xsl:when>
				<xsl:when test="areaid = 3885">Netherweb Ridge</xsl:when>
				<xsl:when test="areaid = 3886">Derelict Caravan</xsl:when>
				<xsl:when test="areaid = 3887">Refugee Caravan</xsl:when>
				<xsl:when test="areaid = 3888">Shadow Tomb</xsl:when>
				<xsl:when test="areaid = 3889">Veil Rhaze</xsl:when>
				<xsl:when test="areaid = 3890">Tomb of Lights</xsl:when>
				<xsl:when test="areaid = 3891">Carrion Hill</xsl:when>
				<xsl:when test="areaid = 3892">Writhing Mound</xsl:when>
				<xsl:when test="areaid = 3893">Ring of Observance</xsl:when>
				<xsl:when test="areaid = 3894">Auchenai Grounds</xsl:when>
				<xsl:when test="areaid = 3895">Cenarion Watchpost</xsl:when>
				<xsl:when test="areaid = 3896">Aldor Rise</xsl:when>
				<xsl:when test="areaid = 3897">Terrace of Light</xsl:when>
				<xsl:when test="areaid = 3898">Scryer's Tier</xsl:when>
				<xsl:when test="areaid = 3899">Lower City</xsl:when>
				<xsl:when test="areaid = 3900">Invasion Point: Overlord</xsl:when>
				<xsl:when test="areaid = 3901">Allerian Post</xsl:when>
				<xsl:when test="areaid = 3902">Stonebreaker Camp</xsl:when>
				<xsl:when test="areaid = 3903">Boulder'mok</xsl:when>
				<xsl:when test="areaid = 3904">Cursed Hollow</xsl:when>
				<xsl:when test="areaid = 3905">Coilfang Reservoir</xsl:when>
				<xsl:when test="areaid = 3906">The Bloodwash</xsl:when>
				<xsl:when test="areaid = 3907">Veridian Point</xsl:when>
				<xsl:when test="areaid = 3908">Middenvale</xsl:when>
				<xsl:when test="areaid = 3909">The Lost Fold</xsl:when>
				<xsl:when test="areaid = 3910">Mystwood</xsl:when>
				<xsl:when test="areaid = 3911">Tranquil Shore</xsl:when>
				<xsl:when test="areaid = 3912">Goldenbough Pass</xsl:when>
				<xsl:when test="areaid = 3913">Runestone Falithas</xsl:when>
				<xsl:when test="areaid = 3914">Runestone Shan'dor</xsl:when>
				<xsl:when test="areaid = 3915">Fairbridge Strand</xsl:when>
				<xsl:when test="areaid = 3916">Moongraze Woods</xsl:when>
				<xsl:when test="areaid = 3917">Auchindoun</xsl:when>
				<xsl:when test="areaid = 3918">Toshley's Station</xsl:when>
				<xsl:when test="areaid = 3919">Singing Ridge</xsl:when>
				<xsl:when test="areaid = 3920">Shatter Point</xsl:when>
				<xsl:when test="areaid = 3921">Arklonis Ridge</xsl:when>
				<xsl:when test="areaid = 3922">Bladespire Outpost</xsl:when>
				<xsl:when test="areaid = 3923">Gruul's Lair</xsl:when>
				<xsl:when test="areaid = 3924">Northmaul Tower</xsl:when>
				<xsl:when test="areaid = 3925">Southmaul Tower</xsl:when>
				<xsl:when test="areaid = 3926">Shattered Plains</xsl:when>
				<xsl:when test="areaid = 3927">Oronok's Farm</xsl:when>
				<xsl:when test="areaid = 3928">The Altar of Damnation</xsl:when>
				<xsl:when test="areaid = 3929">The Path of Conquest</xsl:when>
				<xsl:when test="areaid = 3930">Eclipsion Fields</xsl:when>
				<xsl:when test="areaid = 3931">Bladespire Grounds</xsl:when>
				<xsl:when test="areaid = 3932">Sketh'lon Base Camp</xsl:when>
				<xsl:when test="areaid = 3933">Sketh'lon Wreckage</xsl:when>
				<xsl:when test="areaid = 3934">Town Square</xsl:when>
				<xsl:when test="areaid = 3935">Wizard Row</xsl:when>
				<xsl:when test="areaid = 3936">Deathforge Tower</xsl:when>
				<xsl:when test="areaid = 3937">Slag Watch</xsl:when>
				<xsl:when test="areaid = 3938">Sanctum of the Stars</xsl:when>
				<xsl:when test="areaid = 3939">Dragonmaw Fortress</xsl:when>
				<xsl:when test="areaid = 3940">The Fetid Pool</xsl:when>
				<xsl:when test="areaid = 3941">Test</xsl:when>
				<xsl:when test="areaid = 3942">Razaan's Landing</xsl:when>
				<xsl:when test="areaid = 3943">Invasion Point: Cataclysm</xsl:when>
				<xsl:when test="areaid = 3944">The Altar of Shadows</xsl:when>
				<xsl:when test="areaid = 3945">Netherwing Pass</xsl:when>
				<xsl:when test="areaid = 3946">Wayne's Refuge</xsl:when>
				<xsl:when test="areaid = 3947">The Scalding Pools</xsl:when>
				<xsl:when test="areaid = 3948">Brian and Pat Test</xsl:when>
				<xsl:when test="areaid = 3949">Magma Fields</xsl:when>
				<xsl:when test="areaid = 3950">Crimson Watch</xsl:when>
				<xsl:when test="areaid = 3951">Evergrove</xsl:when>
				<xsl:when test="areaid = 3952">Wyrmskull Bridge</xsl:when>
				<xsl:when test="areaid = 3953">Scalewing Shelf</xsl:when>
				<xsl:when test="areaid = 3954">Wyrmskull Tunnel</xsl:when>
				<xsl:when test="areaid = 3955">Hellfire Basin</xsl:when>
				<xsl:when test="areaid = 3956">The Shadow Stair</xsl:when>
				<xsl:when test="areaid = 3957">Sha'tari Outpost</xsl:when>
				<xsl:when test="areaid = 3958">Sha'tari Base Camp</xsl:when>
				<xsl:when test="areaid = 3959">Black Temple</xsl:when>
				<xsl:when test="areaid = 3960">Soulgrinder's Barrow</xsl:when>
				<xsl:when test="areaid = 3961">Sorrow Wing Point</xsl:when>
				<xsl:when test="areaid = 3962">Vim'gol's Circle</xsl:when>
				<xsl:when test="areaid = 3963">Dragonspine Ridge</xsl:when>
				<xsl:when test="areaid = 3964">Skyguard Outpost</xsl:when>
				<xsl:when test="areaid = 3965">Netherwing Mines</xsl:when>
				<xsl:when test="areaid = 3966">Dragonmaw Base Camp</xsl:when>
				<xsl:when test="areaid = 3967">Dragonmaw Skyway</xsl:when>
				<xsl:when test="areaid = 3968">Ruins of Lordaeron</xsl:when>
				<xsl:when test="areaid = 3969">Rivendark's Perch</xsl:when>
				<xsl:when test="areaid = 3970">Obsidia's Perch</xsl:when>
				<xsl:when test="areaid = 3971">Insidion's Perch</xsl:when>
				<xsl:when test="areaid = 3972">Furywing's Perch</xsl:when>
				<xsl:when test="areaid = 3973">Blackwind Landing</xsl:when>
				<xsl:when test="areaid = 3974">Veil Harr'ik</xsl:when>
				<xsl:when test="areaid = 3975">Terokk's Rest</xsl:when>
				<xsl:when test="areaid = 3976">Veil Ala'rak</xsl:when>
				<xsl:when test="areaid = 3977">Upper Veil Shil'ak</xsl:when>
				<xsl:when test="areaid = 3978">Lower Veil Shil'ak</xsl:when>
				<xsl:when test="areaid = 3979">The Frozen Sea</xsl:when>
				<xsl:when test="areaid = 3980">Daggercap Bay</xsl:when>
				<xsl:when test="areaid = 3981">Valgarde</xsl:when>
				<xsl:when test="areaid = 3982">Wyrmskull Village</xsl:when>
				<xsl:when test="areaid = 3983">Utgarde Keep</xsl:when>
				<xsl:when test="areaid = 3984">Nifflevar</xsl:when>
				<xsl:when test="areaid = 3985">Falls of Ymiron</xsl:when>
				<xsl:when test="areaid = 3986">Echo Reach</xsl:when>
				<xsl:when test="areaid = 3987">The Isle of Spears</xsl:when>
				<xsl:when test="areaid = 3988">Kamagua</xsl:when>
				<xsl:when test="areaid = 3989">Garvan's Reef</xsl:when>
				<xsl:when test="areaid = 3990">Scalawag Point</xsl:when>
				<xsl:when test="areaid = 3991">New Agamand</xsl:when>
				<xsl:when test="areaid = 3992">The Ancient Lift</xsl:when>
				<xsl:when test="areaid = 3993">Westguard Turret</xsl:when>
				<xsl:when test="areaid = 3994">Halgrind</xsl:when>
				<xsl:when test="areaid = 3995">The Laughing Stand</xsl:when>
				<xsl:when test="areaid = 3996">Baelgun's Excavation Site</xsl:when>
				<xsl:when test="areaid = 3997">Explorers' League Outpost</xsl:when>
				<xsl:when test="areaid = 3998">Westguard Keep</xsl:when>
				<xsl:when test="areaid = 3999">Steel Gate</xsl:when>
				<xsl:when test="areaid = 4000">Vengeance Landing</xsl:when>
				<xsl:when test="areaid = 4001">Baleheim</xsl:when>
				<xsl:when test="areaid = 4002">Skorn</xsl:when>
				<xsl:when test="areaid = 4003">Fort Wildervar</xsl:when>
				<xsl:when test="areaid = 4004">Vileprey Village</xsl:when>
				<xsl:when test="areaid = 4005">Ivald's Ruin</xsl:when>
				<xsl:when test="areaid = 4006">Gjalerbron</xsl:when>
				<xsl:when test="areaid = 4007">Tomb of the Lost Kings</xsl:when>
				<xsl:when test="areaid = 4008">Shartuul's Transporter</xsl:when>
				<xsl:when test="areaid = 4009">Illidari Training Grounds</xsl:when>
				<xsl:when test="areaid = 4010">Mudsprocket</xsl:when>
				<xsl:when test="areaid = 4018">Camp Winterhoof</xsl:when>
				<xsl:when test="areaid = 4019">Development Land</xsl:when>
				<xsl:when test="areaid = 4020">Mightstone Quarry</xsl:when>
				<xsl:when test="areaid = 4021">Bloodspore Plains</xsl:when>
				<xsl:when test="areaid = 4022">Gammoth</xsl:when>
				<xsl:when test="areaid = 4023">Amber Ledge</xsl:when>
				<xsl:when test="areaid = 4024">Coldarra</xsl:when>
				<xsl:when test="areaid = 4025">The Westrift</xsl:when>
				<xsl:when test="areaid = 4026">The Transitus Stair</xsl:when>
				<xsl:when test="areaid = 4027">Coast of Echoes</xsl:when>
				<xsl:when test="areaid = 4028">Riplash Strand</xsl:when>
				<xsl:when test="areaid = 4029">Riplash Ruins</xsl:when>
				<xsl:when test="areaid = 4030">Coast of Idols</xsl:when>
				<xsl:when test="areaid = 4031">Pal'ea</xsl:when>
				<xsl:when test="areaid = 4032">Valiance Keep</xsl:when>
				<xsl:when test="areaid = 4033">Winterfin Village</xsl:when>
				<xsl:when test="areaid = 4034">The Borean Wall</xsl:when>
				<xsl:when test="areaid = 4035">The Geyser Fields</xsl:when>
				<xsl:when test="areaid = 4036">Fizzcrank Pumping Station</xsl:when>
				<xsl:when test="areaid = 4037">Taunka'le Village</xsl:when>
				<xsl:when test="areaid = 4038">Magnamoth Caverns</xsl:when>
				<xsl:when test="areaid = 4039">Coldrock Quarry</xsl:when>
				<xsl:when test="areaid = 4040">Njord's Breath Bay</xsl:when>
				<xsl:when test="areaid = 4041">Kaskala</xsl:when>
				<xsl:when test="areaid = 4042">Transborea</xsl:when>
				<xsl:when test="areaid = 4043">The Flood Plains</xsl:when>
				<xsl:when test="areaid = 4046">Direhorn Post</xsl:when>
				<xsl:when test="areaid = 4047">Nat's Landing</xsl:when>
				<xsl:when test="areaid = 4048">Ember Clutch</xsl:when>
				<xsl:when test="areaid = 4049">Tabetha's Farm</xsl:when>
				<xsl:when test="areaid = 4050">Derelict Strand</xsl:when>
				<xsl:when test="areaid = 4051">The Frozen Glade</xsl:when>
				<xsl:when test="areaid = 4052">The Vibrant Glade</xsl:when>
				<xsl:when test="areaid = 4053">The Twisted Glade</xsl:when>
				<xsl:when test="areaid = 4054">Rivenwood</xsl:when>
				<xsl:when test="areaid = 4055">Caldemere Lake</xsl:when>
				<xsl:when test="areaid = 4056">Utgarde Catacombs</xsl:when>
				<xsl:when test="areaid = 4057">Shield Hill</xsl:when>
				<xsl:when test="areaid = 4058">Lake Cauldros</xsl:when>
				<xsl:when test="areaid = 4059">Cauldros Isle</xsl:when>
				<xsl:when test="areaid = 4060">Bleeding Vale</xsl:when>
				<xsl:when test="areaid = 4061">Giants' Run</xsl:when>
				<xsl:when test="areaid = 4062">Apothecary Camp</xsl:when>
				<xsl:when test="areaid = 4063">Ember Spear Tower</xsl:when>
				<xsl:when test="areaid = 4064">Shattered Straits</xsl:when>
				<xsl:when test="areaid = 4065">Gjalerhorn</xsl:when>
				<xsl:when test="areaid = 4066">Frostblade Peak</xsl:when>
				<xsl:when test="areaid = 4067">Plaguewood Tower</xsl:when>
				<xsl:when test="areaid = 4068">West Spear Tower</xsl:when>
				<xsl:when test="areaid = 4069">North Spear Tower</xsl:when>
				<xsl:when test="areaid = 4070">Chillmere Coast</xsl:when>
				<xsl:when test="areaid = 4071">Whisper Gulch</xsl:when>
				<xsl:when test="areaid = 4072">Sub zone</xsl:when>
				<xsl:when test="areaid = 4073">Winter's Terrace</xsl:when>
				<xsl:when test="areaid = 4074">The Waking Halls</xsl:when>
				<xsl:when test="areaid = 4075">Sunwell Plateau</xsl:when>
				<xsl:when test="areaid = 4076">Reuse Me 7</xsl:when>
				<xsl:when test="areaid = 4077">Sorlof's Strand</xsl:when>
				<xsl:when test="areaid = 4078">Razorthorn Rise</xsl:when>
				<xsl:when test="areaid = 4079">Frostblade Pass</xsl:when>
				<xsl:when test="areaid = 4080">Isle of Quel'Danas</xsl:when>
				<xsl:when test="areaid = 4081">The Dawnchaser</xsl:when>
				<xsl:when test="areaid = 4082">The Sin'loren</xsl:when>
				<xsl:when test="areaid = 4083">Silvermoon's Pride</xsl:when>
				<xsl:when test="areaid = 4084">The Bloodoath</xsl:when>
				<xsl:when test="areaid = 4085">Shattered Sun Staging Area</xsl:when>
				<xsl:when test="areaid = 4086">Sun's Reach Sanctum</xsl:when>
				<xsl:when test="areaid = 4087">Sun's Reach Harbor</xsl:when>
				<xsl:when test="areaid = 4088">Sun's Reach Armory</xsl:when>
				<xsl:when test="areaid = 4089">Dawnstar Village</xsl:when>
				<xsl:when test="areaid = 4090">The Dawning Square</xsl:when>
				<xsl:when test="areaid = 4091">Greengill Coast</xsl:when>
				<xsl:when test="areaid = 4092">The Dead Scar</xsl:when>
				<xsl:when test="areaid = 4093">The Sun Forge</xsl:when>
				<xsl:when test="areaid = 4094">Sunwell Plateau</xsl:when>
				<xsl:when test="areaid = 4095">Magisters' Terrace</xsl:when>
				<xsl:when test="areaid = 4096">Claytön's WoWEdit Land</xsl:when>
				<xsl:when test="areaid = 4097">Winterfin Caverns</xsl:when>
				<xsl:when test="areaid = 4098">Glimmer Bay</xsl:when>
				<xsl:when test="areaid = 4099">Winterfin Retreat</xsl:when>
				<xsl:when test="areaid = 4100">The Culling of Stratholme</xsl:when>
				<xsl:when test="areaid = 4101">Sands of Nasam</xsl:when>
				<xsl:when test="areaid = 4102">Krom's Landing</xsl:when>
				<xsl:when test="areaid = 4103">Nasam's Talon</xsl:when>
				<xsl:when test="areaid = 4104">Echo Cove</xsl:when>
				<xsl:when test="areaid = 4105">Beryl Point</xsl:when>
				<xsl:when test="areaid = 4106">Garrosh's Landing</xsl:when>
				<xsl:when test="areaid = 4107">Warsong Jetty</xsl:when>
				<xsl:when test="areaid = 4108">Fizzcrank Airstrip</xsl:when>
				<xsl:when test="areaid = 4109">Lake Kum'uya</xsl:when>
				<xsl:when test="areaid = 4110">Farshire Fields</xsl:when>
				<xsl:when test="areaid = 4111">Farshire</xsl:when>
				<xsl:when test="areaid = 4112">Farshire Lighthouse</xsl:when>
				<xsl:when test="areaid = 4113">Unu'pe</xsl:when>
				<xsl:when test="areaid = 4114">Death's Stand</xsl:when>
				<xsl:when test="areaid = 4115">The Abandoned Reach</xsl:when>
				<xsl:when test="areaid = 4116">Scalding Pools</xsl:when>
				<xsl:when test="areaid = 4117">Steam Springs</xsl:when>
				<xsl:when test="areaid = 4118">Talramas</xsl:when>
				<xsl:when test="areaid = 4119">Festering Pools</xsl:when>
				<xsl:when test="areaid = 4120">The Nexus</xsl:when>
				<xsl:when test="areaid = 4121">Transitus Shield</xsl:when>
				<xsl:when test="areaid = 4122">Bor'gorok Outpost</xsl:when>
				<xsl:when test="areaid = 4123">Magmoth</xsl:when>
				<xsl:when test="areaid = 4124">The Dens of Dying</xsl:when>
				<xsl:when test="areaid = 4125">Temple City of En'kilah</xsl:when>
				<xsl:when test="areaid = 4126">The Wailing Ziggurat</xsl:when>
				<xsl:when test="areaid = 4127">Steeljaw's Caravan</xsl:when>
				<xsl:when test="areaid = 4128">Naxxanar</xsl:when>
				<xsl:when test="areaid = 4129">Warsong Hold</xsl:when>
				<xsl:when test="areaid = 4130">Plains of Nasam</xsl:when>
				<xsl:when test="areaid = 4131">Magisters' Terrace</xsl:when>
				<xsl:when test="areaid = 4132">Ruins of Eldra'nath</xsl:when>
				<xsl:when test="areaid = 4133">Charred Rise</xsl:when>
				<xsl:when test="areaid = 4134">Blistering Pool</xsl:when>
				<xsl:when test="areaid = 4135">Spire of Blood</xsl:when>
				<xsl:when test="areaid = 4136">Spire of Decay</xsl:when>
				<xsl:when test="areaid = 4137">Spire of Pain</xsl:when>
				<xsl:when test="areaid = 4138">Frozen Reach</xsl:when>
				<xsl:when test="areaid = 4139">Parhelion Plaza</xsl:when>
				<xsl:when test="areaid = 4140">The Dead Scar</xsl:when>
				<xsl:when test="areaid = 4141">Torp's Farm</xsl:when>
				<xsl:when test="areaid = 4142">Warsong Granary</xsl:when>
				<xsl:when test="areaid = 4143">Warsong Slaughterhouse</xsl:when>
				<xsl:when test="areaid = 4144">Warsong Farms Outpost</xsl:when>
				<xsl:when test="areaid = 4145">West Point Station</xsl:when>
				<xsl:when test="areaid = 4146">North Point Station</xsl:when>
				<xsl:when test="areaid = 4147">Mid Point Station</xsl:when>
				<xsl:when test="areaid = 4148">South Point Station</xsl:when>
				<xsl:when test="areaid = 4149">D.E.H.T.A. Encampment</xsl:when>
				<xsl:when test="areaid = 4150">Kaw's Roost</xsl:when>
				<xsl:when test="areaid = 4151">Westwind Refugee Camp</xsl:when>
				<xsl:when test="areaid = 4152">Moa'ki Harbor</xsl:when>
				<xsl:when test="areaid = 4153">Indu'le Village</xsl:when>
				<xsl:when test="areaid = 4154">Snowfall Glade</xsl:when>
				<xsl:when test="areaid = 4155">The Half Shell</xsl:when>
				<xsl:when test="areaid = 4156">Surge Needle</xsl:when>
				<xsl:when test="areaid = 4157">Moonrest Gardens</xsl:when>
				<xsl:when test="areaid = 4158">Stars' Rest</xsl:when>
				<xsl:when test="areaid = 4159">Westfall Brigade Encampment</xsl:when>
				<xsl:when test="areaid = 4160">Lothalor Woodlands</xsl:when>
				<xsl:when test="areaid = 4161">Wyrmrest Temple</xsl:when>
				<xsl:when test="areaid = 4162">Icemist Falls</xsl:when>
				<xsl:when test="areaid = 4163">Icemist Village</xsl:when>
				<xsl:when test="areaid = 4164">The Pit of Narjun</xsl:when>
				<xsl:when test="areaid = 4165">Agmar's Hammer</xsl:when>
				<xsl:when test="areaid = 4166">Lake Indu'le</xsl:when>
				<xsl:when test="areaid = 4167">Obsidian Dragonshrine</xsl:when>
				<xsl:when test="areaid = 4168">Ruby Dragonshrine</xsl:when>
				<xsl:when test="areaid = 4169">Fordragon Hold</xsl:when>
				<xsl:when test="areaid = 4170">Kor'kron Vanguard</xsl:when>
				<xsl:when test="areaid = 4171">The Court of Skulls</xsl:when>
				<xsl:when test="areaid = 4172">Angrathar the Wrathgate</xsl:when>
				<xsl:when test="areaid = 4173">Galakrond's Rest</xsl:when>
				<xsl:when test="areaid = 4174">The Wicked Coil</xsl:when>
				<xsl:when test="areaid = 4175">Bronze Dragonshrine</xsl:when>
				<xsl:when test="areaid = 4176">The Mirror of Dawn</xsl:when>
				<xsl:when test="areaid = 4177">Wintergarde Keep</xsl:when>
				<xsl:when test="areaid = 4178">Wintergarde Mine</xsl:when>
				<xsl:when test="areaid = 4179">Emerald Dragonshrine</xsl:when>
				<xsl:when test="areaid = 4180">New Hearthglen</xsl:when>
				<xsl:when test="areaid = 4181">Crusader's Landing</xsl:when>
				<xsl:when test="areaid = 4182">Sinner's Folly</xsl:when>
				<xsl:when test="areaid = 4183">Azure Dragonshrine</xsl:when>
				<xsl:when test="areaid = 4184">Path of the Titans</xsl:when>
				<xsl:when test="areaid = 4185">The Forgotten Shore</xsl:when>
				<xsl:when test="areaid = 4186">Venomspite</xsl:when>
				<xsl:when test="areaid = 4187">The Crystal Vice</xsl:when>
				<xsl:when test="areaid = 4188">The Carrion Fields</xsl:when>
				<xsl:when test="areaid = 4189">Onslaught Base Camp</xsl:when>
				<xsl:when test="areaid = 4190">Thorson's Post</xsl:when>
				<xsl:when test="areaid = 4191">Light's Trust</xsl:when>
				<xsl:when test="areaid = 4192">Frostmourne Cavern</xsl:when>
				<xsl:when test="areaid = 4193">Scarlet Point</xsl:when>
				<xsl:when test="areaid = 4194">Jintha'kalar</xsl:when>
				<xsl:when test="areaid = 4195">Ice Heart Cavern</xsl:when>
				<xsl:when test="areaid = 4196">Drak'Tharon Keep</xsl:when>
				<xsl:when test="areaid = 4197">Wintergrasp</xsl:when>
				<xsl:when test="areaid = 4198">Kili'ua's Atoll</xsl:when>
				<xsl:when test="areaid = 4199">Silverbrook</xsl:when>
				<xsl:when test="areaid = 4200">Vordrassil's Heart</xsl:when>
				<xsl:when test="areaid = 4201">Vordrassil's Tears</xsl:when>
				<xsl:when test="areaid = 4202">Vordrassil's Tears</xsl:when>
				<xsl:when test="areaid = 4203">Vordrassil's Limb</xsl:when>
				<xsl:when test="areaid = 4204">Amberpine Lodge</xsl:when>
				<xsl:when test="areaid = 4205">Solstice Village</xsl:when>
				<xsl:when test="areaid = 4206">Conquest Hold</xsl:when>
				<xsl:when test="areaid = 4207">Voldrune</xsl:when>
				<xsl:when test="areaid = 4208">Granite Springs</xsl:when>
				<xsl:when test="areaid = 4209">Zeb'Halak</xsl:when>
				<xsl:when test="areaid = 4210">Drak'Tharon Keep</xsl:when>
				<xsl:when test="areaid = 4211">Camp Oneqwah</xsl:when>
				<xsl:when test="areaid = 4212">Eastwind Shore</xsl:when>
				<xsl:when test="areaid = 4213">The Broken Bluffs</xsl:when>
				<xsl:when test="areaid = 4214">Boulder Hills</xsl:when>
				<xsl:when test="areaid = 4215">Rage Fang Shrine</xsl:when>
				<xsl:when test="areaid = 4216">Drakil'jin Ruins</xsl:when>
				<xsl:when test="areaid = 4217">Blackriver Logging Camp</xsl:when>
				<xsl:when test="areaid = 4218">Heart's Blood Shrine</xsl:when>
				<xsl:when test="areaid = 4219">Hollowstone Mine</xsl:when>
				<xsl:when test="areaid = 4220">Dun Argol</xsl:when>
				<xsl:when test="areaid = 4221">Thor Modan</xsl:when>
				<xsl:when test="areaid = 4222">Blue Sky Logging Grounds</xsl:when>
				<xsl:when test="areaid = 4223">Maw of Neltharion</xsl:when>
				<xsl:when test="areaid = 4224">The Briny Pinnacle</xsl:when>
				<xsl:when test="areaid = 4225">Glittering Strand</xsl:when>
				<xsl:when test="areaid = 4226">Iskaal</xsl:when>
				<xsl:when test="areaid = 4227">Dragon's Fall</xsl:when>
				<xsl:when test="areaid = 4228">The Oculus</xsl:when>
				<xsl:when test="areaid = 4229">Prospector's Point</xsl:when>
				<xsl:when test="areaid = 4230">Coldwind Heights</xsl:when>
				<xsl:when test="areaid = 4231">Redwood Trading Post</xsl:when>
				<xsl:when test="areaid = 4232">Vengeance Pass</xsl:when>
				<xsl:when test="areaid = 4233">Dawn's Reach</xsl:when>
				<xsl:when test="areaid = 4234">Naxxramas</xsl:when>
				<xsl:when test="areaid = 4235">Heartwood Trading Post</xsl:when>
				<xsl:when test="areaid = 4236">Evergreen Trading Post</xsl:when>
				<xsl:when test="areaid = 4237">Spruce Point Post</xsl:when>
				<xsl:when test="areaid = 4238">White Pine Trading Post</xsl:when>
				<xsl:when test="areaid = 4239">Aspen Grove Post</xsl:when>
				<xsl:when test="areaid = 4240">Forest's Edge Post</xsl:when>
				<xsl:when test="areaid = 4241">Eldritch Heights</xsl:when>
				<xsl:when test="areaid = 4242">Venture Bay</xsl:when>
				<xsl:when test="areaid = 4243">Wintergarde Crypt</xsl:when>
				<xsl:when test="areaid = 4244">Bloodmoon Isle</xsl:when>
				<xsl:when test="areaid = 4245">Shadowfang Tower</xsl:when>
				<xsl:when test="areaid = 4246">Wintergarde Mausoleum</xsl:when>
				<xsl:when test="areaid = 4247">Duskhowl Den</xsl:when>
				<xsl:when test="areaid = 4248">The Conquest Pit</xsl:when>
				<xsl:when test="areaid = 4249">The Path of Iron</xsl:when>
				<xsl:when test="areaid = 4250">Ruins of Tethys</xsl:when>
				<xsl:when test="areaid = 4251">Silverbrook Hills</xsl:when>
				<xsl:when test="areaid = 4252">The Broken Bluffs</xsl:when>
				<xsl:when test="areaid = 4253">7th Legion Front</xsl:when>
				<xsl:when test="areaid = 4254">The Dragon Wastes</xsl:when>
				<xsl:when test="areaid = 4255">Ruins of Drak'Zin</xsl:when>
				<xsl:when test="areaid = 4256">Drak'Mar Lake</xsl:when>
				<xsl:when test="areaid = 4257">Dragonspine Tributary</xsl:when>
				<xsl:when test="areaid = 4258">The North Sea</xsl:when>
				<xsl:when test="areaid = 4259">Drak'ural</xsl:when>
				<xsl:when test="areaid = 4260">Thorvald's Camp</xsl:when>
				<xsl:when test="areaid = 4261">Ghostblade Post</xsl:when>
				<xsl:when test="areaid = 4262">Ashwood Post</xsl:when>
				<xsl:when test="areaid = 4263">Lydell's Ambush</xsl:when>
				<xsl:when test="areaid = 4264">Halls of Stone</xsl:when>
				<xsl:when test="areaid = 4265">The Nexus</xsl:when>
				<xsl:when test="areaid = 4266">Harkor's Camp</xsl:when>
				<xsl:when test="areaid = 4267">Vordrassil Pass</xsl:when>
				<xsl:when test="areaid = 4268">Ruuna's Camp</xsl:when>
				<xsl:when test="areaid = 4269">Shrine of Scales</xsl:when>
				<xsl:when test="areaid = 4270">Drak'atal Passage</xsl:when>
				<xsl:when test="areaid = 4271">Utgarde Pinnacle</xsl:when>
				<xsl:when test="areaid = 4272">Halls of Lightning</xsl:when>
				<xsl:when test="areaid = 4273">Ulduar</xsl:when>
				<xsl:when test="areaid = 4275">The Argent Stand</xsl:when>
				<xsl:when test="areaid = 4276">Altar of Sseratus</xsl:when>
				<xsl:when test="areaid = 4277">Azjol-Nerub</xsl:when>
				<xsl:when test="areaid = 4278">Drak'Sotra Fields</xsl:when>
				<xsl:when test="areaid = 4279">Drak'Sotra</xsl:when>
				<xsl:when test="areaid = 4280">Drak'Agal</xsl:when>
				<xsl:when test="areaid = 4281">Acherus: The Ebon Hold</xsl:when>
				<xsl:when test="areaid = 4282">The Avalanche</xsl:when>
				<xsl:when test="areaid = 4283">The Lost Lands</xsl:when>
				<xsl:when test="areaid = 4284">Nesingwary Base Camp</xsl:when>
				<xsl:when test="areaid = 4285">The Seabreach Flow</xsl:when>
				<xsl:when test="areaid = 4286">The Bones of Nozronn</xsl:when>
				<xsl:when test="areaid = 4287">Kartak's Hold</xsl:when>
				<xsl:when test="areaid = 4288">Sparktouched Haven</xsl:when>
				<xsl:when test="areaid = 4289">The Path of the Lifewarden</xsl:when>
				<xsl:when test="areaid = 4290">River's Heart</xsl:when>
				<xsl:when test="areaid = 4291">Rainspeaker Canopy</xsl:when>
				<xsl:when test="areaid = 4292">Frenzyheart Hill</xsl:when>
				<xsl:when test="areaid = 4293">Wildgrowth Mangal</xsl:when>
				<xsl:when test="areaid = 4294">Heb'Valok</xsl:when>
				<xsl:when test="areaid = 4295">The Sundered Shard</xsl:when>
				<xsl:when test="areaid = 4296">The Lifeblood Pillar</xsl:when>
				<xsl:when test="areaid = 4297">Mosswalker Village</xsl:when>
				<xsl:when test="areaid = 4298">Plaguelands: The Scarlet Enclave</xsl:when>
				<xsl:when test="areaid = 4299">Kolramas</xsl:when>
				<xsl:when test="areaid = 4300">Waygate</xsl:when>
				<xsl:when test="areaid = 4302">The Skyreach Pillar</xsl:when>
				<xsl:when test="areaid = 4303">Hardknuckle Clearing</xsl:when>
				<xsl:when test="areaid = 4304">Sapphire Hive</xsl:when>
				<xsl:when test="areaid = 4306">Mistwhisper Refuge</xsl:when>
				<xsl:when test="areaid = 4307">The Glimmering Pillar</xsl:when>
				<xsl:when test="areaid = 4308">Spearborn Encampment</xsl:when>
				<xsl:when test="areaid = 4309">Drak'Tharon Keep</xsl:when>
				<xsl:when test="areaid = 4310">Zeramas</xsl:when>
				<xsl:when test="areaid = 4311">Reliquary of Agony</xsl:when>
				<xsl:when test="areaid = 4312">Ebon Watch</xsl:when>
				<xsl:when test="areaid = 4313">Thrym's End</xsl:when>
				<xsl:when test="areaid = 4314">Voltarus</xsl:when>
				<xsl:when test="areaid = 4315">Reliquary of Pain</xsl:when>
				<xsl:when test="areaid = 4316">Rageclaw Den</xsl:when>
				<xsl:when test="areaid = 4317">Light's Breach</xsl:when>
				<xsl:when test="areaid = 4318">Pools of Zha'Jin</xsl:when>
				<xsl:when test="areaid = 4319">Zim'Abwa</xsl:when>
				<xsl:when test="areaid = 4320">Amphitheater of Anguish</xsl:when>
				<xsl:when test="areaid = 4321">Altar of Rhunok</xsl:when>
				<xsl:when test="areaid = 4322">Altar of Har'koa</xsl:when>
				<xsl:when test="areaid = 4323">Zim'Torga</xsl:when>
				<xsl:when test="areaid = 4324">Pools of Jin'Alai</xsl:when>
				<xsl:when test="areaid = 4325">Altar of Quetz'lun</xsl:when>
				<xsl:when test="areaid = 4326">Heb'Drakkar</xsl:when>
				<xsl:when test="areaid = 4327">Drak'Mabwa</xsl:when>
				<xsl:when test="areaid = 4328">Zim'Rhuk</xsl:when>
				<xsl:when test="areaid = 4329">Altar of Mam'toth</xsl:when>
				<xsl:when test="areaid = 4342">Acherus: The Ebon Hold</xsl:when>
				<xsl:when test="areaid = 4343">New Avalon</xsl:when>
				<xsl:when test="areaid = 4344">New Avalon Fields</xsl:when>
				<xsl:when test="areaid = 4345">New Avalon Orchard</xsl:when>
				<xsl:when test="areaid = 4346">New Avalon Town Hall</xsl:when>
				<xsl:when test="areaid = 4347">Havenshire</xsl:when>
				<xsl:when test="areaid = 4348">Havenshire Farms</xsl:when>
				<xsl:when test="areaid = 4349">Havenshire Lumber Mill</xsl:when>
				<xsl:when test="areaid = 4350">Havenshire Stables</xsl:when>
				<xsl:when test="areaid = 4351">Scarlet Hold</xsl:when>
				<xsl:when test="areaid = 4352">Chapel of the Crimson Flame</xsl:when>
				<xsl:when test="areaid = 4353">Light's Point Tower</xsl:when>
				<xsl:when test="areaid = 4354">Light's Point</xsl:when>
				<xsl:when test="areaid = 4355">Crypt of Remembrance</xsl:when>
				<xsl:when test="areaid = 4356">Death's Breach</xsl:when>
				<xsl:when test="areaid = 4357">The Noxious Glade</xsl:when>
				<xsl:when test="areaid = 4358">Tyr's Hand</xsl:when>
				<xsl:when test="areaid = 4359">King's Harbor</xsl:when>
				<xsl:when test="areaid = 4360">Scarlet Overlook</xsl:when>
				<xsl:when test="areaid = 4361">Light's Hope Chapel</xsl:when>
				<xsl:when test="areaid = 4362">Sinner's Folly</xsl:when>
				<xsl:when test="areaid = 4363">Pestilent Scar</xsl:when>
				<xsl:when test="areaid = 4364">Browman Mill</xsl:when>
				<xsl:when test="areaid = 4365">Havenshire Mine</xsl:when>
				<xsl:when test="areaid = 4366">Ursoc's Den</xsl:when>
				<xsl:when test="areaid = 4367">The Blight Line</xsl:when>
				<xsl:when test="areaid = 4368">The Bonefields</xsl:when>
				<xsl:when test="areaid = 4369">Dorian's Outpost</xsl:when>
				<xsl:when test="areaid = 4371">Mam'toth Crater</xsl:when>
				<xsl:when test="areaid = 4372">Zol'Maz Stronghold</xsl:when>
				<xsl:when test="areaid = 4373">Zol'Heb</xsl:when>
				<xsl:when test="areaid = 4374">Rageclaw Lake</xsl:when>
				<xsl:when test="areaid = 4375">Gundrak</xsl:when>
				<xsl:when test="areaid = 4376">The Savage Thicket</xsl:when>
				<xsl:when test="areaid = 4377">New Avalon Forge</xsl:when>
				<xsl:when test="areaid = 4378">Dalaran Arena</xsl:when>
				<xsl:when test="areaid = 4379">Valgarde</xsl:when>
				<xsl:when test="areaid = 4380">Westguard Inn</xsl:when>
				<xsl:when test="areaid = 4381">Waygate</xsl:when>
				<xsl:when test="areaid = 4382">The Shaper's Terrace</xsl:when>
				<xsl:when test="areaid = 4383">Lakeside Landing</xsl:when>
				<xsl:when test="areaid = 4384">Strand of the Ancients</xsl:when>
				<xsl:when test="areaid = 4385">Bittertide Lake</xsl:when>
				<xsl:when test="areaid = 4386">Rainspeaker Rapids</xsl:when>
				<xsl:when test="areaid = 4387">Frenzyheart River</xsl:when>
				<xsl:when test="areaid = 4388">Wintergrasp River</xsl:when>
				<xsl:when test="areaid = 4389">The Suntouched Pillar</xsl:when>
				<xsl:when test="areaid = 4390">Frigid Breach</xsl:when>
				<xsl:when test="areaid = 4391">Swindlegrin's Dig</xsl:when>
				<xsl:when test="areaid = 4392">The Stormwright's Shelf</xsl:when>
				<xsl:when test="areaid = 4393">Death's Hand Encampment</xsl:when>
				<xsl:when test="areaid = 4394">Scarlet Tavern</xsl:when>
				<xsl:when test="areaid = 4395">Dalaran</xsl:when>
				<xsl:when test="areaid = 4396">Nozzlerust Post</xsl:when>
				<xsl:when test="areaid = 4399">Farshire Mine</xsl:when>
				<xsl:when test="areaid = 4400">The Mosslight Pillar</xsl:when>
				<xsl:when test="areaid = 4401">Saragosa's Landing</xsl:when>
				<xsl:when test="areaid = 4402">Vengeance Lift</xsl:when>
				<xsl:when test="areaid = 4403">Balejar Watch</xsl:when>
				<xsl:when test="areaid = 4404">New Agamand Inn</xsl:when>
				<xsl:when test="areaid = 4405">Passage of Lost Fiends</xsl:when>
				<xsl:when test="areaid = 4406">The Ring of Valor</xsl:when>
				<xsl:when test="areaid = 4407">Hall of the Frostwolf</xsl:when>
				<xsl:when test="areaid = 4408">Hall of the Stormpike</xsl:when>
				<xsl:when test="areaid = 4411">Stormwind Harbor</xsl:when>
				<xsl:when test="areaid = 4412">The Makers' Overlook</xsl:when>
				<xsl:when test="areaid = 4413">The Makers' Perch</xsl:when>
				<xsl:when test="areaid = 4414">Scarlet Tower</xsl:when>
				<xsl:when test="areaid = 4415">The Violet Hold</xsl:when>
				<xsl:when test="areaid = 4416">Gundrak</xsl:when>
				<xsl:when test="areaid = 4417">Onslaught Harbor</xsl:when>
				<xsl:when test="areaid = 4418">K3</xsl:when>
				<xsl:when test="areaid = 4419">Snowblind Hills</xsl:when>
				<xsl:when test="areaid = 4420">Snowblind Terrace</xsl:when>
				<xsl:when test="areaid = 4421">Garm</xsl:when>
				<xsl:when test="areaid = 4422">Brunnhildar Village</xsl:when>
				<xsl:when test="areaid = 4423">Sifreldar Village</xsl:when>
				<xsl:when test="areaid = 4424">Valkyrion</xsl:when>
				<xsl:when test="areaid = 4425">The Forlorn Mine</xsl:when>
				<xsl:when test="areaid = 4426">Bor's Breath River</xsl:when>
				<xsl:when test="areaid = 4427">Argent Vanguard</xsl:when>
				<xsl:when test="areaid = 4428">Frosthold</xsl:when>
				<xsl:when test="areaid = 4429">Grom'arsh Crash-Site</xsl:when>
				<xsl:when test="areaid = 4430">Temple of Storms</xsl:when>
				<xsl:when test="areaid = 4431">Engine of the Makers</xsl:when>
				<xsl:when test="areaid = 4432">The Foot Steppes</xsl:when>
				<xsl:when test="areaid = 4433">Dragonspine Peaks</xsl:when>
				<xsl:when test="areaid = 4434">Nidavelir</xsl:when>
				<xsl:when test="areaid = 4435">Narvir's Cradle</xsl:when>
				<xsl:when test="areaid = 4436">Snowdrift Plains</xsl:when>
				<xsl:when test="areaid = 4437">Valley of Ancient Winters</xsl:when>
				<xsl:when test="areaid = 4438">Dun Niffelem</xsl:when>
				<xsl:when test="areaid = 4439">Frostfield Lake</xsl:when>
				<xsl:when test="areaid = 4440">Thunderfall</xsl:when>
				<xsl:when test="areaid = 4441">Camp Tunka'lo</xsl:when>
				<xsl:when test="areaid = 4442">Brann's Base-Camp</xsl:when>
				<xsl:when test="areaid = 4443">Gate of Echoes</xsl:when>
				<xsl:when test="areaid = 4444">Plain of Echoes</xsl:when>
				<xsl:when test="areaid = 4445">Ulduar</xsl:when>
				<xsl:when test="areaid = 4446">Terrace of the Makers</xsl:when>
				<xsl:when test="areaid = 4447">Gate of Lightning</xsl:when>
				<xsl:when test="areaid = 4448">Path of the Titans</xsl:when>
				<xsl:when test="areaid = 4449">Uldis</xsl:when>
				<xsl:when test="areaid = 4450">Loken's Bargain</xsl:when>
				<xsl:when test="areaid = 4451">Bor's Fall</xsl:when>
				<xsl:when test="areaid = 4452">Bor's Breath</xsl:when>
				<xsl:when test="areaid = 4453">Rohemdal Pass</xsl:when>
				<xsl:when test="areaid = 4454">The Storm Foundry</xsl:when>
				<xsl:when test="areaid = 4455">Hibernal Cavern</xsl:when>
				<xsl:when test="areaid = 4456">Voldrune Dwelling</xsl:when>
				<xsl:when test="areaid = 4457">Torseg's Rest</xsl:when>
				<xsl:when test="areaid = 4458">Sparksocket Minefield</xsl:when>
				<xsl:when test="areaid = 4459">Ricket's Folly</xsl:when>
				<xsl:when test="areaid = 4460">Garm's Bane</xsl:when>
				<xsl:when test="areaid = 4461">Garm's Rise</xsl:when>
				<xsl:when test="areaid = 4462">Crystalweb Cavern</xsl:when>
				<xsl:when test="areaid = 4463">Temple of Life</xsl:when>
				<xsl:when test="areaid = 4464">Temple of Order</xsl:when>
				<xsl:when test="areaid = 4465">Temple of Winter</xsl:when>
				<xsl:when test="areaid = 4466">Temple of Invention</xsl:when>
				<xsl:when test="areaid = 4467">Death's Rise</xsl:when>
				<xsl:when test="areaid = 4468">The Dead Fields</xsl:when>
				<xsl:when test="areaid = 4469">Dargath's Demise</xsl:when>
				<xsl:when test="areaid = 4470">The Hidden Hollow</xsl:when>
				<xsl:when test="areaid = 4471">Bernau's Happy Fun Land</xsl:when>
				<xsl:when test="areaid = 4472">Frostgrip's Hollow</xsl:when>
				<xsl:when test="areaid = 4473">The Frigid Tomb</xsl:when>
				<xsl:when test="areaid = 4474">Twin Shores</xsl:when>
				<xsl:when test="areaid = 4475">Zim'bo's Hideout</xsl:when>
				<xsl:when test="areaid = 4476">Abandoned Camp</xsl:when>
				<xsl:when test="areaid = 4477">The Shadow Vault</xsl:when>
				<xsl:when test="areaid = 4478">Coldwind Pass</xsl:when>
				<xsl:when test="areaid = 4479">Winter's Breath Lake</xsl:when>
				<xsl:when test="areaid = 4480">The Forgotten Overlook</xsl:when>
				<xsl:when test="areaid = 4481">Jintha'kalar Passage</xsl:when>
				<xsl:when test="areaid = 4482">Arriga Footbridge</xsl:when>
				<xsl:when test="areaid = 4483">The Lost Passage</xsl:when>
				<xsl:when test="areaid = 4484">Bouldercrag's Refuge</xsl:when>
				<xsl:when test="areaid = 4485">The Inventor's Library</xsl:when>
				<xsl:when test="areaid = 4486">The Frozen Mine</xsl:when>
				<xsl:when test="areaid = 4487">Frostfloe Deep</xsl:when>
				<xsl:when test="areaid = 4488">The Howling Hollow</xsl:when>
				<xsl:when test="areaid = 4489">Crusader Forward Camp</xsl:when>
				<xsl:when test="areaid = 4490">Stormcrest</xsl:when>
				<xsl:when test="areaid = 4491">Bonesnap's Camp</xsl:when>
				<xsl:when test="areaid = 4492">Ufrang's Hall</xsl:when>
				<xsl:when test="areaid = 4493">The Obsidian Sanctum</xsl:when>
				<xsl:when test="areaid = 4494">Ahn'kahet: The Old Kingdom</xsl:when>
				<xsl:when test="areaid = 4495">Fjorn's Anvil</xsl:when>
				<xsl:when test="areaid = 4496">Jotunheim</xsl:when>
				<xsl:when test="areaid = 4497">Savage Ledge</xsl:when>
				<xsl:when test="areaid = 4498">Halls of the Ancestors</xsl:when>
				<xsl:when test="areaid = 4499">The Blighted Pool</xsl:when>
				<xsl:when test="areaid = 4500">The Eye of Eternity</xsl:when>
				<xsl:when test="areaid = 4501">The Argent Vanguard</xsl:when>
				<xsl:when test="areaid = 4502">Mimir's Workshop</xsl:when>
				<xsl:when test="areaid = 4503">Ironwall Dam</xsl:when>
				<xsl:when test="areaid = 4504">Valley of Echoes</xsl:when>
				<xsl:when test="areaid = 4505">The Breach</xsl:when>
				<xsl:when test="areaid = 4506">Scourgeholme</xsl:when>
				<xsl:when test="areaid = 4507">The Broken Front</xsl:when>
				<xsl:when test="areaid = 4508">Mord'rethar: The Death Gate</xsl:when>
				<xsl:when test="areaid = 4509">The Bombardment</xsl:when>
				<xsl:when test="areaid = 4510">Aldur'thar: The Desolation Gate</xsl:when>
				<xsl:when test="areaid = 4511">The Skybreaker</xsl:when>
				<xsl:when test="areaid = 4512">Orgrim's Hammer</xsl:when>
				<xsl:when test="areaid = 4513">Ymirheim</xsl:when>
				<xsl:when test="areaid = 4514">Saronite Mines</xsl:when>
				<xsl:when test="areaid = 4515">The Conflagration</xsl:when>
				<xsl:when test="areaid = 4516">Ironwall Rampart</xsl:when>
				<xsl:when test="areaid = 4517">Weeping Quarry</xsl:when>
				<xsl:when test="areaid = 4518">Corp'rethar: The Horror Gate</xsl:when>
				<xsl:when test="areaid = 4519">The Court of Bones</xsl:when>
				<xsl:when test="areaid = 4520">Malykriss: The Vile Hold</xsl:when>
				<xsl:when test="areaid = 4521">Cathedral of Darkness</xsl:when>
				<xsl:when test="areaid = 4522">Icecrown Citadel</xsl:when>
				<xsl:when test="areaid = 4523">Icecrown Glacier</xsl:when>
				<xsl:when test="areaid = 4524">Valhalas</xsl:when>
				<xsl:when test="areaid = 4525">The Underhalls</xsl:when>
				<xsl:when test="areaid = 4526">Njorndar Village</xsl:when>
				<xsl:when test="areaid = 4527">Balargarde Fortress</xsl:when>
				<xsl:when test="areaid = 4528">Kul'galar Keep</xsl:when>
				<xsl:when test="areaid = 4529">The Crimson Cathedral</xsl:when>
				<xsl:when test="areaid = 4530">Sanctum of Reanimation</xsl:when>
				<xsl:when test="areaid = 4531">The Fleshwerks</xsl:when>
				<xsl:when test="areaid = 4532">Vengeance Landing Inn</xsl:when>
				<xsl:when test="areaid = 4533">Sindragosa's Fall</xsl:when>
				<xsl:when test="areaid = 4534">Wildervar Mine</xsl:when>
				<xsl:when test="areaid = 4535">The Pit of the Fang</xsl:when>
				<xsl:when test="areaid = 4536">Frosthowl Cavern</xsl:when>
				<xsl:when test="areaid = 4537">The Valley of Lost Hope</xsl:when>
				<xsl:when test="areaid = 4538">The Sunken Ring</xsl:when>
				<xsl:when test="areaid = 4539">The Broken Temple</xsl:when>
				<xsl:when test="areaid = 4540">The Valley of Fallen Heroes</xsl:when>
				<xsl:when test="areaid = 4541">Vanguard Infirmary</xsl:when>
				<xsl:when test="areaid = 4542">Hall of the Shaper</xsl:when>
				<xsl:when test="areaid = 4543">Temple of Wisdom</xsl:when>
				<xsl:when test="areaid = 4544">Death's Breach</xsl:when>
				<xsl:when test="areaid = 4545">Abandoned Mine</xsl:when>
				<xsl:when test="areaid = 4546">Ruins of the Scarlet Enclave</xsl:when>
				<xsl:when test="areaid = 4547">Halls of Stone</xsl:when>
				<xsl:when test="areaid = 4548">Halls of Lightning</xsl:when>
				<xsl:when test="areaid = 4549">The Great Tree</xsl:when>
				<xsl:when test="areaid = 4550">The Mirror of Twilight</xsl:when>
				<xsl:when test="areaid = 4551">The Twilight Rivulet</xsl:when>
				<xsl:when test="areaid = 4552">The Decrepit Flow</xsl:when>
				<xsl:when test="areaid = 4553">Forlorn Woods</xsl:when>
				<xsl:when test="areaid = 4554">Ruins of Shandaral</xsl:when>
				<xsl:when test="areaid = 4555">The Azure Front</xsl:when>
				<xsl:when test="areaid = 4556">Violet Stand</xsl:when>
				<xsl:when test="areaid = 4557">The Unbound Thicket</xsl:when>
				<xsl:when test="areaid = 4558">Sunreaver's Command</xsl:when>
				<xsl:when test="areaid = 4559">Windrunner's Overlook</xsl:when>
				<xsl:when test="areaid = 4560">The Underbelly</xsl:when>
				<xsl:when test="areaid = 4564">Krasus' Landing</xsl:when>
				<xsl:when test="areaid = 4567">The Violet Hold</xsl:when>
				<xsl:when test="areaid = 4568">The Eventide</xsl:when>
				<xsl:when test="areaid = 4569">Sewer Exit Pipe</xsl:when>
				<xsl:when test="areaid = 4570">Circle of Wills</xsl:when>
				<xsl:when test="areaid = 4571">Silverwing Flag Room</xsl:when>
				<xsl:when test="areaid = 4572">Warsong Flag Room</xsl:when>
				<xsl:when test="areaid = 4575">Wintergrasp Fortress</xsl:when>
				<xsl:when test="areaid = 4576">Central Bridge</xsl:when>
				<xsl:when test="areaid = 4577">Eastern Bridge</xsl:when>
				<xsl:when test="areaid = 4578">Western Bridge</xsl:when>
				<xsl:when test="areaid = 4579">Dubra'Jin</xsl:when>
				<xsl:when test="areaid = 4580">Crusaders' Pinnacle</xsl:when>
				<xsl:when test="areaid = 4581">Flamewatch Tower</xsl:when>
				<xsl:when test="areaid = 4582">Winter's Edge Tower</xsl:when>
				<xsl:when test="areaid = 4583">Shadowsight Tower</xsl:when>
				<xsl:when test="areaid = 4584">The Cauldron of Flames</xsl:when>
				<xsl:when test="areaid = 4585">Glacial Falls</xsl:when>
				<xsl:when test="areaid = 4586">Windy Bluffs</xsl:when>
				<xsl:when test="areaid = 4587">The Forest of Shadows</xsl:when>
				<xsl:when test="areaid = 4588">Blackwatch</xsl:when>
				<xsl:when test="areaid = 4589">The Chilled Quagmire</xsl:when>
				<xsl:when test="areaid = 4590">The Steppe of Life</xsl:when>
				<xsl:when test="areaid = 4591">Silent Vigil</xsl:when>
				<xsl:when test="areaid = 4592">Gimorak's Den</xsl:when>
				<xsl:when test="areaid = 4593">The Pit of Fiends</xsl:when>
				<xsl:when test="areaid = 4594">Battlescar Spire</xsl:when>
				<xsl:when test="areaid = 4595">Hall of Horrors</xsl:when>
				<xsl:when test="areaid = 4596">The Circle of Suffering</xsl:when>
				<xsl:when test="areaid = 4597">Rise of Suffering</xsl:when>
				<xsl:when test="areaid = 4598">Krasus' Landing</xsl:when>
				<xsl:when test="areaid = 4599">Sewer Exit Pipe</xsl:when>
				<xsl:when test="areaid = 4601">Dalaran Island</xsl:when>
				<xsl:when test="areaid = 4602">Force Interior</xsl:when>
				<xsl:when test="areaid = 4603">Vault of Archavon</xsl:when>
				<xsl:when test="areaid = 4604">Gate of the Red Sun</xsl:when>
				<xsl:when test="areaid = 4605">Gate of the Blue Sapphire</xsl:when>
				<xsl:when test="areaid = 4606">Gate of the Green Emerald</xsl:when>
				<xsl:when test="areaid = 4607">Gate of the Purple Amethyst</xsl:when>
				<xsl:when test="areaid = 4608">Gate of the Yellow Moon</xsl:when>
				<xsl:when test="areaid = 4609">Courtyard of the Ancients</xsl:when>
				<xsl:when test="areaid = 4610">Landing Beach</xsl:when>
				<xsl:when test="areaid = 4611">Westspark Workshop</xsl:when>
				<xsl:when test="areaid = 4612">Eastspark Workshop</xsl:when>
				<xsl:when test="areaid = 4613">Dalaran City</xsl:when>
				<xsl:when test="areaid = 4614">The Violet Citadel Spire</xsl:when>
				<xsl:when test="areaid = 4615">Naz'anak: The Forgotten Depths</xsl:when>
				<xsl:when test="areaid = 4616">Sunreaver's Sanctuary</xsl:when>
				<xsl:when test="areaid = 4617">Elevator</xsl:when>
				<xsl:when test="areaid = 4618">Antonidas Memorial</xsl:when>
				<xsl:when test="areaid = 4619">The Violet Citadel</xsl:when>
				<xsl:when test="areaid = 4620">Magus Commerce Exchange</xsl:when>
				<xsl:when test="areaid = 4621">UNUSED</xsl:when>
				<xsl:when test="areaid = 4622">First Legion Forward Camp</xsl:when>
				<xsl:when test="areaid = 4623">Hall of the Conquered Kings</xsl:when>
				<xsl:when test="areaid = 4624">Befouled Terrace</xsl:when>
				<xsl:when test="areaid = 4625">The Desecrated Altar</xsl:when>
				<xsl:when test="areaid = 4626">Shimmering Bog</xsl:when>
				<xsl:when test="areaid = 4627">Fallen Temple of Ahn'kahet</xsl:when>
				<xsl:when test="areaid = 4628">Halls of Binding</xsl:when>
				<xsl:when test="areaid = 4629">Winter's Heart</xsl:when>
				<xsl:when test="areaid = 4630">The North Sea</xsl:when>
				<xsl:when test="areaid = 4631">The Broodmother's Nest</xsl:when>
				<xsl:when test="areaid = 4632">Dalaran Floating Rocks</xsl:when>
				<xsl:when test="areaid = 4633">Raptor Pens</xsl:when>
				<xsl:when test="areaid = 4635">Drak'Tharon Keep</xsl:when>
				<xsl:when test="areaid = 4636">The Noxious Pass</xsl:when>
				<xsl:when test="areaid = 4637">Vargoth's Retreat</xsl:when>
				<xsl:when test="areaid = 4638">Violet Citadel Balcony</xsl:when>
				<xsl:when test="areaid = 4639">Band of Variance</xsl:when>
				<xsl:when test="areaid = 4640">Band of Acceleration</xsl:when>
				<xsl:when test="areaid = 4641">Band of Transmutation</xsl:when>
				<xsl:when test="areaid = 4642">Band of Alignment</xsl:when>
				<xsl:when test="areaid = 4646">Ashwood Lake</xsl:when>
				<xsl:when test="areaid = 4650">Iron Concourse</xsl:when>
				<xsl:when test="areaid = 4652">Formation Grounds</xsl:when>
				<xsl:when test="areaid = 4653">Razorscale's Aerie</xsl:when>
				<xsl:when test="areaid = 4654">The Colossal Forge</xsl:when>
				<xsl:when test="areaid = 4655">The Scrapyard</xsl:when>
				<xsl:when test="areaid = 4656">The Conservatory of Life</xsl:when>
				<xsl:when test="areaid = 4657">The Archivum</xsl:when>
				<xsl:when test="areaid = 4658">Argent Tournament Grounds</xsl:when>
				<xsl:when test="areaid = 4665">Expedition Base Camp</xsl:when>
				<xsl:when test="areaid = 4666">Sunreaver Pavilion</xsl:when>
				<xsl:when test="areaid = 4667">Silver Covenant Pavilion</xsl:when>
				<xsl:when test="areaid = 4668">The Cooper Residence</xsl:when>
				<xsl:when test="areaid = 4669">The Ring of Champions</xsl:when>
				<xsl:when test="areaid = 4670">The Aspirants' Ring</xsl:when>
				<xsl:when test="areaid = 4671">The Argent Valiants' Ring</xsl:when>
				<xsl:when test="areaid = 4672">The Alliance Valiants' Ring</xsl:when>
				<xsl:when test="areaid = 4673">The Horde Valiants' Ring</xsl:when>
				<xsl:when test="areaid = 4674">Argent Pavilion</xsl:when>
				<xsl:when test="areaid = 4676">Sunreaver Pavilion</xsl:when>
				<xsl:when test="areaid = 4677">Silver Covenant Pavilion</xsl:when>
				<xsl:when test="areaid = 4679">The Forlorn Cavern</xsl:when>
				<xsl:when test="areaid = 4688">claytonio test area</xsl:when>
				<xsl:when test="areaid = 4692">Quel'Delar's Rest</xsl:when>
				<xsl:when test="areaid = 4710">Isle of Conquest</xsl:when>
				<xsl:when test="areaid = 4722">Trial of the Crusader</xsl:when>
				<xsl:when test="areaid = 4723">Trial of the Champion</xsl:when>
				<xsl:when test="areaid = 4739">Runeweaver Square</xsl:when>
				<xsl:when test="areaid = 4740">The Silver Enclave</xsl:when>
				<xsl:when test="areaid = 4741">Isle of Conquest No Man's Land</xsl:when>
				<xsl:when test="areaid = 4742">Hrothgar's Landing</xsl:when>
				<xsl:when test="areaid = 4743">Deathspeaker's Watch</xsl:when>
				<xsl:when test="areaid = 4747">Workshop</xsl:when>
				<xsl:when test="areaid = 4748">Quarry</xsl:when>
				<xsl:when test="areaid = 4749">Docks</xsl:when>
				<xsl:when test="areaid = 4750">Hangar</xsl:when>
				<xsl:when test="areaid = 4751">Refinery</xsl:when>
				<xsl:when test="areaid = 4752">Horde Keep</xsl:when>
				<xsl:when test="areaid = 4753">Alliance Keep</xsl:when>
				<xsl:when test="areaid = 4760">The Sea Reaver's Run</xsl:when>
				<xsl:when test="areaid = 4763">Transport: Alliance Gunship</xsl:when>
				<xsl:when test="areaid = 4764">Transport: Horde Gunship</xsl:when>
				<xsl:when test="areaid = 4769">Hrothgar's Landing</xsl:when>
				<xsl:when test="areaid = 4809">The Forge of Souls</xsl:when>
				<xsl:when test="areaid = 4812">Icecrown Citadel</xsl:when>
				<xsl:when test="areaid = 4813">Pit of Saron</xsl:when>
				<xsl:when test="areaid = 4820">Halls of Reflection</xsl:when>
				<xsl:when test="areaid = 4832">Transport: Alliance Gunship (IGB)</xsl:when>
				<xsl:when test="areaid = 4833">Transport: Horde Gunship (IGB)</xsl:when>
				<xsl:when test="areaid = 4859">The Frozen Throne</xsl:when>
				<xsl:when test="areaid = 4862">The Frozen Halls</xsl:when>
				<xsl:when test="areaid = 4889">The Frost Queen's Lair</xsl:when>
				<xsl:when test="areaid = 4890">Putricide's Laboratory of Alchemical Horrors and Fun</xsl:when>
				<xsl:when test="areaid = 4891">The Sanctum of Blood</xsl:when>
				<xsl:when test="areaid = 4892">The Crimson Hall</xsl:when>
				<xsl:when test="areaid = 4893">The Frost Queen's Lair</xsl:when>
				<xsl:when test="areaid = 4894">Putricide's Laboratory of Alchemical Horrors and Fun</xsl:when>
				<xsl:when test="areaid = 4895">The Crimson Hall</xsl:when>
				<xsl:when test="areaid = 4896">The Frozen Throne</xsl:when>
				<xsl:when test="areaid = 4897">The Sanctum of Blood</xsl:when>
				<xsl:when test="areaid = 4898">Frostmourne</xsl:when>
				<xsl:when test="areaid = 4904">The Dark Approach</xsl:when>
				<xsl:when test="areaid = 4905">Scourgelord's Command</xsl:when>
				<xsl:when test="areaid = 4906">The Shadow Throne</xsl:when>
				<xsl:when test="areaid = 4908">The Hidden Passage</xsl:when>
				<xsl:when test="areaid = 4910">Frostmourne</xsl:when>
				<xsl:when test="areaid = 4987">The Ruby Sanctum</xsl:when>
				
            </xsl:choose>
         </td>
         
         <td><xsl:value-of select="latency"/>ms</td>
            

      </tr>
      </xsl:for-each>
</table>

   </xsl:template>

</xsl:stylesheet>
