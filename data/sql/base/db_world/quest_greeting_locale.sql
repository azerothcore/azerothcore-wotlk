-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `quest_greeting_locale`
--

DROP TABLE IF EXISTS `quest_greeting_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quest_greeting_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Greeting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`type`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_greeting_locale`
--

LOCK TABLES `quest_greeting_locale` WRITE;
/*!40000 ALTER TABLE `quest_greeting_locale` DISABLE KEYS */;
INSERT INTO `quest_greeting_locale` VALUES
(234,0,'deDE','In Westfall hat sich üble Verderbnis eingeschlichen. Während ich auf dem Schlachtfeld von Lordaeron meine Pflicht tat, wurden diese anständig geführten Höfe überfallen und zu Schlupfwinkeln für Schläger und Mörder umfunktioniert. Die Volksmiliz ist auf Eure Hilfe angewiesen.',0),
(235,0,'deDE','Willkommen in unserer bescheidenen Hütte! Wir freuen uns über jedes freundliche Gesicht. Und Ihr habt so starke Arme. Mein Mann und ich sind ständig auf der Suche nach jemandem, der uns auf dem Hof hilft. Jetzt, wo die ganzen guten Leute weg sind, ist es nicht einfach, kräftige Helfer zu bekommen.',0),
(238,0,'deDE','Manchmal denke ich, eine große dunkle Wolke schwebt über uns, aus der Unglück auf uns herabregnet. Erst werden wir von unserem Land vertrieben und jetzt kommen wir noch nicht einmal aus Westfall weg. Alles liegt im Argen. Es muss etwas geschehen.',0),
(239,0,'deDE','Abenteuer in Ländern so nah und so fern $BVerschiedene Leute, wir treffen sehr gern $BDocht wollt Ihr eine Frage stellen $BMüsst Ihr zuerst \'ne einfache Aufgabe erfüllen!',0),
(240,0,'deDE','Ach je, es ist auch ohne diese neuen Probleme schon schwer genug, hier für Ordnung zu sorgen! Ich hoffe, Ihr bringt gute Neuigkeiten, $N...',0),
(241,0,'deDE','He, mein Freund. Man nennt mich Remy. Ich komme aus dem Rotkammgebirge im Osten und bin auf der Suche nach interessanten... Geschäften, interessanten... Geschäften. Habt Ihr vielleicht welche... vielleicht welche?',0),
(261,0,'deDE','Seid gegrüßt. Ihr seht aus wie $Gein Mann:eine Frau; $Gder:die; weiß, was $Ger:sie; will... habt Ihr mit der Armee von Sturmwind zu tun?',0),
(265,0,'deDE','Ich spürte schon seit geraumer Zeit, dass Ihr kommen würdet, $N. Es stand in den Sternen geschrieben.',0),
(272,0,'deDE','Hallo, hallo! Willkommen in meiner Küche, $Gmein Herr:meine Dame;! Hier werden all die köstlichen Delikatessen der Taverne Zum roten Raben zubereitet. Ah, riecht nur das wunderbare Aroma!',0),
(278,0,'deDE','Hallo, $Gwerter Herr:werte Dame;. Nehmt Platz und esst etwas, wenn Ihr Hunger habt. Und keine Sorge, ich bin zwar mit meiner Handarbeit beschäftigt, aber ich höre Euch gut zu...',0),
(342,0,'deDE','Seid gegrüßt, $N! Willkommen in meinem bescheidenen Garten. Das Wetter ist in letzter Zeit wirklich vorzüglich. Lasst uns hoffen, dass es bis zur Ernte anhält.',0),
(344,0,'deDE','Wer ist $Gdieser:diese; $C, $Gder:die; sich vor das Gericht von Seenhain im Königreich Sturmwind begibt? Sagt, was Euer Anliegen in dieser Stadt ist, $R. Die Bedrohung des Königreichs durch die Orcs ist zu groß, um Zeit mit einem Geplänkel zu vergeuden.',0),
(381,0,'deDE','Grüße, $C. Wenn Ihr aus geschäftlichen Gründen hier seid, so schnappt Euch ein Bier und dann reden wir.',0),
(382,0,'deDE','Ich habe keine Zeit zum Schwatzen, doch wenn Ihr gewillt seid, uns im Kampf gegen die Orcs beizustehen, dann finden wir schon etwas für Euch zu tun.',0),
(392,0,'deDE','Erschreckt nicht, $R. Ich bin seit langem schon aus diesem Land geschieden, aber ich habe nicht vor, Euresgleichen Schaden zuzufügen. Ich habe in meinem Leben zu viel Tod gesehen. Mein einziger Wunsch ist der nach Frieden. Vielleicht könnt Ihr mir dabei helfen.',0),
(415,0,'deDE','He, $GKumpel:Maidlein;, könntet Ihr mir wohl bei einer Sache unter die Arme greifen? Ich stecke wirklich in der Klemme...',0),
(464,0,'deDE','Grüße, $C. Schlimme Zeiten sind dies, $Gmein Freund:meine Freundin;, denn unsere Stadt wird belagert! Die Orcs des Schwarzfelsklans greifen von der Burg Steinwacht aus an, die Schattenfellgnolle bedrohen den Ilgalar-Turm und das Rotkammgnollrudel gewinnt an Stärke. Ich hoffe, Ihr hattet nicht vor, hier Urlaub zu machen...',0),
(633,0,'deDE','Dunkle Zeiten sind über uns hereingebrochen, $C... Nicht mehr lange, und wir werden alles verlieren... wenn das Licht alle verlässt, außer jenen, die wahrhaftig unter dem Lichte wandeln.',0),
(656,0,'deDE','Überall waren Diebe!$B$BEs war schrecklich. Die Höhle stürzte über uns ein. Ich glaube, die Bergarbeiter sind alle tot, darunter auch mein Bruder, der Großknecht.',0),
(661,0,'deDE','Seid gegrüßt. Was habt Ihr mit der Familie Treuwein zu tun? Wollt Ihr die Treuweins im Kampf gegen die Untoten unterstützen?',0),
(714,0,'deDE','Grüße, $C! Herrlicher Tag zum Jagen, meint Ihr nicht auch? Ich selbst hatte bereits ziemliches Glück mit den Ebern. Möchtet Ihr es auch versuchen?',0),
(733,0,'deDE','Passt auf, was Ihr hier tut, $GSöhnchen:Mädel;. Ihr gehört zwar nicht zu unserer Truppe, aber das bedeutet nicht, dass ich Euch nicht übers Knie lege, wenn Ihr aus der Reihe tanzt!',0),
(737,0,'deDE','Ah, guten Tag. Mir scheint, Ihr seid einem kleinen Zusatzverdienst nicht abgeneigt, hmmm? Ich kann es an Euren Augen erkennen. Mein Name ist Mogul Kebok, Vorarbeiter der Unternehmungen in Azeroth, und wenn Ihr auf Reichtum aus seid, dann kann ich da vielleicht etwas arrangieren.',0),
(773,0,'deDE','$C, eh? Ich bin Krazek, Sekretär von Baron Revilgaz. Ich weiß über alles Bescheid, das in diesem Dschungel und darüber hinaus vor sich geht. Vielleicht möchtet Ihr den aktuellen Ölpreis in Ratschet wissen? Nein? Oder sucht Ihr vielleicht Arbeit? Da kann ich Euch helfen.',0),
(786,0,'deDE','Seid gegrüßt, $GJungchen:Mädel;. Mein Name ist Grelin Weißbart. Ich soll untersuchen, welche Bedrohung von den Trollen im Eisklammtal ausgeht, deren Zahl ständig anwächst. Was ich festgestellt habe? Naja, es ist schon etwas besorgniserregend...',0),
(823,0,'deDE','Guten Tag, $C. Normalerweise würde ich jetzt meine Runde machen und die Leute von Sturmwind beschützen, doch viele der Wachen von Sturmwind kämpfen in fremdem Landen. Daher mache ich jetzt hier Vertretung und setze Kopfgelder aus, wo ich doch eigentlich lieber auf Patrouille sein würde...',0),
(1071,0,'deDE','Ich habe mit der Zeit gelernt, dass es keine langweiligen Aufträge gibt. Der Schutz des Thandolübergangs hätte eine leichte Aufgabe sein sollen. Aber da der Hauptteil der Armee an der Seite der Allianz kämpft, wurden wir hier überwältigt und Dun Modr fiel.',0),
(1092,0,'deDE','Seid gegrüßt, $n.',0),
(1105,0,'deDE','Wisst Ihr, eigentlich wollte ich ja Ausgrabungsleiter werden. Aber da ich von jeher gut mit Zahlen umgehen konnte, beschloss die Gilde, dass ich am besten für die Buchhaltung geeignet sei! An jedem Tag meiner Jugend hieß es Lernen, Lernen und noch mal Lernen...',0),
(1239,0,'deDE','Wenn Ihr gewillt seid, Euch Geschichten anzuhören, die Eure Knochen zum Schlottern bringen und Euch das Fürchten lehren werden, dann holt Euch etwas zu trinken und setzt Euch hin...',0),
(1284,0,'deDE','Seid gegrüßt, $n.',0),
(1343,0,'deDE','Na, wenn das nicht $Gein junger, wilder:eine junge, wilde; $C ist, $Gden:die; zweifellos Erzählungen über meine Taten auf dem Schlachtfeld hierher geführt haben!$B$BLeider ist jetzt keine Zeit für große Geschichten, denn es gilt bedeutende Taten zu vollbringen! Wenn Ihr also auf Ruhm aus seid, dann ist Euch das Glück heute hold...',0),
(1344,0,'deDE','Auch wenn es in diesen Ruinen zurzeit recht ruhig ist, bin ich doch davon überzeugt, dass das nicht lange andauern wird. In der Zwischenzeit kann ich jemanden wie Euch jedoch gut gebrauchen. Möchtet Ihr die Forschergilde der Zwerge unterstützen?',0),
(1356,0,'deDE','Ich bin mit einer äußerst bedeutenden Aufgabe beschäftigt. Ausgrabungsleitergeschäfte. Sofern Ihr mir daher nicht etwas mindestens ebenso Wichtiges zu sagen habt, was ich bezweifeln möchte, müsst Ihr mich schon entschuldigen.',0),
(1374,0,'deDE','Verflucht sei die Brauerliga! Die Leute können sich die besten Zutaten besorgen, während wir uns hier verzweifelt ein bisschen Hopfen und Getreide zusammenkratzen müssen!$B$BWie gern würde ich denen als Ausgleich ein bisschen bittere Medizin zu schlucken geben...',0),
(1377,0,'deDE','Nicht jeder kann einen Dampfpanzer fahren. Dafür braucht man einen eisernen Griff und Nerven wie Drahtseile... Zum Glück besitze ich beides! Wie steht es mit Euch? Traut Ihr Euch? Möchtet Ihr es mir beweisen?',0),
(1428,0,'deDE','Seid gegrüßt, $n.',0),
(1495,0,'deDE','Seid gegrüßt, $C. Seid wachsam, wenn Ihr nach Osten zum Bollwerk reist. Aktuellen Spähermeldungen zufolge ist in dem Bereich eine erhöhte Aktivität der Geißel zu verzeichnen. Hier ist also Vorsicht geboten.',0),
(1499,0,'deDE','He, Ihr da! Ich hätte da ein paar Aufgaben zu vergeben und muss unbedingt kurz erklären, wie außerordentlich wichtig sie sind. Hört gut zu.',0),
(1500,0,'deDE','Ich hoffe, Ihr seid den Umständen entsprechend wohlauf.$B$BNehmt doch hier Platz und lauscht meiner Geschichte. Natürlich ist es eine Tragödie, aber hoffentlich eine, die am Ende gerächt wird!',0),
(1515,0,'deDE','Der scharlachrote Kreuzzug rückt unserer Heimat näher. Die törichten Eiferer erkennen nicht, dass die treuen Diener der dunklen Fürstin alles tun werden, um sie zu töten.',0),
(1518,0,'deDE','Die dunkle Fürstin hat die Herausforderung gestellt. Es liegt an uns, sie anzunehmen.',0),
(1646,0,'deDE','Seid gegrüßt, ich bin Baros Alexston, Stadtarchitekt von Sturmwind.',0),
(1719,0,'deDE','Hier drüben, nutzloses Pack...! Wenn Ihr etwas Sinnvolles tun wollt, dann hört genau zu!',0),
(1738,1,'deDE','Diese Schriftrollensammlung enthält verschiedene logistische und strategische Informationen sowie kodierte Nachrichten.',0),
(1748,0,'deDE','Ich bin Bolvar Fordragon, Hochlord von Sturmwind.',0),
(1937,0,'deDE','Die dunkle Fürstin hat die Herausforderung gestellt. Jetzt liegt es an der Königlichen Apothekervereinigung, eine neue Seuche zu entwickeln. Wir werden Arthas und seine jämmerliche Armee in die Knie zwingen.',0),
(1938,0,'deDE','Die Kirin Tor haben meine Warnungen in den Wind geschlagen! Die Allianz ist ein Schwindel. Arugal ist ein tollkühner Dummkopf.',0),
(1950,0,'deDE','Mein Bruder und ich sind in wichtiger Mission unterwegs, aber wir sind in diesem Bauernhaus festgenagelt. Die Todespirscher brauchen Eure Hilfe.',0),
(1952,0,'deDE','Hallo, $C. Da Ihr hier seid, wisst Ihr ja wohl, dass der Silberwald voll von unseren Feinden ist. Um zu überleben m',0),
(2080,0,'deDE','Die Entstehung von Teldrassil war ein großer Erfolg, doch jetzt muss sich die Welt neu orientieren, um wieder ins Gleichgewicht zu finden.',0),
(2086,0,'deDE','Seid gegrüßt, $n.',0),
(2094,0,'deDE','Seid gegrüßt, $C. Ich befinde mich gerade in einer etwas misslichen Lage, ich habe fast keine Bälge mehr.',0),
(2121,0,'deDE','Informationen... Mit unseren Spähern und Agenten haben wir den Informationsfluss in Lordaeron in der Hand. Bewegungen der Geißel, ihre Stellungen, nichts entgeht unseren wachsamen Augen...',0),
(2215,0,'deDE','Um der dunklen Fürstin und Varimathras zu dienen, müssen wir gegen die menschliche Plage vorgehen.',0),
(2216,0,'deDE','Wir stehen kurz vor der Entwicklung der neuen Seuche, nach der unsere dunkle Fürstin so dringend verlangt.',0),
(2263,0,'deDE','Ich hoffe, Ihr seid zum Arbeiten hergekommen, $C. Wir haben viel zu tun und von der Horde, dem Syndikat und den Ogern können wir keine Hilfe erwarten.',0),
(2498,0,'deDE','Was, Was?! Wir müssen alle einen Profit machen... und das geht nicht, wenn wir nur dumm herumstehen.',0),
(2501,0,'deDE','Eh! Lust auf eine Runde Fingerhakeln?',0),
(2700,0,'deDE','Wir auf der Zuflucht halten eines der letzten Gebiete von Stromgarde im Arathihochland. Aber wir werden zusehends bedrängt...$B$BWenn Ihr Neuigkeiten bringt, dann hoffentlich gute.',0),
(2706,0,'deDE','Dank des Kriegshäuptlings verbleibt selbst in den Ruinen unseres alten Gefängnisses noch Hoffnung, und die Horde erhebt sich erneut.',0),
(2713,1,'deDE','Dieses Holzbrett bietet Platz für primitive Steckbriefe.',0),
(2785,0,'deDE','Weg da! Bleibt zurück! Ich habe ein Paket Sprengpulver und zögere nicht, es zu benutzen! Ich sprenge uns alle in die Luft!$B$BOh, Verzeihung. Ich dachte, Ihr wäret jemand anderes...',0),
(2786,0,'deDE','Willkommen bei \'Knochengriffs Runen und Verdamnisse\', $C. Ihr dürft Euch umsehen, aber bitte fasst nichts an',0),
(2817,0,'deDE','Ihr müsst in Schwierigkeiten sein, wenn Ihr dieses Ödland durchstreift, $C. In Schwierigkeiten wie ich.$B$BOder vielleicht seid Ihr auch nur verrückt. Verrückt wie ich.',0),
(2860,0,'deDE','Es war ein ziemlich spektakulärer Abgang, kann ich Euch sagen, $C. Wir haben alles gegriffen, was nicht niet- und nagelfest war. Darum haben wir jetzt ein paar Vorräte übrig.',0),
(2910,0,'deDE','Die Bastarde haben sich nachts auf uns gestürzt, nachdem wir ordentlich gezecht hatten. Sonst hätten wir sie leicht überwältigt, das ist mal sicher.$B$BJetzt sind alle tot... bis auf einige wenige von uns.',0),
(2920,0,'deDE','He, hallo, $N.$B$BLotwil ist nicht gerade der aufmerksamste Boss, den ich je hatte. Manchmal ist er ziemlich in seine Arbeit vertieft. Dann kriegen sein Untergebenen nichts zu essen oder werden nicht bezahlt.$B$B<Lucien sieht Lotwil missbilligend an.>$B$BAber deshalb solltet Ihr nicht leiden müssen.',0),
(2921,0,'deDE','Wie gut, dass Ihr vorbeikommt, $C.$B$BIch heiße Lotwil Veriatus, Gründungsmitglied der Erleuchteten Versammlung für Arkanologie, Alchimie und Ingenieurwissenschaften: Unser Streben ist, die hohen Wissenschaften von Azeroth zu einer umfassenden Schule zu verschmelzen.',0),
(3188,0,'ruRU','Если ты хочешь поговорить о чем-то, |3-6($c)... то, заходи, посиди со мной.',0),
(3390,0,'esES','Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.',47014),
(3390,0,'esMX','Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.',47014),
(5638,0,'esES','Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?',NULL),
(5638,0,'esMX','Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?',NULL),
(22292,0,'ruRU','Свет ещё не воссиял над Скеттисом.',0);
/*!40000 ALTER TABLE `quest_greeting_locale` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:25
