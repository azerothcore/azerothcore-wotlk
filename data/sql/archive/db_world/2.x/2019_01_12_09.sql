-- DB update 2019_01_12_08 -> 2019_01_12_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_12_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_12_08 2019_01_12_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546089286503990309'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546089286503990309');

-- ----------------------------
-- Insert data quest_offer_reward_locale
-- ----------------------------

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (6, 'deDE', 'Ha, Ihr habt ihn erwischt! Ihr habt ganz Elwynn einen großen Dienst erwiesen und Euch ein schönes Kopfgeld verdient!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (7, 'deDE', 'Gut gemacht, Bürger. Diese Kobolde sind Diebe und Feiglinge, aber wenn sie in Massen auftreten, dann sind sie doch eine Gefahr für uns. Und die Menschen von Sturmwind können nun wirklich keine weitere Gefahr gebrauchen.$B$BHabt meinen Dank dafür, dass Ihr sie besiegtet!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9, 'deDE', 'Gute Arbeit, $Gmein Freund:meine Liebe;. Ihr habt Euch Eure Bezahlung redlich verdient. Wer weiß, vielleicht wird Westfall ja wieder aufblühen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11, 'deDE', 'Wie ich sehe, wart Ihr fleißig! Habt Dank, $N.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12, 'deDE', 'Gut gemacht, $N. Mein Späher hat Eure tapferen Taten beobachtet. Bis jetzt bewährt Ihr Euch recht gut.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13, 'deDE', 'Ihr habt Euren Wert für die Volksmiliz durch die tapferen Taten bewiesen, die Ihr bisher vollbracht habt.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14, 'deDE', 'Als ich Lordaeron, dieses besudelte Land, verließ, fand ich hier, in meiner Heimat, schlimme Zustände vor. Doch es besteht noch Hoffnung für Westfall. Wie Ihr durch Euren Heldenmut im Kampfe bewiesen habt, dient Ihr ganz offensichtlich ehrenvoll unserer Sache. Mit großem Stolz berufe ich Euch in die Volksmiliz ein. Möge das Licht über Euch leuchten.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (15, 'deDE', 'Es gefällt mir gar nicht, dass sich so viele Kobolde in unserer Mine herumtreiben. Das bedeutet nichts Gutes. Hier, nehmt dies als Bezahlung und sprecht mich wieder an, sobald Ihr dazu bereit seid. Denn ich möchte, dass Ihr noch einmal in die Minen zurückkehrt.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (18, 'deDE', 'Ah, wie ich sehe, seid Ihr zurück und habt Kopftücher dabei. Die Armee von Sturmwind weiß Eure Hilfe zu schätzen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (19, 'deDE', 'Tharil\'zun war ein bösartiger, verschlagener Orc. Gut gemacht! Ich bin sicher, er war nicht leicht zu besiegen. Hier ist Eure Belohnung, $N.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (20, 'deDE', 'Gut, jetzt sind es wesentlich weniger Orcs, um die wir uns sorgen müssen, danke.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (21, 'deDE', 'Und wieder habt Ihr Euch meinen Respekt und die Dankbarkeit der Armee von Sturmwind verdient. Vielleicht gibt es in der Mine noch immer Kobolde, doch ich werde andere schicken, um gegen sie zu kämpfen. Für Euch haben wir andere Aufgaben.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (22, 'deDE', 'Die sind genau richtig, $N! Vielen herzlichen Dank. Heute abend werden Bauer Saldean und ich königlich speisen. Und hier ist auch etwas für Euch, für Eure harte Arbeit. Bei mir muss $Gkein:keine; $C hungern.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (33, 'deDE', 'Das war eine unangenehme Aufgabe, Freund, aber Ihr habt Euch an Euren Teil der Abmachung gehalten.$B$BIch habe hier ein paar Sachen, die Euch vielleicht gefallen könnten - sucht Euch etwas aus!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (34, 'deDE', 'Endlich hat die Bedrohung ein Ende! Ich danke Euch, $N. Ihr habt mir einen großen Dienst erwiesen. Dieses Jahr wird mein Garten herrlich blühen!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (35, 'deDE', 'Ja, es haben sich Murlocs in und an den Flüssen und Bächen des östlichen Elwynn niedergelassen. Wir wissen nicht, warum sie hergekommen sind, aber sie sind aggressiv und zumindest halbintelligent.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (36, 'deDE', 'Die Verna ist immer so ein liebes Mädchen gewesen! Wir werden sie hier in Westfall vermissen, aber ganz ehrlich und nur unter uns, sie ist ja eigentlich ein Stadtkind und deswegen wird sie sich in Sturmwind pudelwohl fühlen. Aber genug getratscht! Jetzt können wir Westfalleintopf kochen!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (37, 'deDE', 'Vom Leichnam selbst ist nicht mehr viel zu erkennen. Doch in der Nähe findet Ihr ein Medaillon, in das die Worte \"Malakai Stone, Soldat\" eingeprägt sind.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (38, 'deDE', 'Das Okra wird die Brühe schön eindicken. Und jetzt geben wir nur noch das sehnige Geierfleisch, ein paar Murlocaugen und diese leckeren Geiferzahnschnauzen dazu. Und fertig! Ich möchte, dass Ihr für all Eure Hilfe den ersten Schwung Westfalleintopf bekommt, $N. Hier, nehmt!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (39, 'deDE', 'Hmm... das sind beunruhigende Neuigkeiten. Unsere Reihen sind ohnehin schon ausgedünnt, und dass wir jetzt auch noch Rolf und Malakai verloren haben, macht die Lage noch schlimmer.$B$BWenn sich die Dinge nicht bald ändern, dann wird in ein paar Tagen sogar Goldhain umkämpft sein.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (40, 'deDE', 'Ja, ich habe mit Remy darüber gesprochen. Er ist ein guter Händler und ich respektiere ihn, aber alle Berichte von Murlocs im Osten waren bisher bestenfalls bruchstückhaft.$B$BIch nehme Eure Sorgen zur Kenntnis, aber solange ich nicht einen zuverlässigen Bericht aus berufener militärischer Quelle erhalte, der bestätigt, dass die Murlocs tatsächlich eine Bedrohung darstellen, können wir es uns nicht leisten, weitere Soldaten nach Osten zu schicken.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (45, 'deDE', 'Um den Hals trägt der Leichnam ein Medaillon aus Metall, auf dem die Worte \"Rolf Hartford, Soldat\" stehen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (47, 'deDE', 'Danke für den Goldstaub, $N. Hier habt Ihr Euer Geld und hier habt Ihr noch eine kleine... Zugabe von Freunden von mir. Das könnte Euch vielleicht noch nützlich werden... nützlich werden.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (52, 'deDE', 'Vielen Dank für Eure Hilfe, $N. Im Wald muss es irgendetwas geben, das die Tiere so angriffslustig macht.$B$BWas auch immer es sein mag, ich hoffe, es bleibt dort!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (54, 'deDE', 'Oha, hier steht, dass Ihr in den Rang des kommissarisch ernannten Stellvertreters des Marschalls von Sturmwind erhoben worden seid. Herzlichen Glückwunsch.$B$BUnd viel Erfolg bei der Arbeit - Elwynn sicher zu machen ist kein Spaziergang, zumal der größte Teil der Armee sonst wo zugange ist und sonst was für irgendwelche Adligen macht!$B$BEs ist schon schwer, in diesen dunklen Zeiten den Überblick über die Politik zu behalten...', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (60, 'deDE', 'Ihr habt wohl eifrig Kobolde gejagt, hmm? Danke für die Kerzen, $N. Hier habt Ihr Eure Belohnung.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (61, 'deDE', 'Hier habt Ihr Eure Bezahlung. Und wenn Ihr schon einmal hier seid, schaut Euch ruhig um. Ich bin sicher, dass wir den einen oder anderen Trank oder sonst irgendetwas haben, das Euch von Nutzen wäre.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (62, 'deDE', 'Das sind allerdings schlechte Nachrichten. Was kommt als Nächstes, Drachen?!? Wir werden wohl unsere Patrouillen rund um die Mine verstärken müssen. Habt Dank für Eure Bemühungen, $N. Und wartet einen Moment... Ich habe vielleicht noch eine andere Aufgabe für Euch.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (64, 'deDE', 'Meine Uhr! Oh, danke, danke vielmals, $g werter Herr:werte Dame;! $B$BWir sind nur arme Bauern und wir haben unser Land verloren, aber nehmt doch bitte dies als Zeichen unseres Dankes.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (65, 'deDE', 'So, Starkmantel hat Euch geschickt, hm?$BNa ja, dem schulde ich noch was.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (71, 'deDE', 'Damit bestätigt Ihr meine Befürchtungen, $N. Die Murlocs sind eine Bedrohung, die wir nicht länger ignorieren können.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (76, 'deDE', 'Kobolde in der Jaspismine, sagt Ihr? Verflucht noch eins! Die Lage wird von Minute zu Minute schlimmer!$B$BVielen Dank für Euren Bericht, $N. Aber ich wünschte mir, Ihr hättet bessere Nachrichten gebracht.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (83, 'deDE', 'Ah ja, das sind schöne Kopftücher, obwohl der Stoff ein wenig rau ist...$B$BHier, bitte schön!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (84, 'deDE', 'Mmmm, lecker! Diese Pastete ist perfekt!$B$BIch glaube, langsam kommt mein Gedächtnis wieder...', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (85, 'deDE', 'Ihr habt was verloren? Also ich hab keine Kette genommen, denn ich bin kein Dieb!$B$BIch weiß vielleicht, wer\'s war, aber... <grins>... ich hab einfach zu viel Hunger, um darauf zu kommen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (86, 'deDE', 'Das Fleisch von wilden Ebern ist zwar zäh, aber wenn man es lange genug köcheln lässt, dann wird eine ganz vorzügliche Pastete daraus!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (87, 'deDE', 'Oh, Ihr habt sie tatsächlich gefunden! Danke, danke, $Gmein Lieber:meine Liebe;!$B$BHier, nehmt dies. Es hat meinem Mann gehört und er sagte immer, dass es Glück brächte. Wenn er es doch nur auf seinem letzten Feldzug nicht vergessen hätte! *schnief*', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (88, 'deDE', 'Welch ein Glück! Dieses Schwein war schon so groß, dass es bestimmt bald unsere gesamte Ernte gefressen hätte! Ich danke Euch, $N.$B$BNun, könnt Ihr mit einem dieser Dinge hier etwas anfangen?', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (89, 'deDE', 'Gute Arbeit, $N. Dieses Material wird den Brückenbau ganz enorm beschleunigen. Die kleine Schönheit hier wird im Handumdrehen repariert sein.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (91, 'deDE', 'Das Gericht von Seenhain weiß Euren Einsatz für die Gerechtigkeit zu schätzen, $N. Indem Ihr die Gesetze des Königreichs durchgesetzt habt, habt Ihr auch der Gerechtigkeit in diesem Land einen Sieg verschafft.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (92, 'deDE', 'Gut gemacht, $N. Und so schöne Exemplare noch dazu! Dafür bekommt Ihr hier auch die köstliche Spezialität, die als Rotkammgulasch bekannt ist!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (102, 'deDE', 'Gut gemacht, $N. Wenn tapfere Abenteurer wie Ihr selbst weiter Seite an Seite mit der Volksmiliz kämpfen, ist es durchaus möglich, dass Westfall wieder zu der reichen Kornkammer werden könnte, die es einmal war. Bitte nehmt dies in Anerkennung Eurer unermüdlichen Anstrengungen entgegen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (106, 'deDE', 'Ach! Ich kann es nicht ertragen, dass wir getrennt sind. Ich muss sie unbedingt sehen!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (107, 'deDE', 'Maybell und Tommy Joe, diese armen Kinder, haben mein ganzes Mitgefühl. Ich kann mich noch gut daran erinnern, wie ich mich einst fühlte, als ich selbst noch jung und verliebt war...$B$BEs muss doch etwas geben, das ich tun kann, um ihnen zu helfen! Lasst mich einen Moment nachdenken...', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (109, 'deDE', 'Ah, mein Freund hat Euch also zu mir geschickt? Wie nett. $B$BNun, das Königshaus von Sturmwind hat unsere Sache aufgegeben. Jetzt ist es an der Volksmiliz, das Land von der Verderbnis zu befreien. Wenn Euch unsere Sache interessiert, so würde ich Eure Fertigkeiten im Kampf gern im Namen der Freiheit einsetzen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (111, 'deDE', 'Solange die Feindschaft zwischen unseren Familien besteht, sehe ich keine gemeinsame Zukunft für Tommy Joe und Maybell... Aber vielleicht können wir sie ja wenigstens für kurze Zeit zusammenbringen.$B$BHmm, was kann man da machen...', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (112, 'deDE', 'Ihr habt den Tang bekommen. Ausgezeichnet! Wartet noch einen kleinen Moment, während ich den Trank braue...', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (114, 'deDE', 'Ach du liebe Zeit! Ich fühle mich schuldig, weil ich meine Familie täuschen muss, aber meine Gefühle für Tommy Joe sind einfach zu stark. Ich kann sie nicht ignorieren.$B$BIch danke Euch, $N. Ich werde den Schnaps trinken, sobald ich eine Möglichkeit dazu habe, und mich zu meinem Liebsten schleichen.$B$BUnd Ihr... bitte nehmt dies.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (115, 'deDE', 'Ich danke Euch, $N. Ich werde diese Kugeln umgehend ihrer Beseitigung zuführen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (120, 'deDE', 'Rührt Euch, $C.$B$BMagistrat Solomon ist ein guter Anführer, und seine Worte haben großes Gewicht für mich. Ich werde um eine Audienz beim König ersuchen und ihm die Lage verdeutlichen. Versichert dem guten Richter, dass er sich der Unterstützung der Armee von Sturmwind gewiss sein kann. Ich werde Verstärkung entsenden, sobald Seine Majestät den Befehl dazu gibt.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (121, 'deDE', 'Ich danke Euch für die Zeit, die Ihr aufgewendet habt, $C. Für Eure Dienste an Seenhain und Sturmwind belohne ich Euch mit diesen Münzen.$B$BWenn Ihr mich jetzt entschuldigen wollt, diese Depesche stellt mich vor ein gewisses Rätsel. Irgendetwas stimmt in unserem Königreich nicht. Ich fürchte, dies ist erst der Anfang des Kampfes, nicht dessen Ende.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (125, 'deDE', 'Das habt Ihr gut gemacht, $N! Ich hätte nie gedacht, dass ich diese Werkzeuge jemals wiedersehen würde.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (127, 'deDE', 'Schön, mit Euch Geschäfte zu machen, $GKumpel:Mädel;!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (128, 'deDE', 'Wie ich sehe, habt Ihr tapfer gegen den Schwarzfelsklan gekämpft, $C. Ihr habt unserem Ort wahrlich einen großen Dienst erwiesen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (129, 'deDE', 'Vielen Dank, das Essen hatte ich jetzt wirklich nötig. Seenhain gegen die Orcs und Gnolle zu beschützen strengt ganz schön an.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (130, 'deDE', 'Ihr braucht einen Blumenstrauß? Ihr seid noch nicht sehr lange in der Stadt - habt Ihr Euch etwa schon eine Liebste angelacht?$B$BIch weiß, es gehört sich nicht, so neugierig zu sein, aber ich finde es einfach schön, dass Liebe in der Luft liegt... vor allem in gefährlichen Zeiten wie diesen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (131, 'deDE', 'Die Blumen sind wunderschön! Ich kann es kaum erwarten, sie ins Wasser zu stellen.$B$BAber wartet mal... das sind ja die Lieblingsblumen von Martie! Parker hat Euch doch wohl nicht etwa zu diesem missgünstigen Drachen geschickt, um die Blumen zu besorgen! Ihr habt ihr doch hoffentlich nicht gesagt, für wen die waren, oder? Falls doch, dann würde es mich nicht wundern, falls Martie die Blumen irgendwie vergiftet hätte.$B$BAber da könnt ihr ja nichts dafür. Vielen Dank - und hier habt Ihr auch Euer Essen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (150, 'deDE', 'Gut gemacht, $N. Ich hoffe, diese Murlocs haben Euch nicht zu viele Schwierigkeiten bereitet.$B$BEs ist seltsam, dass man sie so weit vom Meer entfernt sieht. Ich frage mich, ob sie hier sind, weil sie vor etwas davonlaufen...', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (151, 'deDE', 'Vielen herzlichen Dank, $N! Da wird sich die gute Graumähne aber freuen!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (153, 'deDE', 'Gute Arbeit, $R. Bitte nehmt einen dieser Gegenstände als Bezahlung für Eure harte Arbeit an.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (169, 'deDE', 'Ausgezeichnete Arbeit, $N! Gath\'llzogg führte diese Bestien in die Schlacht und war für den Tod vieler unschuldiger Menschen verantwortlich. Nun haben wir uns gerächt. Dies ist der erste Schritt zur Wiedereroberung der Burg für das Königreich Sturmwind!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (176, 'deDE', 'Ha! Gut gemacht! Ich hatte schon befürchtet, niemand würde diesem Monster den Garaus machen!$B$BHier, bitte schön, $N. Und danke - dieser Gnoll hat mir Kopfschmerzen vom Ausmaß der Schwarzfelsspitze verursacht!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (180, 'deDE', 'Der üble Leutnant Fangor ist also tot? Endlich sind wir diese abscheuliche Kreatur los. Ihr seid sehr tapfer, $C. Die Stadt Seenhain dankt Euch für Eure Hilfe.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (184, 'deDE', 'Vielen, vielen Dank, $N! Wie schon gesagt, diese Gegend ist kein Ort mehr für ehrliche LEute, aber wenn die Dinge besser werden sollten, dann können wir mit dieser Besitzurkunde unser Land zurückfordern.$B$BIch habe nicht viel, was ich Euch anbieten kann, aber hier: Nehmt das.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (218, 'deDE', 'Text: Großartig, $N! Vielen Dank, dass Ihr mein Notizbuch zurückgeholt habt. Nun, es scheint, als sei das Trollproblem hier im Eisklammtal unter Kontrolle und als müssten wir uns nicht allzu viele Sorgen machen.$B$BNachdem ich meinem Bericht den letzten Schliff gegeben habe, werde ich jemanden brauchen, der ihn meinem Bruder Senir bringt.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (239, 'deDE', 'Marschall Dughan hat Euch geschickt, wie? Ihr seid zwar nicht in der Armee, aber wenn Dughan Euch geschickt hat, dann soll mir das recht sein.$B$BUnsere Lage hier ist, um es gelinde auszudrücken, angespannt. Ich hoffe, Ihr könnt ein wenig aushelfen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (244, 'deDE', 'Rotkammgnolle so nah an Elwynn? Es ist möglich, dass sie kurz vor einem Einfall in unsere Heimat stehen. Bald werden die Bewohner von Seenhain nicht die einzigen Menschen sein, die belagert werden!$B$BHier ist Euer Lohn, auch wenn Ihr uns schlechte Nachrichten bringt. Und es kommt auch noch zu einem schlechten Zeitpunkt, denn wir sind nicht gut dafür gerüstet.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (246, 'deDE', '<Stellvertreter Feldon hört sich Euren Bericht an.>$B$BDann lagert dort eine beachtliche Streitmacht Gnolle und nach dem, was Ihr mir erzählt habt, sind sie auch zäh. Es kann nicht leicht für Euch gewesen sein, diese Informationen zu beschaffen.$B$BHier, bitte schön, $N. Wir danken Euch für Eure Hilfe.$B$BUnd falls Ihr es noch nicht getan habt, sprecht in Seenhain auch mit Marschall Marris und Magistrat Solomon. Unsere Situation wird immer verzweifelter - die beiden werden Euch brauchen können, da bin ich mir sicher.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (373, 'deDE', 'Edwin van Cleef, sagt Ihr? Mit einem Brief von meiner toten Großmutter hätte ich eher gerechnet... Ihr habt ihn also getötet? Verzeiht, wenn ich das sage, aber ich bin etwas überrascht. Er war ein unvergleichlicher Krieger in seinen jungen Jahren. Lasst mich mal sehen, weswegen er mir nach so vielen Jahren auf einmal schreiben muss.$B$B<Baros überfliegt den Brief.>$B$BEdwin... Die Jahre haben dich offensichtlich kein bisschen verändert, immer noch der alte Idealist und Romantiker. Es kümmert ihn nicht, wen er verletzt, $N. Die Rache hat ihn verzehrt. Allerdings weiß ich nicht, ob ich ihm daraus einen Vorwurf machen kann.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (386, 'deDE', 'Targorr den Schrecklichen hat endlich sein Schicksal ereilt. Es freut mich jedenfalls, zu hören, dass diese Bestie jetzt weiß, wie es ist, selbst im ewigen Griff des Todes zu stecken. Ihr habt Eure Sache gut gemacht, $N. Manchmal kann wahre Gerechtigkeit nur außerhalb des Gerichtssaales und der Kurzsichtigkeit der Politik gefunden werden.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (387, 'deDE', 'Eure Bemühungen im Verlies waren tapfer, $N. Es ist offensichtlich, dass dieses Problem etwas über unserer beider Fähigkeiten liegt. Aber Ihr habt Eure Sache gut gemacht, und dafür bin ich Euch dankbar.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (388, 'deDE', 'Diese Kopfwickel - diese schmutzigen Wahrzeichen der Korruption - sind es also, wofür mein Mac sterben musste? Was für eine Verschwendung. Welch tragisches Opfer.$B$BDoch leider kann ich nicht in die Vergangenheit zurückkehren. Wisset jedoch, $N, dass Ihr meiner Familie mit Euren Tagen Gerechtigkeit verschafft habt.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (389, 'deDE', 'Was, beim Licht, wollt Ihr? Könnt Ihr nicht sehen, dass wir hier in einer Krisensituation sind?$B$BBazil Thredd?! Warum solltet Ihr mit diesem Trottel sprechen wollen? Woher soll ich wissen, ob Ihr nicht einer seiner Spießgesellen seid, der herkam, um ihm bei seinem verdammten Aufstand zu helfen? Wenn die verfluchten Zellen nicht alle offen wären, würde ich Euch für eine Weile in eine davon werfen!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (391, 'deDE', 'Jetzt, wo Thredd sie nicht mehr anführen kann, ist der Aufstand hoffentlich eher unter Kontrolle zu bringen... Wir werden sehen.$B$BIch muss gestehen, dass ich nach einer halben Stunde kaum mehr erwartete, dass Ihr wieder herauskommen würdet, aber ich habe Euch wohl falsch eingeschätzt.$B$BIch nehme daher mal an, dass Ihr nicht viele nützliche Informationen aus ihm herausbekommen habt. Aber ich weiß bereits das eine oder andere über Thredds Aktivitäten, das für Euch von Interesse sein könnte.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (783, 'deDE', 'Ah, gut. Noch ein Freiwilliger. Es kommen viele davon in letzter Zeit. $B$BHoffentlich sind es genug.$B$BDas Menschenland wird von außerhalb bedroht und große Teile unserer Streitkräfte wurden ins Ausland beordert. Das lässt Raum für verderbte und gesetzlose Gruppen, die sich innerhalb unserer Grenzen ausbreiten können.$B$BWir kämpfen hier gleich an mehreren Fronten, $N. Stellt Euch auf eine lange Kampagne ein.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (1097, 'deDE', 'Ihr seid hier, um mir mit meiner Lieferung zu helfen? Sehr gut!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (1657, 'deDE', 'Ah, gut gemacht! Ich hoffe die Allianz erstickt an dem fauligen Gift, das wir ihnen verabreicht haben, genauso wie wir den Witz der Versklavung an die Geißel schlucken mussten!$B$BIhr habt die wahre Bedeutung der Schlotternächte erhalten, $N, ich danke Euch dafür. Lasst mich ein paar Schlotternachtssüßigkeiten mit Euch als zusätzliche Belohung teilen. Ihr werdet sie sicher als eine recht angenehme Abwechslung betrachten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (1658, 'deDE', 'Gut gemacht, $N. Das Fest des Weidenmanns wird auch noch zukünftig für Ärger sorgen, wenn die abscheulichen Verlassenen weiterhin die Verbliebenen von Lordaeron jagen dürfen. Es ist KEINE passende Ehrung für dieses einst so stolze Königreich, lasst Euch das gesagt sein...$B$BHier sind ein paar Münzen für eventuell benötigte Reparaturen. Ich habe dem Anlass entsprechend auch ein paar Süßigkeiten, die Ihr mögen könntet, mit hinzugepackt. Gruselige Schlotternächte - lasst es uns dafür sorgen, dass es in Süderstade so sicher wie möglich bleibt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (1860, 'deDE', 'Wurdet Ihr geschickt, um mich bei meiner Aufgabe zu unterstützen, $N? Gut. Schön zu sehen, dass junge Magier darauf brennen, unsere Sache zu unterstützen...$B$BWas für eine Sache, fragt Ihr? Alles zu seiner Zeit. Zu gegebener Zeit werdet Ihr es erfahren.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (1861, 'deDE', 'Danke, $N. Ich werde das Wasser auf magische Eigenschaften hin prüfen. Hoffen wir, dass es keine enthält, sonst werden alle, die zu lange aus dem Spiegelese trinken, negativ beeinflusst.$B$BHier, $N. Nehmt diese Kugel oder diesen Stab als Zeichen dafür, dass Ihr mir gute Dienste geleistet habt. Was Ihr auch wählt, es möge Euch nützlich sein.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (2158, 'deDE', 'Ruhe und Entspannung für die Müden und Frierenden - das ist unser Leitspruch! Bitte setzt Euch ans Feuer und wärmt Eure müden Knochen.$B$BMöchtet Ihr von unseren erlesenen Speisen und Getränken kosten?', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (3741, 'deDE', 'Vielen Dank, dass Ihr meine Halskette gefunden habt... Ihr seid sehr gütig! Auch mein Kätzchen dankt Euch... nicht wahr, Effsee?', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (3903, 'deDE', 'Ach, Stellvertreter Willem hat Euch also gesagt, Ihr sollt mit mir reden, ja? Er ist ein tapferer Kerl und immer bereit, mir zu helfen, aber seine Pflichten halten ihn in der Abtei von Nordhain fest und ich fürchte, das Problem, das ich heute habe, ist etwas zu groß für ihn.$B$BVielleicht könnt Ihr mir helfen?', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (3904, 'deDE', 'Oh, danke, $N! Ihr habt meine Ernte gerettet! Und ich hoffe, Ihr habt einigen von diesen Defias gezeigt, dass sie hier nicht so einfach Ärger machen können.$B$BWir sind zurzeit zwar knapp an Wachen, aber glücklicherweise haben wir $GHelden:Heldinnen; wie Euch, die uns beschützen!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (3905, 'deDE', 'Dann zeigt mal her...$B$BMeine Güte! Millys Trauben sind gerettet! Als sie mir erzählte, dass Briganten ihren Weinberg überfallen haben, wäre ich fast verzweifelt, doch ich habe den Glauben an das Licht nicht verloren!$B$BUnd dank Eures Heldenmutes haben wir jetzt Trauben, um neuen Wein herstellen zu können! Möge das Licht Euch segnen und über Euch wachen, $N!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (5261, 'deDE', 'Das ist wahr. Ich suche nach jemandem, der für mich ein paar kranke Wölfe jagt! Seid Ihr diese Person?', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (5545, 'deDE', 'Exzellent! Dank Euch sollte ich die Bestellung rechtzeitig zusammenstellen können. Um Euch meine Dankbarkeit zu zeigen, würde ich Euch gern ein paar Münzen als Entschädigung für Eure Mühen anbieten.$B$BVielen Dank und lebt wohl.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (5921, 'deDE', 'Und so beginnt es, Vater Cenarius. Und so beginnt es.$B$BDendrite macht eine schnelle, unsichtbare Geste in die Luft über ihm. Eine leichte Aura der Macht fällt über ihn.$B$BDie erste Perspektive der Natur, die Ihr Euch aneignen müsst, ist die des Bären. Ich werde Euch auf den Weg bringen, um diesen Aspekt des Druidenlebens zu verstehen, aber Ihr müsst ihn Euch zu Eigen machen und pflegen - von nun an und für immer!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (5925, 'deDE', 'Ich bin froh, dass Ihr heute Euren Weg hierher gefunden habt. Es ist an der Zeit für Euch, einen großen Schritt in eine noch viel größere Welt zu tun.$B$BIn jedem von Cenarius\' Kindern steckt die Berufung, der Natur zu dienen. Tiere und Pflanzen sind unsere Freunde wie auch unsere Schützlinge. Wir haben uns entschlossen, sowohl zu ihrem wie auch unserem Wohl unsere Leben dem Erhalt des Gleichgewichts zu widmen. Euer erster Schritt in diese Welt wird es sein, etwas über den Weg des Bären und die Stärke von Körper und Herz zu erlernen.$B$BMacht Euch bereit!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (5929, 'deDE', 'Dendritte macht eine weitere unsichtbare Geste in der Luft über ihm, als Ihr Euch ihm nähert. Eine erneute Aura der Macht legt sich auf ihn und er lächelt ein wenig.$B$BIch spüre Weisheit in Euch, Weisheit, die nicht zugegen war, als wir uns das erste Mal trafen. Ihr blickt mit Stärke und verständnisvollem Eifer zu mir auf, auch wenn dieser Eifer noch nicht sehr zielgerichtet ist. Ihr werdet nun lernen, Eure Stärke zu fokussieren und das Wesen des Bären in Eure Arbeit anzuwenden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (5931, 'deDE', 'Willkommen, $N. Ich spüre, dass Eure erste Begegnung mit dem großen Bärengeist genauso verlief wie bei allen Druiden, wenn sie die ersten Schritte auf dem Pfad der Klaue tun... etwas verwirrend, aber sehr eindrucksvoll. Ich weiß, dass es für mich damals auch so war.$B$BDer große Bärengeist ist schon so lange ein Teil von Azeroth wie Azeroth in den Himmeln existiert. Wir verlassen uns heute auf seine Weisheit und seine Macht, um unseren Absichten Antrieb zu verleihen. Nun ist es an der Zeit für Eure erste Prüfung dieser Absichten. Hört mir gut zu...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (6001, 'deDE', 'Endlich habt Ihr den Schritt in eine viel größere Welt getan, $N. Ich spüre die Lehre des großen Bärengeistes in Euch, und auch, dass Ihr die Kraft erhalten habt, die Mondklaue besaß.$B$BKein weiteres Hindernis versperrt Euren Weg... lasst mich Euch jetzt lehren, was es bedeutet, ein $C der Klaue zu sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (6181, 'deDE', 'Ihr müsst diese Notiz nach Sturmwind bringen? Das ist kein Problem, Ihr könnt einen meiner Greifen nehmen!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (6261, 'deDE', 'Eine Kiste für Westfall, eh? Seid Ihr schon mal in Westfall gewesen? Falls ja, ist das kein Problem. Ich habe viele Greifen ausgebildet, damit sie diese Route fliegen können!', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (6281, 'deDE', 'Ah, eine Notiz von Quartiermeister Lewis? Es überrascht mich gar nicht, dass er mehr Ausrüstung braucht. Die Späherkuppe ist weit entfernt in einem Land, das Sturmwind fast vergessen hat.$B$BIch danke Euch, $N. Hier habt Ihr etwas Geld für Eure Reisespesen.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8311, 'deDE', 'Wow, Ihr habt sie alle! Ihr seid großartig!$B$BDanke, dass Ihr für mich Süßigkeitensammeln und Streichespielen gegangen seid. Hier, nehmt diese Kürbisdrops - Ihr findet sie bestimmt ganz toll!$B$BGruselige Schlotternächte, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8312, 'deDE', 'Wow, Ihr habt sie alle! Ihr seid großartig!$B$BDanke, dass Ihr für mich Süßigkeitensammeln und Streichespielen gegangen seid. Hier, nehmt diese Kürbisdrops - Ihr findet sie bestimmt ganz toll!$B$BGruselige Schlotternächte, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8322, 'deDE', 'Nachdem Ihr Euch erfolgreich bis ins Gasthaus durchgeschlagen habt, werft Ihr jetzt die Eier in den großen Kessel. Ihr riecht bereits, wie der faulige Gestank die Luft verpestet...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8325, 'deDE', 'Ihr habt Eure erste Aufgabe erfolgreich gemeistert; lasst mich Euch dafür danken. Ein derartiger Erfolgt bestärkt mich in meinem Glauben, dass Ihr Euch besser anstellen werdet als diese jungen Blutelfen, die sich nicht an die Vorgaben ihrer Meister halten. Weitere Leistungen wie diese werden belohnt werden - nicht nur mit Wissen, sondern auch mit greifbaren Belohnungen.$B$BDennoch, Eure Arbeit hier ist noch nicht getan. Es gibt noch viel zu lernen, mein Kind...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8326, 'deDE', 'Der Turm und die unmittelbare Umgebung sollten jetzt einigermaßen sicher sein, zumindest vorerst. Dank Euch haben wir an Sicherheit gewonnen, aber es gilt die Kontrolle über die ganze Insel wiederzuerlangen, wenn wir hier auf Dauer überleben wollen. Es wird weitaus mehr verlangen, als Manawyrms und Luchse auszulöschen.$B$BNehmt dies, $N - es wird Euch bei Euren künftigen Taten sicherlich von Nutzen sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8327, 'deDE', 'Magistrix Erona sagte mir bereits, dass Ihr schon bald hier sein würdet, $N. Es steht sehr schlecht um die Akademie von Falthrien, das große schwebende Gebäude mit den kunstvollen Türmchen, das westlich von uns liegt. Ihr werdet den Rückeroberungsversuch gegen einen Getriebenen anführen - einen Blutelfen, der ihrer erbärmlichen Gier auf ewig verfallen ist.$B$BIch hoffe Ihr seid bereit. Dies wird Euch nicht nur einiges über Gefahren lehren, sondern auch etwas über das Schicksal, das Euch ereilt, wenn Ihr Eure Existenz leugnet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8328, 'deDE', 'Ah, $N - Ihr gehört wohl zu den neuen Magiern hier auf der Insel, ja? Nun, Ihr seid hier richtig. Wenn es die Arkanbeherrschung ist, nach der Ihr sucht, dann kann ich Euch dieses Wissen vermitteln - solange Ihr über die erforderlichen Mittel verfügt, um die Ausbildungskosten zu tragen und solange Ihr Euch auf das konzentrieren könnt, was ich Euch lehre.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8330, 'deDE', 'Gut gemacht – ich wusste, dass Ihr für diese Aufgabe geeignet sein würdet. Sobald wir uns auf der Insel wieder frei bewegen können, werde ich meine Sachen gut einsetzen.$B$BWie ich schon sagte, Ihr könnt den Ranzen behalten. Außerdem könnte auch dieses Rüstungsteil von Nutzen für Euch sein. Betrachtet es als großzügige Entlohnung für eine einfache Pflichterfüllung! ', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8334, 'deDE', 'Der Tod der Borklinge macht mich zwar nicht glücklicher, aber es beweist mir, dass Ihr für die wichtigste Aufgabe hier auf der Insel der Sonnenwanderer bereit seid. Nehmt dies und setzt es mit Bedacht ein; Ihr werdet gute Waffen und einen scharfen Verstand für Euren nächsten Auftrag brauchen. Es liegt an Euch, ob wir die Kontrolle über die Insel erfolgreich wiedererlangen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8335, 'deDE', 'Felendrens Kopf... Ihr verdient Lob, $N. Wo andere, wie Felendren, versagt haben, habt Ihr Euch erfolgreich gezeigt. Vielleicht seid Ihr wirklich bereit, ein gleichgestelltes Mitglied der Blutelfen zu werden.$B$BEuer Erfolg hier beweist, dass Ihr vor den größeren Bedrohungen Immersangs gefeit seid... und glaubt mir, es gibt genug davon.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8336, 'deDE', 'Großartig, die werden ihren Zweck erfüllen! Ursprünglich habe ich diesen abgelegenen Ort aufgesucht, um in aller Ruhe nachzudenken und zu erforschen, unter welchem Fluch die Insel der Sonnenwanderer leidet. Eine der Möglichkeiten, die ich in Betracht zog, war das Sammeln der Arkanspäne von den Wildtieren auf der Insel. Mit ihnen wollte ich experimentieren, um eine mögliche Ursache zu entdecken.$B$BWie auch immer, ich werde mich weiter auf meine Forschungen konzentrieren. Erlaubt mir, diesen Zauber auf Euch zu wirken. Ich denke, Ihr werdet ihn sehr nützlich finden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8338, 'deDE', 'Das ist... äußerst interessant. Mit interessant meine ich beunruhigender als alles andere.$B$BUnser Bestreben nach der Zerstörung des Sonnenbrunnens wieder die Kontrolle über diese Insel zu erlangen, war eine Herausforderung. Ich vermute, welch Übel auch immer der Grund für diese Verderbnis der Insel ist, dass das Fragment uns weitere Auskünfte über dessen Ursprung geben kann.$B$BEs war weise von Euch, damit zu mir zu kommen, $N. Nehmt dies als Vergütung für Eure Mühen. Ich danke Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8345, 'deDE', 'Ah, $N – Danke, dass Ihr mir von Euren Beobachtungen beim Schrein von Dath\'Remar erzählt habt. Euer Forscherdrang hat uns und Euch heute ausgezeichnete Dienste geleistet. Ich bin sicher, er wird Euch nicht nur hier, sondern in ganz Azeroth von Nutzen sein.$B$BWas Eure merkwürdigen Empfindungen beim Schrein angeht, ich denke, dass sich dort ein Teil der Verderbnis eingenistet hat, die die gesamte Insel der Sonnenwanderer bedroht. Wir werden die Sache im Auge behalten; danke, dass Ihr uns alarmiert habt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8346, 'deDE', 'Wenn es eine Lektion von Eurer Zeit auf der Insel der Sonnenwanderer gibt, die Ihr niemals vergessen dürft, dann ist es diese: Verliert unter keinen Umständen die Kontrolle über Euer Verlangen nach Magie. Dieser Durst ist unstillbar, $N. Verwendet den arkanen Strom, um das, was Ihr absorbiert, zu kontrollieren und in der von Euch gewünschten Form wieder freizulassen. Begeht Ihr dabei einen Fehler, werdet Ihr zu einem Getriebenen... hoffnungslos abhängig und dem Wahnsinn verfallen.$B$BSucht nach einem Manawyrm und fokussiert Euren Manadurst auf ihn. Lernt, Eure Macht zu kontrollieren. Kehrt zu mir zurück, wenn Ihr einen arkanen Strom entfesselt habt - und das zufriedenstellend.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8347, 'deDE', 'Oh, hallo $C! Ich hörte schon, dass eine von Magistrix Eronas findigen Blutelfen sich auf den Weg hierher gemacht hat, um uns Kundschaftern ein wenig zur Hand zu gehen. Etwas Hilfe kommt uns sehr gelegen, insbesondere von jemand so tatkräftigem wie Euch.$B$BSeid Ihr bereit, ein oder zwei Botengänge für uns zu erledigen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8350, 'deDE', 'Vielen Dank, ich weiß Eure prompte Lieferung sehr zu schätzen.$B$BWo Ihr schon mal da seid, könnt Ihr es Euch auch gleich gemütlich machen. Ich habe einige Ruhesteine im Angebot, falls Ihr noch keinen erworben habt. Mit diesem Stein könnt Ihr Euch einmal alle halbe Stunde in ein Gasthaus zurückteleportieren. Macht Euch keine Sorgen, wenn Ihr Euren Ruhestein mal verlieren solltet. Kehrt einfach zu einem Gastwirt Eurer Wahl zurück und er wird Euch mit Freuden einen neuen Stein zur Verfügung stellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8353, 'deDE', 'Was für ein Spaß! Nicht schlecht, $N! Hier ist Eure Süßigkeit.$B$BGruselige Schlotternächte!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8354, 'deDE', 'Was für ein Spaß! Nicht schlecht, $N! Hier ist Eure Süßigkeit.$B$BGruselige Schlotternächte!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8355, 'deDE', 'Huu-huu! Klasse, $N! Hier ist Eure Süßigkeit.$B$BGruselige Schlotternächte!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8356, 'deDE', 'Ihr seid wirklich stark, haha! Gut gemacht, danke für die tolle Schau. Hier ist Eure Süßigkeit.$B$BGruselige Schlotternächte, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8357, 'deDE', 'Ihr seid ganz schön tanzwütig, $N!$B$BHier ist die Süßigkeit für Eure tolle Leistung. Gruselige Schlotternächte und sagt dem kranken Kindchen alles Gute von mir! Hoffentlich wird es bald wieder gesund.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8358, 'deDE', 'Huu-huu! Klasse, $N! Hier ist Eure Süßigkeit.$B$BGruselige Schlotternächte!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8359, 'deDE', 'Ihr seid wirklich stark, haha! Gut gemacht, danke für die tolle Schau. Hier ist Eure Süßigkeit.$B$BGruselige Schlotternächte, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8360, 'deDE', 'Ihr seid ganz schön tanzwütig, $N!$B$BHier ist die Süßigkeit für Eure tolle Leistung. Gruselige Schlotternächte und sagt dem kranken Kindchen alles Gute von mir! Hoffentlich wird es bald wieder gesund.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8373, 'deDE', 'Ah, es riecht schon fast wieder gut hier. Fast.$B$BIch danke Euch, $N, Süderstade kommt vielleicht ein weiteres Mal über die Schlotternächte hinweg. Hier sind Eure Süßigkeiten, gern geschehen! Solltet Ihr noch mehr Süßigkeiten benötigen, dann könnte Euch eventuell eine Gnomin namens Katrina Schimmerstern in Eisenschmiede noch mehr verkaufen; ich glaube, dass sie sich nur während der Schlotternächte dort aufhält.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8409, 'deDE', 'Ah, Erfolg! Ihr habt wahren Schlotternachtsgeist bewiesen - Geist eines VERLASSENEN sollte ich wohl eher sagen!$B$B<Ruferin der Dunkelheit Yanka lacht und reibt sich die Hände.>$B$BIch lache mir ins Fäustchen, dass Süderstade sich jetzt an verdorbenem Bier erfreuen darf! Hier habt Ihr Eure Süßigkeiten. Ich bin mir sicher, dass Ihr eine gute Verwendung dafür finden werden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8463, 'deDE', 'Hervorragende Arbeit, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8468, 'deDE', 'Diesen Halunken, Thaelis, hat endlich sein gerechtes Schicksal ereilt. Gute Arbeit, $N. Damit sollten wir einige Zeit lang Ruhe vor den Getriebenen haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8472, 'deDE', 'Ihr habt Euch gut geschlagen, $N. Solange die arkanen Sankten nicht vollständig einsatzbereit sind, werden sich diese Kraftkerne als sehr nützlich erweisen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8473, 'deDE', 'Es ist also getan. Ich verfluche diese Zeit, die uns zu solch verzweifelten Maßnahmen treibt... und ich verfluche unseren Feind, die Geißel!$B$BVerinnerlicht diese Lektion, $N. Unser Land muss beschützt werden, ganz egal wie hoch der Preis dafür sein mag. Wir werden obsiegen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8474, 'deDE', 'Dieser... dieser Anhänger. Ich gab ihn Weißborke dem Alten, nachdem seine Leute uns beim Wiederaufbau unseres Dorfes geholfen hatten.$B$BIch vermute, das bedeutet, dass er...$B$B<Die Blutelfe räuspert sich und gewinnt ihre Fassung wieder.>$B$BIch weiß zu schätzen, dass Ihr mir den Anhänger gebracht habt, $N. Ich muss Euch um einen Gefallen bitten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8475, 'deDE', 'Wir denken nicht, dass die Geißel in absehbarer Zeit ihre Angriffe einstellen wird, dennoch sind wir jedem dankbar, der uns bei der Verteidigung der Schneise unterstützt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8476, 'deDE', 'Gute Arbeit, $N. Mit mehr Leuten wie Euch, wird unser Königreich schon bald zu alter Größe zurückfinden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8477, 'deDE', 'Die Gerüchte entsprechen der Wahrheit, $N. Dieser Hammer ist leicht und mächtig zugleich; ich werde einige meiner begonnenen Werke fertigstellen können. Natürlich dürft Ihr Euch als Erster etwas von den Gegenständen aussuchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8479, 'deDE', 'Yo, Mann. Zul\'Marosh hat\' solch ein Ende verdient. Er brannte Ven\'jashis Dorf nieder. Ich hab\' viele Amani getötet, bevor sie mich in diesen Käfig steckten. Ich habe etwas im Sand versteckt, es ist mein Geschenk an Euch.$B$BAh... ah, das Gift... es wirkt stärker, Mann. Zeit zu ruhen... ', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8480, 'deDE', 'Gute Arbeit, $N. Jetzt zeigen wir den Getriebenen mal, aus welchem Holz wir geschnitzt sind!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8482, 'deDE', 'Seid Ihr sicher, dass Ihr das bei einem Nachtelfen gefunden habt? Das Geschriebene ist eindeutig zwergisch...$B$BSoweit ich diesen Brief deuten kann, hatte der Verfasser nichts mit der Fehlfunktion zu tun, stattdessen wurde er hierher gesandt, um die Folgen der Katastrophe zu beobachten. Sie bezeichnen unsere Bemühungen als rücksichtslos und gefährlich, aber wer...?$B$BNatürlich! Dieser Gesandte aus Eisenschmiede! Es war ein Fehler von uns, einem Mitglied der Allianz zu vertrauen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8483, 'deDE', 'So, es ist also getan. Hervorragende Arbeit.$B$BWir haben den Waldläufergeneral von der Situation in Kenntnis gesetzt und glaubt mir, die Zwerge werden für ihren Verrat mit Blut bezahlen.$B$BHeute habt Ihr Eurem Volk einen großen Dienst geleistet, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8486, 'deDE', 'Danke, $N. Jetzt, wo wir die Gespenster unter Kontrolle haben, können wir das Ganze von jemandem begutachten lassen. Hoffentlich handelt es sich nicht um bleibende Schäden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8487, 'deDE', 'Ausgezeichnet. Ich werde einen Zauber auf die Proben wirken, damit ich die Besudelung besser analysieren kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8488, 'deDE', 'Es ist hoffnungslos, $N. Die Beschaffenheit der Erde selbst hat sich verändert... die Besudelung ist unabänderlich. Vielen Dank für Eure Unterstützung. Ich muss Euch noch um einen letzten Gefallen bitten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8490, 'deDE', 'Hervorragend. Die Verteidigungsmaßnahmen sollten die Geißel noch ein wenig länger in Schach halten. Vielen Dank für Eure Hilfe, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8491, 'deDE', 'Die werden ihren Zweck erfüllen, $N. Nehmt dieses Rüstungsteil als Belohnung. Mit den Pelzen, die Ihr mir gebracht habt, werde ich noch mehr herstellen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8884, 'deDE', 'Gute Arbeit, $C. Dem Gestank nach zu urteilen, seid Ihr mit der von mir geforderten Beute zurückgekehrt, vielleicht sogar mit mehr. Ich bin mir sicher, dass wir dafür Verwendung haben werden, sei es in einem Eintopf oder etwas Ähnlichem.$B$BLeider scheinen Eure Bemühungen den Zweck nicht erfüllt zu haben; die Murlocs ziehen sich noch immer nicht zurück. Wir müssen noch tatkräftiger handeln!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8885, 'deDE', 'Endlich! Die Grimmschuppen sind zwar noch immer nicht gewichen, wie erhofft, aber es war ein herrliches Schauspiel, als sie nach dem Tod ihres Anführers in Panik und Verwirrung umhergeirrt sind. Ihr habt meinen Dank und den der Sin\'dorei von Silbermond!$B$BBitte, nehmt eine dieser Belohnungen für Eure Mühen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8886, 'deDE', 'Ihr habt es geschafft! Ihr habt mich vor dem Ruin bewahrt und die scheußlichen Kreaturen meine Vergeltung spüren lassen!$B$BWenn ich es jetzt noch schaffe, dass mir diese hübschen Waldläufer mit meiner Fracht helfen, dann komme ich endlich weg von hier! Ich muss noch einmal zurückkehren, wenn Velendris die Schiffswerft zurückerobert hat.$B$BHier, nehmt diese Münze. Ich kann Euch leider nicht mehr geben, aber ich hoffe, es entlohnt Eure Mühen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8887, 'deDE', 'Oh, Ihr herzensguter, herzensguter $C! Ich hatte ja keine Ahnung, dass diese widerlichen Grimmschuppenmurlocs auch noch meine Seekarten entwendet hatten! Ohne diese Karten hätte ich niemals wieder in See stechen können, sobald wir den Ankerplatz zurückerobert und das Schiff repariert haben.$B$BIch bin Euch zutiefst dankbar! Hier, nehmt diese Münze als Zeichen meiner Anerkennung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8888, 'deDE', 'Der Magister sorgt sich um mein Wohlergehen? Wie süß von ihm; ich wünschte, er hätte ein derartiges Interesse etwas früher gezeigt, als wir noch im Turm waren.$B$BNaja, das tut jetzt nichts zur Sache. Hört gut zu, $C, ich muss Euch um einen Gefallen bitten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8889, 'deDE', 'Ich bin Euch für Eure Hilfe dankbar, aber es betrübt mich zu hören, dass einige meiner Lehrlingsfreunde der Abhängigkeit verfallen sind.$B$BJetzt, da die Kraftquellen des Turms deaktiviert wurden, werde ich wohl noch eine Weile hier bleiben. Ich möchte sehen, ob sich die Lage beruhigt, damit ich mich hineinschleichen kann, um ihre Überreste zu bergen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8890, 'deDE', 'Nein! Ich war zu spät. Es ist alles meine Schuld.$B$BMeine Untersuchungen hinsichtlich der Aufbereitung alternativer Magiequellen sind mir außer Kontrolle geraten und ich konnte nichts mehr tun, was dies hätte aufhalten können. Wäre ich nur selbst gegangen... oder hätten sie auf mich gehört und meine Warnungen befolgt!$B$BMeine Hände sind mit Blut befleckt, $C. Ich danke Euch dennoch, dass Ihr diese armen Seelen meiner ehemaligen Lehrlinge erlöst habt. Es ist ein kleiner Trost zu wissen, dass sie nicht länger in dem Zustand verweilen müssen, an dessen Stelle ein Blutelf besser tot wäre.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8891, 'deDE', 'Hier ist er also, $N, der Beweis für mein Verbrechen. Dieses Tagebuch enthält all meine schlecht durchdachten Studien.$B$BIch schenkte den Warnungen keine Beachtung und führte meine Untersuchungen fort, bis es schon fast zu spät war. Als ich endlich meine Fehler einsah, tat ich alles in meiner Macht Stehende. Allerdings sind einige meiner Schüler zu diesem Zeitpunkt bereits zu weit gegangen. Ich evakuierte den Turm, um sie vor der Verderbnis in Schutz zu bringen. Jedoch vergaß ich in meiner Eile, die Kraftquellen zu deaktivieren.$B$BIch werde diese Aufzeichnungen verbrennen, damit sie zukünftig keinen Schaden mehr anrichten können. Ich wollte den Sin\'dorei doch nur helfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8892, 'deDE', 'Das wird ihnen zeigen, dass man es sich mit uns besser nicht verscherzt. Gute Arbeit, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8894, 'deDE', 'Nun, ich denke, das dürfte fürs Erste genügen, oder nicht? Danke für die Hilfe, $C. Ich hoffe nur, dass ich hier alles rechtzeitig absichern kann, bevor der Magister zum Nachtschimmerturm zurückkommt.$B$BNehmt dies bisschen Kleingeld; es ist nicht viel, aber ich habe im Moment nicht mehr. Ihr könnt ruhig noch ein paar Bestien mehr töten, wenn Ihr hier unterwegs seid, das wäre nett von Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (8895, 'deDE', 'Vielen Dank, $N. Ich habe diesen Brief bereits erwartet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9035, 'deDE', 'Sie sind jetzt weg. Hab\' ihnen mit einem gut platzierten Feuerball eine Heidenangst eingejagt! Unglücklicherweise haben sie unsere wertvollen Güter in den Fluss geworfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9062, 'deDE', 'Das Buch ist völlig aufgeweicht. Instrukteur Antheol wird alles andere als erfreut sein.$B$BHier, nehmt das Geld. Ich habe eine Idee.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9064, 'deDE', 'Ihr sagt, dass Euch diese zwei unfähigen Narren bestochen haben, damit Ihr mich anlügt? Es war richtig von Euch, zu mir zu kommen, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9066, 'deDE', 'Ausgezeichnete Arbeit, $N. Keine Sorge, sie werden nicht auf Dauer in dieser Gestalt ausharren müssen. Allerdings geht es mit ihrer Lehre erst dann weiter, wenn sie es sich verdient haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9067, 'deDE', 'Ihr seid in der Tat $Gein aufgeweckter junger Mann:eine aufgeweckte junge Dame;, nicht wahr?$B$BDiese Waren erscheinen mir dem Zwecke angemessen. Für Eure Mühen habt Ihr eine angemessene Entschädigung verdient und vielleicht ein kleines Trinkgeld.$B$BOh, das hätte ich beinahe vergessen! Hier ist eine Einladung zu meinem Fest. Und $C, wenn Ihr das nächste Mal mein Anwesen betretet, stellt sicher, dass Ihr ein wenig, sagen wir... festlicher gekleidet seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9076, 'deDE', 'Ihr habt ihn also doch noch bezwungen! Meine Männer hatten ihn natürlich schon geschwächt.$B$BDas war ein Scherz, $C. Ihr habt Euch gut geschlagen. Wenn Ihr weiterhin eine weiße Weste behaltet, werdet Ihr Euch noch einen Namen machen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9119, 'deDE', 'Seht Euch um. Hier stimmt so einiges nicht.$B$BBeim Sanktum des Westens kam es zu einem schweren Zwischenfall. Lasst uns alles Erdenkliche tun, um Schlimmeres zu verhindern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9130, 'deDE', 'Sathiel möchte, dass Ihr nach Silbermond geht und ihre Waren zurückbringt, was? Kein Problem, ich kann Euch schnell dorthin bringen... gegen eine kleine Gebühr, versteht sich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9133, 'deDE', 'Was soll das? Sie möchte all das!?$B$BHabt Ihr wenigstens jemanden bei Euch, der Euch beim Rücktransport behilflich ist?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9134, 'deDE', 'Zurück nach Tristessa in den Geisterlanden, ja? Alles klar, ich kann Euch schnell an Euer Ziel bringen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9135, 'deDE', 'Hmmm, wenn er gesagt hat, dass der Rest schnell über den Landweg nachgeliefert wird, dann will ich ihn mal beim Wort nehmen. In der kurzen Zeit, in der wir zusammen gearbeitet haben, hat er es noch immer geschafft, die Waren pünktlich zu liefern.$B$BIch danke Euch, $N. Hier, nehmt diese Münzen... sie haben schon den ganzen Tag in meiner Tasche geklimpert.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9138, 'deDE', 'Hervorragend! Doch es gibt noch viel zu tun, bis auch der letzte Rest dieser Landplage namens Geißel aus dem mächtigen Quel\'Thalas vertrieben wurde!$B$BHier, Eure Bezahlung... Es ist zwar nicht viel, doch Ihr habt es Euch verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9139, 'deDE', 'Euer Erfolg in Goldnebel bringt uns wieder einen Schritt näher an die vollständige Rückeroberung unserer Ländereien. Doch lasst Euch nicht täuschen, $C, diese Schlacht ist noch lange nicht geschlagen.$B$BHier, diese Belohnung habt Ihr Euch mehr als verdient. Sie wird sich als nützlich erweisen, sobald Ihr nach Windläuferdorf aufbrecht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9140, 'deDE', 'Ihr habt es geschafft, $N. Ihr habt drei Dörfer aus der Umklammerung der Geißel befreit! Nun können wir uns voll und ganz auf die Bekämpfung der Geißel in der Todesschneise und südlich bei der Todesfestung konzentrieren.$B$BSucht Euch eine dieser Belohnungen aus. Ich hoffe, Ihr bleibt noch ein Weilchen. Wir können Eure Hilfe auch weiterhin gut gebrauchen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9143, 'deDE', 'Ich schätze Eure Bemühungen, $C! Habt Dank. Wenigstens können wir jetzt sagen, dass diese ganze Expedition und die vielen Opfer nicht vergebens gewesen sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9144, 'deDE', 'Helft mir, Fremder. Ich muss... Tristessa... erreichen... Ich darf nicht versagen.$B$B<Der Blick des Blutelfen entschwindet ins Leere, und er versinkt wieder in Bewusstlosigkeit.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9145, 'deDE', 'Es ist gut zu hören, dass Lethvalin sich in Sicherheit bringen konnte, und dass er Euch um Hilfe gebeten hat, anstatt einfach nur abzuwarten.$B$BHoffentlich konnte sich Waldläuferin Salissa zur Enklave der Weltenwanderer durchschlagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9146, 'deDE', 'Das sind in der Tat schlechte Nachrichten - Ich habe Tomathrens Führungsqualitäten völlig überschätzt. Ich werde sofort einen Kampftrupp entsenden, um ihn und Valanna sicher zurückzubringen.$B$BUnglücklicherweise haben wir nichts mehr von Waldläuferin Salissa gehört, ich befürchte das Schlimmste.$B$BIhr habt den Weltenwanderern heute einen wertvollen Dienst erwiesen, $C. Bitte nehmt dies als Zeichen unserer Wertschätzung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9147, 'deDE', 'Gerade noch rechtzeitig, $N! Ich war drauf und dran für unseren Freund hier ein schönes Loch auszuheben.$B$BMein Trank scheint zu wirken; er kommt wieder zu sich.$B$BHey, ich glaube er will Euch etwas sagen. Warum versucht Ihr nicht mal mit ihm zu sprechen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9148, 'deDE', 'Endlich! Wir haben schon seit Wochen auf eine Antwort vom Lordregenten gewartet! Lasst mich mal sehen...$B$B<Vandril beginnt den Brief zu lesen.>$B$BWas soll das? Eine finstere Präsenz? Er spürt eine finstere Präsenz in den Geisterlanden?! Im Ernst, das hätte ich ihm auch sagen können!$B$BIst das die Nachricht, auf die wir gewartet haben?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9149, 'deDE', 'Ausgezeichnet! Diese Rückgrate sind für meine Untersuchungen von unschätzbarem Wert! Sollte ich ein Heilmittel gegen die Seuche finden und meinem Namen dadurch Ruhm verleihen, werde ich nicht vergessen, Euch zu erwähnen!$B$BBis dahin, nehmt dies als Belohnung. Ihr könntet davon Gebrauch machen, solltet Ihr noch einmal zur Küste gehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9150, 'deDE', 'Sie sind in einem bemerkenswert guten Zustand, $N. Ich bin mit Eurer Arbeit sehr zufrieden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9151, 'deDE', 'Darenis schickt Euch? Gut, ich schätze, wir können Euch im Kampf gegen Dar\'khans Streitmächte brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9152, 'deDE', 'Dank der restlichen Vorräte hier, kann ich jetzt endlich mit meinem Geschäft loslegen. Ich bin mir sicher, dass der Hochexekutor erfreut sein wird, sobald er hört, dass der Krieg gegen Dar\'Khan und die Geißel beginnen kann.$B$BNatürlich gibt es da auch noch Eure Belohnung. Nun gut, $C, hier ist die von mir erwähnte Münze. Solltet Ihr irgendwelche Handwerkswaren benötigen, schaut einfach vorbei.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9155, 'deDE', 'Nicht schlecht, $N. Macht weiter so! Leute wie Euch können wir immer gebrauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9156, 'deDE', 'Aha! Luzran und Faulbein! Jetzt seht ihr nicht mehr so gefährlich aus, was? Aber immer noch genauso hässlich!$B$BNehmt dies als Belohnung, $N. Ihr habt es Euch verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9157, 'deDE', 'Mithilfe dieser Halsketten werden wir Aquantion erneut beschwören. Der rebellische Elementar wird bezahlen und unser Tod wird gerächt werden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9158, 'deDE', 'Ihr habt Euch bewährt, $N. Es ist von größter Wichtigkeit, dass die Seuche nicht auch noch die gesunde Fauna des Immersangwalds befällt. Ich habe noch weitere Aufgaben für Euch, sofern Ihr noch auf der Suche nach Arbeit seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9159, 'deDE', 'Ihr habt Eure Aufgabe sehr ernst genommen und daher möchte ich Euch entsprechend belohnen. Wir brauchen mehr Verbündete mit Eurer Hingabe und Tapferkeit, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9160, 'deDE', 'Es ist enttäuschend, dass es keine offensichtlichen Hinweise auf die Pläne der Nachtelfen bei An\'daroth gab. Wie auch immer, diese Bäume, welche aussahen wie kleine magisch gewachsene Bäume mit Energiekugeln auf ihrer Spitze, sind äußerst interessant. Es scheint mir, als müssten wir die Art unserer Informationsbeschaffung ein wenig direkter gestalten.$B$BHier, nehmt diese Münze und die Tränke. Vermutlich werdet Ihr sie noch brauchen, bevor wir diese Angelegenheit mit den Nachtelfen geklärt haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9161, 'deDE', 'Ihr blättert durch die ersten Einträge des uralten Buchs und kommt zu dem Schluss, dass es einst der Person gehörte, die heute als Dar\'khan Drathir bekannt ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9162, 'deDE', 'Diese Information ist für uns von hohem Wert, $N. Wir alle wussten von Dar\'Khans Plänen, die Macht des Sonnenbrunnens für die Geißel zu stehlen, doch vieles auf diesen Seiten ist völlig neu für uns. Magister Kaendris beim Sanktum der Sonne wird sich sicherlich sehr dafür interessieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9163, 'deDE', 'Äußerst beunruhigend! Die Pläne zeigen die Streitkräfte der Nachtelfen bei An\'daroth, von denen wir bereits wussten, doch gibt es wohl eine weitere Gruppe bei An\'owyn, einem eher abgelegenen Leyliniennexus im Südosten.$B$BEs existiert noch ein dritter Nexus im Osten, An\'telas, der nicht weiter erwähnt wird. Ich habe da ein ganz mieses Gefühl bei der Sache, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9164, 'deDE', 'Ich danke Euch, $N. Ohne Eure Hilfe hätten diese Gefangenen ihren Verstand und ihre Seele an die Geißel verloren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9166, 'deDE', 'Es war schrecklich! Nachtelfen! Sie haben einen Mondkristall beschworen und irgendeine Niedertracht geplant. Glücklicherweise konnte ich mich davonschleichen und einige unserer Späher und Zauberer aus dem nahegelegenen Sanktum der Sonne zu Hilfe holen. Es gelang uns, die meisten von ihnen zu töten. Die anderen sind daraufhin losgezogen, um die Überlebenden zu jagen!$B$BIch bin so froh, dass Ihr gekommen seid; man hat mich hier nur mit einigen wenigen Spähern zur Verteidigung zurückgelassen!$B$BGebt mir einen Moment, um diese Pläne zu lesen, möglicherweise finde ich heraus, worauf es die Nachtelfen abgesehen haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9167, 'deDE', 'Am heutigen Tage habt Ihr der Geißel in dieser Region einen tödlichen Schlag versetzt.$B$BNach dem Tod des schändlichen Verräters ist die Rückeroberung unserer Länder nur noch eine Frage der Zeit. Schon bald werden wir zu altem Ruhm und Glanz zurückgefunden haben!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9169, 'deDE', 'Ich bin erleichtert, $C! Seid versichert, dass wir ohne Eure Hilfe bei der Abschaltung der Seherkristalle in einer noch viel schwierigeren Lage wären, als wir es sowieso schon sind! Man stelle sich nur vor, umgeben von Feinden und einer von ihnen besäße die Fähigkeit, uns auf Schritt und Tritt zu beobachten!$B$BDank Euch müssen wir uns darüber keine Sorgen mehr machen! Ich habe hier zufällig noch einige Gegenstände herumliegen, für die ich keine weitere Verwendung mehr habe; sicherlich werdet Ihr davon etwas gebrauchen können. Hier, nehmt das als Belohnung.$B$BNochmals vielen Dank, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9170, 'deDE', 'Dar\'Khans Armeen fallen! Die Geißel kann nicht gegen die vereinte Macht der Sin\'dorei und der Verlassenen bestehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9171, 'deDE', 'Sehr schön, das dürfte den Zweck erfüllen. Nein, erzählt mir nicht, wie die Dinger rumgekrabbelt sind, ich will es nicht wissen! Ich werde etwas Magie verwenden, dann werden diese Beinchen schon schmackhaft. Ein paar Gewürze, eine Messerspitze Kräuter und natürlich ein paar arkane Zutaten – et voilà, ein passendes Mahl für eine Königin... oder in diesem Fall, eine Dame.$B$BEure Dienste waren zufriedenstellend, $C. Hier, nehmt dieses Rezept und ein paar Portionen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9172, 'deDE', 'Dieses Buch... das ist unmöglich! Es ist Dar\'Khans eigene Handschrift. Irgendwo in diesem Buch muss es einen Hinweis geben, der uns eine Schwäche des Gegners aufzeigt.$B$BIhr habt gut daran getan, uns aufzusuchen, $N. Indem sie diese Angelegenheit in unsere fähigen Hände gaben, haben die Weltenwanderer ihre Weitsicht bewiesen. Diese Rüstung sollte Euch helfen, unsere Sache weiterzuführen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9173, 'deDE', 'Ich bin sicher, Fürstin Sylvanas wird über unsere Fortschritte in dieser Sache erfreut sein.$B$BHier, nehmt dies als Bezahlung für Eure Mühen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9174, 'deDE', 'Ihr habt unseren Tod gerächt und Aquantions Macht über unsere Seelen gebrochen. Endlich können wir ruhen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9175, 'deDE', 'Ihr sagt, Ihr fandet dies bei einem Schergen der Geißel am Windläuferturm, und dass es eine Inschrift gibt? Lasst mich sehen!$B$BHier, nehmt dies für Eure gute Arbeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9176, 'deDE', 'Die Geschichten sind also wahr! Der Stein des Lichts und der Stein der Flamme existieren tatsächlich! Wir werden ihre Macht nutzen, um wirkungsvolle Waffen gegen Dar\'Khan zu schmieden.$B$BWenn Ihr die in diesen Artefakten schlummernden Energien zum richtigen Zeitpunkt freisetzt, werden sie Dar\'Khan vernichten. Einst wollte er uns diese Macht nehmen, doch jetzt wird sie sein Untergang sein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9192, 'deDE', 'Da habt Ihr mal ordentlich Blut fließen lassen, $C. Die Minenarbeiter können jetzt wieder an die Arbeit. Sie sind sicher enttäuscht, dass ihre Pause jetzt vorbei ist, aber wir brauchen nun mal mehr Erz, um Rüstungen und Waffen herzustellen.$B$BHier, nehmt dies als Lohn für Eure pflichtbewusste Tat. Lasst Rüstung und Waffen reparieren und trinkt einen auf mich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9193, 'deDE', 'Abscheulich, aber glaubt mir, es war notwendig. Ihr habt mit Euren Nachforschungen eine gute Tat vollbracht, $C. Bitte, nehmt dies als Zeichen unserer Großzügigkeit und Anerkennung an.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9199, 'deDE', 'Mumien, die von den Trollpriestern wiedererweckt werden... clever! Die Waldschattentrolle wollen ihre Reihen wohl mithilfe nekromantischer Mittel verstärken. Ich wette, dass diese Orakel das Juju bei ihrem Wiedererweckungsritual verwendet haben.$B$BIhr habt Eure Pflicht wieder einmal so erfüllt, wie es sich für jemanden mit ständig wachsendem Ansehen geziemt. Nehmt diesen Lohn als Dank.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9207, 'deDE', 'Mein Lehrling konnte sich nicht selbst um diese Angelegenheit kümmern? Ich werde noch ein Wörtchen mit ihr zu reden haben, sobald sie wieder da ist, Gnolle hin oder her. Außerdem, warum ist sie nicht mit Euch zurückgekommen?$B$B<Der Magister seufzt.>$B$BSie ist eine schwierige Persönlichkeit und ihre Ausbildung wird mir noch helle Freude bereiten. Danke, dass Ihr mir diese Proben gebracht habt, $C. Wir hoffen ein paar spezielle Eigenschaften darin zu entdecken, die uns im Kampf gegen die Geißel von Nutzen sein können.$B$BBitte nehmt diesen Lohn als Zeichen meiner Wertschätzung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9212, 'deDE', 'Ihr seid ein ziemlicher Held, $C, sie da lebend herausbekommen zu haben. Ich denke, wir müssen einen Gegenschlag planen, um diese Katakomben auszuräuchern. Als wenn wir nicht schon genug Ärger mit den lebenden Trollen hätten!$B$BIhr habt heute außerordentlich gute Arbeit geleistet, Ihr verdient eine Belohnung. Sucht Euch etwas aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9214, 'deDE', 'Ich werde umgehend einige Waldläufer entsenden, um den Schaden, den Ihr unter den Waldschattentrollen angerichtet habt, zu begutachten. Wenn die von Euch mitgebrachte Waffensammlung auch nur ansatzweise den Erfolg Eures Angriffs gegen die Trolle widerspiegelt, sollten wir mit den Überlebenden leichtes Spiel haben. Das wird uns einen baldigen Angriff auf die Geißel ermöglichen.$B$BHier, nehmt diese Münze als Zeichen meiner Dankbarkeit, das schafft wieder etwas Platz in meinem Geldbeutel.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9215, 'deDE', 'Ah, Kel\'gashs Kopf ist der Quell dieses wundervollen Aromas. Ihr habt offensichtlich ganze Arbeit geleistet, $C!$B$BDer Tod ihres Anführers hat die Waldschattentrolle ins Chaos gestürzt. Berücksichtigt man jetzt noch Eure letzten Einsätze zur Dezimierung ihrer Anzahl, denke ich, dass jetzt der Zeitpunkt für unsere Gegenoffensive gekommen ist, um sie ein für alle Mal zu vernichten.$B$BIhr habt meinen Dank, $N. Kann ich Euch vielleicht für einen dieser Gegenstände begeistern?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9216, 'deDE', 'Nehmt dieses Gebräu, $N. Sobald Ihr es getrunken habt, erfährt Eure körperliche Stärke im Kampf gegen die Geißel einen Schub. Wenn Ihr noch mehr von dieser Probe brauchen solltet, bringt mir mehr Herzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9217, 'deDE', 'Dies wird Euch mit mehr Stärke im Kampf gegen die Geißel versorgen. Bringt mir mehr Herzen, falls Ihr welche findet, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9218, 'deDE', 'Hier, für Euch, $N. Ihr werdet den Unterschied sofort spüren!$B$BIhr könnt mir jederzeit mehr Wirbelknochenstaub bringen, ich kann so viel davon verarbeiten, wie Ihr mir besorgen könnt. Nebenwirkungen? Naja, Eure Stimme klingt ein bisschen höher, aber das sind lediglich die Rückstände des Staubs, die verrückt spielen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9219, 'deDE', 'Dieser Wirbelknochenstaub ist nach wie vor mächtig, $N. Bringt mir auch weiterhin welchen, wenn Ihr Verstärkung für Eure magischen Fähigkeiten im Kampf gegen die Geißel benötigt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9220, 'deDE', 'Die Geißel hat unsere Rache zu spüren bekommen, $N. Nicht mehr lange und ihre verfluchte Zitadelle wird in Trümmern liegen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9252, 'deDE', 'Vielen Dank, $N. Es ist eine undankbare Aufgabe, der wir hier nachgehen, doch Eure heutige Mithilfe hat sie ein wenig einfacher gemacht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9253, 'deDE', 'Jemand aus Morgenluft muss Euch zu mir geschickt haben. Ich wusste doch, dass es nur eine Frage der Zeit war, bevor Hilfe eintrifft.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9254, 'deDE', 'Es rührt mich, dass meine ehemalige Mentorin nach mir sehen lässt. Es ist nur traurig, dass sie seit langer Zeit kein Vertrauen mehr in meine Arbeit hat.$B$BIhr verschwendet Eure Zeit, Ihr könnt mich nicht überreden zu ihr zurückzugehen. Entweder helft Ihr mir mit meinen Untersuchungen hier oder Ihr geht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9255, 'deDE', 'Diese Notizen... es ist schockierend. Wenn das stimmt, dann ist der Schaden, den das Land entlang der Todesschneise erlitten hat, nicht wiedergutzumachen.$B$BIch werde dem Großmagister sofort Bescheid sagen. Ein weiterer Grund für unser Volk, dieser Welt zu entfliehen und sein wahres Schicksal in der Scherbenwelt zu finden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9256, 'deDE', 'Danke, dass Ihr gekommen seid, $N. Es steht um einiges schlechter, als wir angenommen hatten. Die Getriebenen haben den Ankerplatz der Sonnensegel bereits gänzlich eingenommen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9258, 'deDE', 'Ah, mein Bruder hat Euch geschickt. Es gibt da etwas, wobei ich Eure Hilfe gebrauchen könnte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9274, 'deDE', 'Ich bin dankbar für Eure Hilfe, $N. Es schmerzt mich, die Geister meiner Ahnen in diesem jämmerlichen Zustand zu sehen. Mögen sie in Frieden ruhen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9275, 'deDE', 'Ah, hervorragend! Ich wusste es, ein $R war die richtige Wahl, um das Gift hinreichend zu verteilen. Mit etwas Glück werden die Waldschattentrolle schön fett, bevor sie durch die Wirkung des Gifts in den Nether eingehen. Damit dürften die Weltenwanderer ihre Ruhe haben und ich kann endlich meine wohlverdiente Heimreise nach Tristessa antreten.$B$BEs war mir eine Freude mit Euch zu arbeiten, $C!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9276, 'deDE', 'Gut, sehr gut! Das habt Ihr hervorragend gemeistert! Dann wollen wir doch mal sehen, ob Ihr auch der nächsten Herausforderung gewachsen seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9277, 'deDE', 'Unglaublich! Ihr solltet Euch unbedingt mit unserem Hauptmann über einen Beitritt in die Reihen der Weltenwanderer unterhalten.$B$BNun gut, $N, Ihr habt uns die dringende Atempause zum Sammeln unserer Streitkräfte verschafft. Genau genommen scheinen unserer letzten Zählung nach nur wenige Trolle übrig zu sein! Vielleicht können wir uns nun mit den Streitkräften Tristessas vereinen, um gemeinsam die Todesfestung anzugreifen, anstatt unsere Zeit weiter mit den hiesigen Trollen zu verschwenden.$B$BIch denke, Ihr habt Euch eine kleine Belohnung verdient. Greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9279, 'deDE', '$N, bei meiner ewigen Seele, es ist gut, Euch zu sehen! Ich weiß nicht, warum die Exodar abgestürzt ist. Nur diejenigen von uns, die in diesem Teil des Schiffs waren, sind noch am Leben.$B$BUns bleibt nicht viel Zeit, wenn wir so viele wie möglich retten wollen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9280, 'deDE', 'Wie bedauernswert, dass diese Kreaturen sterben mussten, damit wir überleben können - wahlloses Töten entspricht nicht dem Weg der $R. Wie auch immer, das von Euch gesammelte Blut wird unsere Heilkristalle wieder aufladen, somit war ihr Opfer nicht umsonst.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9281, 'deDE', 'Vielen Dank für Eure Unterstützung, $N. Mir schaudert bei dem Gedanken, mich so nahe bei der Todesfestung in den Wald zu wagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9282, 'deDE', 'Kaendris hat Euch geschickt? Möglicherweise habe ich eine Aufgabe für Euch, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9283, 'deDE', 'Dem Licht sei Dank! Ihr habt getan, was nur eine wahre Heldin vollbringen kann, $N! Jeder $R, den Ihr gerettet habt, verdankt Eurer Selbstlosigkeit sein Leben!$B$BBitte, nehmt diesen Vorratsbeutel. Ihr könnt ihn sicher besser gebrauchen als ich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9289, 'deDE', 'Es ist gut, dass Ihr meine Weisung ersucht. Ich habe seit Jahrhunderten junge Draeneikrieger ausgebildet, also werde ich Euch schon auf die eine oder andere Weise auf den richtigen Weg eines Kriegers verhelfen können. Ich sehe eine Zukunft als mächtiger $C für Euch voraus, aber nur, wenn Ihr auch wirklich beherzigt, was ich Euch beibringe.$B$BSeid Ihr bereit, junger $C?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9290, 'deDE', 'Es ehrt mich, dass Ihr mich wegen meines Wissens aufsucht. Es gibt viel zu tun, wenn sich Eure magischen Fähigkeiten gänzlich entfalten sollen.$B$BSeit mehr als hundert Jahren lehre ich die Künste der arkanen Magie, Frost- und Feuerzauber. Auch auf dieser Welt kann ich ihre Macht spüren. Möchtet Ihr, dass ich Euch an meinen Kenntnissen teilhaben lasse?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9293, 'deDE', 'Genau das habe ich gebraucht. Danke, $C!$B$BWährend Ihr unterwegs wart, habe ich bereits meine Ausrüstung aufgebaut, um die Proben auswerten zu können. Ich sollte lediglich ein paar Augenblicke benötigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9294, 'deDE', 'Euren Schilderungen zufolge hat der Neutralisierungswirkstoff funktioniert! Ich wünschte nur, ich wüsste, wie lange er anhält. Wir müssen den Energiekristall gänzlich aus dem See entfernen.$B$BDanke, $N! Ich werde Tedon bitten, den Neutralisierungswirkstoff sofort an einem der gefangenen Tiere auszuprobieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9303, 'deDE', 'Da jetzt viele der Eulkin immunisiert wurden, können wir uns auf unseren Aufbruch von hier konzentrieren, ohne die gesamte Eulkinpopulation ausrotten zu müssen.$B$BHier, sucht Euch etwas aus. Ihr habt eine so wunderbare Arbeit geleistet, Ihr verdient eine Belohnung!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9305, 'deDE', 'Lasst mich mal sehen.$B$BJa, ich denke, das wird gehen; gute Arbeit, $N! Der Emitter ist ziemlich komplex und deshalb kann die Reparatur ein Weilchen dauern. Ich sage Euch Bescheid, sobald ich fertig bin.$B$BSchaut in der Zwischenzeit bei Verteidiger Aldar vorbei und fragt ihn, ob er Euch brauchen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9309, 'deDE', 'Hilfe... Blutelfen! Ein... ein Hinterhalt. Ich habe... nicht mehr lange...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9311, 'deDE', 'Danke, dass Ihr Euch um die Gutachterin gekümmert habt. Sie war ganz sicher ihre Anführerin. Ich versichere Euch, dass wir uns um den restlichen Haufen, der sich eventuell noch hier in der Nähe aufhält, kümmern werden.$B$BBitte, nehmt eine dieser Waffen als Zeichen unserer Dankbarkeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9312, 'deDE', 'Ja, ja! Ich glaube, ich habe den Emitter reparieren können! Hier, ich muss lediglich den letzten Kristall aktivieren und das sollte es gewesen sein.$B$BSeht, $N, der Emitter. Er scheint zu funktionieren... es erscheint jemand', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9313, 'deDE', 'Ah, es ist gut, Euch wiederzusehen! Ich bin froh, dass wir beide unsere Emitter reparieren konnten, sonst hätten wir uns wohl nie gefunden. Sorgt Euch nicht, wir werden natürlich Hilfe und Vorräte ins Am\'mental schicken.$B$BDa wir gerade von Hilfe sprechen... jetzt wo Ihr hier seid, könnt Ihr Euch ja mal umsehen und Euch bei den anderen vorstellen. Ich weiß, dass es jede Menge zu tun gibt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9314, 'deDE', 'Oh, Ihr müsst einer der Überlebenden sein, von denen wir gehört haben!$B$BIch bin froh, dass Ihr gekommen seid. Keine Sorge, wir schicken jemanden los, der sich Aeuns verletztes Bein ansehen wird.$B$BIch will unbedingt alles über Eure aufregende Überlebensgeschichte hören! Wenn Ihr bis hierhergekommen seid, müsst Ihr sehr tapfer sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9315, 'deDE', 'Ich muss mich für die schlechte Aufklärung entschuldigen, $C. Hätte ich vorher etwas von der Existenz dieser Anok\'suten gewusst, hätte ich Euch natürlich umgehend davon in Kenntnis gesetzt.$B$BUnsere Kräfte sind einfach zu weit verteilt und manche Dinge schlüpfen uns unter diesen Umständen einfach durchs Netz.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9327, 'deDE', 'Ich weiß, wir Verlassenen mögen in Euren Augen monströs erscheinen, aber ich versichere Euch, wir sind für Euer Volk keine Bedrohung. Wir sind hier, weil wir einen gemeinsamen Feind haben: Dar\'Khan den Verräter! Er ist zurückgekehrt und befehligt die Geißel von der Todesfestung im Süden aus.$B$BUnsere Anführerin, Fürstin Sylvanas Windläufer, stammt aus dieser Gegend und war früher eine Elfe. Sie hatte schon mit Dar\'Khan zu tun und möchte ihn genauso gern tot sehen, wie Euer Volk.$B$BWir werden ihn zusammen besiegen, $C!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9328, 'deDE', 'Nun, das ist ein Gesicht, das ich noch nicht so früh hier erwartet hätte.$B$BDas sind ziemlich gute Neuigkeiten, $N, in mehr Hinsichten, wie Ihr Euch denken könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9329, 'deDE', 'Die Verlassenen sind hier, weil wir und die Blutelfen einen gemeinsamen Feind haben: Dar\'Khan! Er ist zurückgekehrt und befehligt die Geißel von der Todesfestung im Süden aus.$B$BFürstin Sylvanas Windläufer, die ursprünglich aus dieser Gegend hier stammt, hatte schon früher mit Dar\'Khan zu tun und möchte ihn tot sehen!$B$BWir werden ihn besiegen, $N, und Ihr werdet uns dabei helfen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9340, 'deDE', 'Gute Arbeit, $N. Das sollte die Felsklauen lehren, sich von uns fernzuhalten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9345, 'deDE', 'Die sollten ihren Zweck erfüllen. Ich werde die Salbe fertigstellen und mein Bein schienen, bevor ich nach Thrallmar aufbreche. Wieso glaube ich genau zu wissen, was mir Scharfseherin Regulkut erzählen wird, wenn sie mich so sieht?$B$B<Grelag seufzt halbherzig.>$B$BVielen Dank für Eure Hilfe, $N. Ich habe noch einige von den Höllenwirbelkräutern übrig. Nehmt sie mit, wenn Ihr sie braucht. Wer weiß, wofür sie noch gut sind?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9349, 'deDE', 'Für ausgezeichnete Küche braucht man ausgezeichnete Zutaten. Und diese Eier sehen großartig aus!$B$BIch habe gerade meine Pfanne geputzt, Ihr seid also herzlich eingeladen, mir bei einem Mahl Gesellschaft zu leisten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9351, 'deDE', 'Perfekt! Ich glaube sogar, dass das so gut funktionieren wird, dass ich den Motor umbauen muss, damit ich alle Vorteile dieses Kraftstoffs nutzen kann! Falls - ich meine natürlich - wenn wir hier wegkommen, muss ich allen in Area 52 meine Entwürfe zeigen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9352, 'deDE', 'Nachtelfen? Hier? Diese Ratten!$B$BGlaubt Ihr, es besteht irgendeine Verbindung zu der Fehlfunktion in meinem Sanktum? Falls Ihr irgendwelche Informationen habt, bringt Ihr sie besser umgehend zu Hauptmann Sonnenmal!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9355, 'deDE', 'Gut gemacht, $N. Wir sollten uns aber nicht zu früh freuen. Ich bin mir sicher, dass wir diese Würmer nicht zum letzten Mal gesehen haben. Wenn sie ihre hässlichen Köpfe wieder in diese Gegend strecken sollten, werden die Söhne sie schon erwarten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9356, 'deDE', 'Felshetzereier... Bämm!$B$BHölleneberspeck... Bämm!$B$BBussardflügel... Bämm! Bämm!$B$BWas für ein großartiges Essen. Ihr solltet wirklich mal probieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9358, 'deDE', 'Ihr seid hier, um zu helfen? Warum habt Ihr das nicht gleich gesagt? Wir können jede helfende Hand gebrauchen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9359, 'deDE', 'Ihr seid hier, um zu helfen? Ausgezeichnet!$B$BDer Kampf gegen die Amanitrolle hat uns sehr in Anspruch genommen und fähige Kämpfer wie Ihr sind stets willkommen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9360, 'deDE', 'Die Trolle haben uns hier festgehalten, während sie einen Angriff auf Morgenluft planten. Wir hatten nichts dergleichen erwartet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9361, 'deDE', 'Hmmm...$B$BEs sieht essbar aus, wenn man es richtig würzt. Erzählt Quack aber nicht, woraus sein Frühstück besteht, ja?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9363, 'deDE', 'Die Informationen, die Ihr mir gebracht habt, sind von entscheidender Bedeutung, $N. Jetzt, da wir über die Pläne der Trolle Bescheid wissen, können wir uns auf einen Angriff vorbereiten.$B$BSie werden uns nicht ahnungslos überrumpeln.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9366, 'deDE', 'Die in den Proben gespeicherten Energien sind unfassbar stark, $N. Nun müssen wir nur noch sicherstellen, dass wir auch in Zukunft freien Zugriff auf das Teufelsblut haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9369, 'deDE', 'Wie bedauernswert, dass diese Kreaturen sterben mussten, damit wir überleben können - wahlloses Töten entspricht nicht dem Weg der $R. Wie auch immer, das von Euch gesammelte Blut wird unsere Heilkristalle wieder aufladen, somit war ihr Opfer nicht umsonst.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9370, 'deDE', 'Das wird diese heiligen Fanatiker lehren, sich um ihren eigenen Kram zu kümmern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9371, 'deDE', 'Oh, welch Glück, dass Ihr hier seid! Wir haben Einiges zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9372, 'deDE', 'Gute Arbeit, $N. Diese Blutproben werden mir bei meinen Forschungen, und der Expedition bei ihren Studien der Scherbenwelt und ihrer Lebewesen, sehr dienlich sein.$B$BWenn ich den Grund für die fortschreitende Veränderung der Tiere herausfinden könnte, könnte ich vielleicht ein Gegengift herstellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9373, 'deDE', 'Danke, dass Ihr mir dies hier gebracht habt, $C. Ich habe mich schon gewundert, warum ich so lange nichts mehr von der Expedition gehört habe. Ich frage mich, wie lange diese Nachricht schon unterwegs ist und was wohl aus ihrem Überbringer geworden ist.$B$BHier habt Ihr etwas Geld für Eure Mühen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9374, 'deDE', 'Das Tagebuch meines Ehemanns... hat nicht das Geringste mit seinen Forschungen zu tun!$B$BWie konnte ich nur so blind sein? `Die magischen Eigenschaften dämonisch beeinflusster Schleimformen`, beinahe hätte ich es geglaubt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9375, 'deDE', '<Taleris ruft einige der Blutelfen aus dem Außenposten herbei.>$B$BSchafft sie herein und versorgt ihre Wunden!$B$B<Taleris wendet sich wieder Euch zu.>$B$BSie kann sich glücklich schätzen, dass Ihr sie noch rechtzeitig gefunden habt, $C. Viel länger hätte sie dort draußen alleine nicht überlebt.$B$BKonntet Ihr verstehen, was sie gesagt hat?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9376, 'deDE', 'Vielen Dank, dass Ihr dies zurückgebracht habt, $N. Ich weiß nicht, was der verletzten Pilgerin an diesem Beutel so wichtig ist, aber sie lässt keinen an sich heran, bis sie ihn wieder hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9381, 'deDE', 'Die sollten ihren Zweck erfüllen. Ich hatte schon befürchtet, dass den Waldläufern bald die Pfeile ausgehen, doch nun muss ich mir darüber erstmal keine Sorgen mehr machen. Vielen Dank für Eure Hilfe, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9383, 'deDE', 'Ihr habt Euch bewährt, $N. Es scheint, als würde der Verwahrungskristall fürs Erste standhalten, allerdings weiß niemand wie lange. Wir werden ihn im Auge behalten und in der Zwischenzeit noch mehr Kristalle vorbereiten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9385, 'deDE', 'Gut gemacht, $N. Das wird den Biestern zeigen, wer hier der Boss ist!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9387, 'deDE', 'Ihr wart mir eine große Hilfe, $N. Nun wollen wir sehen, was wir von unserem blauen Freund lernen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9390, 'deDE', 'Ihr habt den Leichnam eines jungen Paladins der Draenei gefunden. Es scheint, als hätte ihn jemand hinterrücks erschlagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9391, 'deDE', 'Obwohl die Große Kluft noch immer ein gefährlicher Ort ist, gibt sie einen brauchbaren Pfad für unsere Pilger ab.$B$BEin derartiger Akt der Verzweiflung ist unvermeidlich, solange die Allianz weiterhin sämtliche ein- und ausgehenden Straßen zur Falkenwacht beobachtet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9394, 'deDE', 'Wer seid Ihr? Ihr seid keiner von den Lehrlingen des Magisters, das steht fest!$B$BMan hat Euch sicherlich hierher geschickt, um mir dabei zu helfen, wieder Ordnung in dieses Chaos zu bringen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9395, 'deDE', 'Ah, Magistrix Morgenwandler hat zu guter Letzt doch noch auf meine simple Anfrage reagiert. Beizeiten werde ich ihr Benehmen mit dem Lordregenten erörtern. Sie ist eine recht ungehobelte Person!$B$BNichts, worüber Ihr Euch Sorgen machen müsstet. Nun, wo Ihr schon mal hier seid, besteht vielleicht die Möglichkeit, dass ich endlich meine Vorräte für das Fest bekomme, auf die ich schon so lange warte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9396, 'deDE', 'Gut gemacht, $N. Die Geheimnisse der Scherbenwelt werden sich nicht lange vor uns verstecken können.$B$BEs ist unser Schicksal, die Meister dieser Welt zu werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9397, 'deDE', 'Ihr habt es geschafft! Ihr habt ein junges Weibchen gefangen!$B$BSie ist wundervoll. Vielen, vielen Dank, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9398, 'deDE', 'Ihr habt gute Arbeit geleistet, $N. Es ist immer schlimm, wenn Töten die einzige Möglichkeit ist, die bleibt, sogar wenn es sich um so gefährliche Biester wie die Steinsichelklauen handelt.$B$BIhr habt meinen Dank, dass Ihr diese grausame Aufgabe erledigt habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9399, 'deDE', 'Ihr habt es geschafft! Wir stehen tief in Eurer Schuld, $N. Seht Euch nur all die Ankömmlinge des Lumpenpacks an.$B$BUnter meiner geistigen Führung werden sie alles über die alten Traditionen lernen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9400, 'deDE', 'Der Leichnam stimmt mit der Beschreibung von Krun Rückenbrecher, dem Assassinen der Höllenfeuerzitadelle, überein. Als Ihr den noch warmen Körper umdreht, erblickt Ihr eine Steinaxt, die in seinem Rücken steckt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9401, 'deDE', 'Er wurde mit dieser Waffe getötet? Das ist unmöglich!$B$BHaben wir... haben wir sie tatsächlich gefunden?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9402, 'deDE', 'Oh, gut gemacht... ich sagte Ihr sollt in den Tümpel springen und Ihr habt es getan. Ich kann mir gut vorstellen, was Ihr tun würdet, wenn einer Eurer Freunde Euch um etwas bitten würde.$B$BWollt Ihr für Eure Mühe belohnt werden, dann ist es das: macht keinen Finger krumm, bevor Ihr nicht wisst, was dabei für Euch herausspringt. Der Geist des Magiers ist seine stärkste Waffe. Vergesst das nicht und versucht Euren ein wenig mehr anzustrengen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9403, 'deDE', 'Mal sehen, was Ihr mir gebracht habt...$B$B<Er hält die Phiole gegen das Licht und studiert sie genau.>$B$BJa, das sollte es sein. Gut gemacht, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9404, 'deDE', 'Ihr seid meiner Bitte nachgekommen, $N. Ihr könnt Eure Belohnung jetzt entgegennehmen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9405, 'deDE', 'Ich verstehe Nazgrels Anliegen, $C. Sagt nichts weiter.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9406, 'deDE', 'Seid Ihr sicher? Das sind große Neuigkeiten, $N. Diese Orcs können sicherlich unserer Sache hier und auch zuhause dienlich sein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9407, 'deDE', 'Unser Expeditionskorps kam ohne Probleme durch das Portal und hat ein neues Lager namens Thrallmar errichtet. Aber wie Ihr sehen könnt ist die Brennende Legion eingefallen und hat uns von unseren Brüdern abgeschnitten. Die Dämonen sind eindeutig darauf aus, das Dunkle Portal einzunehmen und uns daran zu hindern, Verstärkung aus Azeroth zu holen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9409, 'deDE', 'Gute Arbeit! Das wird die erschöpften Heilkristalle wieder aufladen.$B$BDa Ihr nun schon einmal hier seid... ich hätte da noch eine Aufgabe für Euch, solltet Ihr gewillt sein?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9410, 'deDE', 'Wer seid Ihr, dass Ihr hier so einfach unangekündigt umherwandert? Ich habe meine Männer nur zurückgehalten, weil Ryga die Anwesenheit der Geister in Eurer Nähe verspürte.$B$BIhr könnt frei sprechen, doch wählt Eure Worte mit Bedacht. Wir vertrauen normalerweise keinen Fremden, die hier so nah bei der Zitadelle umherstreifen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9417, 'deDE', 'Fantastische Arbeit, $N! Ich ernenne Euch hiermit zum Langbart ehrenhalber.$B$BBleibt noch ein Weilchen und trinkt etwas mit uns!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9418, 'deDE', 'Mit dieser Kugel erlange ich meine Freiheit wieder. Nehmt Eure Belohnung, Sterblicher, auf dass meine Schuld bezahlt sei.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9420, 'deDE', 'Ihr habt Euren Teil der Abmachung erfüllt. Ich schätze, Geschäft ist Geschäft!$B$BHier, mein Freund. Passt gut auf ihn auf.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9421, 'deDE', 'Ich bin Firmanvaar und mich aufzusuchen war weise von Euch. Ich bin dazu berufen, Schamanen den richtigen Weg zu weisen, besonders denen, die wie Ihr noch unerfahren sind.$B$BDer Schamanismus wird von uns Draenei gerade erst wiederentdeckt, $N. Ihr seid wahrhaft mutig, dieser Lehre zu folgen, denn unter Unseresgleichen wird sie mit Argwohn betrachtet.$B$BIch bin hier, solltet Ihr meine Unterweisung wünschen. ', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9423, 'deDE', 'Sedai, mein geliebter Bruder... $B$BDiese feigen Orcs! Er war unbewaffnet, wie konnten sie nur?$B$BLasst mich alleine, $N. Ich danke Euch für Eure Hilfe, doch ich brauche jetzt etwas Zeit für mich selbst.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9424, 'deDE', 'Ja... Rache! Ihr wart gut.$B$BNehmt dies, es war ein Geschenk von Sedai. Wenn Makuru es behält, stimmt es ihn nur traurig.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9426, 'deDE', 'Ja, ich fühle, wie die teuflische Präsenz in den Teichen abnimmt.$B$BIhr habt gute Arbeit geleistet, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9427, 'deDE', 'Die Essenz von Aggonar lebte in seinem verderbten Nachkommen Aggonis weiter. Dank Eures Erfolgs gegen den Dämon können wir nun beginnen, die Teiche zu ihrer ursprünglichen Reinheit zurückzuführen.$B$BIhr habt unseren Dank, $N. Eure Arbeit hat einen tiefen Eindruck in dieser Welt hinterlassen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9430, 'deDE', 'Das Glück hat Euch gesegnet. Genau wie ich es erhofft hatte, habt Ihr ein ganz besonderes Relikt zwischen all den anderen gefunden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9438, 'deDE', '<Thralls Augen werden immer größer, als er Nazgrels Brief liest.>$B$BMein Volk... wir müssen sie erreichen. Wir müssen Nagrand so schnell wie möglich erreichen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9441, 'deDE', 'Es bedeutet uns sehr viel, dass Ihr uns in diesen schwierigen Zeiten Eure helfende Hand reicht. Niemals werden wir Euch, noch denjenigen vergessen, der Euch hierher entsandt hat.$B$BEuch gebührt unser Dank.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9442, 'deDE', 'Gorkan hat viel Gutes über Euch gesagt. Wie sich herausstellt, war alles wahr.$B$BVielen Dank für Eure Hilfe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9447, 'deDE', 'Mögen die Geister Euch segnen, $N. die Mag\'har stehen in Eurer Schuld.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9449, 'deDE', 'Es ist sehr kühn von Euch, meinen Rat zu ersuchen, nach all dem, was Eure Leute diesen Inseln angetan haben, $GFremder:Fremde;! Dennoch, Euer Mut spricht für sich, also werde ich Teile meines Wissens preisgeben.$B$BDie Erde unter Euren Füßen ist die Grundlage aller Dinge. Der Himmel, das Wasser, sogar große Feuer - alle lasten auf ihren Schultern. Während die anderen oft in wilden Stürmen toben, hält die Erde geduldig aus. Sie verleiht Eurem Innern Stärke und Kraft.$B$BJetzt werdet Ihr Euch beweisen, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9450, 'deDE', 'Ihr habt Euch gut geschlagen, $C. Indem Ihr die Zahl der ruhelosen Geister reduziert habt, habt Ihr geholfen, das Gleichgewicht der Elemente wiederherzustellen, das Eure Leute unbeabsichtigterweise zerstört hatten.$B$BDas Gleichgewicht muss immer gewahrt bleiben. Auf Eurem Lebensweg als Schamane, dürft Ihr diese Lehre nie vergessen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9451, 'deDE', 'Ausgezeichnet, $N. Indem Ihr das Gleichgewicht der Elemente im Hain wieder hergestellt habt, habt Ihr auch für einen Einklang zwischen den Erdelementen dieser Welt und den Draenei gesorgt. Möglicherweise zeigen diejenigen unter uns, die unseren Weg ablehnen, nun mehr Verständnis?$B$BIch werde ein Totem für Euch erschaffen, das mit den Elementen der Erde verbunden ist. Mit dessen Hilfe werdet Ihr die Kräfte der Erde auf Euren Wunsch herbeirufen können. Mit mehr Weisheit, werden sich Euch auch noch mehr Geheimnisse der Erde erschließen.$B$BHier, nehmt Euer Totem, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9452, 'deDE', 'Ich hoffe Ihr hattet nicht zu viele Scherereien wegen der Murlocs, $N. Ich bin Euch sehr dankbar für alles, was Ihr getan habt.$B$BSoll ich Euch vielleicht das Angeln beibringen? Ich kann Euch sogar eine Angelrute und ein glänzendes Schmuckstück geben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9453, 'deDE', 'Arme Diktynna... der Murloc hat ihr wohl einen ziemlichen Schrecken eingejagt.$B$B<Acteon seufzt.>$B$BHoffentlich heilen ihre Verletzungen bald...$B$BIhr haltet also nach Arbeit Ausschau, nun, davon gibt es bei der Azurwacht jede Menge!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9454, 'deDE', 'Gut gemacht, $N, gut gemacht!$B$BHier, während Ihr fort wart, habe ich ein paar der Lenden, die Ihr mir gebracht habt, zubereitet. Vielleicht wollt Ihr ja auch das Rezept haben?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9455, 'deDE', 'Wie konnte solch ein Ding nur im Magen eines Nachtpirschers enden? Könnten die Trümmer des Absturzes noch mehr Kreaturen verseucht haben?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9456, 'deDE', 'Ich hoffe nur, dass es nicht schon zu spät ist...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9461, 'deDE', 'Hallo, $N, ich habe Euch erwartet. Heute scheint Euer Tag zu sein, nicht?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9462, 'deDE', 'Hallo, $N, ich habe Euch erwartet. Ich hoffe, Ihr seid bereit, Eure Ausbildung fortzusetzen. Die nächste Aufgabe wird schwierig werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9463, 'deDE', 'Lasst uns hoffen, dass diese Salbe ihren Lebenswillen neu belebt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9464, 'deDE', 'Sehe ich richtig, dass das Funkeln in Euren Augen Euren Wunsch heranzuwachsen und zu verstehen widerspiegelt? Gut!$B$BTuluun hat Euch hierher geschickt, da er erkannt hat, dass Ihr fähig seid zu lernen und uns bei einem Problem zu helfen, das durch den Absturz der Exodar verursacht wurde.$B$BWir werden sehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9465, 'deDE', 'Seht Ihr? Das Feuer geht niemals aus. Das ist das Werk Hauteurs. Es ist das Symbol seines Hochmuts. Flammen sollen verzehren, was sie selbst brennen lässt und dann sterben, um ein andermal wieder entfacht zu werden.$B$BIch würde Euch ja beim Löschen der Fackel helfen, aber sie muss noch brennen, damit Ihr Euch Hauteur stellen könnt. Lassen wir sie noch ein wenig länger am Leben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9466, 'deDE', 'Ihr seid ein tapferer $C, $N. Diese Bestie hat viele meiner besten Jäger das Leben gekostet.$B$BNehmt die Belohnung, Ihr habt sie Euch redlich verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9467, 'deDE', 'Ihr habt heute eine besonders wichtige Lektion gelernt. Es ist die Geschichte vom Ende und vom neuanfang.$B$BAls wir und das erste Mal unterhielten, sagte ich Euch, dass das Feuer nicht nur Zerstörung verkörpert, sondern auch die erneuernde Kraft der Elemente. Durch Euer Handeln habt Ihr Hauteur zerstört und gleichzeitig gerettet, auf das er aus seiner Asche wiedergeboren wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9468, 'deDE', 'Ihr habt das reinigende Feuer der Zerstörung erfahren und seid erneuert worden, $N. Dies ist nichts im Gegensatz zu dem Elend, das die Draenei derzeit erleiden. Ihr habt Hauteur vor sich selbst gerettet und somit Eure Bindung zu dem Element des Feuers in dieser Welt gesichert.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9472, 'deDE', 'Hervorragend! Diese hinterhältige Göre wird sich mit niemandes Ehemann mehr davonschleichen.$B$BHier habt Ihr eine Kleinigkeit für Eure Mühen. Ich vertraue darauf, dass diese Angelegenheit unter uns bleibt, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9473, 'deDE', 'Seht, wie die Pflanze ihre wundersame Wirkung entfaltet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9483, 'deDE', 'Vielleicht werden wir ja doch noch Freunde. Folgt mir! Wir wollen schließlich nicht mit den anderen teilen müssen, oder?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9487, 'deDE', 'Welche Verschwendung, Magie zu nutzen um Wesen von körperlicher Gewalt zu erschaffen. Ich dachte immer, das wäre der Grund, warum wir uns mit den niederen Völkern verbündet hätten.$B$BEs war gut von Euch, sie zu zerstören. Nun können wir ihre Überreste für angemessenere Zwecke verwenden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9488, 'deDE', 'Die Details der Herstellung von magischen Roben brauchen Euch nicht zu interessieren, $B, Ihr müsst nur Wissen, was Ihr mir zu bringen habt.$B$BUm ehrlich zu sein, Ihr habt mir genug für mehrere Roben gebracht. Der Profit, den ich damit machen kann, sollte ausreichen, um die Herstellungskosten Eurer Robe zu decken, und mir selbst noch etwas Nettes zu kaufen. Habt Dank!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9490, 'deDE', 'Ja, an diese scharfen Krallen erinnere ich mich genau!$B$BNehmt diese Belohnung, $N. Ihr habt eine gefährliche Aufgabe erledigt. Ihr habt Euch jedes einzelne Stück hiervon verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9492, 'deDE', 'Gut gemacht, $N. Mit Eurem Sieg in der Höllenfeuerzitadelle haben wir den Orcs großen Schaden zugefügt.$B$BIhr müsst mit Feldkommandant Romus über das weitere Vorgehen und das Ziel, die Orcs weiter in der Defensive zu halten, sprechen. Jetzt, da wir Verstärkung haben, können wir die Ehrenfeste viel leichter verteidigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9493, 'deDE', 'Das sind großartige Nachrichten, $N. Mit diesen Fortschritten bei der Höllenfeuerzitadelle können wir es vielleicht sogar wagen, die Höllenhorde auch in anderen Orten der Halbinsel und der ganzen Scherbenwelt zu bekämpfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9494, 'deDE', 'Gut gemacht! Ich maße mir nicht an, Nethekurses Meisterwerke nachahmen zu können, aber wir wären dumm, wenn wir die Macht der Teufelsglut außer Acht lassen würden.$B$BEs gibt jedoch einige, die meine Art der Forschung verbieten wollen, deshalb muss ich meine Entdeckungen geheimhalten. Bitte erzählt niemandem davon, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9495, 'deDE', 'Das habt Ihr gut gemacht, $N. In seiner Jugend war Kargath Messerfaust ein vortrefflicher Krieger, ein Held und ein gutes Beispiel für sein Volk.$B$BSein Tod ist für uns alle schmerzhaft, jedoch besonders für Kriegshäuptling Thrall. Was auch immer in seinen letzten Tagen mit ihm geschehen sein mag, wir dürfen nie den Orc vergessen, der Kargath einst war, genauso wenig wie die Lektion, die uns sein Fall sein sollte.$B$BFür Eure Dienste für die Horde werdet Ihr mit einer dieser Waffen belohnt, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9496, 'deDE', 'Ausgezeichnete Arbeit, $N. Jetzt, da die Legionäre gefallen sind, wird es einfacher, der Höllenhorde auf dem Schlachtfeld zu begegnen, auch wenn sie immer noch ein ernstzunehmender Gegner ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9498, 'deDE', 'Willkommen in der Falkenwacht, $R. Alle Verbündeten der Horde sind hier willkommen, insbesondere all jene, mit einer Empfehlung von Martik.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9499, 'deDE', 'Willkommen in der Falkenwacht, Bruder. Viele andere Blutelfen haben es leider nicht geschafft, heil hier anzukommen.$B$BEs ist eine Schande. Unsere Arbeit in der Scherbenwelt hat doch gerade erst begonnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9501, 'deDE', 'Fürchtet Euch nicht, $N. Wir werden hier mit Hilfe unserer Gedanken miteinander kommunizieren.$B$BIch bin Weissager Nobundo dankbar, dass er Euch zu mir gesandt hat. Etwas verunreinigt das Wasser auf und um die Blutmythosinsel herum. Nicht einmal einem Blinden würde der Effekt entgehen, den diese Störung auf die Kreaturen hat.$B$BIhr und ich werden zusammen gegen diese Verderbnis vorgehen, bevor sie sich noch weiter ausbreitet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9504, 'deDE', 'Wasser schwindet schnell, vereinigt man aber genug davon, bildet es eine unaufhaltsame Kraft. Es spült Erde und Feuer hinfort und bahnt sich auch durch die Luft seinen Weg.$B$BWir sind diese unaufhaltsame Kraft, $N, nicht diejenigen, die die Blutmythosinsel vergiftet haben!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9505, 'deDE', 'Ihr sagt, dass Ihr eines unserer Besatzungsmitglieder gefunden habt und dass sie schwer verletzt ist? Ich werde umgehend ein Mitglied meiner Besatzung in Euer Dorf entsenden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9506, 'deDE', 'Ihr seid verdammt einfallsreich! Jetzt, da wir unsere Navigationsinstrumente zurückerhalten haben, sollte es leicht sein, herauszufinden, wie weit wir vom Kurs abgekommen sind.$B$BAber wartet, was ist das? Da ist etwas in der Karte eingerollt. Lasst mich mal sehen...$B$BDas sind Befehle von Mogul Raztunk der Venture Company. Laut diesen Plänen sind sie hier, um die Insel ihrer Kristalle zu berauben und unsere Schiffe zu kapern, wenn sie fertig sind!$B$BBei Bronzebarts buschiger Braue! Deswegen haben sie uns an Land gezwungen? Wie konnten sie von unseren Plänen erfahren?$B$BDas riecht nach einem Verräter...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9508, 'deDE', 'Wir haben es geschafft! Der Katastrophe wurde vorgebeugt und Ihr habt die Erholung der Gewässer von der Blutmythosinsel in Gang gesetzt. Mit der Zeit wird sich das Wasser, in Verbindung mit den anderen Elementen, wieder von selbst heilen.$B$BEs ist wirklich traurig, die Blutelfen sehen einfach nicht, wie sie sich durch die Zerstörung ihrer Umgebung langsam selbst vernichten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9512, 'deDE', 'Erste Sahne, $GFremder:Fremde;. Das wird helfen, die Moral der Mannschaft wieder mächtig aufzumöbeln.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9513, 'deDE', 'Gelobt sei Elune! Mögen die ruhelosen Geister endlich Frieden finden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9514, 'deDE', 'Ich kann diese Runen leider nicht entziffern, doch ich kenne jemanden, der dies zu tun vermag...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9515, 'deDE', 'Nach dem Tod von Kriegsherr Sriss\'tiz dürfte die Gefahr einer Nagainvasion fürs Erste gebannt sein...$B$BIch muss gestehen, es war falsch von mir, so schlecht über Euch zu denken, $N. Ihr habt bewiesen, dass Ihr weit entfernt seid vom Abschaum, der sich Archimonde nannte. Bitte nehmt dieses Geschenk der Nachtelfen als ein Zeichen der Freundschaft entgegen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9523, 'deDE', 'Mein Paps wäre stolz! Sein Junge hat bei den ersten Nachtelfenruinen, auf die er gestoßen ist, das große Los gezogen... dank Eurer Hilfe natürlich. Ja, macht Euch keine Sorgen, ich werde Euch nicht von der Entdeckung ausschließen. Euer Name ist $N, stimmt\'s? In Eisenschmiede werden alle von Euch hören.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9527, 'deDE', 'Ich danke Euch, $N. Ihre Geister können nun in Frieden ruhen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9528, 'deDE', '<Freudentränen strömen über Cowlens Gesicht.>$B$BWie kann ich Euch dafür jemals genug danken, $N? Bitte, nehmt dieses Erbstück. Es symbolisiert die heiligen Bande der Freundschaft sowie das Vertrauen und die Verbundenheit zwischen den Nachtelfen. Ihr seid wie ein Bruder für mich - vom heutigen Tag bis in alle Ewigkeit...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9530, 'deDE', 'Ich muss Euch warnen: Das, was ich als Nächstes von Euch verlangen werde, ist sehr gefährlich. Ich würde es Euch nicht verdenken, wenn Ihr mir dabei lieber nicht aushelfen wollt, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9531, 'deDE', 'Ich kann es nicht glauben! Der Gnom war es, die ganze Zeit über... Ich hätte es wissen sollen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9537, 'deDE', 'Unglaublich! Das gehörte alles zu ihrem perfiden Plan!$B$BIhr müsst diese Informationen dem König und Euren eigenen Anführern zukommen lassen. Die Folgen sind erschütternd.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9538, 'deDE', 'Das Totem weist zahlreiche Symbole der Fibel auf. Ihr könnt Eulen, Bären, Wölfe und Hirsche erkennen, die darauf eingraviert wurden.$B$BEuch fällt eine seltsame Ansammlung von Symbolen auf, die Eure Lippen das Wort A-K-I-D-A formen lassen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9539, 'deDE', 'Das Totem weist zahlreiche Symbole der Fibel auf. Ihr könnt Eulen, Bären, Wölfe und Hirsche erkennen, die darauf eingraviert wurden.$B$BEuch fällt eine seltsame Ansammlung von Symbolen auf, die Eure Lippen das Wort C-O-O formen lassen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9540, 'deDE', 'Das Totem weist zahlreiche Symbole der Fibel auf. Ihr könnt Eulen, Bären, Wölfe und Hirsche erkennen, die darauf eingraviert wurden.$B$BEuch fällt eine seltsame Ansammlung von Symbolen auf, die Eure Lippen das Wort T-I-K-T-I formen lassen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9541, 'deDE', 'Das Totem weist zahlreiche Symbole der Fibel auf. Ihr könnt Eulen, Bären, Wölfe und Hirsche erkennen, die darauf eingraviert wurden.$B$BEuch fällt eine seltsame Ansammlung von Symbolen auf, die Eure Lippen das Wort Y-O-R formen lassen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9542, 'deDE', 'Beim Lesen des Totems formen Eure Lippen das Wort V-A-R-K. Ihr versteht die Bedeutung, sie lautet Gerechtigkeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9543, 'deDE', 'Wie kann ich Euch behilflich sein, $N? Ihr klingt, als hättet Ihr Sorgen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9544, 'deDE', '[Furbolg] Die Prophezeiung sprach von jemandem, der sich erheben und uns aus dem gewaltsamen Griff der Sichelklauen befreien würde; dass die Geister selbst die Ankunft dieses Helden verkünden würden.$B$BJetzt seid Ihr gekommen.$B$BIch beuge mich vor Euch in Demut, Großartiger.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9545, 'deDE', 'Tief in meinem Innersten hoffe ich, dass Eure Vision Euch neue Einblicke auf die Ereignisse, die zu Sedais Tod geführt haben, gewährt hat. Das Relikt zeigte Euch eine mögliche Reihe von Ereignissen, die zur Gegenwart führten. Die Wahrheit mag irgendwo dazwischen liegen, doch wir werden es nie mit Sicherheit erfahren.$B$BHättet Ihr mit Eurem jetzigen Wissen anders gehandelt?$B$BWer kann schon sagen, ob unser Konflikt mit den Orcs ewig währen wird? Doch am wichtigsten ist es, immer für alle Möglichkeiten offen zu sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9548, 'deDE', 'Das ist fantastisch! Der Diebstahl meiner Ausrüstung hat mir zu noch mehr Einsicht in das Verhalten der Murlocs verholfen, als ich womöglich mittels wochenlanger Beobachtungen hätte gewinnen können!$B$BIch weiß schon, was ich in meinen Bericht schreiben werde.$B$B\'Beim Aufeinandertreffen mit Erzeugnissen einer technologisch höher gestellten Kultur, zeigten die Murlocs der Schwarzschlammküste nicht die sonst typische Neugier wie humanoide Entwicklungskulturen.$B$B\'Das ist großartig! Die Herren in Eisenschmiede werden es lieben! Ich kann Euch nicht genug danken, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9549, 'deDE', 'Verblüffend, einfach verblüffend! Diese Stücke sind perfekt, $N. Ich kann sie mir bereits unter Glas im Museum von Eisenschmiede vorstellen. Der Text für die Vitrine schreibt sich in meinem Kopf gewissermaßen von selbst!$B$BEure Hilfe war für den Fortgang meiner Studien von unschätzbarem Wert. Wie schreibt sich Euer Name doch gleich? Ich werde dafür sorgen, dass Ihr in meinem Bericht als Mitautor auftaucht.$B$BEiner der Burschen auf dem Schiff gab mir diese \'Schatzkarte\', um seine Spielschulden bei mir zu begleichen, allerdings ist Mythologie keines meiner Fachgebiete. Abergläubiges Pack, diese Seefahrer.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9550, 'deDE', 'Nachdem Ihr Euch das Buch sorgfältig angesehen habt, kommt Ihr zu dem Schluss, dass es sich um ein Tagebuch handelt. Die Eintragungen auf den Seiten weisen eine elegante Handschrift auf, die sich von der auf der Karte unterscheidet. Zahlreiche Texte sind durch hinzugefügte Beschriftungen und Zeichnungen im Stil der Karte unleserlich geworden.$B$BDurch das Geschreibsel des Kartenverfassers, in dem er von Trinkgelagen während des Landgangs faselt, sind die eigentlichen Eintragungen fast nicht mehr auszumachen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9555, 'deDE', 'Seid gegrüßt. Es ist stets ermutigend, einen Draenei zu treffen, der sich dem Weg des Schamanismus eröffnet. Es gibt leider nur wenige.$B$BIhr habt nun gelernt, das Feuer nicht nach seinem Äußeren zu beurteilen, genauso, wie Ihr mein Äußeres nicht beurteilen solltet.$B$BIhr seid hier, weil Ihr bereit seid, Euer Feuertotem zu erschaffen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9557, 'deDE', 'Hmm... das ist äußerst faszinierend. Ja, ich sollte in der Lage sein, die eigentlichen Einträge des Schreibers in diesem Buch entziffern zu können.$B$BIch verfüge über die benötigten Mittel hier. Es sollte nur einen Augenblick dauern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9558, 'deDE', 'Wie habt Ihr uns gefunden, $C? Egal, Ihr seid sicher hier, um uns zu helfen. Dann mal an die Arbeit!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9559, 'deDE', 'Jahrhunderte lang lebten wir in verhältnismäßigem Frieden mit den Kreaturen des Landes. Vor einigen Monaten begann Kurz, dunkle Vorzeichen zu sehen. Der Frieden, den wir so lange genossen hatten, schien in Gefahr. Keiner konnte die Ausmaße dieser Katastrophe erahnen!$B$BUnd so kam es, dass die Götter unser Land straften und sowohl Feinde als auch Freunde gegen uns richteten. Aber es gab da noch etwas... inmitten des Chaos sollte sich ein Held erheben: ein Held, in dessen Adern nicht das Blut der Tannenruh fließt. Der Auserwählte würde uns vor der Zerstörung erretten.$B$BDer prophezeite Held wart Ihr.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9560, 'deDE', 'Nicht nur, dass die Prophezeiung wahr ist, nein, diese Rüstung ist ebenso erstaunlich! Eine Rüstung für einen Helden! Ich werde sie Euch für einen besonders günstigen Preis verkaufen, Fellloser.$B$BDas war ein Scherz... das erste Teil gibt\'s umsonst.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9561, 'deDE', 'Gras und Gestrüpp bedecken eine unnatürliche Wölbung am Boden.$B$BNach nur kurzem Graben entdeckt Ihr einen alten Kasten. Es muss sich dabei um den, der in Nolkais Tagebuch beschriebenen ist, handeln.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9562, 'deDE', 'Mmmmm... köstliches Getreide... Parkat wird sich freuen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9563, 'deDE', 'Oh ja! Ihr scheint ganz in Ordnung zu sein, $R. Ich denke, ich kann Euch vertrauen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9564, 'deDE', '<Gurf spuckt auf den Fellfetzen und versucht ihn auf die kahle Stelle auf seinem Hintern anzubringen.>$B$BDas muss vorerst halten! Ich hoffe, dass einer der Schamanen den Schaden wieder beheben kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9565, 'deDE', 'Der Blutkristall verstrahlt eine kränkliche Aura, die in das Wasser im Keller sickert.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9566, 'deDE', 'Von den Blutkristallen, wie Ihr sie gesehen habt, wurden von meinen Spähern noch viele weitere im Norden gesichtet.$B$BIch danke Euch für die Hilfe, muss Euch nun aber bitten zu gehen, weil ich mich noch mit den Ältesten beraten muss. Ich werde nach Euch rufen lassen, sobald ich mit den anderen Ältesten des Dorfes gesprochen habe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9567, 'deDE', 'Gut gemacht, $N. Mal sehen, was ich von dieser Glyphe in Erfahrung bringen kann. Dann können wir unseren nächsten Schritt planen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9569, 'deDE', 'Ohne ihren Anführer und die entwendeten Kristalle können wir die Satyrn bedenkenlos in Schach halten. Nur das Licht weiß, wie viele dieser erbärmlichen Kreaturen da draußen noch lauern.$B$BHerold Mikolaas und ich sind Euch für Eure Hilfe sehr dankbar. Ihr habt uns geholfen, eine noch größere Bedrohung durch die Satyrn abzuwenden. Euer Einsatz wird alle daran erinnern, dass Wachsamkeit der Schlüssel zum Erfolg ist, wenn es darum geht, gegen die Legion und ihre Diener vorzugehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9570, 'deDE', 'Der Held ist erfolgreich zurückgekehrt!$B$BDie Prophezeihung hat sich fast vollständig bewahrheitet. Jetzt zu dem Balg...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9571, 'deDE', 'Das ist die stärkste Rüstung, die ich jemals angefertigt habe! Nutzt sie weise, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9572, 'deDE', 'Das ist ein guter Anfang. Ohne diese drei sollten die Truppen verwirrt sein. Und solange ihre Artillerie außer Gefecht ist, haben wir bessere Chancen, näher vorzurücken, um die Zitadelle einzunehmen.$B$BAber es gehört mehr dazu, als man glaubt, ich fühle es. Deswegen habe ich einen weiteren Auftrag für Euch.$B$BFürs Erste jedoch habt Ihr Eure Arbeit gut gemacht. Sucht euch etwas aus Thrallmars Waffenkammer aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9573, 'deDE', 'Das könnte die Gelegenheit sein, auf die wir so lange gewartet haben! Ich werde sofort angreifen lassen! Der Stamm der Tannenruhfeste dankt Euch für Euren Einsatz, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9574, 'deDE', 'Ich habe jetzt mehr als genug für meine Untersuchungen. Ich danke Euch, $N. Solltet Ihr noch etwas anderes auftreiben können, das beweist, dass die Kristalle die einheimischen Kreaturen der Blutmythosinsel beeinträchtigen, so lasst es mich sofort wissen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9575, 'deDE', 'Wisst Ihr, was ich noch mehr hasse, als mich zu irren? Gold bei einer Wette zu verlieren, dass Ihr es nicht schafft, $GKumpel:Schätzchen;.$B$BAusgezeichnet! Ohne diese drei sollten die Truppen verwirrt sein. Und solange ihre Artillerie außer Gefecht ist, haben wir bessere Chancen, näher vorzurücken, um die Zitadelle einzunehmen.$B$BIch habe jedoch das Gefühl, dass da noch mehr dahinter steckt. Deswegen habe ich einen weiteren Auftrag für Euch. Hier, sucht Euch etwas aus der Waffenkammer aus!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9578, 'deDE', 'Der Leichnam trägt die für einen Techniker der Exodar übliche Kleidung, aber der von Morae beschriebene Anhänger fehlt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9579, 'deDE', 'Ihr habt die ganze Blutmythosinsel und Azurmythosinsel gerettet, das Leben der $R in Azeroth gesichert, $N! Dafür wird man Euch niemals genug danken können, keine Belohnung, nichts ist groß genug, um Euch unsere Anerkennung zu zeigen.$B$BLeider blieben noch so viele auf Draenor zurück, die dieses historische Ereignis nicht miterleben können. Ihr müsst Euren Weg zurückfinden. Findet Euren Weg zur Scherbenwelt, Held von Argus. Bringt Eure Leute nach Hause. Nach Hause in das Land, das Ihr gerettet habt. Nach Azeroth...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9580, 'deDE', 'Mit diesen Vorräten werden wir fürs Erste versorgt sein und die Zubereitung für den späteren Verzehr wird mich sicherlich ein Weilchen beschäftigen. Ich danke Euch für Eure Hilfe, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9581, 'deDE', 'Dieser Kristallsplitter wird unseren Forschern als Vergleichsgrundlage für Proben von anderen Teilen der Insel dienen, da er aus einem weniger verseuchten Gebiet der Blutmythosinsel stammt.$B$BIch werde die Probe erst losschicken können, wenn ich ein vollständiges Probenset habe, aber der Anfang ist getan. Wenn Ihr mir helfen möchtet, die anderen Proben einzusammeln, werde ich Euch für Eure Mühe natürlich belohnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9584, 'deDE', '<Herold Mikolaas untersucht den Kristallsplitter.>$B$BDieser Splitter unterscheidet sich stark von der ersten Probe.$B$B<Herold Mikolaas hält den Kristall ins Licht.>$B$BSeht Ihr, wie das Licht darin pulsiert? Das ist bedenklich. Ich werde in meinem Bericht vermerken, dass die Blutelfen diesen Kristall verändert zu haben scheinen. Ich danke Euch für Eure erneute Hilfe, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9585, 'deDE', '<Herold Mikolaas nimmt den letzten Kristall von Euch entgegen.>$B$BDamit ist das Set vollständig. Ich muss nur noch alles verpacken und zur Exodar senden.$B$B<Der Herold scheint erleichtert, dass die Sache erledigt ist.>$B$BVersteht mich nicht falsch, $N, ich bin mir sicher, dass die Forschungsarbeit wertvoll ist, aber wir haben es hier draußen noch mit zahlreichen anderen Problemen zu tun, die dringend sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9602, 'deDE', '<Exarch Menelaous nimmt die Mitteilung von Euch entgegen und beginnt sie zu lesen.>$B$BVerdammt... verdammt sie alle in den Nether. Sie hatten einen Spion, der sie über all unsere Aktivitäten informiert hat! Und seit wann?$B$BIch werde sofort Velen informieren!$B$BIhr habt uns einen großen Dienst erwiesen, $N. Haltet die Augen offen, ich werde mich an Euch wenden, sobald der Prophet mir mitgeteilt hat, was es zu tun gilt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9603, 'deDE', 'Ihr müsst also zu der Exodar?$B$BDas ist ein ganz schön weiter Weg, aber keine Sorge, ich weiß schon, wie Ihr auf dem schnellsten Weg an Euer Ziel kommt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9604, 'deDE', 'Ah, Ihr habt also Chellans Liste mitgebracht. Ausgezeichnet! Ich hatte gehofft, dass ich sie heute erhalten würde. Lasst mal sehen, was sie braucht.$B$B<Nurguni überfliegt die Liste und beginnt verschiedene Gegenstände in eine Kiste zu packen.>$B$BDas sind fast alle Dinge, die sie aufgelistet hat. Die Teile für die Betten sind einfach zu groß, um auf einem Hippogryphen transportiert werden zu können. Ich werde dafür sorgen, dass sie mit einem Wagen nachgeliefert werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9605, 'deDE', 'Ihr wollt also mit dieser Kiste zurück zur Azurwacht? Kein Problem, $C. Sagt einfach Bescheid, wenn\'s losgehen soll.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9606, 'deDE', '<Ihr überreicht die Kiste und erklärt, dass Nurguni dafür sorgt, dass die größeren Gegenstände mit einem Wagen nachgeliefert werden.>$B$BGroßartig! Ich werde jetzt endlich ein paar Lagerstätten und eine Versorgungsstation einrichten können. Hier wird man sich in Zukunft um Verwundete und mögliche weitere Überlebende kümmern können.$B$BIch weiß gar nicht, wie ich Euch für Eure Hilfe danken kann, $N. Die Anerkennung von mir und den Verteidigern der Azurwacht ist Euch sicher.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9607, 'deDE', 'SIE HABEN EINEN GRUBENLORD?!$B$B<Der Truppenkommandant bemerkt die starrenden Gesichter der anderen und senkt seine Stimme.>$B$BDas ist es. Sie müssen das Blut dieses Grubenlords verwenden, um neue Höllenorcs, die aus irgendeinem Grund nicht zur Brennenden Legion gehören, zu erschaffen. Und wenn sie das mit den braunen Mag\'har können, schaffen sie das auch mit grünen! Bei all den Orcs, die durch das Dunkle Portal kommen, sind das alles andere als gute Nachrichten!$B$BWir müssen sie ins Herz ihrer Militärmacht treffen, und zwar bald!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9608, 'deDE', 'SIE HABEN EINEN GRUBENLORD?!$B$B<Nazgrel bemerkt die starrenden Gesichter der anderen und senkt seine Stimme.>$B$BDas ist es. Sie müssen das Blut dieses Grubenlords verwenden, um neue Höllenorcs, die aus irgendeinem Grund nicht zur Brennenden Legion gehören, zu erschaffen. Und wenn sie das mit den braunen Mag\'har können, schaffen sie das auch mit uns!$B$BWir müssen sie ins Herz ihrer Militärmacht treffen, und zwar bald!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9612, 'deDE', 'Gut gemacht, $N. Sehr gut gemacht! Ihr seid $Gein besonderer:eine besondere; $R - Weiter als andere in Eurem Alter. Nehmt dies als Belohnung!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9616, 'deDE', 'Beim bartlosen, quadratischen Schädel von O\'ros! Gut, dass Ihr das zu mir gebracht habt, $N. Diese Blutelfen haben es... nun ja, auf Blut abgesehen. Velen wird davon sofort in Kenntnis gesetzt werden! Nehmt dies als Anerkennung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9620, 'deDE', 'Auf dem Boden liegen überall die Körper der $R, die dem Vermessungsteam angehörten - von Waffen der Naga durchbohrt. Ihr seht die verstreuten Überreste ihrer Vorräte und Vermessungsausrüstung, aber ihre Datenkristalle befinden sich nicht darunter.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9621, 'deDE', 'Dann ist es also geschehen. Der gemeine Verräter hat bekommen, was er verdient hat.$B$BIhr habt das selbst getan? Eine beeindruckende Tat, die beweist, dass Euer Volk immer noch würdig ist, $N.$B$BWie ich sehe, hat Lor\'themar weitere Nachrichten, die seine Beziehungen zu den Trollen und ihrem Kriegshäuptling deutlich verbessern werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9622, 'deDE', 'Visionen sagt Ihr? Interessant... und diese Prophezeiung hat sich also bewahrheitet?$B$BIhr sagt jedoch, dass man den Kraftkern der Exodar gesehen hat? O\'ros erschien auch in der Vision? Was kann das nur bedeuten?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9623, 'deDE', '<Torallius seufzt.>$B$BNun gut, lasst mich einen Blick auf diese Befehle werfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9624, 'deDE', 'War das Auffinden der Früchte schwierig? Ich brauche mit jedem Mal länger.$B$BIch werde allmählich ganz damit aufhören müssen, da ich keine Zeit mehr dafür habe. Danke für das Sammeln der Birnen, $N. Jetzt kann ich zumindest noch ein oder zwei Kuchen backen, bevor die Saison vorüber ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9625, 'deDE', 'Naja, zumindest habt Ihr\'s bis hierher geschafft! Jetzt schicken wir Euch lieber an die Arbeit, bevor Ihr noch zertrampelt werdet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9626, 'deDE', '<Saurfang beginnt, den Brief zu lesen.>$B$BSylvanas ist hartnäckig. Sie geht sogar so weit, einen Champion von Silbermond zu schicken... aber was soll das ändern?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9627, 'deDE', 'Eure Taten waren den Zielen unseres Volkes sehr dienlich.$B$BBereitet Euch auf große Veränderungen vor, $N. Wir sind nun offiziell ein Teil der Horde.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9628, 'deDE', '<Ihr erzählt Herold Mikolaas vom Schicksal des Vermessungsteams. Er nimmt den Kristall von Euch entgegen, aber schweigt für einen langen Augenblick.>$B$BEs waren gute Männer, Saphirus, sie wussten, dass ihre Mission gefährlich sein würde. Ich bin Euch dankbar für das Auffinden des Teams und die Wiederbeschaffung des Kristalls.$B$B<Der Herold ballt seine Faust.>$B$BWie haben bereits zu viele unserer Männer verloren, dabei hat unsere Mission gerade erst begonnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9629, 'deDE', 'Gut gemacht, $N. Ich hatte befürchtet, dass der Sender beim Markieren beschädigt werden könnte, aber scheinbar ist ja alles wie geplant verlaufen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9632, 'deDE', 'Ich kann Euch helfen, nach Auberdine zu kommen. Glücklicherweise ist es nur eine kurze Fahrt mit dem Schiff von hier!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9633, 'deDE', '<Thundris nimmt das Schreiben von Euch entgegen, liest es und nickt.>$B$BDie Inseln der $R, die Azurmythosinsel und die Blutmythosinsel, wurden vor langer Zeit von meinen Leuten bewohnt. Einige der Bedrohungen, denen sich Anachoret Paetheus und seine Brüder und Schwestern jetzt stellen müssen, sind alte Feinde der Nachtelfen.$B$BIch bin mir sicher, dass man unseren neuen Verbündeten hier in Auberdine alles zur Verfügung stellen möchte, das benötigt wird. Sobald ich mit den Bewohnern der Stadt und den Schildwachen gesprochen habe, werde ich Paetheus benachrichtigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9634, 'deDE', 'Gut gemacht, $N. Der Felshetzerbestand wird zwar nur für einige Zeit begrenzt bleiben, aber es ist ein guter Anfang.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9641, 'deDE', 'Gut gemacht. Diese Splitter werden als Rohmaterial für weitere Stärkungskristalle dienen.$B$BIhr könnt Euch einen der drei Typen aussuchen, die ich herstellen kann. Ich finde sie alle recht nützlich, je nachdem auf welche Beute man es abgesehen hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9642, 'deDE', 'Sehr schön, hier sind meine Kristalle, $N. Verwendet sie weise.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9643, 'deDE', 'Das scheint mir stabil genug für meine Konstruktion. Danke für die Hilfe, $N. Euer Unterstützung bei der Verteidigung der Blutwacht wird nicht vergessen werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9646, 'deDE', 'Gut gemacht. Von dem, was ich gehört habe, war es wohl kein leichter Kampf. Ihr habt Euch Eure Belohnung mehr als verdient, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9647, 'deDE', 'Es gilt jetzt, eine längerfristige Lösung zu finden, um die Arten wieder in ihren Urzustand zurückzuführen. Momentan ist das zeitweilige Ausmerzen ihres Bestandes jedoch die beste Methode. Danke für Eure Hilfe, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9648, 'deDE', 'Nun, ich hatte Euch gewarnt - oder etwa nicht? Ich hoffe diese kleine Bezahlung wird Euch für Eure Unannehmlichkeiten etwas entschädigen können. Kehrt zu mir zurück, sobald Ihr Euch ein wenig erholt habt, dann habe ich vielleicht noch eine Aufgabe für Euch - mit Pilzen natürlich!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9649, 'deDE', 'Ich hoffe diese Aufgabe hat nicht zu viel von Euch abverlangt, $N. Ihr habt erneut bewiesen, dass Ihr $Gein fähiger und aufmerksamer:eine fähige und aufmerksame; $R seid. Habt meinen Dank und natürlich eine kleine Abfindung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9663, 'deDE', 'Gut gemacht, $N. Dies war ein Test Eurer Fähigkeiten, aber Ihr habt mit wehenden Fahnen bestanden. Um ein Soldat der Hand von Argus zu werden, gilt es viele dieser Tests zu bestehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9666, 'deDE', 'Es tut mir leid, dass Ihr das tun musstet, $N. Rohe Gewalt entspricht nicht der Natur der $R, aber manchmal ist sie der einzige Weg.$B$BUnglücklicherweise gehört dies zum Leben und man versteht es oft erst dann, wenn es zu spät ist. Genau wie mit den Orcs, die unsere Brüder und Schwestern abschlachteten.$B$BEin Mitglied der Hand von Argus zu werden, ist ein Prozess der Wiedergeburt. Mit der Geburt kommt bekanntlich auch der Schmerz...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9667, 'deDE', 'Ihr habt erneut bewiesen, dass Ihr all dem entsprecht, was in der Prophezeiung vorhergesagt wurde. Ihr habt den ewigen Dank des Oberhäuptlings, $N - und Ihr habt die Wahl zwischen diesen Relikten der Tannenruhfeste...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9668, 'deDE', 'Ich hatte es bereits im Gefühl, dass Ihr es bis hierher schaffen würdet, $C. Wenn Ihr noch weiter kommen möchtet, bin ich gerne bereit Euch zu unterrichten...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9669, 'deDE', 'Unglaublich! Konntet Ihr andere Überlebende finden?$B$B<Achelus senkt seine Stimme zu einem Flüstern.>$B$BIch möchte ehrlich mit Euch sein, $N, niemand sonst wollte diesen Auftrag annehmen. Ihr seid sehr mutig, $C...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9670, 'deDE', 'Ihr habt mehr als die Hälfte des Teams befreit! Der Exarch und die anderen bei der Blutwacht werden mit Sicherheit von Eurer heldenhaften Tat erfahren. Ich danke Euch, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9671, 'deDE', 'Seid Ihr $N? Es wurde auch Zeit! Ich war gerade dabei, die Suche nach Euch aufzugeben!$B$BBeim Briefkasten wartet eine dringende Nachricht auf Euch. Die Person, die sie mir übergeben hatte, war ein Admiral der Menschen von der Azurmythosinsel. Admiral Odesy-irgendwas... der Name ist mir entfallen. Er sagte, Ihr würdet wissen, wer er sei.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9672, 'deDE', 'Habt Ihr von dem Blutfluch gehört, Landratte? Nein, natürlich nicht. Der Blutfluch ist das, was all diese Schiffe hat sinken lassen. Der verderbte, entweihte Teil des Wassers hier wird Riff des Blutfluchs genannt - ein Teil der Welt, den Ihr niemals sehen möchtet. Ich bin hier selbst seit 20 Jahren.$B$BSkorbut, so ein Quatsch! Ich starb an diesen Wilden Ufern als Drachenfutter... Ah, das ist wieder eine andere Geschichte, für ein anderes Mal. Jetzt müssen wir den armen Seelen helfen, die hier im Riff gefangen sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9674, 'deDE', 'Ein guter Anfang, aber es gibt noch viel mehr zu tun!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9675, 'deDE', 'Zu wissen, wie man seinen Begleiter füttert und wiederbelebt, ist nicht nur ein zusätzlicher Leckerbissen, wie Euer letzter Lehrer so gelinde sagte - es ist viel mehr. Mit der richtigen Ausbildung kann sich Euer Begleiter auf eine Weise verbessern, wie er es nie von alleine getan hätte.$B$BIch habe bereits viel von den Furbolgs gelernt, also gebt Acht und ich werde dieses Wissen an Euch weitergeben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9676, 'deDE', 'Mit der Zeit werdet Ihr Euch Euren Platz in unseren Reihen verdienen. Doch zunächst müsst Ihr die Mächte des Lichts beherrschen lernen. Eure Waffenkampkünste verfeinern und Eure Würdigkeit unter Beweis stellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9682, 'deDE', 'Ihr habt den Hoffnungslosen einen großen Dienst erwiesen, $N. Es gilt jedoch noch eine letzte Aufgabe zu erledigen: Tötet den Anführer des Blutfluchs.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9683, 'deDE', 'Ihr habt es geschafft! Hunderte von Seelen sind Euch für alles, was Ihr getan habt, dankbar.$B$BGestattet mir, Euch etwas zu überreichen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9687, 'deDE', 'Ein Ritual? Die Eulkin haben seit tausenden von Jahren mit dem Land in Einklang gelebt. Derartiges ist nicht normal!$B$BWie bedauerlich...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9688, 'deDE', 'Wie verwerflich Eure Aufgabe auch war, es musste einfach getan werden. Jetzt müsst Ihr in das Angesicht des Bösen sehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9689, 'deDE', 'Wie lange war es noch? Tausend Jahre? Zehntausend Jahre vielleicht? Ihr habt mir und der Erinnerung meiner Leute einen großen Dienst erwiesen, $N. Bitte, nehmt diesen mächtigen Gegenstand als Zeichen der Anerkennung von Loreth\'Aran an - für Eure ehrenvollen Taten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9693, 'deDE', 'Ah, $N... ich habe bereits von Euch gehört. Ihr seid also derjenige, der den Korsallauf in unter 15 Minuten gemacht hat. Ts, wahrscheinlich nicht.$B$BSeid Ihr bereit, etwas Blut im Namen des Lichts zu vergießen? Für Velen? Für Argus?$B$B<Boros lacht.>$B$BGut, gut, ich halte mich jetzt besser zurück.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9694, 'deDE', 'Ihr seid zurück - in einem Stück!$B$BIch habe gute Neuigkeiten, $N. Wir haben neue Informationen zum wahrscheinlichen Aufenthaltsort weiterer Überlebender erhalten. Eine neue Absturzstelle wurde entdeckt! Sobald ich mich eingehender damit befasst habe, werde ich mich an Euch wenden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9696, 'deDE', '<Elysia liest das Dokument.>$B$BWenn wirklich stimmt, was hier steht, dann haben die Blutelfen ein Portal zur Scherbenwelt geöffnet! Das würde auch ihre schier endlose Zahl erklären...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9697, 'deDE', 'Oh, gut... endlich Unterstützung! Es gibt einfach so viel zu tun, und ich muss hierbleiben, um alles zu organisieren.$B$BIch hoffe Ihr seid bereit, Euch die Hände schmutzig zu machen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9698, 'deDE', '<Velen beginnt das Dokument zu lesen.>$B$BInteressant... dies erklärt in der Tat einiges.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9699, 'deDE', 'Es ist ein guter Plan, aber auch ein gefährlicher. Ich bin mir jedoch sicher, dass alles gut verlaufen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9700, 'deDE', 'Wie viele sagtet Ihr doch gleich, habt Ihr bei der Warpgondel gesichtet? Wie oft haben sie nur dieses Sonnenportal geöffnet? Das sind sehr schlechte Neuigkeiten...$B$BTja, Ihr habt Euch nun alles von mir angeeignet, was ich Euch lehren kann, $N. Kuros wird nach Euch rufen lassen, wenn es an der Zeit ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9701, 'deDE', 'Was?! Die Sumpflords des Quaggkamms ESSEN die Sporenkapseln der Sporlinge? Das ist nicht gut!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9702, 'deDE', 'Das habt Ihr gefunden? Das ist komisch. Diese vertrockneten Pilzüberreste sind ungewöhnlich und kommen mir irgendwie bekannt vor.$B$BIch muss kurz darüber nachdenken. Geht nicht weg!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9703, 'deDE', 'Nur Blutelfen? Keine Überlebenden? Das ist beunruhigend. Ich brauche etwas Zeit zum Nachdenken, $N. Vielleicht haben Aesom oder Boros einen Auftrag für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9704, 'deDE', 'Die Habseligkeiten der Kundschafterin wurden mit Ausnahme eines Pakets allesamt entwendet. Es scheint der Beschreibung zu entsprechen, die Euch Alarion von Eronas Päckchen gegeben hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9705, 'deDE', 'Beim Sonnenbrunnen! Es ist der dritte Kundschafter, den wir diesen Monat verloren haben.$B$BIch weiß Euren Mut zu schätzen, den Ihr bei Eurer Reise zum Dämmerweg bewiesen habt. Die Wachen müssen diese verdammten Getriebenen besser im Auge behalten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9706, 'deDE', '<Kuros erbleicht beim Lesen des Tagebuchs und Tränen strömen seine Wangen herab.>$B$BSaruan war mein Meister... mein Lehrer... mein Mentor... Ich nahm seinen Platz im Dreigestirn erst vor Kurzem ein - nachdem wir die Suche nach ihm aufgegeben hatten.$B$B<Kuros\' Gesichtsausdruck schlägt in Zorn über.>$B$BMatis...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9708, 'deDE', 'Die Proben stimmen definitiv überein. Und die Anwesenheit der Oger und was sie dort tun erklärt alles. Jetzt verstehe ich, warum der Ort Prügelsumpf genannt wird.$B$BWir müssen etwas an dieser Situation ändern, aber was? Wir können nicht einfach alle Oger auslöschen, sie haben genauso viel Recht hier zu leben, wie alle anderen Lebewesen in den Marschen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9709, 'deDE', 'Sie sind perfekt! Oh danke, $C!$B$BIhr wart so darauf bedacht, das natürliche Gefüge nicht aus dem Gleichgewicht zu bringen, und wir haben in so kurzer Zeit so viele Informationen sammeln können!$B$BJetzt wollen wir mal schauen, ob unser kleiner Plan, eine neue Nahrungsquelle für die Sumpflords zu schaffen, funktioniert.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9711, 'deDE', 'Das Dreigestirn hat beschlossen, Matis sofort zu verurteilen. Ihr habt heute einen Erzverbrecher der Gerechtigkeit überführt, junger $R.$B$BIhr habt für zwei von drei außerordentliche Arbeit geleistet, lediglich Aesom fehlt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9714, 'deDE', 'Das ist schon mal sehr gut, aber wir können immer noch mehr davon gebrauchen. Vielleicht geht Ihr ja bald mal wieder in den Tiefensumpf?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9715, 'deDE', 'Das ist schon mal sehr gut, aber wir können immer noch mehr davon gebrauchen. Vielleicht geht Ihr ja bald mal wieder in den Tiefensumpf?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9716, 'deDE', 'Die Naga stecken dahinter! Aber warum? Euren Schilderungen zufolge sind die Dampfpumpen für das Sinken der Wasserspiegel in den Marschen verantwortlich.$B$BEgal - dies erklärt Ihre offensichtliche Feindlichkeit uns gegenüber. Lasst uns keine Zeit verschwenden, Ihr müsst eine weitere Aufgabe für uns erledigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9717, 'deDE', '<Der Sporling macht ein Geräusch, das fern an ein prustendes Lachen erinnert.>$B$BPerfekt! Die Moral der Fungusgiganten wird sicher ein Rekordtief erreichen, wenn sie sehen, was Ihr getan habt.$B$BEntweder das oder sie werden so erzürnt sein, dass sie uns bald wieder angreifen.$B$B<T\'shu zuckt mit den Schultern.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9718, 'deDE', 'Es ist so, wie ich dachte. Die Naga haben Pumpstationen an allen größeren Seen in den Zangarmarschen errichtet.$B$BWenn die Marschen weiter existieren sollen, müssen sie aufgehalten werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9719, 'deDE', 'Die Schattenmutter ist tot! Normalerweise schwelge ich ja nicht in solchen Gemetzeln, aber der Schmerz, den die große Mutter und ihre Brut über Jahrhunderte über mein Volk gebracht haben, ist unaussprechlich.$B$BEs ist schade, dass nun einer ihrer Nachkömmlinge sich verwandeln wird, um ihren Platz einzunehmen, aber das wird Zeit benötigen. So haben wir eine kleine Atempause, und müssen uns eine zeitlang nicht vor den Marschenläufern fürchten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9720, 'deDE', 'Es ist also vollbracht. Die Marschen sind vorerst gerettet.$B$BGlaubt aber nicht, dass wir zum letzten Mal von den Naga gehört haben. Wir müssen unseren Feind im Auge behalten, während wir unsere Mission in der Scherbenwelt fortsetzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9724, 'deDE', 'Das sind schlimme Nachrichten, die Ihr mir über die Naga in den Zangarmarschen bringt. Es war sehr klug von Ysiel, uns darüber zu informieren. Sie hat nicht vergessen, dass die Expedition nicht ohne die Unterstützung des Zirkels existieren kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9726, 'deDE', '<Gzun\'tt nickt Euch zu.>$B$BWir sind sehr erfreut, dass Ihr unsere Freundschaft bestätigt habt, $N. Vielleicht denken die heidnischen Naga in Zukunft zweimal darüber nach, bevor sie uns belästigen, wenn wir so einen starken Verbündeten haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9727, 'deDE', '<Gzun\'tt nickt Euch zu.>$B$BWir sind sehr erfreut, dass Ihr unsere Freundschaft erneut bestätigt habt, $N. Sicherlich werden die sinnlosen Angriffe auf unser Volk jetzt, da Ihr unseren Standpunkt mehrfach klar gemacht habt, aufhören.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9728, 'deDE', 'Gut gemacht, $N. Beruhigt Eurer schlechtes Gewissen, falls Ihr eines haben solltet. Diese Naga sind böse Kreaturen - noch viel böser als die in Azeroth.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9729, 'deDE', 'Fhwoor ist ein guter Riese. Wir haben ihn vor einer Weile vor den Naga gerettet und seitdem ist er hier und hilft uns.$B$BWir können nur hoffen, dass die Naga den Hinweis verstehen. Wenn wir in der Lage sind, uns in ihr Dorf einzuschleichen und ihren wertvollsten Besitz zu rauben, können wir noch viel Schlimmeres tun. Vielleicht gehen sie jetzt zurück in ihren Kessel und lassen uns in Ruhe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9730, 'deDE', 'Ich mochte schon die Naga in Azeroth nicht, aber die hier mag ich noch viel weniger. Es ist eine Schande, dass unsere Mission nicht friedvoll verlaufen konnte, aber Ihr werdet mich niemals auch nur eine Träne für einen Naga vergießen sehen.$B$BHier ist Eure Belohnung, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9731, 'deDE', 'Die Naga haben den Schlangensee in einen riesigen Wasserablauf für den Rest der Zangarmarschen verwandelt. Was haben sie wohl vor?$B$BEs war eine kluge Entscheidung, uns diese Neuigkeiten mitzuteilen, $N. Wir werden eine Gruppe losschicken, um den Ablauf, den Ihr gefunden habt, zu untersuchen. Bis dahin habe ich eine andere Aufgabe für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9732, 'deDE', 'Euer Anblick ist mir sehr willkommen, $N. Die Lage in der Zuflucht des Cenarius hat sich verschlechtert, seit Ihr fortgegangen seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9738, 'deDE', 'Ich bin froh, dass einige meiner Freunde noch am Leben sind, aber es bricht mir das Herz zu hören, was den anderen widerfahren ist. Immerhin starben sie bei etwas, was sie mehr als alles andere im Leben liebten. Ich bin Euch auf ewig dankbar für Eure Hilfe, $N.$B$BBitte nehmt einen meiner Ringe als Zeichen meiner Dankbarkeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9739, 'deDE', 'Ihr habt es geschafft! Ihr habt den Dank meines Volkes.$B$BIch hoffe Ihr versteht... daraus entstehen unsere Jungen. Wir können diese Biester sie nicht einfach fressen lassen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9740, 'deDE', 'Fabelhaft! Wir haben ihre Versorgungszufuhr durchtrennt. Jetzt müssen wir sie nur noch kaltmachen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9741, 'deDE', 'Dort herrscht ein ganz schönes Durcheinander, was? Gute Arbeit, $N. Ich werde ein paar Anachoreten entsenden, die Loryi und Jorli helfen werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9742, 'deDE', 'Ja! Ihr habt noch mehr Sporensäcke gerettet.$B$BIhr seid anders als die anderen von außerhalb. Ich werde meinem Volk von Euren Taten erzählen!$B$B<Diese Quest kann wiederholt werden, bis Ihr einen freundlichen Ruf erlangt habt.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9743, 'deDE', 'Ihr seid heil zurück! Ich werde den anderen Sporlingen von Euch erzählen! $N, der Riesentöter!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9744, 'deDE', 'Unglaublich! Es würde hunderte von Sporlingen brauchen, um so viele Riesen zu töten wie Ihr. Ich werde ganz bestimmt allen von Euren Heldentaten erzählen!$B$B<Diese Quest kann wiederholt werden, bis Ihr einen freundlichen Ruf erlangt habt.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9746, 'deDE', 'Dies wird ihre Verteidigung ganz sicher geschwächt haben. Ab sofort werden sie es sich zweimal überlegen, bevor sie uns kopflos überfallen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9747, 'deDE', 'Danke, $N. Endlich werde ich nachts ruhig schlafen können. Wäre ich nicht so alt und schwach, würde ich mich selbst mit meinen Feinden auseinandersetzen.$B$BNehmt dieses Gold. Es ist nicht viel, aber Eure Freundlichkeit darf nicht unbelohnt bleiben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9748, 'deDE', 'Wie ich vermutet habe, ist das Wasser von der Verseuchung durch die austretende Kernflüssigkeit rot geworden.$B$BIch hoffe, dass Ihr nicht in dem verseuchten Wasser geschwommen seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9751, 'deDE', 'Habt Ihr von dem Blutfluch gehört, Landratte? Nein, natürlich nicht. Der Blutfluch ist das, was all diese Schiffe hat sinken lassen. Der verderbte, entweihte Teil des Wassers hier wird Riff des Blutfluchs genannt - ein Teil der Welt, den Ihr niemals sehen möchtet. Ich bin hier selbst seit 20 Jahren.$B$BSkorbut, so ein Quatsch! Ich starb an diesen Wilden Ufern als Drachenfutter... Ah, das ist wieder eine andere Geschichte, für ein anderes Mal. Jetzt müssen wir den armen Seelen helfen, die hier im Riff gefangen sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9752, 'deDE', 'Ihr habt einen meiner Druiden gerettet. Das könnten wir Euch niemals zurückzahlen, $N.$B$BIhr habt meinen Dank sowie den Dank der Expedition.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9753, 'deDE', 'Ich brauche Eure Hilfe, $N. Es ist mein Plan, die gesamte Armee der Sonnenfalken zu stürzen. Zuvor gilt es jedoch ein paar grundlegende Informationen zu sammeln.$B$BWir müssen die Schwäche ihrer Verteidigung ausmachen. Unglücklicherweise ist es uns bis jetzt noch nicht gelungen, nahe genug an die Vektorspule heranzukommen und ihre Verteidigung auszukundschaften. Wenn wir den Gefangenen zum Sprechen bringen könnten, würden wir womöglich die Informationen bekommen, die wir brauchen, um durch ihre Verteidigung zu brechen und die Vektorspule zu zerstören.$B$BIhr habt richtig gehört, ich will das verdammte Ding in die Luft jagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9756, 'deDE', 'A-ha! Gut gemacht, $N. Wirklich sehr gut gemacht. Seid Ihr bereit der Blutelfenbedrohung unserer Insel nun endlich ein Ende zu bereiten?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9757, 'deDE', 'Lasst uns sofort mit der Ausbildung beginnen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9758, 'deDE', 'Ah, gut, da seid Ihr ja. Und gerade zur rechten Zeit, es gibt viel zu tun!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9760, 'deDE', 'Vielleicht verhelft Ihr unserem Volk ja zu einem neuen Zeitalter des Wohlstands und des Friedens.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9761, 'deDE', 'Hoffentlich meldet sich bald ein Held, bevor sie Verstärkung anfordern können, um die gerade von Euch abgesicherte Gegend zu bewachen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9763, 'deDE', 'Unser größter Feind in der Gegend ist endlich tot. Ihr habt der Expedition einen sehr großen Gefallen getan, $N.$B$BWir stehen auf ewig in Eurer Schuld.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9769, 'deDE', 'Die sind fein, $N. Hier ist Eure Bezahlung.$B$BNe, nicht mein Fall, aber ich hab ja auch keine Ahnung von Mode.$B$BEs ist das Geld, was zählt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9770, 'deDE', 'Schon satt?$B$B<Reavij lacht.>$B$BEs gibt einen Grund warum unsere Besucher nicht lange bleiben.$B$BWenn ich eine Wahl hätte, würde ich einen angenehmeren Ort für den Posten auswählen. Aber ich ziehe die Marschfänge immer noch Denjais Launen vor!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9771, 'deDE', 'Diese in Mitleidenschaft gezogene Leiche passt genau zu Zurais Beschreibung. Was auch immer den Späher getötet haben mag, muss ihn überrascht haben, da er seine Waffen nicht gezogen hatte und Tintenflecken auf dem Boden zu sehen sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9772, 'deDE', '<Zurai nimmt den Bericht von Euch und schaut ihn sich an.>$B$BViele von diesen Informationen sind uns bereits bekannt. Alles in dieser Gegend scheint ausgetrocknet oder am verwelken zu sein, aber hier steht etwas neues.$B$BEr sagt, die Fungusgiganten sind von dem Wassermangel wahnsinnig geworden. Eurer Beschreibung nach muss es einer von ihnen gewesen sein, der ihn umgebracht hat.$B$BIch werde meinen Männer anweisen, die Gegend zu meiden. Wir können uns keine weiteren Verluste erlauben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9773, 'deDE', 'Endlich, eine Abwechslung zu den Pilzen! Wenn Ihr nicht nach Fisch riechen würdet, würde ich Euch umarmen.$B$BWollen wir mal schauen, wie neidisch die anderen werden, wenn sie meinen gebratenen Fisch riechen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9774, 'deDE', 'Danke, $N. Jedes noch so kleine bisschen hilft.$B$BEs ist immer noch viel zu tun, aber mal ehrlich, was soll ich sonst zwischen den Patrouillen machen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9775, 'deDE', 'Warum habt Ihr nicht gleich gesagt, dass Ihr einen Bericht von Zurai habt? Ich warte schon auf Nachricht von ihm.$B$BIch habe ihn nach Osten geschickt, damit er dort einen Posten baut, nicht um auf den Händen zu sitzen. Wollen wir mal sehen, was er zu sagen hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9776, 'deDE', 'Wenn Anachoret Ahuurn Euch als Freund betrachtet, kann ich Euch vielleicht vertrauen. Bitte vergebt mir meinen Argwohn, $R, doch oft rettet nur dieser mein Volk vor dem Tod. Seid in unserer Zuflucht willkommen. Vielleicht wird so unser gegenseitiges Vertrauen wachsen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9777, 'deDE', 'Diese Sporen sind sehr gut und sollten uns für einen Weile reichen. Vielen Dank für Eure Hilfe bei der Aufstockung unserer Vorräte, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9778, 'deDE', 'Ysiel hat Euch geschickt? Natürlich habe ich für jemanden wie Euch Verwendung! Wir können immer ein paar Muskeln brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9779, 'deDE', '<Verteidiger Boros betrachtet das Dokument.>$B$BDas ist Thalassisch. Glücklicherweise kenne ich eine Person, die es übersetzen kann...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9780, 'deDE', 'Danke für Eure Hilfe, $N. Euer Großmut wird nicht vergessen werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9781, 'deDE', 'Gut gemacht. Das sollte den Bedarf an Nahrung in der Gegend für die nahe Zukunft etwas mindern, auch wenn wir immer noch nach neuen Nahrungsquellen suchen sollten. Fisch und Pilze reichen aus, aber etwas Abwechslung sollte nicht unterschätzt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9782, 'deDE', 'Hmm... der Boden ist nicht ausgelaugt, das kann also nicht der Grund für das Problem sein, wie ich zuerst vermutet habe. Wo liegt die Verbindung? Warum stirbt alles so plötzlich?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9783, 'deDE', 'Danke für Eure Hilfe bei dieser schweren Aufgabe, $N. Unsere Arbeit im Todesmoor ist noch nicht beendet, aber nun können wir uns darauf konzentrieren, das Gleichgewicht in der Gegend wiederherzustellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9784, 'deDE', 'Ausgezeichnet. Wenn Ihr noch mehr Pflanzenteile findet, bringt sie zu mir.$B$B<Diese Quest kann wiederholt werden, bis Ihr einen wohlwollenden Ruf erlangt habt.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9785, 'deDE', 'Ihr seid zurück. Habt Ihr den Segen der Uralten erhalten?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9786, 'deDE', 'Die Verirrten des Wildfennstamms haben sich also in den Ruinen eingenistet? Das ist verblüffend. Sie müssen sich an Ihr Erbe erinnern und die Wichtigkeit dieses Ortes erkennen können. Wir müssen mehr darüber erfahren, $N. Vielleicht ist in diesem Tempel der Schlüssel zur Erlösung der Verirrten und zur Wiedervereinigung der verschiedenen Arten der Draenei versteckt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9787, 'deDE', 'Diese sollten mehr als ausreichen, $N. Sie scheinen auf Vögel fixiert zu sein, was merkwürdig ist, da es in den Zangarmarschen keine einheimischen Vogelarten gibt. Was könnte das wohl bedeuten?$B$BSind sie vielleicht auf die Arakkoa getroffen? Für ein schamanistisches Volk mögen sie vielleicht wie der Inbegriff eines mächtigen Vogelgeists wirken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9788, 'deDE', 'Meine Sachen! Sie sind alle da!$B$BIch danke Euch, $N. Wie versprochen dürft Ihr Euch etwas von den Dingen aussuchen. Ich habe nicht viel anzubieten, aber mein Volk hat schon immer das Wenige, was wir hatten, geteilt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9789, 'deDE', 'Ein akzeptabler Start. Doch das war erst der Anfang.$B$BDie harmloseren Grollhufe beweisen noch gar nichts. Versuchen wir es doch mal mit einer größeren Herausforderung für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9790, 'deDE', 'Habt Dank, $N.$B$BZumindest müsst Ihr sie nicht säubern. Das ist der schlimmste Teil der Arbeit, aber wenn ich damit fertig bin, werdet Ihr niemals erkennen, dass sie mal zu einem riesigen Insekt gehört haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9791, 'deDE', 'Danke für Eure Hilfe bei der Auslöschung einiger Marschenfangreißer, $N. Wenn sie über Intelligenz verfügen würden, würden sie vielleicht erkennen, dass es am besten ist, zu leben und leben zu lassen.$B$BGroße, überwucherte Käfer mit Intelligenz. Ich frage mich, wie das wohl wäre...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9792, 'deDE', 'Ikuti ist wie ein Bruder für mich. Seine Freunde sind auch meine Freunde. Ihr seid hier willkommen, $N, und Ihr habt unseren Dank für die Hilfe, die Ihr meinem Volk geleistet habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9793, 'deDE', 'Hmm... Ich kann mich erinnern, dass unsere Späher von den Ruinen einer Draeneisiedlung in den nördlichen Ausläufern des Waldes berichtet haben. Ich weiß jedoch selbst nicht viel über die Ruinen, aber Ihr könnt gerne mit unseren Spähern sprechen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9794, 'deDE', 'Ihr bringt mir also Timothys Antwort?$B$B<Kialon hält einen Moment inne, um den Brief zu lesen, und fängt an zu lachen.>$B$BEr hat alles unter Kontrolle, sagt er, braucht keine Hilfe. Ich hätte es wissen müssen!$B$BManche Leute ändern sich nie. Schaut, er hat sich sogar die Zeit genommen, meine Rechtschreibfehler zu korrigieren.$B$B<Kialon seufzt halbherzig.>$B$BIch hätte ihm den Brief nicht schicken sollen. Ich habe es vergessen. Der Spezialist hat die Situation immer unter Kontrolle. Immer.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9795, 'deDE', 'Denjai braucht Hilfe? Ich würde ihm gerne ein paar Leute schicken, aber wir können uns selbst kaum halten. Wir haben hier oben unsere eigenen Probleme mit den Ogern.$B$BSobald ich kann, werde ich ihm alle Informationen, die wir über diesen Ogerstamm und seine Taktiken haben, zukommen lassen. Wenn er lang genug durchhält, können wir die widerlichen Kreaturen vielleicht von zwei Seiten aus angreifen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9796, 'deDE', 'Es wurde auch langsam Zeit, dass der Außenposten fertig wird. Wir haben schon viel zu viele Boten an die Vorhut der Allianz verloren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9797, 'deDE', '<Auch wenn er sich Mühe gibt, es zu verheimlichen, macht sich Erleichterung auf Kroghans Gesicht breit.>$B$BEs wurde auch langsam Zeit, dass Ihr kommt! Sicher, Ihr seid keine Armee, $R, aber hier ist ein jeder willkommen, der Kraft genug besitzt, eine Waffe zu führen oder einen Zauber zu wirken. Die Einwohner Garadars sind ein Teil der Horde und stolz, ihr Blut für deren Verteidigung vergießen zu dürfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9798, 'deDE', 'Hier, lasst mich einen Blick auf diese Pläne werfen.$B$BDie Blutelfen sind uns hierher gefolgt? Sie sind durch und durch bösartig und sollten ganz und gar ausgelöscht werden!$B$B<Der Verteidiger braucht einen Moment, um sich wieder zu fassen.>$B$BEntschuldigung, ich hätte mich beherrschen sollen. Wir stehen für die Entdeckung dieser Informationen in Eurer Schuld, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9799, 'deDE', 'Das sieht mir nach ein paar guten Exemplaren aus. Danke für Eure kleine Hilfsarbeit. Sobald ich Zeit zum Untersuchen der Blumen habe, sollte ich bestimmen können, was es zur Wiederherstellung der Felder bedarf.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9800, 'deDE', 'Bitte wascht Euch nicht in den heiligen Wassern des Throns.$B$B<Elementarist Lo\'ap reicht Euch eine fertige Caracolitablette.>$B$BLegt sie unter Eure Zunge und lasst sie sich auflösen. Einmal aufgelöst werdet Ihr Wasser wie Luft atmen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9801, 'deDE', 'Diese Reagenzien eignen sich sehr gut. Bitte gebt mir einen Moment Zeit, um den Trank zu mischen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9802, 'deDE', 'Das Abnehmen der natürlichen Arten ist ein Grund zur Sorge. Die Zunahme der eingewanderten Arten könnte mit der neuerlichen Störung des Ökosystems zusammenhängen. Ich habe jedoch noch zu wenig Anhaltspunkte, um Genaueres zu sagen.$B$B<Lauranna macht ein paar Notizen in ein Buch, als sie die Pflanzenteile untersucht.>$B$BNehmt ein paar davon, $N. Sie könnten vielleicht nützlich für Euch sein.$B$BBringt mir alle weiteren Pflanzenteile, die Ihr finden könnt. Ich werde sie in meiner Statistik auflisten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9803, 'deDE', 'Sie haben abgelehnt? Natürlich steht es ihnen frei, selbst zu wählen, aber ihre Entscheidung überrascht mich. Ich habe gedacht, dass alle Draenei, also auch die Zerschlagenen und Verirrten, sich daran erinnern würden, dass wir alle ein Volk sind.$B$BIch schätze er hat Recht damit, dass es töricht war zu versuchen, sie hereinzulegen, aber trotzdem, konnte er denn nicht sehen, dass wir in freundlicher Absicht gehandelt haben?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9804, 'deDE', '<Elementarist Lo\'ap kniet im Wasser und betet.>$B$BDer Irdene Ring ist nicht stolz auf das, was geschehen ist. Wir tun das, was wir müssen, um das Land zu heilen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9805, 'deDE', 'Eure Bemühungen haben die Ausbreitung der Verschmutzung eingedämmt, aber nun sind neue Probleme aufgetaucht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9806, 'deDE', 'Diese Sporen sind perfekt, $N! Die Langstielpilze sind für den Wiederaufbau unseres Dorfs unerlässlich. Und seit den Angriffen der Sumpflords, die wir erdulden mussten, sind unsere Vorräte knapp!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9807, 'deDE', 'Eure Hilfe wird sehr geschätzt, $N. Ihr werdet uns doch weiterhin helfen, oder?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9808, 'deDE', 'Die können wir prima bei den anderen Sporlingen gegen Essen und Vorräte eintauschen. Sporeggar dankt Euch, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9810, 'deDE', 'Die Elemente haben Euren Sieg besungen, als Ihr die verschmutzte Essenz getötet habt. Der Irdene Ring dankt Euch und möchte, dass Ihr Euch eine Belohnung aussucht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9811, 'deDE', 'Ihr habt Dar\'Khan also getötet, $R? Beeindruckend. Ich habe das Gefühl, dass unsere und Eure Leute bald gute Freunde sein werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9814, 'deDE', 'Die sind klasse, Mann!$B$BIch sag\' Euch was. Weil Ihr so nett wart und mir mit den Pilzen geholfen habt, dürft Ihr beim Spaß dabei sein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9815, 'deDE', 'Der Irdene Ring dankt Euch, $N. Auch die Elemente sind Euch dankbar. Eure wiederholten Bemühungen, unsere Welt zu reinigen, werden sehr geschätzt und sicher nicht vergessen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9816, 'deDE', 'Ausgezeichnete Arbeit, Mann! Ich hoffe, sie hatten Spaß damit!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9817, 'deDE', 'Ich wette, die Blutschuppen überlegen es sich nun zweimal, bevor sie unsere Späher nochmals angreifen. Nehmt dies als Belohnung, $N. Ihr habt es Euch verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9818, 'deDE', '<Gordawg scheint Euch zuzunicken.>$B$BSetzt Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9819, 'deDE', '<Gordawg nickt zufrieden.>$B$BGut. Geister schlafen jetzt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9820, 'deDE', 'Gut gemacht, $N. Die Anwesenheit dieser Oger so nah an unserem Außenposten hat mich ein wenig beunruhigt. Es scheint, als kämen sie seit einiger Zeit die Berge im Norden herunter.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9821, 'deDE', '<Gordawg spuckt den gekauten Stein aus, woraufhin ein Steinschauer auf Euch herabrieselt.>$B$BGift. Diese Felsen sind nicht Nagrand. Diese Felsen sind vergiftet. Ihr zerstört Giftfels. Ihr findet Thronräuber.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9822, 'deDE', '<Schattenjäger Denjai untersucht die Pläne.>$B$BIch wusste es! Der Gestank eines Ogers hat immer etwas Bedrohliches an sich. Jetzt, da wir einen Beweis für ihren Plan haben, müssen wir ihnen zuvorkommen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9823, 'deDE', 'Unser Sieg über die Ango\'rosh muss gefeiert werden, $N. Ich frage mich, wie lange es wohl dauert, bis diese Grobiane einen neuen, blutrünstigen Anführer gefunden haben.$B$BGanz gleich, wir werden auf sie vorbereitet sein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9827, 'deDE', 'Das sieht aus wie das Basidium eines Sumpflords, aber ich habe noch nie zuvor eines in einem solchen Zustand gesehen. Ich habe gehört, dass die Riesen im Todesmoor angefangen haben dahin zu siechen, aber es ist schon viel weiter fortgeschritten, als ich befürchtet habe.$B$BDas Todesmoor war einst ein See wie die anderen in den Marschen, und er diente als Nährgrund für die Riesen. Jetzt, da sich das Wasser zurückzieht, scheint es, als könnten sich die Riesen nicht länger vermehren. Wenn das so weitergeht, sterben die Riesen noch aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9828, 'deDE', 'Das sieht aus wie das Basidium eines Sumpflords, aber ich habe noch nie zuvor eines in einem solchen Zustand gesehen. Ich habe gehört, dass die Riesen im Todesmoor angefangen haben dahin zu siechen, aber es ist schon viel weiter fortgeschritten, als ich befürchtet habe.$B$BDas Todesmoor war einst ein See wie kein anderer in den Marschen, und er diente als Nährgrund für die Riesen. Jetzt, da sich das Wasser zurückzieht, scheint es, als könnten sich die Riesen nicht länger vermehren. Wenn das so weitergeht, sterben die Riesen noch aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9830, 'deDE', 'Vielen Dank für das Gift, $N. Jetzt kann ich es den anderen vorführen ohne meine eigenen Vorräte anfassen zu müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9833, 'deDE', 'Das sind wundervolle Nachrichten. Der Weg ist zwar immer noch nicht sicher, aber unsere Boten sind schlau und erfinderisch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9834, 'deDE', 'Das sind gute Bälge, findet Maktu. Sie werden sehr gute Rüstung geben.$B$BWer weiß? Vielleicht sind es genug, damit Maktu ein paar Rüstungen für die Draenei machen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9835, 'deDE', 'Für den Moment ist die Bedrohung durch die Ango\'rosh gebannt, aber ich bin mir sicher, dass sie nicht so leicht aufgeben werden. Ich habe vieles von meinem früheren Leben als Draenei vergessen, aber die Hartnäckigkeit der Oger hat sich in mein Gedächtnis eingebrannt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9839, 'deDE', 'Endlich! Vielen Dank für die Hilfe bei der Sicherung unserer Stellung hier in der Oreborzuflucht. Ich werde den Kurenai in Telaar in Nagrand von Euren Taten berichten. Es werden sich noch viele Gelegenheiten bieten, in denen unsere Völker zusammenarbeiten können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9841, 'deDE', 'Dachte ich es mir, Ich kann den Unterschied schon deutlich hören. Dank Euch werde ich endlich wieder arbeiten können. Falls Ihr jemals Handwerkswaren benötigen solltet, denkt an den alten Gambarinka!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9842, 'deDE', 'Die sollten mir für eine Weile genügen! Ich glaube, ein paar andere sind schon darauf aufmerksam geworden. Ich hatte schon ein paar Angebote, mir die Klingen abzukaufen. Sie nebenbei zu verkaufen könnte vielleicht ein einträglicheres Geschäft als meine herkömmlichen Waren bieten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9845, 'deDE', 'Ich kann es gar nicht erwarten endlich wieder angeln zu gehen. Jetzt werde ich endlich mit echten Fischen in meinem Eimer ins Dorf zurückkehren können, und Gambarinka wird sich nicht mehr über mich lustig machen können!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9846, 'deDE', 'Hmm... Es scheint, als wäre die eine Hälfte mit Bildern von Schlangengeistern, die andere mit Bildern von Vogelgeistern verziert. Kein Dunkelspeertroll mit Selbstachtung würde jemals Vögel verehren. Ihre Geister sind schwach, launisch und besser bei den Schamanen der Amani aufgehoben.$B$BAber die Schlange, $N, die Schlange hat beträchtliche Kräfte und ist daher der Geist, dem ich meine Studien widmen werde.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9847, 'deDE', '<Ihr berichtet Seherin Janidi, was passiert ist, als Ihr das Totem benutzt habt.>$B$BDer Geist hat euch angegriffen? Er muss diesen Verirrten wohl mehr zugetan sein, als ich dachte. Es gibt keine Möglichkeit, ihn mir gefügig zu machen, ohne immensen Aufwand zu betreiben. Ich muss mich wohl nach einer anderen Quelle der Macht in dieser elenden Welt umsehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9848, 'deDE', '<Timothy blättert das Handbuch durch.>$B$BSie benutzen Zottelkappe als Grundlage für das Gift? Nein, das kann nicht richtig sein. Zottelkappe ist nicht giftig.$B$BZottelkappe in ein Gift zu mischen ist so sinnvoll, wie einem Schurken zwei Streitkolben in die Hand zu drücken. Sicher, man kann das zwar tun, aber das entspricht nicht dem Wesen Eurer Berufung! Ich kann das einfach nicht verstehen...$B$B<Timothy räuspert sich.>$B$BNun ja, danke dass Ihr mir das hier besorgt habt. Ich werde das Gift ausprobieren, sobald die Zeit es mir erlaubt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9849, 'deDE', 'GUROK! Gurok hat die Elemente verraten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9850, 'deDE', 'Beeindruckend, sehr beeindruckend.$B$BIhr habt Potenzial, Jungspund. Ich werde Euch die Möglichkeit geben, richtig viel Spaß zu haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9851, 'deDE', 'Ihr habt es tatsächlich geschafft! Ihr habt Banthar erlegt! Ich habe niemals an Euch gezweifelt, $N.$B$BHier, ich denke, das habt Ihr Euch redlich verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9852, 'deDE', '$N! Ihr bringt das Herz dieses alten Zwergs zum Springen.$B$BIhr habt Euch nun bewiesen und seid in die Eliteränge aufgestiegen! Andere sind voller Angst geflüchtet, sind gestorben oder wurden unter den Füßen des Tieres zerquetscht. Ihr habt Euren Verstand, Eure List und Eure Entschlossenheit genutzt, um zu beweisen, dass Ihr die Jagd beherrscht.$B$BNehmt dies und seid gewiss, dass Ihr jederzeit zur Jagd an meiner Seite willkommen seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9853, 'deDE', '<Gordawg beißt fest in Guroks irdenen Kopf und bringt die Steinformation fast zum Bröckeln.>$B$BGuroks Herrschaft ist zu Ende. Die Erdelementare sind frei. Schlafen alle. Gewinner bekommt Preis!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9854, 'deDE', 'Jeder Tag ist ein Geschenk. Macht das Beste daraus. Denn schon morgen werden wir uns schneller fortbewegen als heute. Wir werden unsere Arme weiter ausbreiten und uns anstrengen, um das zu erzielen, von dem wir heute Nacht noch träumen, auch wenn wir es vielleicht nie erreichen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9855, 'deDE', 'Ihr habt Eure Fähigkeiten erneut unter Beweis gestellt, $C. Jetzt müsst Ihr Euch mit der wildesten Sorte von Windrocs messen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9856, 'deDE', 'Ihr Auge sieht aus, als wäre es noch am Leben. Denkt Ihr, sie kann immer noch in Eure Seele schauen?$B$B$N, Ihr könnt Euch zu den Elitesafarijägern zählen. Und Ihr seid auf dem besten Weg, die entscheidende Beute dieses Landes zu jagen, Zahna!$B$BIhr habt Euch das hier verdient. Möge es Euch gute Dienste leisten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9857, 'deDE', 'Das ist schon eine tolle Geschichte...<hust>...wie Ihr all die Hirsche erlegt habt, $C. Aber das könnt Ihr sicher noch besser. Ich habe da etwas anderes für Euch im Auge.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9858, 'deDE', '<hust>, <hust>... $N! Ihr habt es geschafft. Jetzt gibt es... ...nur noch eine Sache......zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9859, 'deDE', 'Wow! Ihr habt es geschafft! Das ist tatsächlich Bach\'lors Huf!$B$BÄhm, wie es aussieht fühle ich mich schon viel besser. Hier, lasst mich Euch etwas zur Feier Eures Jägerkönnens schenken!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9861, 'deDE', 'Es ist ein Notruf, $R. Eine Macht versucht die Elemente zu untergraben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9862, 'deDE', 'Ihr habt gesehen, wie sie die Elemente kontrollieren? Der Wind beugt sich ihrem Willen?$B$B<Morgh versinkt für einen Moment in Gedanken.>$B$BDas ist sehr beunruhigend, $N. Ich muss mich mit den anderen beraten.$B$BVielen Dank für Eure Mühen, $N. Vielleicht solltet Ihr in Euer Dorf zurückkehren und Euch umhören, ob es weitere Informationen über die Finsterblut und ihre schändlichen Ziele gibt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9863, 'deDE', 'Ihr habt den Söhnen des Blitzschlags neue Hoffnung gegeben, $N. Wenn unser Anführer uns schon nicht beschützt, vielleicht können es andere tun - so wie Ihr.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9864, 'deDE', 'Ich habe Geschichten über unser Volk gehört. Sie sagen, dass wir einst Krieger waren...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9865, 'deDE', '<Saurfang dreht sich zu Euch um.>$B$BRieche ich da etwa Blut? Ich bedauere es sehr, dass ich Euch nicht helfen konnte. Wie stolz Ihr auf Euch sein müsst. Meine Brust hebt sich allein von dem Wissen, was Ihr getan habt.$B$BGibt es noch mehr wie Euch? Gibt es noch mehr Helden dort, wo Ihr herkommt?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9866, 'deDE', '<Scharfseher Corhuk starrt gedankenverloren auf den Boden. Er nickt zustimmend.>$B$B<Scharfseher Corhuk wischt sich eine Träne aus dem Gesicht.>$B$BDer Sohn ist der Vater... Mögen die Geister gnädig zu denen sein, die ihm im Weg stehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9867, 'deDE', 'Das ist also das Gesicht unseres Feindes? Ich werde den Kopf aufspießen lassen und außerhalb von Garadar aufstellen. Sollten sie je wagen, uns nochmals anzugreifen, werden sie den Folgen ihres Handelns in die Augen sehen müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9868, 'deDE', 'Was macht das schon? Die Großmutter liegt im Sterben. Das Leben ist nicht lebenswert...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9869, 'deDE', 'Ah, danke für diese Nachricht. Hättet ihr vielleicht etwas dagegen, dem Irdenen Ring zu helfen? Die Elemente sind sehr aufgewühlt, wir können alle Hilfe, die wir bekommen können, brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9870, 'deDE', 'Ah, danke für diese Nachricht. Hättet ihr vielleicht etwas dagegen, dem Irdenen Ring zu helfen? Die Elemente sind sehr aufgewühlt, wir können alle Hilfe, die wir bekommen können, brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9871, 'deDE', '<Arechron schlägt mit der einen Hand in die andere.>$B$BOrtor... Dieser verräterische Dreckskerl!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9872, 'deDE', '<Garrosh zerknüllt die Karte und wirft sie ins Feuer.>$B$BWas soll ich damit? Sie greifen uns schon seit Wochen an. Das ist nichts neues.$B$BVersteht Ihr nicht? Wir sind geliefert... Großmutter Geyah liegt im Sterben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9873, 'deDE', 'Tausend tote Orcs sagt Ihr? Was könnte wohl der Auslöser für solch ein unverfrorenes Vordringen in Orcgebiet sein? Es ist gut, dass er tot ist, aber da steckt mehr dahinter, als ein Tentakel fühlen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9874, 'deDE', '<Otonbu seufzt.>$B$BDas macht uns jegliche Hoffnung auf Frieden mit den Orcs für weitere zehn Jahre zunichte. Zumindest werden wir diese zehn Jahre noch erleben, was wir vielleicht nicht hätten, wenn die Leichen im See verrottet wären.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9875, 'deDE', 'Eine neue Gattung! Seid Ihr sicher?$B$B<Lauranna blättert die Notizen und Diagramme durch.>$B$BToll gemacht, $N. Wir werden sie unserer Liste hinzufügen. Was haltet Ihr von \"Violettblättriges $Nium\"? Ich finde, das ist ein klangvoller Name.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9876, 'deDE', 'Cenarius sein Dank, dass Ihr hier seid. Wegen meiner Verletzungen konnte ich nicht nach draußen zurück, um Hilfe zu holen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9877, 'deDE', 'Janeda schickt Euch, um die Gefangenen der Todesfestung zu retten? Sie muss eine hohe Meinung von Euch haben, $N.', 18019);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9878, 'deDE', 'Ich glaube kaum, dass die Orcs verstehen oder zu schätzen wissen, was Ihr da getan habt, aber Eure Tat war gut für Nagrand. Vielen Dank, Problemlöser...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9879, 'deDE', 'Ja, ich weiß von dem Totem... aber es gehört noch viel mehr zu dieser Geschichte. Ich darf Euch jedoch nichts darüber erzählen. Nur Auserwählte haben Zugang zu solchem Wissen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9882, 'deDE', 'Ich bin beeindruckt. Die meisten sind in ausgezeichnetem Zustand.$B$BIch werde bei unserem Volk ein gutes Wort für Euch einlegen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9883, 'deDE', 'Bringt mir ruhig weiter Kristalle, $N. Wir können nicht zulassen, dass diese Diebe unser Eigentum stehlen.$B$BAuch wenn es eigentlich noch gar nicht unseres ist. Theoretisch natürlich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9884, 'deDE', 'Das Konsortium ist dafür bekannt, dass es sich gut um seine Freunde kümmert. Zu Beginn jeden Monats werde ich Euch ein paar Edelsteine als Bezahlung für Eure Dienste geben.$B$BDie Qualität der Steine hängt davon ab, wie treu ergeben Ihr uns wart. Lasst uns also hoffen, dass Ihr das Richtige tut und bei uns bleibt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9885, 'deDE', 'Schön Euch wiederzusehen, $N. Ich habe Eure Edelsteine für diesen Monat fertig.$B$BIch habe Euch ein paar mehr dazugetan, damit Ihr wisst wie froh wir sind, Euch bei uns zu haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9886, 'deDE', 'Das Konsortium ist dafür bekannt, dass es sich gut um seine Freunde kümmert. Zu Beginn jeden Monats werde ich Euch ein paar Edelsteine als Bezahlung für Eure Dienste geben.$B$BDie Qualität der Steine hängt davon ab, wie treu ergeben Ihr uns wart. Lasst uns also hoffen, dass Ihr das Richtige tut und bei uns bleibt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9887, 'deDE', 'Das Konsortium ist dafür bekannt, dass es sich gut um seine Freunde kümmert. Zu Beginn jeden Monats werde ich Euch ein paar Edelsteine als Bezahlung für Eure Dienste geben.$B$BDie Qualität der Steine hängt davon ab, wie treu ergeben Ihr uns wart. Lasst uns also hoffen, dass Ihr das Richtige tut und bei uns bleibt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9888, 'deDE', '<Kilrath flüstert.>$B$BDiese Oger sind extrem sonderbar. Und auch extrem dumm. Schaut nur, wie der fette den, äh, weniger fetten zum Tanzen zwingt. Es ist faszinierend.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9889, 'deDE', 'Lasst mich leben und ich sage Euch alles, was Ihr wissen wollt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9890, 'deDE', 'Ganz ruhig, $N. Ich bin nur ein kleiner $C. Ich habe keine Ahnung, was ich mit solch einer Information anfangen soll.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9891, 'deDE', 'Sie denken also, dass sie uns Orcs nach Lust und Laune vertreiben und abschlachten können, was? Ich bin mir sicher, dass das nichts damit zu tun hat, dass unser Anführer ein unfähiger Jammerlappen ist... Wenn er doch nur einen Bruchteil der Leidenschaft seines Vaters geerbt hätte...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9892, 'deDE', 'Wir werden gut an diesen Perlen verdienen, $N. Ich werde Khoraazi ganz sicher von Eurer Arbeit hier erzählen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9893, 'deDE', 'Ausgezeichnet. Das wird uns über Wasser halten bis die Sha\'tar fertig sind mit was immer sie auch im Oshu\'gun tun mögen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9894, 'deDE', 'Ihr habt meinen Dank, $N, und den der Behüter. Sie werden sich freuen zu hören, dass sie ihre Arbeit im Süden nun ohne Angst vor weiteren Angriffen fortsetzen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9895, 'deDE', 'Jetzt, da Ihr die Anzeichen der Unausgeglichenheit mit eigenen Augen gesehen habt, achtet bei Euren weiteren Reisen darauf.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9896, 'deDE', 'Ich kann Euch gar nicht genug danken, Kumpel. Ich werde es genießen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9897, 'deDE', 'Nun, ich konnte nicht wissen, ob Ihr Kristen helfen konntet oder nicht. Aber wenn sie Euch eines ihrer Bündel mit Tierhäuten gegeben hat, müsst Ihr wohl in Ordnung sein.$B$BHier ist Eure Belohnung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9898, 'deDE', 'Fantastisch! Ich werde nie vergessen, dass Ihr mir geholfen habt, ihr Herz zu gewinnen. Ihr sollt der Ehrengast auf unserer Hochzeit sein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9899, 'deDE', 'Wenigstens einer hier erfüllt seine Pflicht. Vielen Dank, dass Ihr Euch um diese Angelegenheit gekümmert habt, $N. Ich muss einmal mit Zurai über Reavij sprechen. Seine Tagträumereien müssen langsam ein Ende haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9900, 'deDE', 'Dank Euch müssen wir uns nun nicht mehr vor Gava\'xi fürchten. Wollen wir uns nun um eure Belohnung kümmern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9901, 'deDE', 'Gut gemacht, $N. Ich glaube, wir beide lassen ein ganzes Team von Ausgrabungsleitern neben uns blass aussehen. Wenn ich zurück in Eisenschmiede bin, werde ich mir meine Einsatzorte sicher selbst aussuchen dürfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9902, 'deDE', 'Habt Dank, $N. Vielleicht werden diese Marschen mit der Hilfe der Draenei eines Tages frei von Naga sein. Ich kann mir gar nicht vorstellen, wie schlimm es sein muss, ihnen dienen zu müssen.$B$BEr spricht nicht oft darüber, aber Maktu war einst ihr Sklave.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9903, 'deDE', 'Ich bin mir sicher, der alte Knabe hat das Ende seiner Tage schon vorausgesehen. Bei all diesen Neuankömmlingen musste die alte Rangfolge sich einfach ändern. Es ist nur recht, dass sein Geist nun zu Ruhe kommen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9904, 'deDE', 'Endlich! Wahrscheinlich hat jeder Angler eine Geschichte über \"den, der mir entkommen ist\". Aber ich habe noch keinen Fisch getroffen, den man nicht auf die eine oder andere Art bezwingen konnte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9905, 'deDE', '<Maktu nickt anerkennend.>$B$BMaktu ist dankbar für Eure Hilfe. Maktus Stolz ist befriedigt. Er wird nicht mehr so unvorsichtig sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9906, 'deDE', 'Unser Auftrag ist noch nicht zu Ende. Es gibt noch andere, die einer Lektion bedürfen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9907, 'deDE', 'Wenn dies das Blut in ihren Adern nicht zum Gefrieren bringt, dann wird es nichts schaffen. Ihr habt den Mag\'har zu Gerechtigkeit verholfen, $N. Und für Gerechtigkeit zahlen die Mag\'har gut.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9910, 'deDE', 'Vielleicht wollt Ihr noch eine andere Aufgabe? Eine etwas heiklere?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9911, 'deDE', 'Seid Ihr sicher, dass es echt ist? Ich meine, ich wusste schon, dass es riesige Kreaturen in den Marschen gibt, aber es gibt einen Unterschied zwischen riesigen Kreaturen und RIESIGEN Kreaturen.$B$BDa fällt mir ein, dass die Sporlinge einmal etwas von einem furchterregenden Netherrochen erzählt haben, der sie vor den Angriffen der Sumpflords bedroht hatte.$B$BWas ist, wenn diese Geschichten wahr sind? Oh je. Ich hebe das hier mal lieber auf. Die Expedition wird sicher davon erfahren wollen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9912, 'deDE', 'Willkommen in der Zuflucht des Cenarius, $N. Ich hoffe, Ihr könnt uns bei unserer Aufgabe behilflich sein. Wir haben viel Arbeit vor uns.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9913, 'deDE', 'Seid Ihr bereit für ein wenig Arbeit, $R? Ich habe die perfekte Aufgabe für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9914, 'deDE', 'Ich habe keine Sekunde an Euch gezweifelt, mein Freund. Die meisten hiervon sehen gut aus. Ein bisschen dreckig und verkratzt vielleicht. Aber ich denke, sie sind den Preis, den wir vereinbart hatten, wert.$B$BIch hoffe, das wir auch in Zukunft ins Geschäft kommen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9915, 'deDE', 'Ausgezeichnet, noch mehr hochwertige Stoßzähne. Auch wenn ein paar davon etwas schäbig aussehen.$B$BIhr habt den Dank des Konsortiums, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9916, 'deDE', 'Die meisten unserer Besitztümer wurden bei Angriffen zerstört oder gestohlen. Ich kann euch nicht viel bieten, aber hier sind ein paar Dinge, die Ihr vielleicht als nützlich empfinden könntet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9917, 'deDE', '<Bintook liest die Pläne.>$B$BBEIM LICHT! Diese Handschrift ist grauenvoll! So wie ich das sehe, planen sie \"die blauen Häute zu essen und ihr Dorf einzunehmen\" oder einen Blaubeerkuchen zu backen. Es könnte wirklich beides heißen. Wir müssen der Sache auf den Grund gehen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9918, 'deDE', 'Oh je, das war nur eine kleine Jagdgesellschaft? Ihr müsst Mo\'mor erzählen, was Ihr herausgefunden habt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9919, 'deDE', 'Ihr habt uns geholfen, die nächste Generation Sporlinge zu sichern, $R. Das können wir Euch nur mit einem Willkommen in unserer Stadt vergelten. Bleibt doch ein wenig und lernt die anderen Sporlinge kennen. Sie werden viele Fragen an Euch haben, ich hoffe, das macht Euch nichts aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9920, 'deDE', '<Mo\'mor schaut verdutzt drein.>$B$BEin neuer Ogerstamm drängt die Felsfäuste immer weiter nach Süden? Das klingt beunruhigend. Wir müssen mit der Situation in der Nähe unseres Zuhauses fertigwerden...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9921, 'deDE', 'Ausgezeichnet. Konntet Ihr diesen Lantresor, der in dem Brief dieses Dummkopfs erwähnt wurde, ausfindig machen?$B$BEgal, wir müssen weitermachen. Ich habe Berichte über weitere Ogeraktivitäten erhalten, um die sich sofort jemand kümmern muss!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9922, 'deDE', 'Ausgezeichnete Arbeit! Ich stelle im Augenblick Nachforschungen über den Totschlägerstamm an, den der Leutnant der Felsfäuste erwähnt hat. Jetzt müssen die Aufgaben, die Ihr erledigt habt, getestet werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9923, 'deDE', 'Es tut mir wirklich sehr leid, $R. Er gerät immer in Schwierigkeiten. Manchmal wünschte ich, ich könnte ihn anleinen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9924, 'deDE', 'Ich bin Euch so dankbar, $N. Seine Mutter wird sich in Zukunft um ihn kümmern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9925, 'deDE', 'Ihr zaubert ein Lächeln auf mein Gesicht, $N. Zumindest würdet Ihr das, wenn ich noch ein Gesicht hätte.$B$BWenn Ihr so weiter macht werden wir noch beste Freunde.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9927, 'deDE', 'Könnt Ihr Euch vorstellen, wie verwirrt sie darüber sein werden, $R? Das wird wundervoll.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9928, 'deDE', 'Ausgezeichnet! Unser nächstes Ziel sind die Ruinen des Lachenden Schädels.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9931, 'deDE', 'Der Plan ist perfekt, $N. Ich sehe jetzt schon die Früchte unserer Arbeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9932, 'deDE', 'Ich muss zugeben, dass ich mich seit Jahrzehnten nicht mehr so lebendig gefühlt habe. Ihr habt gute Arbeit geleistet, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9933, 'deDE', 'Bitte, $N, nehmt Euch von diesem Friedensangebot was immer Ihr möchtet. Schließlich wäre dies ohne Eure Hilfe niemals möglich gewesen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9934, 'deDE', '<Garrosh tritt die Kiste um.>$B$BIhr verschwendet Eure Zeit, $R. Nehmt Euch aus der Kiste was immer Ihr wollt. Weder ich noch Garadar haben für diesen unnützen Tand Verwendung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9935, 'deDE', 'Die Alte ist tot! Das sind wundervolle Nachrichten, $N. Hier ist Eure Belohnung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9936, 'deDE', 'Die Alte ist tot! Das sind wundervolle Nachrichten, $N. Hier ist Eure Belohnung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9937, 'deDE', 'Durns tödlicher Griff wurde gelöst! Nagrand schaut Dank Euch auf eine bessere Zukunft, Held. Gut gemacht!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9938, 'deDE', 'Durns tödlicher Griff wurde gelöst! Nagrand schaut Dank Euch auf eine bessere Zukunft, Held. Gut gemacht!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9939, 'deDE', 'Dies ist ein großer Sieg für die Bewohner von Garadar! Gut gemacht, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9940, 'deDE', 'Dies ist ein großer Sieg für die Bewohner von Telaar! Gut gemacht, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9944, 'deDE', 'Dreißig Orcs, $R! Von diesen dreißig sind nur noch Ungriz und ich übrig. Wir haben den jungen Orc, Saurfang, halb tot in der Nähe von Sonnenwind gefunden. Offensichtlich ist er aus einem anderen Grund hier...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9945, 'deDE', 'Das ist ein guter Anfang, aber ihr Anführer muss getötet werden, damit Eure Taten auch langfristige Erfolge erzielen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9946, 'deDE', 'Diesen Kopf stellen wir an dem Toren von Garadar auf, damit alle ihn sehen können. Die Oger werden es sich zweimal überlegen, bevor sie heilige Rituale der Mag\'har stören.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9948, 'deDE', 'Ihr habt geschafft, was keiner für möglich hielt und unsere vermissten Brüder und Schwestern zurückgebracht. Für die Mag\'har seid Ihr ein Held, $N. Alle werden Euren Namen kennen und wissen, was Ihr für uns getan habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9951, 'deDE', 'Es ist besser so. Wenn es keine zivilisierte Einladung annehmen kann, dann ist es das auch nicht wert.$B$B<Aufseher Baumlas schaut Euch kurz verwirrt an.>$B$BWer seid Ihr und was wollt Ihr hier? Ihr müsst von hier verschwinden, bevor es zu spät ist!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9954, 'deDE', 'Diesmal haben sie mich gut eingesperrt, $N. Der König der Totschläger, Cho\'war, hat den Schlüssel.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9955, 'deDE', 'Danke, $N. Ich habe Corki zu den Nachtelfen im Schergrat geschickt. Hoffentlich gelingt es ihnen, ihn vom Ärger fern zu halten.$B$BWegen der Belohnung...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9956, 'deDE', 'Erstaunlich! Wie habt Ihr es geschafft, all das alleine zurückzutragen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9957, 'deDE', 'Ich bin froh, dass die Zuflucht Euch geschickt hat. Die Druiden des Dickichts wurden ermordet! Nur ich und ein weiterer haben überlebt, und er ist geisteskrank.$B$BIch weiß nicht, was passiert ist, aber ich bin entschlossen, es herauszufinden. Was auch immer es war, es passierte schnell und fühlt sich unnatürlich an.$B$BWerdet Ihr mir helfen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9960, 'deDE', 'Ich bin froh, dass die Steinbrecherfeste Euch geschickt hat. Die Druiden des Dickichts wurden ermordet! Nur ich und ein weiterer haben überlebt, und er ist geisteskrank.$B$BIch weiß nicht, was passiert ist, aber ich bin entschlossen, es herauszufinden. Was auch immer es war, es passierte schnell und fühlt sich unnatürlich an.$B$BWerdet Ihr mir helfen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9961, 'deDE', 'Ich bin froh, dass Allerias Feste Euch geschickt hat. Die Druiden des Dickichts wurden ermordet! Nur ich und ein weiterer haben überlebt, und er ist geisteskrank.$B$BIch weiß nicht, was passiert ist, aber ich bin entschlossen, es herauszufinden. Was auch immer es war, es passierte schnell und fühlt sich unnatürlich an.$B$BWerdet Ihr mir helfen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9962, 'deDE', 'Hm, nicht schlecht. Gar nicht schlecht... Ihr habt Potenzial, Kleiner. Hier habt Ihr etwas Gold für Eure Taschen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9967, 'deDE', 'Ich gebe zu, dass ich nicht geglaubt habe, dass Ihr eine Chance hättet, $N! Das war beeindruckend! Wie wär\'s mit einem weiteren Kampf? Gurgthock hat den perfekten Gegner für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9968, 'deDE', 'Merkwürdig. Die Proben der bösartigen Teromotten enthalten etwas, das sich wie reines Mana anfühlt.$B$BWie es scheint hinterließ das, was all die Tode verursacht hat, ein starkes Energiefeld. Aber aus irgendeinem Grund hat es die Teromotten nicht umgebracht, sondern nur aufgewühlt.$B$BEs scheint, als wäre diese merkwürdige Energie ein Nebenprodukt dessen, was das Dickicht angegriffen hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9970, 'deDE', 'Ihr habt die Oger zum Schwitzen gebracht, Kleiner. Diesmal bekommt Ihr noch etwas dazu. Benutzt nicht alles auf einmal!$B$BSeid Ihr bereit für einen weiteren Kampf? Gurgthock setzt die ganze Bank auf Euch!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9971, 'deDE', 'Ich hatte also Recht. Die Leiche eines Zerschlagenen? Und Ihr sagt, dass da tatsächlich ein komisches Objekt auf dem Boden neben ihm war?$B$BDas macht keinen Sinn. Was würde einer von ihnen denn hier wollen? Und was war das für ein Ding, das er dabei hatte?$B$BHat es vielleicht all die Tode verursacht?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9972, 'deDE', 'KLEINER! KLEINER IHR HABT ES GESCHAFFT! Als nächstes kommt der große Kampf! Die Meisterschaft!$B$BOk, locker bleiben. Wir wollen ja nicht, dass die Oger erfahren, dass hier was im Busch ist. Schließlich bekomme ich ja auch meinen Anteil daran.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9973, 'deDE', 'Oh je, Mogor hat sein Kampfrecht als Held der Totschläger eingefordert. Ihr müsst gegen ihn kämpfen!$B$BNiemand hat je behauptet, dass die Totschläger gute Verlierer... äh... Oger wären.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9977, 'deDE', 'Gurthock hat doch gesagt, dass es sich bezahlt machen wird, Kleiner. Sucht Euch was aus!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9978, 'deDE', 'Gut, gut... Ich sage Euch, was ich weiß, aber viel ist das nicht!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9979, 'deDE', 'Ja? Wie kann ich Euch diesmal helfen, $R?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9982, 'deDE', 'Überrascht Euch mein Aussehen? Wisst Ihr, was ich bin?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9983, 'deDE', 'Überrascht Euch mein Aussehen? Wisst Ihr, was ich bin?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9986, 'deDE', 'Gut gemacht, $N. Wir haben schon genug Sorgen, wir können uns nicht erlauben, dass die Arakkoa unsere Händler und Boten erneut angreifen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9987, 'deDE', 'Gut gemacht, $N. Wir haben schon genug Sorgen, wir können uns nicht erlauben, dass die Arakkoa unsere Händler und Boten erneut angreifen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9990, 'deDE', 'Astrale? Waren nach Tuurem? Fremdartige Bauteile? Und ein Blutelf, der den letzten Kasten zum Posten der Feuerschwingen bringen wollte?$B$BWas soll das alles bedeuten?! Was hat das mit dem Schicksal der Druiden im Cenariusdickicht zu tun?$B$BIch glaube, wir sollten einmal einen Blick in den Kasten werfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9991, 'deDE', 'Ausgezeichnete Arbeit, $N! Jetzt haben wir einen Ausgangspunkt um unseren Gegenangriff zu planen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9992, 'deDE', 'Vielen Dank für diese Samenkörner. Ich habe schon fast genügend zusammen, um eine erste Ladung zurückzuschicken!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9993, 'deDE', 'Das ist ein guter Anfang, aber wir werden noch mehr davon brauchen, wenn wir eine angemessene Menge Öl herstellen wollen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9994, 'deDE', 'Oh nein! Das sind furchtbare Nachrichten! Ich kann nicht glauben, dass alle bis auf zwei unserer Cenariusfreunde tot sind!$B$BIn Ordnung, lasst mich die Teile einmal anschauen. Ich hoffe nur, dass sie nicht das sind, was ich vermute.$B$BJa, wie ich befürchtet habe. Ich glaube, das sind Bombenteile. Unsere Augen und Ohren in Shattrath haben uns informiert, dass einige Astrale verbotene Waren aus anderen Dimensionen, mit denen sie in Kontakt stehen, einführen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9995, 'deDE', 'Oh nein! Das sind furchtbare Nachrichten! Ich kann nicht glauben, dass alle bis auf zwei unserer Cenariusfreunde tot sind!$B$BIn Ordnung, lasst mich die Teile einmal anschauen. Ich hoffe nur, dass sie nicht das sind, was ich vermute.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9996, 'deDE', 'Das ist ein guter Anfang, aber nach dem, was Ihr auf dem Hof beobachtet habt und was mir meine Agenten berichten, haben wir weitaus dringendere Dinge zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9997, 'deDE', 'Das ist ein guter Anfang, aber nach dem, was Ihr auf dem Hof beobachtet habt und was mir meine Agenten berichten, haben wir weitaus dringendere Dinge zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9998, 'deDE', '<Die Hochelfe nickt.>$B$BEs ist ein guter Anfang, aber Bertelm hatte Recht, Euch zu mir zu schicken. Ich habe eine Entdeckung gemacht, die die Anwesenheit der Höllenorcs hier erklären könnte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (9999, 'deDE', 'Wie ich es mir dachte. Es gibt keinen normalen Weg, Teufelsstahl zu zerstören. Es ist aber noch nicht alles verloren...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10000, 'deDE', 'Um die Höllenorcs aufzuhalten müssen wir schon mehr tun, als ihre Arbeiter zu töten. Ich habe eine Entdeckung gemacht, die vielleicht erklären kann, warum sie hier sind, und die mich in meiner Überzeugung bestätigt, dass wir schnell handeln müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10001, 'deDE', 'Mein Bekannter kennt hoffentlich einen Weg, die Lager zu zerstören. Er war schließlich mal ein Ingenieur der Legion...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10002, 'deDE', '<Theloria nickt Euch zu.>$B$BGut gemacht. Dadurch haben wir uns ein wenig Zeit verschafft. Die Blutelfen werden sich fragen, was ihrer Freundin zugestoßen ist. Hoffentlich wissen wir bis dahin mehr über ihre Pläne.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10003, 'deDE', '<Kaide nickt Euch zu.>$B$BGut gemacht. Dadurch haben wir uns ein wenig Zeit verschafft. Die Blutelfen werden sich fragen, was ihrer Freundin zugestoßen ist. Hoffentlich wissen wir bis dahin mehr über ihre Pläne.$B$BWenn die Zeit gekommen ist, werde ich Rokag von unseren Fortschritten berichten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10004, 'deDE', 'Beruhigt Euch, Schätzchen, Sal\'salabim wird helfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10005, 'deDE', 'Eine Bombe aus reinem Mana, die ganze Städte auslöschen kann! Aber warum? Warum würden die Blutelfen so etwas bauen und gegen uns verwenden? Das Cenariusdickicht sollte ein Ort des Friedens und der Erholung sein.$B$BWas auch immer der Grund sein mag, ich bin sicher, dass Aufseher Baumlas ihn kennt, doch ich habe keine Ahnung, wie ich ihn heilen kann. Vielleicht heilt sein Geist mit der Zeit von alleine?$B$BWie auch immer, ich danke Euch für Eure Hilfe. Ich kann nur hoffen, dass diese Tragödie sich niemals wiederholen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10006, 'deDE', 'Eine Bombe aus reinem Mana, die ganze Städte auslöschen kann! Aber warum? Warum würden die Blutelfen so etwas bauen und gegen uns verwenden? Das Cenariusdickicht sollte ein Ort des Friedens und der Erholung sein.$B$BWas auch immer der Grund sein mag, ich bin sicher, dass Aufseher Baumlas ihn kennt, doch ich habe keine Ahnung, wie ich ihn heilen kann. Vielleicht heilt sein Geist mit der Zeit von alleine?$B$BWie auch immer, ich danke Euch für Eure Hilfe. Ich kann nur hoffen, dass diese Tragödie sich niemals wiederholen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10007, 'deDE', 'Langsam sehen die Dinge besser aus. Wenn wir die Höllenorcs daran hindern können, ihre Kumpel hier zu unterstützen, können wir den Posten unter Kontrolle halten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10008, 'deDE', 'Ich weiß, dass Ihr schon weit gereist seid, $N, aber manche Geschichten sollten das Land niemals verlassen, haben wir uns verstanden?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10009, 'deDE', 'Nun, Geschäft sein Geschäft, aber wenn Sal\'salabim Euch sagen, Ihr nicht böse werden, ja?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10010, 'deDE', 'Natürlich! Wir werden sie mit ihren eigenen Waffen schlagen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10011, 'deDE', 'Wir haben gesiegt! Das Vorrücken der Legion wurde gebremst!$B$BIch biete Euch eine Auswahl an Belohnungen für Eure heldenhaften Taten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10012, 'deDE', '<Bertelm nimmt die Pläne und schaut sie an.>$B$BWenn Ihr mir diese Pläne nicht gebracht hättet, hätte ich behauptet, dass Ihr irre seid, aber hier steht es ganz deutlich. Die Höllenorcs sind nicht nur hier, um den Blutelfen zu dienen, sie haben sogar den Auftrag, uns abzulenken.$B$BDiese Pläne werfen mehr Fragen auf, als sie beantworten, aber nun können wir uns besser vorstellen, womit wir es hier zu tun haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10013, 'deDE', '<Rokag nimmt die Pläne und schaut sie an.>$B$BKaide hatte also Recht! Diese Höllenorcs führen etwas im Schilde. Ich hätte jedoch nie gedacht, dass sie mit den Blutelfen zusammenarbeiten.$B$BLaut diesen Plänen sollen die Höllenorcs uns beschäftigen... aber warum? Das sind beunruhigende Nachrichten, $N. Gut, dass Ihr mir die Pläne gleich gebracht habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10016, 'deDE', 'Ah, gut gemacht, Freund. Sie sind noch feiner, als ich gedacht habe. Sie werden sicher einen schönen Umhang abgeben.$B$B<Bertelm schaut zum Gasthaus hinüber.>$B$BJa, das wird ein schöner Umhang.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10018, 'deDE', 'Die Pelze sind perfekt, $N! Ich hätte keine besseren bekommen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10020, 'deDE', 'Vielen Dank, $N. Sich um die Notleidenden zu kümmern ist eine schwierige Aufgabe, aber sie wird auf ihre ganz eigene Weise belohnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10021, 'deDE', 'Ihr habt meinen Dank, $N. Wir sind die Hüter des Lichts und können unsere Pflichten nicht vernachlässigen. Nicht einmal in den schwersten Zeiten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10022, 'deDE', 'Ich verneige mich vor Eurem Geschick, $N. Ihr habt Euch als herausragender $C bewiesen.$B$BIch werde Eure Hilfe bei der Herstellung dieses Umhangs nie vergessen. Er ist ein einzigartiges Gewand, das ich voller Stolz tragen werde.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10023, 'deDE', 'Der Pelz ist noch vortrefflicher, als ich erhofft hatte! Das ist ein gutes Zeichen, $N, und die Geister werden Euch wegen Eurem Beitrag zu dieser Zeremonie wohlgesinnt sein.$B$BIch habe Euch aus dem übrigen Pelz einen Helm gemacht, $N. Er zeichnet Euch als mächtigen Jäger und Verbündeter des großen Wolfgeists der Wälder von Terokkar aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10024, 'deDE', 'Sie sind in tadellosem Zustand, $N. Macht weiter so, und die Seher werden bald zu Euren Freunden zählen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10025, 'deDE', 'Ich danke Euch, $N. Voren\'thals Visionen können vielleicht eines Tages das Schicksal unseres Volks entscheiden. Wir tun gut daran, dafür zu sorgen, dass seine Visionen so klar wie möglich sind.$B$B<Diese Quest kann wiederholt werden, bis Ihr den Ruf \'Neutral\' erlangt habt.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10026, 'deDE', '<Andarl wischt sich die Stirn mit dem Ärmel seiner Robe ab.>$B$BZum Glück. Ich habe schon befürchtet, dass die Biester die restlichen Waldbewohner vertrieben haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10027, 'deDE', 'Keb\'ezil ist sehr erleichtert, dass Ihr Euch um das kleine Problem gekümmert habt, nicht wahr Keb?$B$B<Der Wichtel ignoriert seinen Meister und scheint beleidigt zu sein.>$B$BIhr müsst ihm seine schlechten Manieren nachsehen. Ihr wisst ja, wie Dämonen sind...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10028, 'deDE', 'Ich hoffe, dass dies nicht die einzigen Gefäße in der Stadt sind. Es ist ein guter Anfang, aber ich schätze, wir werden noch viel mehr davon brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10030, 'deDE', 'Super, genau das, was ich brauche... noch mehr Knochen.$B$B<Ramdor seufzt.>$B$BJa, ja, ich werde mich darum kümmern, dass die Gebeine dieser ehrenwerten Vorfahren ein anständiges Begräbnis bekommen, keine Sorge.$B$BWenn Ihr den Toten wirklich helfen wollt, habe ich noch eine andere Aufgabe für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10031, 'deDE', 'Ihr habt getan, was nötig war. Auch wenn es mich traurig macht, dass die Geister meiner Vorfahren zu schrecklichen Untoten verwandelt wurden, hat Euer Handeln sie endlich zur Ruhe gebracht.$B$BVielen Dank, dass Ihr sie befreit habt, $N. Bitte nehmt dieses bescheidene Zeichen meiner Hochachtung für Euch und Eure Selbstlosigkeit an.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10033, 'deDE', 'Ja, ich bin mir sicher, dass Ihr all die Knochenpeitscher getötet habt. Ist ja auch klar, weil der Hauptmann auf dem Anschlag einen Beweis gefordert hat.$B$B<Taela schaut Euch sarkastisch an.>$B$BIch nehme Euch beim Wort. Ich bin mir nicht sicher, wen ich so geärgert habe, dass ich zu diesem Dienst verdonnert wurde, aber vielen Dank für Eure Mühe für die Allianz. Hier habt Ihr eine Entschädigung für Euren Aufwand.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10034, 'deDE', 'Ihr müsst viele von diesen Knochenpeitschern getötet haben! Gut, ich hasse sie! Seit mich einer von ihnen gebissen hat, habe ich dauernd Ohnmachtsanfälle.$B$BWisst Ihr, wie peinlich das ist? Hier, nehmt dies als Dank, dass Ihr meine Rache vollstreckt habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10035, 'deDE', 'Ich bin beeindruckt, $C. Torgos war eines der hartgesottensten Wesen, das ich auf dieser Seite von Nagrand kenne.$B$BNun, ich denke, Ihr habt Euch etwas aus dem Schatz von Allerias Feste verdient. Sucht Euch etwas aus!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10036, 'deDE', 'Ich danke Euch, $N. Ihr habt meine Rache ausgeübt, und wie versprochen werde ich Euch belohnen.$B$BSucht Euch hiervon etwas aus und benutzt es weise!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10037, 'deDE', 'Danke! Ich kann mich nicht erinnern, wann ich das letzte Mal Aal gegessen habe.$B$BWie soll ich sie bloß kochen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10038, 'deDE', 'Es wird auch langsam Zeit, dass Ihr kommt. Ich habe diesen Bericht schon vor über einer Woche zur Allerias Feste geschickt!$B$BBürokratie!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10039, 'deDE', 'Es wird auch langsam Zeit, dass Ihr kommt. Ich habe diesen Bericht schon vor über einer Woche zur Steinbrecherfeste geschickt!$B$BBlutelfen und ihre Bürokratie!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10040, 'deDE', 'Gut, Ihr seid endlich zurück! Was habt Ihr herausgefunden? Wer sind sie?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10041, 'deDE', 'Gut, Ihr seid endlich zurück! Was habt Ihr herausgefunden? Wer sind sie?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10042, 'deDE', 'Das sind schlechte Nachrichten! Aber ich habe die richtige Wahl getroffen, als ich Euch geschickt habe, um Wöch zu helfen. Das Letzte, was wir brauchen können, ist, dass der Schattenrat einen starken Posten genau vor unserer Haustür errichtet.$B$B$N, als Anerkennung für Eure Taten in Grangol\'var erlaube ich Euch hiermit, Euch eine dieser wundervollen Belohnungen auszusuchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10043, 'deDE', 'Das sind schlechte Nachrichten! Aber ich habe die richtige Wahl getroffen, als ich Euch geschickt habe, um Neftis zu helfen. Das Letzte, was wir brauchen können, ist, dass der Schattenrat einen starken Posten genau vor unserer Haustür errichtet.$B$B$N, Ihr habt Euch etwas Nettes verdient. Sucht Euch etwas aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10044, 'deDE', 'Wir müssen zuerst Euren Geist erweitern, damit Ihr mit den Ahnen sprechen könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10045, 'deDE', 'Ihr seid sehr geschickt, $N. Unsere besten Kräutersammler hätten doppelt so lange gebraucht, um die Kräuter zu sammeln.$B$B$B$BHabt keine Angst.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10046, 'deDE', 'Willkommen in der Scherbenwelt, $N - willkommen im Alptraum! Auch wenn das erste Expeditionskorps es unbeschadet hierher geschafft hat, versucht die Legion nun, das Portal zurückzuerobern und unsere Verstärkung daran zu hindern, es zu durchschreiten.$B$BIch würde Euch gerne hier einsetzen, aber unsere Truppen und die Soldaten der Horde können die Kolonnen der Legion, die diese Plattform erobern wollen, selbst zurückhalten.$B$BIhr müsst dorthin gehen, wo Ihr am meisten gebraucht werdet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10047, 'deDE', 'Ihr habt meinen aufrichtigen Dank für Eure Mühen, $N. Wenn auch noch viel zu tun ist, macht es mich froh, dass einige nun ihren wohlverdienten Frieden gefunden haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10050, 'deDE', 'Die Söhne sind Euch für Eure Mühen dankbar, auch wenn nur wenige über das Rüstlager sprechen möchten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10051, 'deDE', 'Isla Sternenmähne ist gerade gegangen, aber sie hat mir einen vollständigen Bericht über die Vorkommnisse im Posten der Feuerschwingen gegeben. Verständlich, dass sie über die Geschehnisse beim Cenariusdickicht sehr bestürzt ist. Garstige Blutelfen!$B$BSie hat mir gesagt, dass Ihr die entscheidende Rolle bei ihrer Rettung gespielt habt, damit wir diese Informationen erhalten. Allerias Feste steht tief in Eurer Schuld.$B$BBitte, nehmt im Namen aller dieses Geschenk an.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10052, 'deDE', 'Isla Sternenmähne ist gerade gegangen, aber sie hat mir einen vollständigen Bericht über die Vorkommnisse im Posten der Feuerschwingen gegeben. Verständlich, dass sie über die Geschehnisse beim Cenariusdickicht sehr bestürzt ist.$B$BSie hat mir gesagt, dass Ihr die entscheidende Rolle bei ihrer Rettung gespielt habt, damit wir diese Informationen erhalten. Die Steinbrecherfeste steht tief in Eurer Schuld.$B$BBitte, nehmt im Namen aller dieses Geschenk an.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10055, 'deDE', 'Das hier ist in einem besseren Zustand, als ich befürchtet habe. Sicher, es wird eine Weile dauern bis der ganze Rost und Zunder entfernt ist, aber ich kann mich nicht beklagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10057, 'deDE', 'Wir können nur hoffen, dass die Geister der Fußsoldaten mit dem Verschwinden der Geister ihrer Offiziere zur Ruhe kommen. Ich danke Euch ein weiteres Mal für Eure Hilfe, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10058, 'deDE', 'Ist es das? Kaum zu glauben, dass es die Schlacht überlebt hat. Die Gegebenheiten in den Ruinen waren nicht gerade gut für das Buch, aber ich bin dennoch froh, dass ich es wiederhabe.$B$BEs ist das einzige Zeichen, das ich von Turalyon habe.$B$B<Vater Devidicus scheint mit den Tränen zu kämpfen.>$B$BWenn man so lange Zeit Seite an Seite gekämpft hat, steht man sich noch näher als die eigene Familie.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10063, 'deDE', 'Dachte ich\'s mir doch! Dieser mürrische alte Zwerg sollte mir eigentlich beim Transport meiner Ausrüstung und dem Sammeln von Daten helfen, aber stattdessen sitzt er nur in dem komischen Draeneidorf herum und betrinkt sich sinnlos.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10064, 'deDE', 'Ich habe gehofft, dass die Blutwacht uns Verstärkung schicken würde, sobald man dort weiß, mit wem wir es hier zu tun haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10065, 'deDE', 'Es sieht da draußen schon etwas besser aus, ich bin mir jedoch noch immer nicht sicher, ob es besser wäre, hier auf medizinische Versorgung zu warten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10066, 'deDE', 'Gut gemacht, $N. Ohne die Tücken der Greifer, wird es jetzt wesentlich einfacher sein, Verstärkung von der Blutwacht zu erhalten oder Angriffe gegen die Sonnenfalken zu starten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10067, 'deDE', 'Gut gemacht, $N. Es ist besonders wichtig, dass wir keine Möglichkeit außer Acht lassen, die den Sonnenfalken weiterhin ihre Existenz sichern könnte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10074, 'deDE', 'Wundervoll, $N. Das wird uns in unserem Kampf gegen den Abschaum der Allianz helfen, der sich hier in der Scherbenwelt breitgemacht hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10075, 'deDE', 'Ich danke Euch für Euren Beitrag, <Name>. Wenn Ihr noch mehr finden solltet, wisst Ihr, wo Ihr sie hinbringen könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10076, 'deDE', 'Wundervoll, $N. Das wird uns in unserem Kampf gegen den Abschaum der Horde helfen, der sich hier in der Scherbenwelt breitgemacht hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10077, 'deDE', 'Ich danke Euch für Euren Beitrag, <Name>. Wenn Ihr noch mehr finden solltet, wisst Ihr, wo Ihr sie hinbringen könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10078, 'deDE', 'Das nenne ich Einsatz!$B$BIch bin froh, dass wir endlich Unterstützung erhalten haben, aber ich bin nicht so sicher, ob sie die richtige Einstellung gegenüber der Horde haben. Dort, wo ich herkomme, ist jeder, der eine Waffe auf Euch richtet, ein Feind und muss vernichtet werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10079, 'deDE', 'Bei Bronzebarts bronzenem... Bart, Ihr habt es geschafft! Ihr seid ein Held, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10081, 'deDE', 'Der Trank, den Ihr zu Euch genommen habt, hat keine echte Wirkung. Ihr könnt einen Geist nur sehen, wenn er es zulässt. Der Trank ist nur ein Symbol Eures Glaubens und Eurer Hingabe. Es war ein Test. Und Ihr habt ihn bestanden...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10082, 'deDE', 'Es ergibt keinen Sinn. Sie erheben sich weiter. Es muss etwas Heimtückischeres dahinter stecken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10085, 'deDE', 'Das ist sehr beunruhigend. Ihr sagt, keiner der Ahnen war in seinem Dorf? Sie gehen alle nach Süden?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10086, 'deDE', 'Die Materialien sind ausgezeichnet! Vielleicht ein wenig verbogen oder angesengt, aber ich habe mich noch nie von minderwertigem Material aufhalten lassen, wenn es darum ging, Präzisionssprengstoff herzustellen!$B$BDanke, $N. Ihr habt wirklich ein Händchen exquisiten Müll!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10087, 'deDE', 'Dachte ich\'s mir doch! Ich konnte die Zerstörung von hier aus zwar nicht richtig sehen, aber ich kann sie mir redlich vorstellen! Ausgezeichnet!$B$BGut gemacht, $N. Das oberste Kommando von Thrallmar wird sich freuen, von Eurem Erfolg zu hören!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10091, 'deDE', 'To\'gun hat mir bereits seinen Bericht abgeliefert. Er hätte Euch unterstützen sollen!$B$BIch habe ihn zurückgeschickt, um Grik\'tha zu helfen. Ich finde, die beiden sind ein schönes Paar.$B$BDies sind also die Seeleninstrumente, mit denen der Schattenrat seine Beschwörungskraft erhöht? Ich finde, sie sehen gefährlich aus. Vielleicht können die Seher sie brauchen?$B$BHier, nehmt einen davon als Belohnung für Euren Kampf gegen den Schattenrat im Labyrinth.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10093, 'deDE', 'Ah, Ihr habt also Seher Kryv getroffen. Er ist ein weiser und begabter Mann, und seine Freunde sind auch meine Freunde.$B$BMacht es Euch gemütlich und stellt Euch den anderen vor, die diesen Tempel ihr Zuhause nennen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10094, 'deDE', 'Während Ihr den magiegeladenen Folianten öffnet, überkommt Euch ein Gefühl des Schreckens.$B$BIrgendetwas ist hier eindeutig falsch!$B$BIhr lest weiter, aber was Ihr lest scheint unglaublich zu sein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10095, 'deDE', 'Murmur ist fast ausgebrochen?! Sie haben das Biest zwei Jahre sicher im Inneren verwahrt... Ich frage mich, was sie wohl falsch gemacht haben, dass sie nach all der Zeit die Kontrolle darüber verlieren.$B$BWas auch immer es sein mag, Micp, Ihr habt uns alle gerettet! Mir wird schwindelig, wenn ich daran denke, was Shattrath und dem Rest der Scherbenwelt zugestoßen wäre, wenn das Ding sich hätte befreien können!.$B$BIch bin so froh, dass Ihr die Sache in die Hand genommen und die Bedrohung durch den Schattenrat in Auchindoun beseitigt habt. Wie können wir Euch je dafür belohnen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10096, 'deDE', 'Gut! Diese Marschenbiester haben kein Recht, das Zuhause der Sporloks zu überfallen!$B$BEs wäre besser, wenn diese Tiere lernen würden, in Harmonie zu leben, aber wenn das nicht geht, müssen wir uns eben um die Situation kümmern!$B$BHier, bitte nehmt etwas hiervon als Dank für Eure Hilfe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10097, 'deDE', 'Ich kann Euch nicht genug danken, $N. Zu wissen, dass Lakka frei ist, bedeutet, dass ich endlich all meine Bande zu den Sethekk abwerfen kann.$B$BEin Teil von mir wird mir Syths Tod niemals verzeihen, aber es musste getan werden. Ich werde die Todesriten für ihn vollziehen. Vielleicht kann sein Geist zur Ruhe kommen, wenn er für die Irreführung unseres Volkes gebüßt hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10098, 'deDE', 'Vielleicht wird mir meine Rolle bei den Verbrechen der Sethekk niemals vergeben werden, aber ich möchte versuchen, meine Sünden zu büßen, indem ich die Relikte von Terokk meinen Volk zurückgebe.$B$BVielen Dank für Eure Hilfe dabei, $N. Ihr habt keine Ahnung, welch großartige Tat Ihr heute geleistet habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10099, 'deDE', 'Ich bin froh, dass Ihr Euch um, um... wie sagtet Ihr hieß er noch gleich? Z\'kral?$B$BEurer Beschreibung nach war es wohl mehr ein es als ein er. Nun ja, was zählt ist, dass es tot ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10101, 'deDE', '<Eine sanfte, melodische Stimme erklingt in Eurem Kopf.> Ich bin K\'ure von den Naaru, $N. Ihr steht hier im Herzen meines alten Schiffs.$B$BOshu\'gun, wie die Orcs es genannt haben, ist das Schiff, mit dem die Draenei zuerst auf diese Welt gekommen sind. Obwohl wir schon vor hunderten von Jahren hier vom Himmel gefallen und abgestürzt sind, sind meine Energien immer noch in diesen Trümmern gefangen. Leider bin ich der Grund für die Schmerzen der Orcgeister.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10102, 'deDE', 'Es war weise von K\'ure, Euch hierherzuschicken. Wir können das Leiden der Orcahnen nicht lindern, doch es gibt einen, der es kann.$B$BEinen, der bald im Licht wiedergeboren wird...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10103, 'deDE', 'Um ehrlich zu sein hatte ich mehr Leute erwartet, aber Ihr müsst reichen. Willkommen im Sumpfrattenposten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10104, 'deDE', 'Ich fühle mich geschmeichelt, dass Euer Freund von den Zerschlagenen mich für einen Gelehrten für Relikte seines Volkes hält, aber um ehrlich zu sein habe ich seit meiner Ankunft nicht viel Gelegenheit gehabt, sie zu studieren. Das war sicherlich meine Absicht, aber als ich hier ankam musste ich feststellen, dass es andere Dinge gibt, um die ich mich dringend kümmern muss.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10105, 'deDE', 'Ich hatte gehofft, seine Leute würden den Außenposten früher fertigstellen, aber sein Geld kostet es ja schließlich nicht. Immerhin geht es voran.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10106, 'deDE', 'Gut gemacht, $N. Eure Taten auf dem Schlachtfeld sind für unseren Kampf auf der Höllenfeuerhalbinsel sehr hilfreich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10107, 'deDE', 'Wie also lautet Eure Entscheidung? Soll es Krieg geben, oder werdet Ihr mich unterstützen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10108, 'deDE', 'Wie also lautet Eure Entscheidung? Soll es Krieg geben, oder werdet Ihr mich unterstützen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10109, 'deDE', 'Ausgezeichnet! Nur ein paar kleine Einstellungen und dieses Ding ist so gut wie neu. Oh richtig, Euer Schlüssel! Bitte sehr.$B$BDer Spring-o-Mat hat übrigens noch ein paar Macken, die ich noch reparieren muss. Äh, seid einfach vorsichtig damit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10110, 'deDE', 'Gute Arbeit, $N. Ich konnte fast die Kampfschreie an den Befestigungsanlagen hören. Ich wünschte, ich wäre dabei gewesen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10111, 'deDE', 'Nun, es ist kein Ei... Aber Hühnchen mag ich auch! Ich beiße mich einfach durch diese riesige Klaue durch! Danke!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10112, 'deDE', 'Ja, ich glaube, es wird alles deutlicher.$B$BUnd ich glaube, dass Euer Eifer in dieser Angelegenheit mit mehr als nur den Informationen, die Ihr sucht, belohnt werden sollte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10113, 'deDE', 'Ich schätze, wir müssen einen Ersatz für den Wasserträger finden. Nun, Ihr seht aus wie ein kräftiger $C. Interesse an einem Job? Oder kommt Ihr wegen der Jagd?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10114, 'deDE', 'Ich bin erleichtert zu hören, dass er in Sicherheit ist. Seid Ihr hier, um an der Jagd teilzunehmen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10115, 'deDE', 'Ihr habt gute Arbeit geleistet, $N. Keiner ist der Meinung, dass es noch Erlösung für den Dolchfennstamm gegeben hätte, aber ich glaube nicht, dass die Draenei in dieser Situation schnell genug gehandelt hätten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10116, 'deDE', 'Bemerkenswert! Es gab schon einige vor Euch, die das Kopfgeld gewinnen wollten, aber keiner von ihnen ist je zurückgekehrt. Es ist nicht schwer sich auszumalen, was ihnen wohl zugestoßen ist.$B$BIch bin sehr erleichtert, dass wir in Zukunft nichts mehr von Mummaki und seinem Gesindel zu befürchten haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10117, 'deDE', 'Ihr habt meinen Dank, $N. Ich hatte mir schon überlegt, einen Teil der Garnison dorthin zu schicken und Mummaki selbst zu erledigen. Welche Folgen das jedoch für Zabra\'jin gehabt hätte, ist schwer zu sagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10118, 'deDE', 'Ich glaube, Ihr habt ihnen eine ziemlich deutliche Botschaft zukommen lassen. Vielleicht haben meine Männer nun nicht mehr so viel Angst vor dem Dolchfennstamm. Oder sie schämen sich zumindest für ihren Mangel an Mut.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10119, 'deDE', 'Willkommen in der Scherbenwelt, $N - willkommen im Alptraum! Auch wenn das erste Expeditionskorps es unbeschadet hierher geschafft hat, versucht die Legion nun, das Portal zurückzuerobern und unsere Verstärkung daran zu hindern, es zu durchschreiten.$B$BIch würde Euch gerne hier einsetzen, aber unsere Truppen und die Soldaten der Horde können die Kolonnen der Legion, die diese Plattform erobern wollen, selbst zurückhalten.$B$BIhr müsst dorthin gehen, wo Ihr am meisten gebraucht werdet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10120, 'deDE', 'Ihr seid also Orions neuer Bote? Ich hoffe, es ergeht Euch besser als dem letzten, den er geschickt hat, $C. Mit der vorrückenden Legion schafft Ihr es niemals zu Fuß nach Thrallmar. Sagt Bescheid und mein treuer Wyvern wird Euch sicher dorthin bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10121, 'deDE', 'Ihr habt sicher auf Eurem Flug vom Dunklen Portal die Krieger der Legion überall in der Landschaft gesehen. Auch wenn wir sie in der Schlacht am Berg Hyjal vor etwa 5 Jahren besiegt haben, haben diese verfluchten Dämonen immer noch nicht genug. Wenn sie auf eine Herausforderung aus sind, wird die Horde ihnen entsprechend antworten!$B$BWir Orcs haben mit der Legion mehr als nur eine Rechnung zu begleichen! Was ist mit Euch, $N? Soll ich Euch von unserem Feind erzählen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10123, 'deDE', 'Ausgezeichnete Arbeit, Soldat. Die Häufigkeit der Angriffe wird nun sicher nachlassen - zumindest bis sie neue Schreckenslords schicken.$B$BNun zu den schlechten Nachrichten: ich habe Eure neuen Befehle...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10124, 'deDE', 'Ihr habt also die Teufelsfunkenklamm aufgeräumt, was? Gut zu hören - wir brauchen Soldaten wie Euch, die sich kopfüber in die Schlacht stürzen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10129, 'deDE', 'Das wird sie um Wochen zurückwerfen! Fantastische Arbeit, $N. Die Legion hätte sicher nie mit so starkem Widerstand gerechnet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10132, 'deDE', 'Gute Arbeit.$B$BWenn Ihr mich fragt, müssen wir einfach genug von diesen Kolossen töten, dann brauchen wir uns nicht mehr um diese merkwürdigen Kristall in der Mitte kümmern.$B$BHier, nehmt eines hiervon als Belohnung der Expedition des Cenarius.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10134, 'deDE', 'Hm, für mich sieht es einfach wie ein großer Klumpen ungeschliffenen Kristalls aus.$B$BZugegeben, ich fühle eine kranke, böse Aura, die von ihm ausgeht, aber das ist nicht gerade mein Spezialgebiet. Ich bin nur hier, um die Bedrohung durch die Bergriesen aufzuhalten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10136, 'deDE', 'Alle kommenden Generation werden diesen Tag bejubeln, $N. Sie werden von Eurem Heldenmut singen. Ich wünschte, Thrall wäre hier, um diesen Sieg mit uns zu feiern. Die Legion liegt am Boden, und die Höllenfeuerhalbinsel gehört wieder der Horde! Vielleicht besteht doch noch Hoffnung für diese verwüstete Welt und unser Volk auf ihr.$B$BLok\'tar ogar!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10140, 'deDE', 'Unsere Expedition zu dieser verlassenen, zerschlagenen Welt wäre fast zum Stillstand gekommen, $N. Wir haben mehr Widerstand erfahren, als wir dachten.$B$BAls ob die Brennende Legion nicht schon schlimm genug wäre, gibt es in diesen Ländern Schrecken, die wir noch nie zuvor gesehen haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10141, 'deDE', 'Truppenkommandant Danath hat meine Anfrage nach Verstärkung wohl etwas falsch verstanden. Ihr seht zwar fähig aus, aber... ich habe um ein komplettes Bataillon gebeten!$B$BWisst Ihr, wir haben da ein kleines Dämonenproblem.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10142, 'deDE', 'Ausgezeichnete Arbeit, Soldat. Die Häufigkeit der Angriffe wird nun sicher nachlassen - zumindest bis sie neue Schreckenslords schicken.$B$BNun zu den schlechten Nachrichten: ich habe Eure neuen Befehle...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10143, 'deDE', 'Schön, Euch kennenzulernen, Soldat.$B$BGenug gequatscht... nun hört zu - Ich habe eine wichtige Mission für Euch und ich möchte, dass Ihr sie erfüllt... und überlebt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10144, 'deDE', 'Gut gemacht, $N. Die Zerstörung der Portale wird den Nachschub an Verstärkung für die Legion für eine Weile bremsen!$B$BAber noch können wir uns nicht ausruhen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10146, 'deDE', 'Das wird sie um Wochen zurückwerfen, kein Zweifel! Ihr habt mir gerade ungewöhnlich gute Laune verschafft, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10159, 'deDE', 'Jetzt, da die Verheerer fort sind, können die Reisenden der Zuflucht des Cenarius in den Zangarmarschen wieder sicher vorankommen.$B$BDie Expedition des Cenarius ist Euch etwas schuldig, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10160, 'deDE', '<Leutnant Amadi nickt.>$B$BGut, wir können jede Hilfe gebrauchen. Die zunehmende Orcbevölkerung am Südlichen Bollwerk bereitet mir Kopfschmerzen. Ich habe einen Späher losgeschickt, um sie zu erkunden, aber er ist noch nicht zurück.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10161, 'deDE', 'Einige davon sind in einem ziemlich schlechten Zustand, aber ich sollte damit zurechtkommen. Es braucht nur ein wenig kreative Ingenieurskunst und es wird sicher klappen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10162, 'deDE', 'Ihr fliegt, als hättet Ihr Euer Leben lang nichts anderes getan, $N. Hervorragende Vorstellung! Und nicht einmal ein kleiner Kratzer an den Wyvernzerstörern!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10163, 'deDE', 'Ihr fliegt, als hättet Ihr Euer Leben lang nichts anderes getan, $N. Hervorragende Vorstellung! Und nicht einmal ein kleiner Kratzer an den Greifenzerstörern!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10164, 'deDE', 'Ihr habt es geschafft, $N! Die Geister sind frei!$B$BAuch wenn ich keinen weltlichen Körper habe, kann ich Euch trotzdem mit Gegenständen aus der Geisterwelt belohnen. Benutzt sie mit Vorsicht, da diese Gegenstände oft unberechenbar sind und Ihrem Träger großen Schaden zufügen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10165, 'deDE', 'Und wieder ein Konkurrent weniger... Ihr leistet gute Arbeit für ein Wesen aus Fleisch und Blut, $R. Wenn Ihr je im Nethersturm sein solltet, sucht mich auf. Ich wohne in der Sturmsäule.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10166, 'deDE', 'Ich gehöre dieser Welt nicht länger an und muss mich geschlagen geben. Das Land hat sich auf ewig verändert, und nichts wird mehr sein wie früher.$B$BLasst den Anhänger hier bei mir, $N. Eines Tages vielleicht, wenn die Elfen schon lange nicht mehr sind, wird ein Baum an genau diesem Ort wachsen - in einem versengten Wald und zwischen toten Treants.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10168, 'deDE', 'Ihr habt eine lange und gefährliche Reise hinter Euch und Leben und Gesundheit für die Sicherheit der Mag\'har und den Frieden unserer Ahnen aufs Spiel gesetzt. Ich bin Euch dafür dankbarer, als tausend Worte sagen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10170, 'deDE', 'Ich möchte, dass Ihr diese Nachrichten persönlich zu Garrosh bringt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10171, 'deDE', 'Alle sind stolz. Stolz, dass unser Volk einen weiteren Winter überleben wird. Aber danach? Was ist danach?$B$BVielleicht solltet Ihr diesen Klan anführen, $N. Vielleicht ist es mir dann vergönnt zu sterben, wenn die Großmutter dahinscheidet. Vergönnt, die Schande meines Familiennamens auszulöschen. Ich sehne mich nach diesem Frieden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10172, 'deDE', '<Tränen strömen über Großmutter Geyahs Gesicht.>$B$BThrall ist auf dem Weg hierher. Ich weiß, dass er bald hier sein wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10173, 'deDE', 'Ah, Ihr habt es also geschafft, den Stab zurückzuholen. Beeindruckend, $N. Vielleicht seid Ihr genau der $C, den ich suche.$B$BOh ja, Eure Belohnung...$B$B$B$BIhr habt sicherlich mehr erwartet, aber das kommt schon noch mit der Zeit. Fürs Erste soll die Möglichkeit Eure Belohnung sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10174, 'deDE', '<Erzmagier Vargoth betrachtet Euch, als Ihr ihm Ravandwyrs Nachricht übermittelt.>$B$BRavandwyr hat alles, was ein Meister sich von einem Lehrling wünschen kann. Als ich ihm den Stab gab und ihm befohlen habe, zu fliehen, habe ich gehofft, dass er ihn benutzen würde, um jemanden zu finden, der mich nach dem Abzug von Kael\'thas Truppen aus dem Turm befreien kann. Seitdem habe ich viel über den Fluch herausgefunden.$B$BEr kann gebrochen werden, aber dazu brauche ich Eure Hilfe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10176, 'deDE', 'Das habt Ihr gut gemacht, $N. Ohne das Dämpferfeld wird es viel leichter für mich, die Magie vorzubereiten, mit der ich den Fluch des Turms endlich aufheben kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10177, 'deDE', 'Es wird langsam Zeit, dass Ihr kommt.$B$BMehlisah hat schon vor Tagen gesagt, dass sie Hilfe schicken würde. Und wir kämpfen hier schließlich schon eine ganze Weile!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10178, 'deDE', 'Was? Grik\'tha hat Euch nach mir geschickt?$B$BIch weiß nicht, ob ich mich geehrt fühlen oder sie eine Närrin schimpfen soll!$B$BKönntet Ihr mir vielleicht aus diesem Käfig raushelfen? Es ist ein bisschen eng hier.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10180, 'deDE', 'Ich hätte wissen sollen, dass er nach mir schicken würde. Er hat versucht mir auszureden, in die Sethekkhallen zurückzukehren, aber ich könnte nicht damit leben, wenn Lakka etwas zustoßen würde.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10182, 'deDE', 'Gut gemacht, $N. Ich kann keine Rastlosigkeit mehr in Dathrics Geist spüren. Ich würde viel dafür geben, wenn ich noch einmal mit ihm sprechen könnte, aber es ist schon gut genug, dass er nun in Frieden ruht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10183, 'deDE', 'Oh, Kupfernickel hat sich also endlich entschlossen, seine Entdeckungen zu berichten, was? Faule Wissenschaftler!$B$BWas ist das?$B$B<Der Chef blättert ein paar Mal durch die Notizen mit einem deutlich skeptischen Gesichtsausdruck.>$B$BEr sagt, dass die gewaltigen Netherenergien, die durch den Nethersturm fließen, alles in nur ein paar Monaten in Stücke reißen werden.$B$BDas ist ungünstig - jetzt müssen wir den Zeitplan für das Raketenschiff etwas straffen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10184, 'deDE', '<Hüter Dierwert schüttelt langsam den Kopf.>$B$BSie haben das nicht verdient, aber es ist das Beste, was wir tun können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10185, 'deDE', '<Der Hüter sieht bestürzt aus.>$B$BIch kann die nächste Welle schon über den Horizont kommen sehen. Sie auszumerzen hilft vielleicht für den Moment, aber wir brauchen langfristige Maßnahmen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10186, 'deDE', 'Pah! Die sehen aber grob aus. Vielleicht können wir sie in einer tertiären Antriebsmehrfachkammer einsetzen?$B$BTrotzdem gute Arbeit, Juniortechniker dritten Grades! Ihr werdet es sicher bald zum zweiten Grad schaffen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10188, 'deDE', 'Ah, es ist so wundervoll, wie ich es in Erinnerung hatte. Könnt Ihr die Macht, die davon ausgeht, spüren?$B$BNatürlich ist noch viel mehr zu tun, aber Ihr habt meinen tiefsten Dank dafür, dass Ihr mir das Siegel zurückgebracht habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10189, 'deDE', 'Ausgezeichnet! Mit dieser Stammrolle können wir bessere Entscheidungen treffen, wenn wir die Anhänger Kaels bei den Manaschmieden angreifen.$B$BEigentlich schade, ich mochte es irgendwie, seine Lakaien wahllos zu töten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10190, 'deDE', 'He, passt auf, auf wen Ihr mit dem Ding zeigt! Ihr habt es auf töten gestellt!!!$B$BGut, es sieht so aus, als hättet Ihr die Batterie genügend aufgeladen. Ich baue sie gleich in Nr. V ein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10191, 'deDE', 'Ihr habt es geschafft! Ihr habt es geschafft! Ich könnte Euch küssen!$B$BOh verdammt... die Batterie von Maxx E. Million Nr. V ist schon wieder leer. Naja, er hat seine Arbeit erledigt, und das ist das Wichtigste.$B$BRaketenchef Doppeldecker wird sich freuen, wenn er diese Draeneimaschinen in der X-52 Netherrakete einbauen kann! Das bedeutet eine Beförderung für mich! Ich bin so glücklich, ich muss Euch einfach belohnen!$B$BHier, sucht Euch etwas davon aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10192, 'deDE', '<Das Abbild von Erzmagier Vargoth scheint das Kompendium zu begutachten.>$B$BEs ist ein wenig mitgenommen, aber wenn man bedenkt, was es durchmachen musste, ist es ein Wunder, dass es überhaupt überlebt hat. Bewahrt es auf, $N. Ohne das Buch haben wir kaum eine Chance, den Schutzschild des Turms zu durchbrechen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10193, 'deDE', 'Ihr seid ein zuverlässiges Mädel. $N. Wenn es etwas gibt, das ich noch mehr mag, als Kaels Schoßhunde zu töten, dann ist es, wenn das jemand anderes für mich erledigt.$B$BSo habe ich weniger Blut auf meinen Klamotten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10194, 'deDE', 'Euren Flug zu organisieren war nicht gerade billig. Ich hoffe, ihr habt das Zeug zu diesem Auftrag.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10197, 'deDE', 'Ausgezeichnet! Wenn ich mit Euch fertig bin, werdet Ihr Euch unbemerkt unter die Ränge des Sonnenzorns mischen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10198, 'deDE', 'Die Manaschmiede Duro ist in Schwierigkeiten? Ich bin mir sicher, dass Thalodien sich über diese Neuigkeiten freuen wird. Lasst uns zunächst diese Aufgabe hier fertigstellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10199, 'deDE', 'Wow! Ok, jetzt stimmt die Sache.$B$BLasst mich nur schnell die Boshaftigkeit aus diesen kleinen Schönheiten quetschen. Das sollte ein Raketentreibstoff werden, der alle von den Socken haut!$B$BHier, lasst mich das Schieferöl und das Stachelgift mischen, und dann schauen wir mal, was passiert...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10200, 'deDE', 'Ihr überrascht mich immer wieder, $N. Das war beeindruckende Spionagearbeit, die Ihr da in der Manaschmiede Coruu geleistet habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10201, 'deDE', '<Ihr berichtet Rakoria die Testergebnisse und sie fängt an, schallend zu lachen.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10202, 'deDE', 'Es ist an der Zeit, dass Ihr auftaucht. Ich habe mich schon gefragt, ob die Seher überhaupt interessiert sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10203, 'deDE', 'Ihr müsst derjenige sein, der uns die ganze Ausrüstung von den Ruinen hergebeamt hat! Ein Hoch auf Euch!$B$BIch habe die Ausrüstung bereits an unsere Grabungsorte weiterverteilt. Jetzt können wir unsere Ausgrabungen im großen Stil überall auf der Insel durchführen! Die Netherrakete wird in null Komma nichts fertig werden!$B$BHmm, merkwürdig. Wartet mal, habt Ihr gesagt, Ihr habt uns vier Dinge zurück geschickt? Ich habe nur drei bekommen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10204, 'deDE', 'Hmmm... wie ich erwartet habe.$B$BSolch rohen Energien ausgesetzt zu sein erhöht unsere angeborene Sucht nach Magie gewaltig.$B$BIch bin nicht überrascht, dass Kael mit seinen Taten ungestraft davon kommt, wenn seine Angestellten praktisch die ganze Zeit betrunken sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10205, 'deDE', 'Ich bin erleichtert zu hören, dass dieser Abschaum endlich vernichtet wurde. Ihr macht Eure Arbeit gut, $N... darf ich so vermessen sein, Euch beim Namen zu nennen?$B$BWenn Ihr möchtet, habe ich eine weitere Aufgabe für Euch. Eine, die besonders wichtig ist. Jemand mit so offensichtlichen Talenten wie Ihr wird sie sicher leicht bewältigen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10206, 'deDE', 'Hehe, astrale Deppen!$B$BDanke, dass Ihr uns die Teile gebracht habt, $C. Ich wette, wir können diese Babys gleich in die Rakete einbauen. Ich frage mich, was sie wohl bewirken? Wird sicher lustig, es herauszufinden!$B$BHm, lasst mich mal schauen ob ich noch ein wenig Wechselgeld für Euch in der Hosentasche habe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10208, 'deDE', 'Gut gemacht! Ich konnte die Explosionen fast bis hierher spüren!$B$BJetzt haben wir noch eine weitere Bombenmission für Euch...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10209, 'deDE', '<Ihr wisst nicht, ob es nur eine Verzerrung ist, aber der Erzmagier scheint zu lächeln.>$B$BJetzt, da ich all meine Besitztümer zurück habe, habe ich alles, um Kael\'thas\' Magie zu durchbrechen. Ich werde den Zauber gleich wirken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10210, 'deDE', '<Das Licht, das Eure Sinne erfüllt hat, als Ihr Euch A\'dal nähertet, wird noch stärker, als Ihr ihn ansprecht. Melodische Klänge ertönen in Eurem Kopf.$B$BIhr seid hier sicher.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10211, 'deDE', 'Ich hoffe, Ihr habt etwas über Shattrath erfahren, $N. Lasst es einfach auf Euch wirken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10213, 'deDE', 'Wir wurden von der Brennenden Legion abgeschossen, obwohl wir eine Friedensflagge geschwenkt haben. Wer hätte ahnen können, dass die Brennende Legion so gemein ist?$B$BWir können leider nicht mit Euch zum Rückenbrecherposten kommen. Wir müssen den Zeppelin reparieren und dann weiterziehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10216, 'deDE', '<Ihr schließt die Augen und drückt einen Knopf.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10218, 'deDE', 'Da dies Morphalius\' Idee war, habe ich ihm seinen alten Job zurückgegeben. Gut gemacht, kleines Fleischwesen. Wirklich gut!$B$BDenkt daran, wenn Ihr je auf der Suche nach Arbeit und im Nethersturm seid, sucht mich in der Sturmsäule auf.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10220, 'deDE', 'Die Unerschütterlichen haben die Macht der Horde gespürt. Vielleicht haben sie jetzt ja Lust, sich meinen Vorschlag anzuhören.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10221, 'deDE', 'Ich werde Sparky immer vermissen. <Schnief> Aber jetzt, da wir wissen, dass Dr. Bumm uns nicht mehr tyrannisieren kann, werden wir alle besser schlafen.$B$BLasst Euch das eine Lehre sein. Kommt hier nicht ohne Netherhelm runter!$B$BNun, wie kann ich Euch dafür belohnen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10222, 'deDE', 'Was Ihr getan habt, kann die Gefallenen nicht zurückbringen, aber vielleicht kann es ihre Geister beruhigen. Obwohl ehrlich gesagt kein Blut der Welt meinen Zorn über Kael\'thas Taten stillen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10223, 'deDE', '<Ihr seid Euch nicht sicher, aber es sieht so aus, als würde Hüter Dierwert gleich anfangen zu weinen.>$B$BEndlich ist es geschafft. Wenn ich könnte, würde ich meine Existenz selbst auslöschen, aber die Wahrheit ist, dass ich nicht loslassen kann. Für die Leute im Dorf ist es schwer, aber zumindest ehrlich. Ich schätze, das ist der Preis, den wir dafür bezahlen müssen, dass wir uns so sehr an diesen Ort gebunden haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10224, 'deDE', 'Wow, das sind viele Essenzen!$B$BGut, schauen wir mal, was passiert, wenn ich sie mit den Astrallithiummatrixkristallen mische.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10225, 'deDE', 'Oh, Astrallithiummatrixkristalle! Ja, die klingen wichtig.$B$BLasst sie uns dort drüben hinstellen und ich kümmere mich gleich um sie.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10226, 'deDE', 'Das ist besser! Gut, ich glaube, jetzt sind wir im Geschäft.$B$BLasst mich dieses Zeug nur kurz in das Zau-ba-Ding hier tun, und ich bin sicher, dass es gleich einen voll funktionsfähigen Phasenantriebskern ausspuckt.$B$BOh, he, ich sollte Euch vielleicht dafür belohnen, dass Ihr meine Haut gerettet habt. Hehe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10227, 'deDE', 'Das Kind hat Recht. Ich war einst ein \"Totenpriester\".$B$B<Ramdor zuckt zusammen.>$B$BWas für ein abstoßender Titel. Innen findet Ihr die Überbleibsel meines Ordens. Sie sind natürlich alle verrückt! Wahnsinnig! Ich denke, ich habe mich sehr hervorgehoben, da ich der letzte von ihnen mit gesundem Menschenverstand war. Natürlich wurde ich wegen meines Glaubens exkommuniziert.$B$BWas, sagtet Ihr, glaube ich noch gleich?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10228, 'deDE', 'Buch der Toten? Nie davon gehört... Worum geht es überhaupt? Wer hat Euch geschickt?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10229, 'deDE', 'Ich habe mein ganzes Unleben lang alte Geschichte studiert, doch nie zuvor etwas wie dieses Buch gesehen. Er erzählt die gesamte Geschichte des Rüstlagers, sogar die Ereignisse nach seiner Zerstörung.$B$BDie Unerschütterlichen haben ihre Geschichte aufgeschrieben, sogar nach ihrem Tod in der Schlacht. Mit diesem Buch können wir die Unerschütterlichen verstehen und sie sicher davon überzeugen, sich uns anzuschließen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10230, 'deDE', 'Gut gemacht, $N. Dieses alte Horn wird uns helfen, die Unerschütterlich zu rufen.$B$BNatürlich nur, wenn sie es möchten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10231, 'deDE', 'Ok, Ok! Tut uns nicht weh. Wir hatten das Buch, aber wir haben es verkauft...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10232, 'deDE', 'Nun, das sind gute und schlechte Nachrichten zugleich. Wir haben ihnen einen Schlag versetzt, aber ich weiß nicht, wie es weitergehen soll, wenn die Brennende Legion überall im Nethersturm frei herumrennt - und näher kommt.$B$BIch habe das Gefühl, dass wir einen Gang hochschalten müssen. Ich hoffe, Ihr könnt uns dabei helfen, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10233, 'deDE', '<Zaubererleutnant Morran nickt grimmig.>$B$BDie Kirin Tor heißen Zerstörung im Allgemeinen nicht gut, aber um unseren Feind zu vernichten überwinden wir jeden Skrupel. Sogar im Tod.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10234, 'deDE', 'Ich denke, die müssen reichen. Wenn wir sie nur fortjagen könnten!$B$BHe, da fällt mir etwas ein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10235, 'deDE', 'Er, äh... er hat was gesagt? SIE WOLLEN AREA 52 ANGREIFEN?$B$BOh, das ist nicht gut... nicht gut!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10236, 'deDE', 'Hurra, Ihr habt ein paar Teile gefunden! Jetzt kann ich meinen Schredder hoffentlich wieder zum Laufen bringen. Wenn ich genug Geld verdiene, kann ich vielleicht wieder zurück nach Beutebucht.$B$BIch hoffe, dass mein Vetter Quack Lufthans mit seinem blöden Zeppelin abstürzt. Ich kann es nicht fassen, dass er mich so hinterhältig in die Scherbenwelt gelockt hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10237, 'deDE', 'Ha, Ihr macht Witze, oder? Die Brennende Legion gibt uns die Schuld daran?$B$BAber IHR wart das!$B$BOh, ich habe Kopfschmerzen, die so groß wie diese Rakete sind! Ok, ok, wir müssen uns einen anderen Plan einfallen lassen.$B$BWenn die Brennende Legion denkt, dass sie hierher kommen, unser Dorf zerstören und meinen Traum von einer Reise durch den Wirbelnden Nether ruinieren kann, dann hat sie sich aber getäuscht.$B$BUnd ich kenne genau den richtigen Goblin, der uns dabei helfen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10238, 'deDE', 'Vielen Dank, dass Ihr meine Peons gerettet habt. Vielleicht kann ich sie jetzt dazu bringen, meinen Schredder mit den Teilen, die Ihr gefunden habt, zu reparieren. Dann kann ich wieder etwas Geld verdienen und aus der Scherbenwelt abhauen. Ich kann es kaum abwarten, wieder in Beutebucht zu sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10239, 'deDE', '<Morran dreht einen der Würfel vorsichtig in der Hand.>$B$BIch glaube nicht, dass ich je zuvor so etwas gesehen habe. Es steckt sicher eine Menge Energie darin, aber es ist rohe Energie. Wir müssen vorsichtig damit sein, aber ich glaube, dass wir einen Weg finden können, wie man sie zur Abwehr der Manakreaturen einsetzen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10240, 'deDE', 'Ausgezeichnete Arbeit. Drückt die Daumen, $N. Ich werde den Schild jetzt aktivieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10241, 'deDE', 'Ausgezeichnete Arbeit, $N. Die Seher haben dank Eures Ablenkungsmanövers wichtige Informationen sammeln können. Vielleicht teilen sie sie dieses Mal tatsächlich mit uns.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10242, 'deDE', 'Ein Bluttest also? Es wird mir ein Vergnügen sein. Ich arbeite immer gerne mit Blut...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10243, 'deDE', 'Ihr öffnet die Rolle und bereitet Euch vor, die merkwürdigen Symbole abzuschreiben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10245, 'deDE', 'Gut gemacht, $N. Gebt mir ein paar Augenblicke, um die Abschrift zu lesen.$B$BIhr habt den Dank der Priesterschaft, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10246, 'deDE', 'Ausgezeichnete Arbeit, $N. Mit Eurem Einsatz schaffen wir es sicher, den Feind zu besiegen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10247, 'deDE', 'Wie es scheint, haben wir großes Glück, junger Mann.$B$BIch habe gerade neulich meine neuste Erfindung, den Schrotthäscher X6000, fertig stellen können!$B$BUnd Ihr habt die Ehre, mir dabei zu helfen, ihn zu testen. Dann können wir ihn zur Verteidigung von Area 52 einsetzen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10248, 'deDE', 'Nun, mein Junge, das war aber aufregend! Und meiner Meinung nach hat der Schrotthäscher X6000 trotz seines Grünschnabelpiloten gut funktioniert.$B$BHehe, seid nicht beleidigt, ich mache nur Witze. Schließlich habt Ihr gerade Area 52 und die X-52 Netherrakete vor dem sicheren Untergang bewahrt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10249, 'deDE', '$N! Oder sollte ich sagen Juniortechniker ersten Grades $N?! Ach, wem mache ich etwas vor. Einen Grad zu überspringen ist keine angemessene Belohnung für das, was Ihr getan habt. Ich ernenne Euch zu meinem Ersten Offizier!$B$BIhr habt uns alle gerettet, und noch viel wichtiger, die X-52 Netherrakete! Ich könnte Euch küssen... aber das tue ich nicht.$B$BLasst mich Euch stattdessen die Dankbarkeit von Area 52 zeigen. Wählt etwas aus!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10250, 'deDE', 'Ich bin froh, dass die Unerschütterlichen Euch im Kampf unterstützt haben. Ich dachte mir schon, dass sie dem Ruf ihres Schlachthorns folgen würden, aber ich war mir nicht sicher. Vielleicht haben wir ihnen jetzt die Rache ermöglicht, die sie so sehr begehrten.$B$BIhr habt Urtrak getötet. Diesen Sieg müssen wir Kommandant Hogarth im Rüstlager der Allianz melden. Er wird verstehen, welche Gefahren Ihr für ihn auf Euch genommen habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10251, 'deDE', 'Die Zeichen waren deutlich, aber ich war blind.$B$BDer eiserne Griff der Legion wird von Tag zu Tag stärker. Sogar hier...$B$BIch wusste es...$B$Bwusste, dass mein Junge mit den Dämonen kommunizierte...$B$BSie haben ihm Macht angeboten und ihm dann einen Vorgeschmack dieser Macht gegeben. Mehr war nicht nötig...$B$BDas Buch ist fort. Levixus hat es genommen...$B$BNur ich und sein dunkler Meister kennen seine Pläne.$B$BFremder, ich weiß nicht, ob Ihr jemals im Leben das Richtige getan habt, aber Ihr müsst eines wissen: der Junge muss aufgehalten werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10252, 'deDE', 'Fremder... ich war nicht ganz aufrichtig zu Euch. Wenn Ihr diesen Trank zu Euch nehmt, werdet Ihr die Welt der Geister für alle Zeit sehen können. Diese Tinktur ist Teil des Initiierungsrituals für alle Totenpriester von Auchindoun. Viele werden wahnsinnig, wenn der Effekt eintritt. Die Toten sehen zu können ist... schockierend. <Nitrin hält Euch den Trank an die Lippen.> Wollt Ihr es tun?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10253, 'deDE', 'Wenn der alte Draenei Euch aufgetragen hat, das Buch zu zerstören, warum habt Ihr es dann nicht getan?$B$B<Ramdor starrt Euch an.> Ach, was soll\'s. Ihr seid vielleicht gierig, aber ehrlich.$B$BIch allerdings... Ich habe gelogen, um an das Buch zu kommen. Ich habe nicht die leiseste Ahnung, wo diese armen, verirrten Seelen ihren Schatz aufbewahren, und wenn ich es wüsste, würde ich es Euch nicht sagen. Aber ich habe trotzdem etwas für Euch. Ihr habt heute etwas Gutes getan. Vielleicht sogar etwas Großartiges... Ihr solltet belohnt werden.$B$BÜbrigens, willkommen im Club.$B$B<Ramdor zeigt auf die Geister.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10254, 'deDE', 'Ich bin froh, dass Ihr hier seid, Bruder. Ich bin Danath Trollbann - Anführer der Söhne des Lothar und Truppenkommandant dieser Feste.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10255, 'deDE', '<Thiah Rotmähne macht große Augen, als Ihr die Ergebnisse des Experiments beschreibt.>$B$BWie konnte das nur geschehen? Ich bin mir sicher, dass ich das Gegengift richtig hergestellt habe!$B$BIch habe gesehen, wie es mit Spinnen- und Schlangengiften funktioniert hat, warum kehrt sich die Wirkung hier nicht um? Vielleicht ist das eine der vielen Besonderheiten der Scherbenwelt, $N. Ich leite diese Information am besten an meine Kameraden weiter.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10256, 'deDE', '<Ihr beschreibt, was Ihr gesehen habt.>$B$BKommandantin Sarannis sagt Ihr? Hmm...$B$BSie ist eine von Kael\'thas Beratern, aber ganz sicher keine Magierin. Ich kenne sie von dem Angriff auf Kirin\'Var. Ich glaube, Ihr habt Recht, $N. Sie mag den Fluch vielleicht nicht selbst aufrechterhalten, aber sie hat den Schlüssel zum Schild.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10257, 'deDE', '<Die Augen des Erzmagiers leuchten auf, als Ihr ihm den Schlüsselstein gebt.>$B$BErstaunlich! Nach dem, was ich von Farahlons Schicksal erblickt habe, bin ich mir nicht sicher, ob ich hinaus will, aber es ist immerhin besser, als für den Rest meiner Tage hier eingesperrt zu sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10258, 'deDE', 'Wir haben die Schlacht vor so langer Zeit gegen die Höllenorcs verloren. Ihr habt uns unsere Ehre zurückgegeben, indem Ihr Urtrak getötet habt.$B$BNehmt Euch eine unserer Waffen. Wenn Ihr gegen unseren verhassten Feind in den Kampf zieht, benutzt diese Waffe, und die unter uns, die frei vom Fluch sind, werden Euch zu Hilfe kommen.$B$BBevor Ihr geht möchten einige, die vor Jahren beim Belagerungsturm gefallen sind, Euch für die Zerstörung unseres Feindes Ehre erweisen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10261, 'deDE', 'Juhuu! Wisst Ihr, wie schwer man an diese Dinge herankommt? Es ist ja nicht so, als ob ich hier draußen täglich eine Teilelieferung bekommen würde.$B$BWisst Ihr was? Als Belohnung lasse ich Euch etwas aus meiner Kramkiste nehmen. Es ist sicher etwas darin, was Ihr brauchen könnt. Wenn nicht, verkauft es einfach weiter.$B$BIn Ordnung, lasst mich das Euch abnehmen und in meinen langhalsigen Spektrumanalysator einbauen, bevor der alte Servo noch explodiert!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10262, 'deDE', 'Diese Insignien sind ein guter Anfang.$B$BUnglücklicherweise haben meine anderen Agenten bei den Zaxxis berichtet, dass Sphärenräuber Nesaad immer noch am Leben ist!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10263, 'deDE', 'Hallo, $R.$B$BIhr steht steht nicht zufällig für eine wichtige Bergungsmission zur Verfügung?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10264, 'deDE', 'Hallo, $R.$B$BIhr steht steht nicht zufällig für eine wichtige Bergungsmission zur Verfügung?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10265, 'deDE', 'Lasst mich ihn mal ansehen.$B$BHmm, er scheint nicht besonders zu sein. Ich bezweifle, dass er das ist, obwohl Eure Beschreibung der Vorgehensweisen der Legion in den Ruinen den Anschein erweckt, dass auch sie nach etwas ganz Bestimmten suchen.$B$BWollen wir hoffen, dass es nicht der Kristall ist, den der Nexusprinz so unbedingt haben will.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10266, 'deDE', 'Ja, es ist wahr. Die Blutelfen weigern sich auch dieses Mal, die Waren, die ihnen schon geliefert wurden, zu bezahlen.$B$BDa Netherpirscher Khay\'ji Euch geschickt hat, hoffe ich, dass Ihr mir bei dieser Angelegenheit helfen könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10267, 'deDE', 'Nun, ich bin froh, dass wir dieses kleine Geschäft abgeschlossen haben. Ich kann mich nicht erinnern, dass das Konsortium je Geschäfte mit solch flegelhaften und unseriösen Wesen gemacht hätte.$B$BIhr scheint jedoch vertrauenswürdig zu sein, $N. Vielleicht wollt Ihr mir ja noch einen Gefallen tun?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10268, 'deDE', 'Ich heiße Euch in der Sturmsäule willkommen, $C. Bitte genießt die Gastfreundschaft des Konsortiums.$B$BDie Ausrüstung könnt Ihr irgendwo abstellen. Ich nehme an, dass Ihr sie schon sehr bald wieder mitnehmen werdet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10269, 'deDE', '<Händler Hazzin senkt seine Stimme zu einem Flüstern.>$B$BAh, ich weiß von Eurem Auftrag. Er ist für Nexusprinz Haramad äußerst wichtig.$B$BJetzt, da wir die Position des ersten Triangulationspunktes herausgefunden haben, müssen wir schnell den zweiten suchen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10270, 'deDE', 'Diese Energiezelle sollte für unsere Zwecke ausreichen. Sobald das Geld zu fließen beginnt, werden wir ihn noch weiter verbessern.$B$BDoch genug davon. Jeder mit Diskussionen verschwendete Augenblick bedeutet verlorenen Gewinn.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10271, 'deDE', 'Man stelle sich nur vor, dass dieser erbärmliche Astrale diese Essenzen wie Süßigkeiten an die Blutelfen verkaufen wollte...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10272, 'deDE', 'Die sollten ihren Zweck erfüllen, $N. Vielen Dank, dass Ihr uns geholfen habt.$B$BBevor wir weitermachen können gibt es jedoch noch etwas anders, worüber wir sprechen müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10273, 'deDE', 'Jetzt, da dieser lästige Astrale beseitigt ist, können wir uns darauf konzentrieren, die Netherdrachen besser verstehen zu lernen. Ich konnte die Eier untersuchen und habe dabei einiges herausgefunden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10274, 'deDE', 'Gut gemacht, $N. Wirklich gut gemacht. Die Netherdrachkin werden zu Anfang keinen blauen Drachen in ihren Reihen akzeptieren, aber wenn ich meine Autorität beweise, werden sie sich fügen. Zerschlagen, isoliert und ohne Führung sind sie leichte Beute für bösartige Mächte. Wir müssen daher regelmäßig ein Auge auf sie werfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10275, 'deDE', 'Sehr gut, in der Tat. Der Nexusprinz wird zufrieden sein.$B$BJetzt haben wir den zweiten Punkt, der uns den dritten und damit die Umgebung, in der sich der Kristall befindet, verraten wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10276, 'deDE', 'In meinen wildesten Träumen habe ich nicht gedacht, dass Ihr den Kristall tatsächlich beschaffen könnt!$B$BUnd Ihr gebt mir ihn sogar! Habt Ihr eine Ahnung, wie mächtig er ist?$B$BEure Selbstlosigkeit ist sehr inspirierend und unvergleichlich, $N! Ihr habt mir viel zum Nachdenken gegeben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10278, 'deDE', 'Unglaublich. Ihr habt die Leere selbst berührt! $N, Ihr habt mein Lebenswerk gerettet. Aber es gibt noch mehr, was getan werden muss, und Ihr könnt mir helfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10280, 'deDE', 'Ihr habt mir den Gesang der Geister zurückgebracht! Prophet Velen hat den Kristall von Ata\'mal zur Sicherheit bei seinem Volk zurückgelassen, bevor er auf seine schicksalsträchtige Mission zur Exodar ging.$B$BMerkwürdig, dass er nicht vorhergesehen hat, dass er in die Hände der Brennenden Legion fallen würde, wenn auch nur für kurze Zeit.$B$BOder vielleicht hat er das ja? Es könnte sein, dass er all dies vorhergesehen hat, und ihn dort ließ, damit Ihr ihn mir bringen könnt.$B$BIch spüre, dass dies die Wahrheit ist. Ihr seid ein großer Held unseres Volkes, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10281, 'deDE', 'Mein Name ist Tyrygosa von Malygos\' Brut, aber nennt mich einfach Tyri. Mein Begleiter ist der Paladin Jorad Knüpp.$B$BDie Kunde von den merkwürdigen Drachkin hier verbreitet sich schnell, und ich fürchte, dass sehr viele kommen werden, um sie auszubeuten, bevor sie überhaupt ihre wahre Natur erkannt haben. Wir hoffen, dass wir mit Eurer Hilfe diese Kreaturen kennenlernen können, bevor andere von ihnen erfahren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10286, 'deDE', 'Ich werde reden, $C. Nehmt die Waffe runter, ich will nicht noch mehr Ärger haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10287, 'deDE', 'Viera Sonnenwisper? Diese widerliche kleine Göre.$B$BIch werde ihr zeigen, dass man mit mir keine Spielchen treibt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10288, 'deDE', 'Berichte für die Ehrenfeste? Kein Problem, einer meiner Greifen wird Euch schnell und sicher dorthin bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10289, 'deDE', 'Ich werde alle Truppen, die ich entbehren kann, zu Orion beim Dunklen Portal schicken. Die Legion wird den Schlachtruf der Horde nicht so bald vergessen! Ihr, $N, habt Thrallmar heute einen großen Dienst erwiesen. Ich glaube, Ihr könnt uns hier eine große Hilfe sein. Natürlich nur, wenn Ihr klug genug seid, um zu überleben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10290, 'deDE', 'Ah ja, genau die Qualität, die ich mir erhofft habe. Wenn wir genügend Nachschub von den Riesen bekommen, brauchen wir die Kristalle nicht mehr abbauen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10291, 'deDE', 'Wir haben schon viele tapfere Krieger an dieses verfluchte Land verloren. Ich habe kein Interesse daran, noch mehr ungeprüfte Rekruten in das Massaker zu schicken.$B$B<Nazgrel schaut Euch durch seine zottige Wolfsmaske streng an.>$B$BAber wenn General Krakork Euch zu mir geschickt hat, muss an Euch ja etwas dran sein. Was sagt Ihr also, $N? Werdet Ihr dem Kriegshäuptling mit Ehre dienen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10293, 'deDE', 'Gut gemacht! Ich kann kaum abwarten, es auszuprobieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10294, 'deDE', 'Ausgezeichnet. Der verbesserte Sphärenrissgenerator ist fast fertig. Es gibt nur noch einen letzten Bestandteil, den wir brauchen. Bald können wir einen stabilen Sphärenriss öffnen, den wir in den kommenden Jahren untersuchen können.$B$BWer weiß, welche fremdartigen Kreaturen durch ihn hindurchkommen werden? Stellt Euch nur vor, $N, die Macht, die ein solches Wissen mit sich brächte, wäre unermesslich!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10295, 'deDE', 'Ihr habt mein Lebenswerk gerettet, $N.$B$BSie haben mich wahnsinnig genannt, mich ausgelacht und gedacht, meine Besessenheit auf den Leerengrat und die Sphärenfelder hätte mich krank gemacht. Mit diesem Seelensplitter kann ich das Geheimnis der Leerwandler lüften. Ich werde die Macht über den Abgrund beherrschen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10299, 'deDE', 'Das Licht ist Euch wohlgesinnt, $N. Wir haben alle für Euren Erfolg gebetet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10300, 'deDE', '<Ravandwyr untersucht die Kristalle genau und wählt dann einen aus.>$B$BDieser Kristall sollte funktionieren. Ich werde den Sockel des Stabs umformen, damit das neue Kopfstück passt.$B$BErzmagier Vargoth wird enttäuscht sein, wenn er ihn sieht, aber ich bin bereit, die Enttäuschung meines Meisters in Kauf zu nehmen, wenn er nur endlich wieder frei ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10301, 'deDE', 'Ausgezeichnet, $N. Jetzt haben wir fast alles, was wir benötigen, um Kael\'thas\' Magie zu durchbrechen.$B$BUnd wenn die Blutelfen unter dem Verlust ihres Kommandanten hier leiden, dann umso besser.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10302, 'deDE', 'Ihr seid fertig? Das sind gute Nachrichten. Hoffentlich finden wir einen Weg, bei dem wir diese mutierten Kreaturen nicht töten müssen.$B$BIch glaube, ich habe einen Plan entwickelt, der uns eine alternative Lösungsmöglichkeit für unser Problem bietet, aber ich werde Eure Hilfe brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10303, 'deDE', 'Diese Blutelfen wollen uns alle töten. Wie können wir sie davon abhalten?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10304, 'deDE', '$N, richtig? Ich habe viel Gutes über Euch und die Arbeit, die Ihr in der kurzen Zeit, in der Ihr hier wart, geleistet habt, gehört.$B$BWir sind auf Eure Hilfe angewiesen, um die Dinge wieder zu normalisieren. Ich bin mir sicher, dass auch Zhanaa da drüben Eure Hilfe brauchen könnte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10305, 'deDE', 'Ja, ich habe davon gehört, dass Bannzauberin Belmara ein altes Buch mit Geschichten hatte, aber ich wusste nicht, dass sie es mit in die Scherbenwelt gebracht hatte. Ich bin mir sicher, dass ihr Geist nun, da Ihr es gefunden und zurückgebracht habt, ruhen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10306, 'deDE', 'Wir haben immer Scherze darüber gemacht, dass Luminrath zu allem diesen Mantel tragen würde. Für ihn passte Rot genauso gut zu Weiß wie zu Schwarz, Violett, Blau, Gelb, Orange und Grün. Er hätte niemals zwei Tage hintereinander dieselbe Robe getragen, aber der Mantel war immer dabei...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10307, 'deDE', '<Der Hüter lächelt, als Ihr Cohliens Name erwähnt.>$B$BIhr habt absolut Recht mit der Kappe. Er trug sie die ganze Zeit und lies sie nicht aus den Augen.$B$BEin paar Mal hat sich einer seiner Kollegen die Kappe ausgeliehen und sie zum Scherz versteckt. Ich brauche nicht zu erwähnen, dass die Androhung eines Frostblitzes von Cohlien ihn schnell zum Umdenken bewegt hat.$B$BIch werde den kleinen Cohlien vermissen. Er war sehr beliebt bei den Elfendamen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10308, 'deDE', 'Verräter, alle!$B$BGute Arbeit, $C! Wenn Ihr nochmals dort hinunter gehen solltet, bin ich immer noch auf der Suche nach weiteren Insignien für meine Sammlung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10309, 'deDE', 'Wow, schaut Euch das an... ein schlagendes Teufelshäscherherz! Nun, es schlägt nicht wirklich, aber Ihr wisst schon, was ich meine.$B$BIch kann es kaum abwarten, dieses Ding zu benutzen. Oder ich verkaufe es. Ich kenne ein paar Depp... äh Kunden, die daran interessiert sein könnten.$B$BHier, Ihr habt Euch die Belohnung verdient!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10310, 'deDE', 'Das sind ausgezeichnete Neuigkeiten, mein Freund!$B$BIhr und Drijya haben uns einen großen Dienst erwiesen. Jetzt, da das Warptor außer Gefecht ist, können die Dämonen in der Nähe keine Verstärkung mehr holen.$B$BBitte erlaubt mir, Euch in der Art des Konsortiums zu belohnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10311, 'deDE', 'Ich hoffe, dass Gahruj Euch hierher geschickt hat, um mir bei meinem Auftrag zu helfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10312, 'deDE', '<Hüter Dierwert nimmt Euch das Buch ab und blättert es durch.>$B$BHmm...$B$BSieht aus, als hätte ich Recht gehabt. Es scheint ein Muster zu geben.$B$BDie aggressivsten und gefährlichsten Geister stimmen mit den mächtigsten und hochrangigsten Kirin Tor, die in dem Dorf gelebt haben, überein. Dagegen scheint man die Dorfleute und Händler übersehen zu haben. Was könnte das bedeuten?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10313, 'deDE', 'Das sind schlimme Nachrichten, $N. Die Warpenergien, die aus den Rohren herausströmen, sind gefährlich hoch.$B$BWir müssen einen Weg finden, um die Manaschmieden abzuschalten, oder der kleine Rest, der noch von der Scherbenwelt übrig ist, wird in tausend Stücke gesprengt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10314, 'deDE', '<Wächter Dierwert untersucht die Überreste.>$B$BDas Gerät, das Ihr beschreibt, klingt nach einem nekromantischen Fokus... Ich hätte wissen sollen, dass dieser bösartige Lehrling sich dazu herablassen würde. Ich dachte, seine Ausbildung würde ihn daran hindern, so weit zu gehen, aber ich schätze, ich habe mich getäuscht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10315, 'deDE', 'Alles, was wir tun, um sie von ihren Taten in den Manaschmieden abzuhalten, ist gut.$B$BMan kann offenbar nicht vernünftig mit ihnen reden. Und was auch immer ihre Anführer vorhaben, sie müssen verrückt sein.$B$BAls Belohnung für Eure treuen Dienste für die Ziele des Konsortiums möchte ich Euch in Eurer Landeswährung bezahlen, wenn Ihr nichts dagegen habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10316, 'deDE', 'Eine leuchtende Kugel liegt auf einem quadratischen Podest. Auf den ersten Blick scheint sie ein Behältnis für magische Energie zu sein, aber welche Art von Energie und zu welchem Zweck?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10317, 'deDE', '<Der Großknecht flüstert.>$B$BSeid Ihr hier, um mich zu töten? Hmm. Nun, ich glaube, die Astralen wissen nicht alles, was?$B$BIch bin nicht der, den Ihr sucht, glaubt mir.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10318, 'deDE', 'Ein Verdammniswachenübermeister? Das ist merkwürdig! Was macht denn die Brennende Legion dort?$B$BHm, einige der Blutelfen werden also abtrünnig. Wir werden das im Hinterkopf behalten, falls wir uns je entschließen sollten, den Ort mit Gewalt einzunehmen. Zumindest sind das ein paar gute Nachrichten, oder?$B$BBitte, $N, nehmt dieses Zeichen meiner Dankbarkeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10319, 'deDE', 'Ausgezeichnete Arbeit, $N. Der Besitz des Phylakteriums ist der Schlüssel zu unserem Sieg. Wenn Ihr gegen Naberius in die Schlacht zieht, werde ich es zerstören und ihn so für Eure Angriffe verwundbar machen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10320, 'deDE', 'Der Sieg über Naberius ist eine große Leistung, $N. Ich kann mir nicht helfen, aber ich glaube, wir hätten eine Chance gegen Kael\'thas\' Streitkräfte gehabt, wenn der Lehrling auf der richtigen Seite gestanden hätte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10321, 'deDE', 'Ausgezeichnete Arbeit. Jetzt sind nur noch zwei Manaschmieden aktiv.$B$BBald wird Kael\'thas von seiner Hauptenergiequelle abgeschnitten sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10322, 'deDE', 'Ihr seid von den Naaru gesegnet, $N. Euer Einsatz für die Sache wird nicht unbemerkt oder unbelohnt bleiben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10323, 'deDE', 'Die Brennende Legion? Verbündet mit Kael\'thas Sonnenwanderer?$B$BDas sind erschütternde Nachrichten. Das erklärt vieles, was wir hier und in Schattenmond beobachtet haben.$B$BWir müssen Shattrath sofort informieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10324, 'deDE', 'Wunderbar! Ihr entwickelt Euch zu einem beachtlichen Jäger, $N.$B$BWürdet Ihr mir gerne ähnlich sehen? Nun, hier ist Eure Chance! Während Ihr auf der Jagd wart, habe ich diese Gegenstände aus den Bälgen, die ich hier noch herumliegen hatte, gefertigt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10328, 'deDE', 'Ausgezeichnete Arbeit, $N! Wollen wir mal schauen, was uns diese Anweisungen verraten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10329, 'deDE', 'Natürlich hat es funktioniert! Ich bin Spionagemeister, meine Informationen sind immer genau.$B$BWie auch immer, da wartet ein brandneuer und spannender Auftrag auf Euch. Wollt Ihr davon hören? Natürlich wollt Ihr das.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10330, 'deDE', 'Wir haben den Aufruhr gehört und wollten gerade gehen. Ich bin froh, dass Ihr nicht allzu viel Prügel einstecken musstet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10331, 'deDE', 'Dem Himmel sei Dank! Jetzt kann ich zurück an die Arbeit. Ich weiß, dass Ihr denkt, dass ich verrückt bin, so weit von einer richtigen Schmiede an meinem Gesellenstück zu arbeiten, aber ich darf nicht riskieren, dass die anderen Lehrlinge meine Entwürfe stehlen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10332, 'deDE', 'Meister Rhonsus hat mir alles beigebracht, was ich über mein Handwerk wissen muss. Ich werde seine Erinnerung in Ehren halten, indem ich den Leuten von Kirin\'Var mit meinem Geschick diene.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10333, 'deDE', 'Was? Er hat mich seine Partnerin genannt? Ich bin seine Frau!$B$BUnd er sagt, ich hätte eine scharfe Zunge. Oh, wenn ich zurück nach Area 52 komme, werde ich ihm die großen grünen Ohren langziehen!$B$BAber ich bin froh, dass Ihr hier seid. Mit einer Sache hatte er Recht; ich kann ganz sicher Eure Hilfe brauchen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10334, 'deDE', '<Als Ihr die Glocke aus Eurer Tasche holt, läutet Ihr sie ein paar Mal und zeigt sie Bessy, die sie zu erkennen scheint. Die Kuh lässt zu, dass Ihr ihr die Glocke um den Hals hängt und schaut Euch erwartungsvoll an.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10335, 'deDE', 'Ihr wollt mir keinen Bären in die Bandagen binden, oder? Das sind ausgezeichnete Nachrichten!$B$BJetzt, da Ihr die Routinearbeiten für die Vermessung für mich ausgeführt habt, kann ich mein Team in die Ruinen führen und schauen, was wir bergen können.$B$BIhr habt meinen Dank, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10336, 'deDE', 'Wirklich ausgezeichnete Arbeit.$B$BJetzt, da die Dämonen von Culuthas tot sind, kann Zephyrion mit seinem Ausgrabungsteam sicher in die Ruinen von Farahlon zurückkehren.$B$BNehmt dies als Zeichen meiner Dankbarkeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10337, 'deDE', 'Bessy, bist Du das?$B$B<Der Bauer dreht sich zu Euch um.>$B$BVielen Dank, dass Ihr mir meine Bessy zurückgebracht habt, $N. Ich könnte ohne sie nicht leben!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10338, 'deDE', 'Jetzt habt Ihr schon drei Manaschmieden abgeschaltet, $N. Kael\'thas muss sich gerade furchtbar über Euch aufregen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10339, 'deDE', 'Wir müssen alle Daten, die sie in diesem Gebiet aufbewahren, sammeln.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10340, 'deDE', 'Ha ha! Ein frischer $R vom Festland! Nun, keine Sorge - der Trümmerposten kann Euch vielleicht etwas seekrank machen, aber er treibt nicht weit weg!$B$BUnd bisher hat er sich nur einmal auf den Kopf gedreht... oder zweimal.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10341, 'deDE', 'Das habt Ihr gut gemacht, $N. Kaels Armee wird sich nicht so leicht von diesem Schlag erholen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10342, 'deDE', 'Ok! Zutat Nummer eins erledigt.$B$BWenn Ihr noch Lust habt, besorgen wir jetzt etwas, das dem Schieferöl den kleinen Extrakick gibt, um die Rakete in den Wirbelnden Nether zu katapultieren... oder in Stücke zu sprengen, was immer zuerst geschehen mag.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10343, 'deDE', 'Eine Manabombe?$B$B<Morran dreht das Fragment in den Händen.>$B$BEs ist unglaublich! Sogar die hellsten Köpfe in Dalaran hätte eine Waffe wie diese nicht entwerfen können. Das schiere Ausmaß der Explosion muss einen Riss im Nether geöffnet und diesen Kreaturen einen Zugang zu unserem Land verschafft haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10344, 'deDE', 'Ihr habt mit Runetog gesprochen? Er ist ein guter Zwerg, hält seine Greifen gut in Schuss und immer kampfbereit.$B$BIch bin Greifgar, Kommandant des Trümmerpostens. Ich weiß, es ist nicht gerade hübsch hier, aber dieser Felsklotz ist ein wichtiger Stützpunkt für Operationen auf der Höllenfeuerhalbinsel. Man kann hier rund um die Uhr Greifen ein- und ausfliegen sehen.$B$BEinen Rat? Hier ist einer: haltet Eure Ausrüstung bereit, Euren Magen leer und Eure Augen am Horizont... wenn der Trümmerposten anfängt auseinanderzufallen, haltet Euch an etwas fest, was nicht wegfliegen kann!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10345, 'deDE', 'Ihr habt meine Bandagen gerettet, $N. Dass Protektorat wird erfahren, was Ihr heute getan habt, Freund.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10346, 'deDE', 'Wie ist es gelaufen? Ihr seid ja in guter Verfassung... Ist sie gut genug für einen weiteren Flug?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10347, 'deDE', 'Die anderen Windreiterführer halten sehr viel von Euch, $N. Ihr habt in der Abyssischen Untiefe ganz schön aufgeräumt. Macht weiter so!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10348, 'deDE', 'Interessante Wahl, oder? Die heilende Wirkung der Pflanze muss überragend sein. Ich bekomme eine Menge Geld für eine Blume, die eine der unspektakulärsten der Kuppeln ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10349, 'deDE', 'Oh, ausgezeichnet!$B$BIch habe die ganze Zeit gehofft, an ein Stück davon zu kommen, aber Tola\'thion kommt nicht in die Gänge. Er sollte mir eigentlich helfen herauszufinden, was im Himmelssturzgrat vor sich geht. Stattdessen schickt er nur arme Tölpel wie Euch - nichts für ungut - dort hoch auf die Schlachtbank.$B$BWenn Ihr mir den Kristall gebt, kann ich vielleicht herausfinden, in welcher Verbindung er zu den Kolossen steht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10350, 'deDE', 'Ah, Ihr seid also endlich gekommen. Ich bin Behomat und werde Euch in den Künsten eines Kriegers unterweisen. Ruada hat mir von Eurer Prüfung gegen den Felshetzer erzählt und ich bin sehr beeindruckt. Ich habe ein Geschenk für Euch.$B$BWir konnten nur wenig aus den Trümmern der Exodar retten, und das verteilen wir nur an die Würdigsten. Bitte nehmt Euch eine Waffe, die Eurem Kampfstil entspricht, und führt sie mit dem Wissen, dass Ihr sie verdient habt.$B$BWo wir gerade von Kampfstilen sprechen - es ist Zeit, dass Ihr etwas Neues lernt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10351, 'deDE', 'Goliathon? Pathaleon der Kalkulator?$B$BKAEL\'THAS!?$B$BPrinz Kael\'thas hat seine Hand im Spiel?!$B$B<Die Erdbinderin schäumt vor Wut.>$B$BWas er getan hat ist Wahnsinn! Riesige Kristalle vom Himmel zu werfen und das Land zu dezimieren kann nur die Arbeit eines Verrückten sein!$B$BIch verspreche Euch, dass der Zirkel des Cenarius nun, da wir wissen was zu tun ist, jegliche weitere Versuche von Illidan und seinen Streitmächten, so etwas noch einmal zu tun, von uns vereitelt werden.$B$BWir stehen tief in Eurer Schuld, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10353, 'deDE', 'Und Sechs-Uhr? Hat er es geschafft?$B$BWollen wir verdammt noch mal hoffen. Ich konnte keine Verstärkung zu ihnen schicken... Das Astraleum hat nun die ganze Gegend in Beschlag genommen.$B$BEntschuldigt, fast hätte ich Eure Belohnung vergessen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10355, 'deDE', '<Ruam betrachtet die Proben und sieht besorgt aus.>$B$BEs ist so, wie ich es befürchtet habe, $N. Die Austrocknung der Umwelt macht den Kreaturen, die außerhalb eines Sumpfgebiets nie überleben würden, sehr zu schaffen. Wir müssen die Umgebung weiterhin überwachen und die Expedition des Cenarius fragen, ob es etwas gibt, was wir tun können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10365, 'deDE', 'Die Brennende Legion? Unter einer Decke mit Kael? Daran wird Voren\'thal sicher seine Freude haben.$B$BDenkt ihr, dass Tausende von Pilgern von Azeroth hierher kommen, um sich mit der Brennenden Legion zu verbünden? Ich glaube kaum!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10366, 'deDE', '$N, ich habe Euch erwartet.$B$BTullas hat Lobeshymnen auf Euch gesungen, und ich bin sehr begierig darauf, Euch im Weg des Lichts zu unterweisen. Sucht mich auf, wenn Ihr bereit seid, Eure Fähigkeiten und Eure Macht verstehen zu lernen, und ich werde Euch geleiten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10367, 'deDE', 'Ich danke Euch, $N. Dank Eurer Hilfe wird mein Volk bald frei sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10368, 'deDE', 'Ich kann es fühlen, $N! Die Geister kehren zu uns zurück.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10369, 'deDE', 'Es ist wahr, $N. Ich war einst Naladu, der Bewahrer der Erde.$B$BIch war es, der die anderen Mitglieder des Lumpenpacks für leere Versprechungen von Macht verkauft hat. Ihr könnt mich nun verachten, wenn Ihr wollt. Wichtig ist, dass mein Stamm nun wieder frei ist und die Geister zu uns zurückgekehrt sind.$B$BIch werde mich dem Rest des Stammes nicht anschließen, aber nun kann ich in Frieden sterben. Mögen die Geister der Erde unter meinen Brüdern einen neuen Diener finden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10380, 'deDE', 'Es ist also vollbracht. Wir kommen im Auftrag unserer Herren hierher, jagen und töten sie. Es gibt kein Pardon.$B$BManchmal gibt das einem zu denken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10381, 'deDE', 'Die schlechten Nachrichten, die Ihr mir bringt, erfüllen mein Herz mit Traurigkeit. Zwei unserer tödlichsten Feinde schließen sich zusammen und einer der teuersten Söhne Shattraths hat seinen Glauben verloren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10382, 'deDE', 'Das trifft sich gut, $C. Ich bin froh, dass dieser brummige alte Zwerg es endlich auf die Reihe bekommen hat, uns ein wenig Hilfe zu schicken!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10384, 'deDE', '<Ihr haltet die Datenzelle so, dass Ameer die Pläne lesen kann.>$B$BNichts... Verdammt! Sie sind klug, aber nicht so klug wie Ameer!$B$BWorum ich Euch nun bitte, wird etwas gefährlich werden. Ich kann verstehen, wenn Ihr nicht weitermachen wollt, Fleischling.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10385, 'deDE', 'Der Existenzgrund des Protektorats ist nun vollkommen bestätigt.$B$BDas Astraleum ist nicht hier, um Dimensius zu jagen! Sie sind hier, um Leere zu werden!$B$BSie manipulieren die Leerenergien bei dieser Manaschmiede um ihre eigenen Energien an eine Kreatur namens Dunkelpirscher zu binden.$B$BSie benutzen sicherlich einen Protobeschleuniger um die Umwandlung zu vervollständigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10388, 'deDE', 'Ah, $N, Ihr kommt genau zur rechten Zeit. Unsere Späher haben herausgefunden, dass es sich bei den Ansammlungen der Legion auf dem Grat hinter uns tatsächlich um \'Konstruktionslager\' handelt. Dort stellen die Dämonen ihre infernalen Teufelshäscher her. Wenn wir schnell gegen sie vorgehen, können wir vielleicht ihre Produktion aufhalten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10389, 'deDE', 'Bravo, $N. Ich wusste, dass Ihr Erfolg haben werdet! Das Ende der Legion rückt immer näher!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10390, 'deDE', 'Gut gemacht, $C. Ein Konstruktionslager weniger, um das wir uns sorgen müssen. Die Legion wird eine Weile brauchen, um die Einrichtung wieder zum Laufen zu bringen. Ihr habt uns das beschafft, was uns im Augenblick am meisten fehlt: Zeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10391, 'deDE', 'Ich wusste, dass Ihr Biss habt, $N, aber dieses Mal habt Ihr Euch selbst übertroffen! Wir haben die Explosionen dieser verfluchten Kanonen bis hierher gehört! Das müsste der Legion beweisen, dass sie die Söhne Durotars nicht unterschätzen sollten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10392, 'deDE', 'Gelobt seien die Ahnen, Ihr habt es geschafft, $N! Die Legion hat eine schreckliche Niederlage einstecken müssen. Thrallmar ist wieder sicher. Ach, wenn ich doch nur hundert Krieger mit Eurem Herz und Eurem Verstand hätte, dann wäre dieses zerschlagene Land schon längst gezähmt. Ich salutiere vor Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10393, 'deDE', 'Es war ganz richtig von Euch, mir dies zu bringen. Es könnte sich um einen Befehl zur Herstellung von zusätzlichen Teufelshäschern handeln - oder um neue Angriffspläne! Es wird etwas dauern, bis ich es entziffert habe. Lasst mich alleine. Ich lasse Euch rufen, wenn ich Genaueres weiß.$B$B<Magister Blutfalke nickt Euch zu, als Ihr Euch abwendet.>$B$BIhr seid sehr gescheit, $N. Ich werde Eure Fortschritte mit Interesse verfolgen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10394, 'deDE', 'Nun, ich muss zugeben, ich bin beeindruckt, $N. Ich hätte nicht gedacht, dass Ihr den Schneid für diese Mission habt. Wirklich gut gemacht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10395, 'deDE', 'Welch glücklicher Zufall, dass Ihr diesen Schriftwechsel abgefangen habt, $N. Ich werde zwar etwas Zeit brauchen, bis ich ihn entziffert habe, aber ich kann den Hass und die Eile, die in dieser Schriftrolle stecken, deutlich spüren. Ich habe das Gefühl, dass die wahren Pläne der Legion in dieser Welt sich bald offenbaren werden...$B$BGebt mir einen Moment Zeit, um die Schrift zu entziffern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10396, 'deDE', 'Eines muss ich Euch lassen, $N, Ihr seid ein geborener Kämpfer! Diese Tölpel der Horde werden vielleicht nie erfahren, wie knapp sie ihrem Ende entronnen sind. Es erfordert sehr viel Rückgrat, um dem Unheil im Namen seiner eigenen Feinde entgegenzutreten. Genau diese Ehre und dieses Pflichtgefühl machen die Allianz aus!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10397, 'deDE', 'Gute Arbeit! Das sollte die Zahl der Dämonen, die uns auf die Pelle rücken, dramatisch verringern. Ich kann Euch nicht genug für Eure Hilfe danken, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10399, 'deDE', 'Ich habe diesen großartigen Sieg vorausgesehen, $N. Die gesegneten Naaru schenken Euch an diesem Tag ihr Lächeln.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10400, 'deDE', 'Dem Licht sei Dank, ich wusste, dass Ihr es schafft! Arazzius und seine Diener sind Geschichte! Bald wird die Legion nach Hause flüchten und diese geschundene Welt wird wieder sicher sein. Und dann, wenn endlich Gerechtigkeit herrscht, können auch wir nach Hause gehen. $B$BVielen Dank, $N. Die Allianz und die Söhne Lothars feiern Euch heute!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10403, 'deDE', 'Ihr seid gekommen, um meinem Stamm zu helfen, $R? Wie ungewöhnlich. Es gibt nicht viele, die sich um das Schicksal der Zerschlagenen in diesem Land scheren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10405, 'deDE', 'Ausgezeichnet! Jetzt kann ich das Gerät einstellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10406, 'deDE', 'Dank Euch sind ihre Pläne gescheitert! Jetzt bleibt nur noch Eines übrig... Salhadaar.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10407, 'deDE', 'Eure Aufopferung für unsere Sache ist beispielhaft, $N. Jetzt, da wir Socrethars Teleportationsstein in unserem Besitz haben, gibt es nur noch Eines zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10408, 'deDE', 'Seit tausend Jahren, vielleicht mehr, führt Salhadaar nun seinen Kreuzzug, bei dem er alles vernichtet, was ihm im Weg steht. Ich kann kaum glauben, dass wir ihn nun zum letzten Mal gesehen haben... Ihr habt uns einen großen Dienst erwiesen, $N, und dafür sollt Ihr belohnt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10409, 'deDE', 'Es ist vollbracht, $N. Socrethar wurde vernichtet.$B$BIch und die anderen werden uns von unseren Wunden erholen, $N. Der Zorn der Magie Socrethars war jedoch zu viel für den jungen Kaylaan. Nicht einmal meine stärksten Gebete konnten ihn wiederbeleben.$B$BEs ist unendlich schade, dass jemand, der so jung ist, in der Schlacht sterben musste. Am Ende war jedoch sein Wille stark genug, um sich von der Verderbtheit der Legion zu erholen. Dies soll uns ein Trost sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10410, 'deDE', 'Socrethar... Ich erinnere mich an den Namen. Er war einst ein berühmter Krieger des Lichts. Sein einziger Fehler war sein Stolz.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10411, 'deDE', 'Ich hoffe, es ist nicht zu spät. Habt Ihr irgendwelche abnormal große Schleime in der Gegend des Leerenabschaums gesehen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10413, 'deDE', 'WAS!? Ihr habt gegen einen Leerenschrecken gekämpft? Und überlebt?! Unglaublich!$B$BDiese Probe ist ihr Gewicht in Gold wert. Ein Fund wie dieser verlangt eine Belohnung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10416, 'deDE', 'Wie versprochen, $N. Die Gesamtheit der ureigenen Macht des Buches, gepackt in eine einzelne Rune.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10417, 'deDE', '<Mehrdad nickt und betrachtet die Diagnoseergebnisse.>$B$BDas ist beunruhigend. Der Schaden ist größer, als ich befürchtet habe. Ich kann mir aus der Sturmsäule einige Werkzeuge schicken lassen, um Reparaturen durchzuführen, aber das ist sinnlos, wenn wir nicht einmal wissen, was den Schaden verursacht hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10418, 'deDE', 'Das Gebiet sieht schon aufgeräumter aus. Die Kuppeln sind sehr hilfreich, aber ein großer Nachteil ist der unkontrollierte Wuchs, den sie an manchen Orten begünstigen, der die einheimischen Arten schneller wachsen und sich schneller vermehren lässt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10419, 'deDE', 'Die Macht in diesem Folianten ist enorm. Und doch kann er von jemandem mit klarem Verstand in eine einzelne Rune verwandelt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10420, 'deDE', 'Schaut zu, wie die verderbten Materialien sich auflösen. Schaut zu, wie sich Metall in Staub verwandelt.$B$BDas Licht reinigt alles, und nur die reinsten Überreste bleiben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10421, 'deDE', 'Die teuflischen Materialien wurden aus dieser Welt entfernt. Nur das Licht bleibt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10422, 'deDE', 'Danke, $N. Tyralius hat schwere Wunden erlitten, aber wir denken, dass er es schaffen wird.$B$BEr hat ganze Felder voller Gefängnisse erwähnt, die so ähnlich sind wie das, aus dem Ihr ihn errettet habt. Gefängnisse voller Kreaturen aus dem ganzen Universum!$B$BWir werden uns bei Euch melden, wenn wir entschließen sollten, sie zu öffnen. Das Konsortium hat schon angemeldet, dass sie planen, ein paar Teams dorthin zu schicken. Sie arbeiten bereits an einer Technologie, mit der sie die Schlösser des Astraleums aufbrechen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10423, 'deDE', '<Ihr stellt Euch vor und meldet die Ergebnisse von Mehrdads Diagnose bei der Biokuppel Mittelreich.>$B$BMehrdad ist nur ein einfacher Techniker, aber er hat ein gutes Auge fürs Detail. Wenn seine Beobachtungen richtig sind, müssen wir auch bei den restlichen Kuppelgeneratoren so schnell wie möglich Diagnosen durchführen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10424, 'deDE', 'Diese Ergebnisse entsprechen denen von Mehrdad genau, aber warum? Der einzige Grund, den ich mir vorstellen kann, ist, dass etwas von der Ausrüstung der Kuppelgeneratoren kaputtgegangen ist oder fehlt. Das würde dazu führen, dass die Kuppeln stark geschwächt werden und aus dem Gleichgewicht geraten, so wie es in der Diagnose deutlich wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10425, 'deDE', '<Kommandant Ameer scheint zufrieden zu sein.>$B$BGut gemacht, Fleischling! Dieser Soldat ist vielleicht der Schlüssel zur Vereitelung aller Pläne des Astraleums.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10426, 'deDE', 'Oh je! Die Energie der Kuppel zu bündeln hat zur Folge, dass die Kreaturen bis zu dem Punkt wachsen, an dem sich eine große Aggressivität entwickelt. Wenn wir die Möglichkeit bekommen, diese Technologie einzusetzen, müssen wir sie auf jeden Fall richtig einstellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10427, 'deDE', 'Ausgezeichnete Arbeit. Ich werde die, die Ihr markiert habt, genau im Auge behalten, um zu beobachten, ob sie genauso schnell wie die anderen Lebensformen in der Kuppel wachsen.$B$BMit der richtigen Überwachung könnten wir diese Technologie benutzen, um die zerstörten Gegenden in der Scherbenwelt und Azeroth wiederzubeleben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10428, 'deDE', 'Meine Familie... Was habe ich getan... Was hätte ich tun sollen?$B$BWarum werde ich so bestraft?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10429, 'deDE', '<Aurine nimmt das Herz an sich.>$B$BSogar für eine Kreatur von dieser Größe ist das Herz viel zu groß. Es musste sich sehr anstrengen, um mit dem riesigen Körper Schritt halten zu können. Ich habe keine Zweifel, dass sie nach der Hälfte ihrer normalen Lebenserwartung gestorben wäre.$B$BTrotz dieser Risiken bin ich entschlossen, die Astralen davon zu überzeugen, ihre Technologie mit anderen zu teilen. Es ist zu viel versprechend, als dass wir jetzt aufgeben sollten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10430, 'deDE', 'Er sieht ein wenig merkwürdig aus. Ghabar hatte sicher nicht den Nethersturm im Hinterkopf, als er ihn entwickelt hat.$B$BSchaut nicht so überrascht drein, $N. Der Nethersturm ist harmlos im Vergleich zu einigen Orten, an denen ich gearbeitet habe. Doch eine kaputte Kuppel ist immer ein Grund zur Sorge.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10431, 'deDE', 'Seid Ihr die ganze Hilfe, die Orelis schickt? Er muss eine hohe Meinung von Euch haben.$B$BLasst es uns hinter uns bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10432, 'deDE', 'Das ist eine große Sache, $N. Sehr groß!$B$BVoren\'thal möchte sicher so früh wie möglich davon erfahren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10433, 'deDE', '<Shauly gibt vor, die Pelze zu bewundern.>$B$BSie sind wundervoll, wirklich wundervoll! Ich werde Euch den besten Preis dafür bezahlen! Was kosten mich Eure Dienste?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10434, 'deDE', '<Ihr stellt Euch vor und sagt, dass Shauly Euch geschickt hat.>$B$BAh, ja, wir haben jemanden erwartet, der uns dabei hilft, äh - ein paar, mh, Güter zu transportieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10435, 'deDE', 'Ausgezeichnete Arbeit! Der schwierigste Teil unseres Projekts ist damit erledigt. Jetzt müssen wir nur noch einen Weg finden, diese hier zurück zu Area 52 zu bringen und auch das Interesse der Expedition des Cenarius zu wecken. Es sollte hier genug geben, um unsere eigenen Interessen zu decken und noch ein wenig Gewinn zu machen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10436, 'deDE', 'Gut gemacht. Wie es aussieht, ist alles in Ordnung. Wir können anfangen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10437, 'deDE', 'Ausgezeichnet. Mit diesen Fragmenten können wir die Bombe einstellen, die die Leerenergieversorgung auf der Manaschmiede Ultris zerstören kann. Dann wird Dimensius\' Verbindung zur Leere unterbrochen und er kann sich nicht mehr verteidigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10438, 'deDE', 'Es ist Zeit zuzuschlagen! Nun, da der Riss fort ist, kann Dimensius mit Kraft und Magie angegriffen werden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10439, 'deDE', 'Seit tausend Jahren kennen wir nur noch Krieg. Wir haben unser Volk gegen die Angriffe der Leerwesen und der Astralen verteidigt.$B$BJetzt ist einer unserer schlimmsten Feinde gefallen - endlich.$B$BIch überbringe Euch den Dank von Milliarden von Astralen, Fleischling.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10440, 'deDE', 'Ich setzte meine Techniker sofort auf die Reparaturen an.$B$BTashars Vermutung, dass es sich um Sabotage handelt, macht mir jedoch Sorgen. Ich kann mir nicht vorstellen, dass jemand waghalsig genug wäre, unsere Technologie zu stehlen. Zumindest niemand, der weiß, wozu wir fähig sind. Vielleicht ist es an der Zeit, die Sturmsäule abzuriegeln.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10442, 'deDE', 'Oh, gut, Ihr müsst die Hilfe sein, die ich vor Wochen von der Falkenwacht angefordert habe.$B$BNun, jetzt seid Ihr hier und es gibt viel zu tun. Ich habe genau das Richtige für Euch für den Anfang.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10443, 'deDE', 'Oh, gut, Ihr müsst die Hilfe sein, die ich vor Wochen vom Tempel von Telhamat angefordert habe.$B$BIch bin froh, dass Ihr hier seid; es gibt viel zu tun. Ich habe genau das Richtige für Euch für den Anfang.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10444, 'deDE', 'Bombenteile. Dann war mein Verdacht also berechtigt. Ich hätte mir gewünscht, dass ich falsch liege.$B$BOk, wir haben also eine grausame Aufgabe vor uns.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10446, 'deDE', 'IHR HABT ES GESCHAFFT! IHR HABT ALLERIAS FESTE GERETTET!!$B$BJetzt, da ihre Streitkräfte dezimiert sind, ihr Anführer tot und die Manabombe zerstört ist, können wir alle etwas aufatmen.$B$BNie zuvor habe ich solche Selbstlosigkeit, solchen Heldenmut gesehen! Bitte, nehmt dies in unser aller Namen an!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10447, 'deDE', 'IHR HABT ES GESCHAFFT! IHR HABT DIE STEINBRECHERFESTE GERETTET!!$B$BJetzt, da ihre Streitkräfte dezimiert sind, ihr Anführer tot und die Manabombe zerstört ist, können wir alle etwas aufatmen.$B$BNie zuvor habe ich solche Selbstlosigkeit, solchen Heldenmut gesehen! Bitte, nehmt dies in unser aller Namen an!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10448, 'deDE', 'Bombenteile. Dann war mein Verdacht also berechtigt. Ich hätte mir gewünscht, dass ich falsch liege.$B$BOk, wir haben also eine grausame Aufgabe vor uns.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10449, 'deDE', 'Ah ja. Das Blut des Knochenmalmerklans. Ich interessiere mich sehr für diese Orcs... sie sind zwar immer noch die verkommenen Feinde unserer Vergangenheit, aber ihre Stärke und Macht ist größer, als ich gedacht habe...$B$BNun, wollen wir beginnen, oder?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10450, 'deDE', 'Hah! Ihr habt also die Knochenmalmer, unsere verkommenen Vettern getroffen. Gut gemacht, $N. Ich bedauere nur, dass nicht mehr von ihnen ihr Leben lassen und ihr Blut vergießen konnten, um meinen Zorn zu besänftigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10451, 'deDE', 'Gelobt sei die Erdenmutter! Ich bin mir sicher, dass Wilda nach Hause finden wird. Bitte nehmt dies als Zeichen unserer Wertschätzung.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10455, 'deDE', 'Das ging schnell. Seid Ihr sicher, dass Ihr so viele getötet habt, wie es nötig war?$B$BGut, dann könnt Ihr uns bei einer weiteren Angelegenheit helfen, wenn Ihr möchtet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10456, 'deDE', 'Gut. Ich werde schauen, ob ich aus diesen Schwänzen etwas Nützliches machen kann.$B$BDie Horde wird ohne Zweifel einen Weg finden, Ihr Wolfsrudel wieder zu vergrößern, aber nun können wir etwas freier durchatmen.$B$B$N, wenn Ihr dazu bereit seid, habe ich eine letzte Bitte an Euch, um Sylvanaar und den Lebenden Hain zu verteidigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10457, 'deDE', 'Nun, da Ihr die Verteidigung des Hains verstärkt habt, fühle ich mich viel sicherer.$B$BIhr habt Euch mehr als nur unseren Dank und unsere Wertschätzung verdient.$B$BMir fällt gerade ein, dass es da noch etwas gibt, bei dem ich Eure Hilfe brauchen könnte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10458, 'deDE', 'Wenn alle Elementarseelen dieser Gegend in diesem Totem eingefangen sind, werden wir mit ihnen reden und herausfinden, ob wir etwas für das Schattenmondtal tun können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10476, 'deDE', 'Ihr beweist Euch allmählich als wertvoller wertvoller Verbündeter und Kämpfer. Macht weiter so!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10477, 'deDE', 'Ihr beweist Euch weiterhin als wertvoll, $N. Möge Eure Stärke nie versagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10478, 'deDE', 'Ihr beweist uns auch weiterhin Eure Stärke und Ehre, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10479, 'deDE', 'Ihr seid wirklich ein starker Verbündeter, $N. Den Ogern der Scherbenwelt Auge in Auge gegenüberzutreten ist nichts, was jeder einfach so tun kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10480, 'deDE', 'Und zurück bleibt nichts als Luft, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10481, 'deDE', 'Erlaubt mir, dass ich Euch für diese wagemutige Tat belohne, Held.$B$BJetzt müssen wir uns an die Arbeit machen! Bitte tretet zurück, damit ich das Totem aufstellen und die Seelen freilassen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10482, 'deDE', 'Sehr gut. Ich bin mir sicher, dass ihr Verlust in der Höllenfeuerzitadelle bemerkt wird. Auch wenn diese dunkle Bastion uns überschattet und unüberwindlich scheint, können wir mit stolzen Taten wie Eurer sicher einen Weg finden, sie zu besiegen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10483, 'deDE', 'Ah, Ihr habt ein Insigne von den Orcs des Blutenden Auges ergattert? Gut! Es ist eine Schande, dass sie unsere Symbole gegen uns verwenden und sich über unsere Kameraden, die im Kampf gegen diese rothäutigen Bestien gefallen sind, lustig machen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10484, 'deDE', 'Danke, $N. Mein Herz ist voller Trauer, wenn ich diese Talismane betrachte. Sie unterstreichen die zahlreichen Verluste, die wir in der Ehrenfeste gegen die Höllenorcs hinnehmen mussten. Aber es freut mich zu sehen, dass Ihr Erfolg gegen sie hattet. Wenn wir genügend von ihnen töten können, treten wir vielleicht als Sieger aus diesem Krieg hervor.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10485, 'deDE', 'Ihr habt es geschafft! Morkh ist tot! Jetzt haben wir eine Chance im Kampf gegen die Bestien der Höllenorcs!$B$BVielen Dank, $N. Eure Hilfe in diesem Krieg ist unermesslich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10486, 'deDE', 'Das ging schnell. Seid Ihr sicher, dass Ihr so viele getötet habt, wie nötig war?$B$BGut. Es gibt noch eine weitere Aufgabe, bei der wir Eure Hilfe benötigen. Eine weitaus wichtigere.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10487, 'deDE', 'Ihr habt nicht nur ihre Verteidigung geschwächt. Mit dem Staub werden wir dazu noch unsere eigene Verteidigung gegen die Allianz stärken können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10488, 'deDE', 'Nun, da Ihr die Wölfe und unsere Verteidigung gestärkt habt, können wir uns wieder einigen tödlicheren Angelegenheiten, wie zum Beispiel den Ogern, zuwenden.$B$BIhr habt uns hier gut geholfen. Wenn Ihr Euch entscheidet zu bleiben, könnten wir auch weiterhin die Dienste von jemandem, der so fähig ist wie Ihr, brauchen.$B$BWie auch immer Ihr Euch entscheiden mögt, Ihr habt meinen Respekt und meine Wertschätzung sicher.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10489, 'deDE', 'Starkast Tiefwurz\' Stumpf! Habt Ihr ihn selbst gefällt?$B$BSicher habt Ihr das. Wisst Ihr, ein starker $C wie Ihr es seid, ist genau die Hilfe, nach der Rexxar und ich gesucht haben. Besonders bei den ständigen Problemen, die wir mit den Ogern haben, könnten wir Euch brauchen. Setzt Euch mit mir in Verbindung, wenn Ihr Interesse habt.$B$BNun, dieser Stumpf ist ein stichhaltiger Beweis. Ihr seid hier, um das Kopfgeld einzustreichen, nicht um mit mir zu plaudern. Wohlan, sucht Euch etwas aus.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10502, 'deDE', 'Das ist ein guter Anfang, um Sylvanaar und den Hain zu schützen.$B$BJetzt, da die Oger nicht mehr ganz so zahlreich sind, überlegen die Blutschläger es sich sicher zweimal, bevor sie uns hier angreifen.$B$BWenn das doch nur der einzige Ogerstamm wäre, mit dem wir Probleme hätten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10503, 'deDE', 'Das ist ein guter Anfang, um unsere Position hier gegen die Oger zu verteidigen.$B$BJetzt, da die Oger nicht mehr ganz so zahlreich sind, überlegen die Speerspießer es sich sicher zweimal, bevor sie versuchen, die Donnerfeste zurück zu erobern.$B$BWenn das doch nur der einzige Ogerstamm wäre, mit dem wir Probleme hätten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10504, 'deDE', 'Eure Taten gegen die Blutschläger und Speerspießer sind ein großer Schritt nach vorne für die Sicherung der Zukunft Sylvanaars. Als wir hier ankamen, fanden wir diesen Flecken Land unbewohnt. Wir haben kein Interesse daran, uns noch weiter auszubreiten, aber wir werden auch nicht dulden, dass man uns vertreibt.$B$BDa Ihr uns gute Dienste geleistet habt, möchte ich Euch mit der Wertschätzung der Allianz belohnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10505, 'deDE', 'Eure Taten gegen die Blutschläger und Speerspießer sind ein großer Schritt nach vorne für die Sicherung der Zukunft der Donnerfeste. Wir werden nicht dulden, dass sich jemand unserem Schicksal in den Weg stellt.$B$BDa Ihr uns gute Dienste geleistet habt, möchte ich Euch mit der Wertschätzung der Horde belohnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10506, 'deDE', 'Ich bin froh zu hören, dass es geklappt hat. Je weniger Wesen der Natur sterben müssen, desto besser.$B$BIch muss sagen, dass ich Euch nach all dem, was Ihr für uns getan habt, ins Herz geschlossen habe.$B$BGebt auf Euch Acht, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10507, 'deDE', 'Ich verfügt über unglaubliche Kraft, $N. Die Seher können sich glücklich schätzen, Euch als Verbündeten zu haben.$B$BWenn sich die Nachricht von Kaels neuem Bündnis verbreitet, werden mehr Leute die Sache wie wir sehen. Die Tatsache, dass wir einen solch entscheidenden Sieg über Kael\'thas errungen haben, bringt uns in eine äußerst günstige Lage.$B$BIch werde Eure Taten nicht vergessen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10508, 'deDE', 'Ihr erstaunt mich immer wieder, $N! Gut, dass Ihr auf unserer Seite steht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10509, 'deDE', 'Ihr habt keine Ahnung, was das für die Seher bedeutet, $N. Ihr müsst mich entschuldigen, während ich nach Atem ringe und die Situation einschätze.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10510, 'deDE', 'Ooh, so wie sie aussehen, handelt es sich hierbei um ganz tolle Exemplare! Ich kann es kaum abwarten, sie mit meinen Untersuchungsgeräten genau unter die Lupe zu nehmen!$B$BVielen Dank!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10511, 'deDE', 'Was riecht hier so? Oh nein, bitte sagt mir nicht, dass dies das Ogergebräu ist?$B$BIch habe fast schon Angst, es zu probieren. Ach zur Hölle, was soll\'s? Hoch die Tassen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10512, 'deDE', 'Ah, hahaha! Das habe ich mir gedacht. Oger trinken wahrscheinlich alles.$B$BWas für ein dummer Haufen!$B$BAuch wenn ich mein Gebräu nicht bekommen habe, habt Ihr mir doch einen guten Start in den Urlaub bereitet.$B$BIch sage Euch was... wir haben hier allen möglichen Kram, den wir nicht wirklich brauchen. Kann ich Euch etwas davon anbieten?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10513, 'deDE', 'Litanei der Verdammnis? Nie davon gehört. Hört auf meinen Rat und lasst die Toten ruhen.$B$BAber wenn Ihr schon hier seid, könnt Ihr mir ja gleich bei ein paar Dingen helfen. Was meint Ihr?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10514, 'deDE', 'Ihr sagt, da waren viel mehr Felshetzer, als Ihr erwartet habt? Sieht aus, als wäre es an der Zeit, die Situation etwas zu entschärfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10515, 'deDE', 'Das wird den verdammten, bösartigen Tieren zeigen, dass man meine Eber nicht töten sollte! Gut gemacht, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10516, 'deDE', 'Ich stehe tief in Eurer Schuld, denn Ihr habt mir meine Ehre wiedergegeben. Aber unsere Arbeit hier ist noch nicht vorüber.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10517, 'deDE', 'Sehr gut. Ihr seid ein sehr gewitzter $C, so viel ist sicher.$B$BIch frage mich, ob Ihr wohl noch eine Sache für mich und Sylvanaar tun könntet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10518, 'deDE', 'Gurn Grubnoshs Helm und ein Banner der Speerspießer?$B$BEin ziemlich gewitzter Plan von der Verteidigerin und Euch.$B$BWenn die Blutschläger weiter mit den Speerspießern beschäftigt sind, nimmt uns das viel von dem Druck, unter dem wir hier in letzter Zeit leiden.$B$BBitte, $N, nehmt dieses bescheidene Geschenk von Sylvanaar an.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10519, 'deDE', 'Versteht Ihr, was getan werden muss? Findet die Söhne Oronoks. Findet meine Jungs...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10521, 'deDE', '<Grom\'tor grunzt.>$B$BGut, dass Ihr hier seid. Diese Made hat gerade geplaudert. Jetzt haben wir sie!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10522, 'deDE', 'Das müsst Ihr sofort zurück zu Vater bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10523, 'deDE', 'Wenn die Litanei der Verdammnis wieder zusammengefügt ist, werden wir diesen Fluch beenden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10524, 'deDE', 'Ich kann meinen Augen nicht trauen! Wenn das ein Scherz sein soll, ziehe ich Euch die Haut vom Leibe, $C!$B$BSchnell, lasst mich diese unschätzbaren Artefakte untersuchen, bevor Ihr sie noch mit Euren zwei linken Händen zerbrecht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10525, 'deDE', 'In der Draenethystmine? Die Blutschläger müssen es von dem Speerspießern gestohlen haben.$B$BPah! Das ist zu weit weg... zu tief im Blutschlägergebiet, als dass ich dorthin reisen könnte.$B$BAber Ihr! Ihr kennt den Weg. Ihr sollt an meiner statt dorthin gehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10526, 'deDE', 'Ich bin beeindruckt. Könnt Ihr Euch überhaupt vorstellen, wie viele zuvor bei dem Versuch, die Relikte zu bergen, gestorben sind?$B$BWir können uns glücklich schätzen, dass Ihr hier mit uns zusammenarbeitet, $N. Auch wenn Ihr etwas langsam seid.$B$BErlaubt mir, Eure Aufopferung für unsere Sache zu belohnen. Wählt, aber wählt weise. Wenn Ihr fertig seid, werde ich die Geister der Donnerfeste besänftigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10527, 'deDE', 'Ar\'tors Körper hängt leblos in der Luft. Ihr wisst nicht, wie lange er schon tot ist, aber Euch überkommt große Traurigkeit für Oronok.$B$BVielleicht solltet Ihr versuchen, seine Leiche zu seinem Vater zu bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10528, 'deDE', 'Ihr steckt den Schlüssel in die Öffnungen im unteren Teil jedes dämonischen Kristalls.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10537, 'deDE', 'Der Name bedeutet in meiner Sprache \'Heldenruh\'. Und auch jetzt, in einer Gegend, in der all unsere Helden gestorben sind, bewahrheitet er sich.$B$BUnd doch scheint einer sich immer wieder zu erheben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10538, 'deDE', 'Sehr gut. Jetzt kann ich meine Tests viel leichter durchführen...$B$BVielen Dank, $N. Eure Begabungen sind beachtlich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10540, 'deDE', '<Ar\'tors Silhouette wird unscharf und wieder schärfer.>$B$BEs scheint, als wäre meine Zeit bald zu Ende, Held.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10541, 'deDE', '<Oronok wischt sich die Träne aus dem Auge und lächelt Euch an.>$B$BDanke. Ich verspreche Euch, Held, dass ein ehrenhaftes Lied über Euch erklingen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10542, 'deDE', 'Ja, genau davon hat T\'chali geredet! Ist sich nicht ganz sicher, was die Oger da reingetan ham. Die Pfeife riecht nicht nach T\'chalis Tabak.$B$BEgal, T\'chali ist glücklich. Sogar so glücklich, dass er Euch um einen weiteren Gefallen bitten will.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10543, 'deDE', 'T\'chali ist zufrieden, dass Korgaah und Grimnok Schlachttaufe jetzt auch die Radieschen von unten anschauen.$B$BAber T\'chalis Rachedurst ist noch nicht gestillt. Ihr müsst noch etwas anders machen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10544, 'deDE', 'Hahaha, Rache ist süss!$B$BAber T\'chali sieht, dass Ihr nun, da meine Rache verübt wurde, gerne weiterziehen wollt. Ich versteh\' schon, Kumpel... lassen wir das Leben den Lebenden.$B$BIch sag\' Euch was, T\'chali hat hier immer noch ein paar Sahnestückchen in seinem Grab. Sucht Euch aus, was Euch am besten gefällt!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10545, 'deDE', 'Das sind gute Nachrichten! Das Gebräu wird bei der nächsten Aufgabe, die T\'chali für Euch hat, nützlich sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10546, 'deDE', '<Borak ist für einen Moment still.>$B$BIch beobachte diese Blutelfen schon seit Wochen und versuche herauszufinden, wo sie den dritten Teil der Litanei der Verdammnis aufbewahren.$B$BSo weit habe ich jedoch keine brauchbaren Hinweise sammeln können. Ich weiß nur, dass Illidan einmal am Tag einen Entsandten vom Schwarzen Tempel herschickt.$B$BDieser Entsandte ist unantastbar. Ich habe ihn eine Woche lang überwacht und nach einem Weg gesucht, ihn von seiner Leibwache zu trennen. Die Leibwache verlässt jedoch unglücklicherweise nie seine Seite.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10547, 'deDE', 'Ihr habt ein verfaultes Arakkoaei? Nun, warum habt Ihr das denn nicht gleich gesagt? Ich denke, wir sind im Geschäft.$B$B<Tobias lächelt und entblößt dabei eine Reihe verfaulter und vergilbter Zähne.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10550, 'deDE', 'Jetzt müssen wir die Falle stellen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10551, 'deDE', 'Seid Ihr Euch Eurer Wahl sicher, $N? Die Aldor heißen Euch gerne als Verbündeten willkommen, aber die Seher werden Euch Eure Entscheidung nicht so leicht vergeben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10552, 'deDE', 'Seid Ihr Euch Eurer Wahl sicher, $N? Die Seher heißen Euch gerne als Verbündeten willkommen, aber die Aldor werden Euch Eure Entscheidung nicht so leicht vergeben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10553, 'deDE', 'Khadgar hat einen neuen Rekruten geschickt? Dann wollen wir Euch mal beschäftigen, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10554, 'deDE', 'Willkommen, $N. Ich bin froh, dass Ihr Euch entschieden habt, unserer Sache beizustehen. Möge das Licht Euch stets beschützen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10555, 'deDE', 'Ihr blättert die Seiten voll gekritzelter Notizen in der dünnen Schrift der Arakkoa der Lashh\'an durch und findet ein Piktogramm, das die Kreise der Macht, die Ihr im Lashhversteck gesehen habt, darstellt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10556, 'deDE', 'Ich weiß nicht, was ich sagen soll. Dieser Zauber ist sehr merkwürdig. Es handelt sich nicht um eine einfache Beschwörung oder Verzauberung, sondern eher um eine Art Vereinigungs- oder Kommunikationszauber.$B$BIch weiß nicht, was ich davon halten soll, $N. Ich muss noch ein wenig darüber nachdenken.$B$BAber trotzdem vielen Dank für Eure Hilfe! Ich bin sicher, dass ich früher oder später dahinter komme.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10557, 'deDE', 'Wow, Ihr habt es geschafft! Und kein einziger blauer Fleck oder offener Knochenbruch! Seht Ihr, ich habe Euch doch gesagt, dass alles funktionieren wird!$B$BHier ist Eure Bezahlung, $N. Ich habe die Arztkosten gleich dazu gerechnet, aber da Ihr sie nicht gebraucht habt, seht es einfach als kleinen Bonus an!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10562, 'deDE', 'Danke, dass Ihr meine Männer unterstützt habt, $N. Mit Eurer Hilfe und der Hilfe anderer, können wir vielleicht noch länger durchhalten. Unglücklicherweise ist Durchhalten leider nicht genug. Wir müssen zum Angriff übergehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10563, 'deDE', '<Schwadronskommandant Nuainn hört sich Euren Bericht an und wird mit jedem Satz nervöser.>$B$BIhr sagt also, dass sie genügend Höllenbestien haben, um die Angriffe noch zu verstärken? Wenn wir sie nicht aufhalten, bevor sie die nächste Phase ihres Plans umsetzen können, ist die Wildhammerfeste verloren!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10564, 'deDE', 'Gut gemacht, $N! Ich wünschte, ich könnte behaupten, dass die Legion nach einem Rückschlag wie diesem aufgeben wird, aber das würdet Ihr mir ohnehin nicht glauben. Die Todesschmiede, von der Ihr erfahren habt, wird unser nächstes Ziel sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10565, 'deDE', 'Ah, schaut nur, wie er leuchtet! Ich muss ihn sofort ausprobieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10566, 'deDE', 'Diese Informationen werden uns sehr viel weiterhelfen, $N. Ich werde den Zauberstab noch verbessern und schauen, ob wir ihn auch für weitere Zwecke einsetzen können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10567, 'deDE', 'Ihr habt ihn!$B$BMit diesem Anhänger werde ich dafür sorgen können, dass Ihr die Sprache der Arakkoa aus Grishnath versteht.$B$BHiermit werden wir die Arakkoa und das Wesen des Raben besser verstehen lernen. Ich brauche dazu Eure Hilfe.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10568, 'deDE', 'Die Schrifttafeln von Baa\'ri! Ja, die werden uns sehr wichtige Informationen liefern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10569, 'deDE', '<Kieran wirft einen kurzen Blick auf die Tagebuchseiten.>$B$BVieles davon ist unleserlich, aber ich kann hier und da ein paar Worte verstehen. Es geht um eine fehlgeschlagene Vorbereitung eines Zaubers, Opfer und eine sich verschlechternde Situation. Hier steht auch irgendetwas Merkwürdiges über einen \'Deserteur\'.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10570, 'deDE', '<Borak nimmt den Schriftwechsel und beginnt zu lesen.>$B$BGerissene Hunde! Dies ist eine Anordnung von Illidan, die besagt, wo die Litanei der Verdammnis als Nächstes versteckt werden soll. Offensichtlich ändern sie den Aufenthaltsort ständig. Aber wir wissen leider nicht, wo sie sich im Augenblick befindet... Wenn wir diesen Brief doch nur abliefern könnten, jetzt, da wir wissen, wo sie die Litanei verstecken werden.$B$BWie schade, dass das Siegel nun zerbrochen und der Brief damit nutzlos ist.$B$BHmm... Es sei denn...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10571, 'deDE', 'Akamas Handschrift. Es ist wirklich sehr traurig, was aus jemandem werden konnte, der so weise und beliebt war wie er.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10572, 'deDE', '<Der Schwadronskommandant setzt den Kraftkern in die Rüstplatten und versiegelt nickend das Gerät.>$B$BDas sollte klappen. Und es sollte auch eine ziemlich große Explosion von sich geben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10573, 'deDE', '<Der Zwerg nickt.>$B$BVerstärkung ist gut. Wir haben bisher grundlegende Informationen über die Pläne des Schattenrats hier gesammelt, aber ich wäre sehr froh, wenn wir endlich gegen sie vorgehen könnten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10574, 'deDE', 'Ja! Die vier Fragmente des Medaillons. Und nun setzt sie zusammen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10575, 'deDE', 'Wir haben Euch erwartet, $N. Akama sagte, dass Ihr früher oder später kommen würdet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10576, 'deDE', 'Gut gemacht, $N. Ich hoffe, Ihr seid ein guter Schauspieler. Der nächste Schritt erfordert etwas Theatralik!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10577, 'deDE', 'Jetzt müsst Ihr nur noch die Litanei besorgen. Einfach, oder?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10578, 'deDE', 'Endlich! Das Fragment der Litanei gehört uns!$B$B<Borak verstaut das Fragment in einer Schließkassette.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10579, 'deDE', 'Sobald alle drei Teile der Litanei zusammengefügt sind, wird es wieder bekannt.$B$BDieses Dokument zu besorgen war zweifellos eine große Herausforderung. Für einen solchen Heldenmut müsst Ihr belohnt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10580, 'deDE', 'SYLVANAAR? KOMMANDANT HIMMELSSCHATTEN?$B$BKEIN DATENBANKEINTRAG!$B$BTRETET ZURÜCK, BEVOR ICH MICH GEZWUNGEN SEHE, EUCH MIT LAUTEN GERÄUSCHEN ZU QUÄLEN!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10581, 'deDE', 'In Ordnung, wollt Ihr Euch nützlich machen? Gut, ich habe genau die richtige Aufgabe, mit der Ihr Euch beweisen könnt.$B$BIch glaube, Ihr werdet sie mögen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10582, 'deDE', 'Ich wünschte, ich hätte mit Euch gehen können! Ich brenne schon die ganze Zeit darauf, meinen Hammer benutzen zu können, aber mein Auftrag ist es, zu beobachten, nicht zu töten.$B$BJetzt, da Ihr ein Loch in ihre Verteidigung geschlagen habt, lasst uns die Produktion in der Todesschmiede zum Stillstand bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10583, 'deDE', '<Ewan schüttelt den Kopf und nimmt Euch den Beutel ab.>$B$BIch glaube nicht, dass Flanis sich im Klaren darüber war, wie schwer die Todesschmiede bewacht ist. Jetzt, da wir wissen, was tatsächlich dort vor sich geht, mache ich ihnen keinen Vorwurf. Ich wünschte nur, dass Flanis es gewusst hätte, als er dort hinein gegangen ist.$B$BIch kann nur hoffen, dass irgendetwas in diesem Beutel uns dabei helfen kann, die Todesschmiede ein für alle Mal auszuschalten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10584, 'deDE', 'Ausgezeichnet! Mit der ganzen Energie, die Ihr gesammelt habt, werden wir die Maschinerien für eine Weile am Laufen halten können.$B$BDas Zephyriumkapazitorium ist ein echter Schluckspecht, wenn es um den Energieverbrauch geht!$B$BIch hoffe, mit den Elektromentaren fertigzuwerden war nicht allzu schwierig. Ich habe noch eine andere Aufgabe für Euch. Ich fürchte, sie wird etwas schwerer werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10585, 'deDE', 'Gut gemacht, $N. Die Beschwörung des Schattenrats zu unterbrechen bringt uns einen Schritt näher an die Abschaltung der Todesschmiede.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10586, 'deDE', '<Ihr erstattet dem Schwadronskommandanten Bericht und übergebt die gefundenen Befehle.>$B$BKriegshetzer Razuun zu besiegen sollte eigentlich das Ende unserer Probleme mit der Legion bedeuten, aber in diesen Befehlen steht deutlich mehr, als ich befürchtet hatte. Ich glaube, wir haben noch viel zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10587, 'deDE', 'Wollen wir uns diese Waffen einmal genauer ansehen, $N. Hmmm... das ist ziemlich beunruhigend.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10588, 'deDE', '<Erdheiler Torlok nimmt Euch die Litanei der Verdammnis ab.>$B$BIhr habt getan, worum Euch die Elemente gebeten haben. Dafür sind wir sehr dankbar. Ihr werdet belohnt werden, doch der Ärger lauert noch immer auf uns. Die Geister des Feuers sind in Aufruhr. Es wurde eine Forderung vorgebracht. Ein weiterer kennt die Litanei der Verdammnis.$B$BIch weiß, das klingt sehr kryptisch, aber das ist alles, was die Geister mir mitgeteilt haben. Das und dieses Symbol...$B$B<Erdheiler Torlok dreht sich um und zeigt gen Himmel.>$B$BWas könnte das wohl bedeuten?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10589, 'deDE', 'Lasst mich schauen, ob ich herausfinden kann, wie das funktioniert...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10594, 'deDE', 'Oh, das ist außergewöhnlich! Ich hatte ja keine Ahnung... Es ist fast so, als wären die Kristalle lebendig!$B$BIch frage mich, ob eine Art symbiotische Beziehung zwischen ihnen und den Netherdrachen besteht.$B$BVielen Dank, vielen Dank! Ihr müsst etwas aus meiner Kuriositätensammlung nehmen, das ich nichtmal im Tode anziehen würde!$B$BAn Euch könnte etwas davon jedoch gut aussehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10595, 'deDE', 'Ich bin beeindruckt, dass Ihr dieses Gemetzel überlebt habt. Ihr seid vielleicht genau die Person, die wir für einen gefährlichen Auftrag brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10596, 'deDE', '<Blutwache Gulmok hört sich Euren Bericht an und wird mit jedem Satz nervöser.>$B$BWas meint Ihr mit sie wollen ihre Angriffe noch verstärken? Das können wir nicht zulassen. Kehrt dorthin zurück und kümmert Euch darum, solange in Schattenmond noch ein Stein auf dem anderen steht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10597, 'deDE', '<Gulmok platziert den Kraftkern in dem Gehäuse und versiegelt es.>$B$BDas sollte funktionieren. Ich möchte nicht in der Feste sein, wenn das Ding hochgeht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10598, 'deDE', '<Gulmok nickt grimmig.>$B$BWir haben keine Zeit zu feiern, $N. Noch sind wir nicht aus der Schusslinie. Ich habe neue Befehle für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10599, 'deDE', '<Der Orc nickt.>$B$BVerstärkung ist gut. Wir haben zwar schon grundlegende Informationen darüber gesammelt, was der Schattenrat dort drin vorhat, doch es ist Zeit zuzuschlagen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10600, 'deDE', 'Ich wäre ja selbst dorthin gegangen und hätte ein paar Schädel zertrümmert, aber ich habe strengste Anweisungen, mich nicht auf einen direkten Kampf mit dem Feind einzulassen.$B$B<Der Späher grummelt und imitiert Blutwache Gulmoks Stimme.>$B$BLasst uns die Produktion in der Schmiede zum Stillstand bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10601, 'deDE', '<Zagran schüttelt den Kopf und nimmt Euch den Beutel ab.>$B$BIch habe Euch doch gesagt, dass er ein Dummkopf ist. Ich hoffe, dass in diesem Beutel irgendetwas ist, die Zeit, die Ihr mit der Suche nach ihm verbracht habt, rechtfertigt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10602, 'deDE', 'Gut. Wir machen Fortschritte. Das bringt uns einen Schritt näher an die Abschaltung diese Monstrosität. Bald können wir sicher nach Schattenmond zurückreisen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10603, 'deDE', '<Ihr erstattet der Blutwache Bericht und übergebt die gefundenen Befehle.>$B$BGute Arbeit, $N, aber denkt nicht, dass Ihr dafür einen Orden verliehen bekommt. Die Nachtelfen mögen vielleicht ihre hübschen kleinen Uniformen dekorieren. Echte Krieger teilen jedoch ihre Geschichten von der Schlacht bei einem kühlen Krug Bier.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10604, 'deDE', 'Endlich haben wir ein Mittel, mit dem wir die Legion aus Schattenmond vertreiben können!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10606, 'deDE', 'Ah, genau was wir brauchen. Die Legion ist zwar nicht für ihre Meisterwerke der Weltliteratur bekannt, aber es sollte seinen Zweck erfüllen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10607, 'deDE', 'Das ist wirklich beunruhigend. Die Arakkoa waren lange ein friedliebendes Volk. Dieser Rabenkult ist nichts als eine Versammlung von Außenseitern und Verrückten.$B$BAber wir können nicht leugnen, dass ihre Macht wächst. Vielleicht steckt hinter diesem Raben mehr, als wir vermuten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10608, 'deDE', 'Ein Glück, dass ich sie los bin! Verdammte Biester!$B$BWenn Ihr sicher seid, dass Ihr diese Nervensägen ausgelöscht habt, habe ich ein kleines Forschungsprojekt für Euch. Ihr werdet es sicher mögen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10609, 'deDE', 'Ihr habt ja keine Ahnung, wie wichtig diese Experimente sein werden. Vielen Dank!$B$BEs wird aufregend werden, sich mit diesen Essenzen zu befassen. Ich bin besonders gespannt, ob der Nether, der die schwarzen Dracheneier zu Netherdracheneiern verwandelt hat vielleicht ein besonderer Segen für meine Studien ist.$B$BDa fällt mir gerade ein, dass Ihr die erste Person sein solltet, die die Vorzüge meines kleinen Gebräus genießen sollte. Hier, nehmt diese Proben und benutzt sie, wenn Ihr sie braucht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10611, 'deDE', 'Das enthält alle nötigen Informationen. Nur noch ein paar Handgriffe, und Ihr habt in null Komma nichts die Kontrolle über einen Teufelshäscher.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10612, 'deDE', 'Erstaunlich! Ihr habt geschafft, was keiner der Greifenreiter der Wildhammerfeste bewerkstelligen konnte! Ihr habt den Vormarsch der Brennenden Legion aufgehalten und uns vor der Vernichtung durch diese schrecklichen Höllenbestien gerettet. Ihr habt unseren tiefsten Dank für Eure Dienste, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10613, 'deDE', 'Ich gebe zu, $N, ich bin von Euren Errungenschaften beeindruckt. Jetzt, da die Legion nicht länger die Mittel hat, uns in Schattenmond anzugreifen, können wir uns anderen Fronten zuwenden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10614, 'deDE', 'Was führt Euch in unser Dorf?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10615, 'deDE', 'Ah, ja, Dertrok. Wir haben kurz über die Arakkoa gesprochen. Ich muss allerdings zugeben, dass unsere... Interessen was sie betrifft deutlich auseinander gehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10617, 'deDE', 'Diese Kokons sind von guter Qualität. Wie ich sehe, habt Ihr die Ernte im Griff.$B$BWir haben versucht, unsere eigenen Seidenflügellarven zu züchten, aber leider produzieren die kleineren nicht genug Seide, um unseren Bedarf zu decken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10618, 'deDE', 'Vielen Dank, $N. Wir werden sie schon früher benutzen, als Ihr Euch vorstellen könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10619, 'deDE', 'Ehre den Naaru, $N. Ihr habt den Willen des Lichts ausgeführt und Illidans Anhänger vernichtet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10620, 'deDE', 'Ziemlich gut für einen Grünschnabel. Es scheint, als gäbe es eine kleine Gruppe von Eierköpfen, die unbedingt die Astralen und ihre Technologie im Norden \'beobachten\' möchten. Sie werden sich riesig freuen, dass Ihr ihnen den Weg freigeräumt habt.$B$BHier, nehmt ein paar hiervon. Wir haben nicht viele, aber vielleicht können sie Euch in der Zukunft nützlich sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10621, 'deDE', '<Ordinn nimmt Euch den Splitter der Waffe ab.>$B$BSo etwas habe schon seit langer Zeit nicht mehr gesehen. Die Waffe wurde aus einem sehr seltenen Erz geschmiedet, aber es handelt sich dabei nicht um eine gewöhnliche Klinge, $N. Sie ist mit einer Magie erfüllt, die Dämonen töten soll. Wenn Ihr sie von der Legion habt, muss sie eine Art \'Geheimwaffe\' sein, die sie gegen Illidan einsetzen wollen. Welch erstaunlicher Fund!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10622, 'deDE', 'Sehr gut, $N. Eure Gesinnung steht nun außer Frage. Ihr dürft jetzt zu Akama.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10623, 'deDE', '<Grokom nimmt Euch den Splitter der Waffe ab.>$B$BSo etwas habe schon seit langer Zeit nicht mehr gesehen. Die Waffe wurde aus einem sehr seltenen Erz geschmiedet, aber es handelt sich dabei nicht um eine gewöhnliche Klinge, $N.$B$BDiese Runen erfüllen die Klinge mit der Macht, Dämonen zu vernichten. Wenn die Legion ihre eigenen Truppen mit Dämonen zerstörenden Waffen ausrüstet, muss ihr Hass auf Illidan unendlich groß sein. Das könnten wir zu unserem Vorteil ausnutzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10624, 'deDE', 'Eure Welt wird sich bald ändern, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10625, 'deDE', 'Blutschatten? T... Teron Blutschatten? Aber... Wie?$B$BWie kann Blutschatten denn hier sein? Das ist nicht möglich!$B$BDie Legende von Teron Blutschatten lässt sogar die Verlassenen vor Angst erzittern. Nach dem, was man hört, war Blutschatten ein $C Gul\'dans und sehr mächtig. Als Blutschatten von Orgrim Schicksalhammer erschlagen wurde, nahm Gul\'dan die Seele des gefallenen Hexenmeisters und pflanzte sie in die zerschlagene Hülle eines gefallenen Ritters von Sturmwind. Und so wurde der erste Todesritter der Horde geboren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10626, 'deDE', 'Sie sind perfekt. Jetzt wollen wir sie ein eine etwas praktischere Form bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10627, 'deDE', 'Sie sind perfekt. Jetzt wollen wir sie ein eine etwas praktischere Form bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10628, 'deDE', 'Seid gegrüßt, $N. Wir haben viel zu besprechen.$B$BIch hoffe, Euer Wesen ist aufgeschlossen. Nicht viele Leute verstehen meine Entscheidungen. Nur meine engsten Mitarbeiter wissen von den bösen Omen, die ich sehe, und den Zeichen, auf die ich warte.$B$BAls ich mich mit Illidan zusammenschloss, geschah dies, weil ich vorausgesehen hatte, dass mein Volk sonst vernichtet würde. Ich habe geduldig auf die anderen Zeichen und Visionen gewartet... Velens Auszug... die Öffnung des Dunklen Portals... und nun... Eure Ankunft.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10629, 'deDE', 'Ihr riecht ja fürchterlich! Aber Ihr habt meine Schlüssel gefunden. Vielen herzlichen Dank! Jetzt kann ich meinen Schredder in Betrieb nehmen und ein wenig Gold verdienen. Bald werde ich das Geld zusammen haben, um die Scherbenwelt zu verlassen. Ich weiß nicht, warum Ihr hier bleiben wollt. Ich hasse diesen Ort. Wärt Ihr nicht viel lieber wieder in Beutebucht?$B$BVielleicht um ein wenig zu Angeln?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10630, 'deDE', 'Diese Gan\'arg werden sich jetzt sicher verziehen. Und in einer Woche bin ich wieder in Beutebucht. Ich kann es kaum abwarten, endlich wieder angeln gehen zu können. Es war ein Fehler in die Scherbenwelt zu kommen. Wenn Ihr meinen Rat hören wollt, macht Euch schleunigst auf den Weg zurück nach wo Ihr herkommt. Verbringt ein wenig Zeit im Schlingendorntal! Oder wenn Ihr mehr auf Abenteuer aus seid im Krater von Un\'Goro. Hauptsache nicht hier.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10632, 'deDE', 'Gute Arbeit, Junge. Der Schmerz ist gerechtfertigt, wenn auch nur einem meiner Soldaten durch Eure Bemühungen das Leben gerettet wird.$B$BIch bin der Meinung, dass auch Ihr von Eurem Blut und Euren Tränen profitieren solltet. Wir werden bald neue Waffen bekommen. Warum nehmt Ihr daher nicht einfach eine von meinen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10633, 'deDE', 'Blutschatten? Diesen Namen habe ich schon seit ewigen Zeiten nicht mehr gehört!$B$BNach dem Zweiten Krieg kehrte Blutschatten mit seinen Todesrittern hierher zurück. Als er nicht mit der Schrecklichkeit seiner neuen Form zurechtkam und ohne die Hilfe seines geliebten Anführers, Gul\'dan, hilflos war, nahm Blutschatten sich das Leben.$B$BIch weiß nichts davon, dass er nun als Geist in diesen Weiten herumwandeln soll. Aber vielleicht kann ich das mit Eurer Hilfe herausfinden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10634, 'deDE', 'Ich muss alle Gegenstände besitzen, bevor ich Blutschattens Schicksal mit Hellsicht herausfinden kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10635, 'deDE', 'Wenn ich alle drei Gegenstände in meinem Besitz habe, kann ich mit Hellsicht versuchen, den Aufenthaltsort von Blutschatten zu bestimmen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10636, 'deDE', 'Nur mit allen drei Gegenständen zusammen kann ich versuchen, die Geheimnisse, die Ihr zu lüften wünscht, hellzusehen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10637, 'deDE', 'Wollen wir hoffen, dass diese Ablenkung uns die Zeit verschafft, die wir brauchen, um alles herauszufinden, was wir über die Ausbildungsgelände von Karabor wissen müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10639, 'deDE', 'Was habt Ihr getan? DUMMKOPF!$B$BIhr müsst dieses Unrecht wieder gutmachen. Schließlich war es Euer Fehler. Nehmt einen dieser Helme. Sie sind mit der Macht der ewig brennenden Asche, die Ihr mir gebracht habt, erfüllt. Viel wichtiger ist jedoch, dass Ihr damit die Geister Schattenmonds sehen könnt, auch Teron Blutschatten.$B$BWenn Ihr ihn jemals findet, vernichtet ihn.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10640, 'deDE', 'Ihr habt einen langen Weg hinter Euch, Fremder. Ich bin überrascht, dass derjenige, der Euch zu mir geschickt hat, von mir gehört hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10641, 'deDE', 'Ihr habt beweisen, dass Ihr nicht von der Berührung der Legion verderbt wurde. Der Feind meines Feindes ist mein Freund.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10642, 'deDE', '<Zorus beginnt damit, etwas aus den Aschenproben herzustellen.>$B$BEs ist vollbracht. Seht her, eine Geisterbrille!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10643, 'deDE', 'Ihr sagt, Ihr habt die Geister zu Euch flüstern hören? Und sie sprachen über Teron Blutschatten?$B$B<Zorus schaudert.>$B$BJa... Ich kenne Teron Blutschatten. Oder besser gesagt kannte ihn. Er ist schon vor langer Zeit gestorben. Wovon können diese Geister wohl gesprochen haben?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10644, 'deDE', 'Blutschatten? Diesen Namen habe ich schon seit ewigen Zeiten nicht mehr gehört!$B$BNach dem Zweiten Krieg kehrte Blutschatten mit seinen Todesrittern hierher zurück. Als er nicht mit der Schrecklichkeit seiner neuen Form zurechtkam und ohne die Hilfe seines geliebten Anführers, Gul\'dan, hilflos war, nahm Blutschatten sich das Leben.$B$BIch weiß nichts davon, dass er nun als Geist in diesen Weiten herumwandeln soll. Aber vielleicht kann ich das mit Eurer Hilfe herausfinden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10645, 'deDE', 'Was habt Ihr getan? DUMMKOPF!$B$BIhr müsst dieses Unrecht wieder gutmachen. Schließlich war es Euer Fehler. Nehmt einen dieser Helme. Sie sind mit der Macht der ewig brennenden Asche, die Ihr mir gebracht habt, erfüllt. Viel wichtiger ist jedoch, dass Ihr damit die Geister Schattenmonds sehen könnt, auch Teron Blutschatten.$B$BWenn Ihr ihn jemals findet, vernichtet ihn.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10646, 'deDE', 'Jetzt kennt Ihr die Geschichte. Bleibt nur noch eine Sache zu erledigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10647, 'deDE', 'Du bist echt der Brüller, was? Gut gemacht! Und du kriegst auch deine Belohnung. Is\' doch Ehrensache...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10648, 'deDE', 'Hier ist Eure Belohnung. Gebt nicht alles auf einmal aus!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10649, 'deDE', 'Ich konnte die Macht des Buches schon über Meilen hinweg spüren. Die Versuchung, es einfach zu behalten ist... sehr groß.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10650, 'deDE', 'Ihr bringt diese Abscheulichkeit eines Buches an einen heiligen Ort? Ich hoffe, dass Ihr dafür eine gute Erklärung habt, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10651, 'deDE', 'Ausgezeichnete Arbeit, $N! Euer Sieg über Varedis ist ein entscheidender Schritt in unserem Krieg gegen Illidan.$B$BIhr habt Euch nicht nur den Aldor, sondern gegenüber der gesamten Scherbenwelt als würdig erwiesen. Bitte gestattet mir, die Überreste dieses schrecklichen Buchs zu vernichten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10652, 'deDE', 'Willkommen, $C. Bemüht Euch, unsere Position nicht zu verraten.$B$BWenn Kaels Spießgesellen uns entdecken, leben wir nicht mehr lange.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10653, 'deDE', 'Sich den Dämonen der Brennenden Legion und den wahnsinnigen Kultisten, die sie verehren, zu stellen ist keine geringe Tat, $N. Ihr habt viel Hingabe und Mut bewiesen. Macht so weiter, und Euer Ruf bei den Aldor wird weiter steigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10654, 'deDE', 'Beweist Euch weiterhin als würdig, $N. Besiegt die Feinde des Lichts, wo immer Ihr sie findet. Eure Taten sollen angemessen belohnt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10655, 'deDE', 'Ihr beweist Euch weiterhin als würdig, $N. Besiegt die Feinde des Lichts, wo immer Ihr sie findet. Eure Taten sollen angemessen belohnt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10656, 'deDE', 'Kaels Armee des Sonnenzorns ist sehr gut ausgebildet. Ihr habt beeindruckende Arbeit geleistet, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10657, 'deDE', 'Jippieh, es hat geklappt! Ich war mir da ehrlich gesagt nicht so sicher... Ich habe eine Wahrscheinlichkeit von 23,72 Prozent berechnet, dass Ihr beim dritten Treffer implodiert.$B$B<Toshley grinst unschuldig.>$B$BJetzt wissen wir also, dass die Sphäre funktioniert. Es sollte also keine weiteren Probleme geben, den nötigen Saft für unser Zephyriumkapazitorium zu beschaffen. Natürlich nur, wenn ich noch mehr Freiwillige finde, die für mich dort hinaus gehen und sich brutzeln lassen.$B$BAber Ihr habt den Pionier für unsere Bemühungen gespielt und verdient eine Belohnung!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10658, 'deDE', 'Ausgezeichnet! Das wird Kael\'thas zeigen, dass unsere Macht nicht zu unterschätzen ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10659, 'deDE', 'Kaels Armee wird bald fallen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10660, 'deDE', '<Forscher Tiorus nimmt die Milzen an sich und beginnt seine Untersuchung.>$B$BDas dürfte eine Weile dauern. Nehmt dies als Bezahlung für Eure harte Arbeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10661, 'deDE', '<Gnomus reißt die Milzen hungrig an sich.>$B$BHier ist die versprochene Bezahlung. Ich rufe Euch, wenn ich noch mehr Milzen brauche.$B$BSo lecker... Ich würde fast meinen \'demilziös\'!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10662, 'deDE', 'Ordinn hat Euch damit zu mir geschickt?$B$B<Der Schmied untersucht die Barren.>$B$BEr hatte Recht. Der Großteil der Magie ist verschwunden, aber ich kann noch immer Spuren davon in dem Metall spüren. Mit ein wenig Arbeit und ein paar \'ausgefallenen\' Materialien kann ich Euch ein mächtiges antidämonisches Schwert aus diesem Metall schmieden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10663, 'deDE', 'Ordinn hat Euch damit zu mir geschickt?$B$B<Der Schmied untersucht die Barren.>$B$BIch werde ehrlich mit Euch sein, $C. Ich bin in einer Zeit großgeworfen, in der die Kooperation mit der Horde undenkbar war.$B$BIch bin nicht so blind, dass ich nicht sehen würde, dass wir keine gemeinsamen Feinde haben. Ich werde Euch helfen, die antidämonische Waffe umzuschmieden, aber es wird einiges an Arbeit bedürfen und ein paar \'ausgefallene\' Materialien.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10664, 'deDE', '<Der Schmied nimmt Euch die Materialien ab und nickt zufrieden.>$B$BDie werden reichen. Der Rest der Materialien, die ich benötige, wird jedoch nicht so leicht zu bekommen sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10665, 'deDE', 'Sie ist sogar noch mächtiger, als ich erwartet habe! Mit so viel Energie könnte ich ein Dutzend Klingen schmieden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10666, 'deDE', '<David blättert die Seiten des Buchs durch und schaudert.>$B$BDas ist nichts, mit dem man spielen sollte, $N. Sobald die Waffe fertig ist, werde ich es zerstören. Es gibt schon genug dämonische Macht in dieser Welt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10667, 'deDE', 'Das sollte funktionieren. Ich hatte zwar auf etwas mehr gehofft, aber um ehrlich zu sein können wir uns glücklich schätzen, hier draußen überhaupt etwas davon in die Finger bekommen zu haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10668, 'deDE', 'Ihr gehört also nicht zu Illidan. Ihr seid einen Schritt näher daran, mein volles Vertrauen zu erlangen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10669, 'deDE', 'Gut gemacht, $N. Er konnte sich also immer noch an den Tag erinnern, an dem ich den Speer in seinen Körper rammte? Das ist schon so lange her...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10670, 'deDE', '<David Wayne hält den Edelstein gegen das Licht und bewundert ihn.>$B$BEr ist absolut makellos und genau das, was wir brauchen. Ein fehlerhafter Edelstein würde den Träger der Waffe in Gefahr bringen und die Magie gegen ihn richten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10671, 'deDE', 'Das sollte genügen. Es stinkt fürchterlich, oder?$B$BIch hoffe, dass es Eure Mühen wert war... Ich bin nur froh, dass ich das Zeug nicht selber sammeln musste!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10672, 'deDE', 'Wir haben keine Zeit zu verschwenden. Ich habe die markierten Dimetrodonten beobachtet und herausgefunden, dass sie alle einem riesigen, nein, GIGANTISCHEN Dimetrodon namens Teufelsflosse dem Großen unterstellt sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10673, 'deDE', 'Endlich bin ich vollkommen vor der Lava geschützt! Natürlich könnt auch Ihr etwas von dieser Technologie abhaben, $N. Ihr habt es Euch verdient!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10674, 'deDE', 'He! Wartet mal!!$B$BDas sieht nicht gut aus...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10675, 'deDE', 'Das geschieht ihm ganz Recht! Vielen Dank, dass Ihr dieser makaberen Mischung aus Magie und Technologie ein Ende bereitet habt.$B$BAls wahrer Held der Gnome überall auf dieser Welt, lasse ich Euch nun die höchste unserer Ehren zukommen... ein paar Stromwandler und Eure Wahl aus diesen Dingen hier!$B$BIch weiß, dass Ihr sie gut einsetzen werdet!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10676, 'deDE', '<David wischt sich den Schweiß von der Braue.>$B$BDer größte Teil der Arbeit ist getan. Um die Magie jedoch zum Leben zu erwecken, muss das Schwert erst gehärtet werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10677, 'deDE', 'Das ist fantastisch! Aber ich habe gerade unglaubliche Nachrichten erhalten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10678, 'deDE', 'Ich brauche jetzt etwas Zeit für mich, $N. Vielen Dank für Eure Hilfe!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10679, 'deDE', 'Gut gemacht!$B$B<Der Schmied untersucht die Klinge sehr genau.>$B$BIch würde sagen, dass sie deutlich besser ist, als die grobe Waffe der Legion, mit der wir angefangen haben. Diese Klinge wird nicht nur die Dämonen der Illidari erschlagen, sondern auch die Diener der Legion vernichten können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10680, 'deDE', 'Es ist gut, dass Ihr gekommen seid, $R. Wir haben viel zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10681, 'deDE', 'Es ist gut, dass Ihr gekommen seid, $R. Wir haben viel zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10682, 'deDE', 'WAS?! Sie haben Euch fortgeschickt und unser Angebot ausgeschlagen?$B$BDas ist empörend! Wir sind in Frieden zu ihnen gekommen und sie schicken Euch weg, ohne auch nur zu versuchen, einen Kompromiss zu finden?$B$BNun, das wird Folgen haben!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10683, 'deDE', 'Die Schrifttafeln von Baa\'ri! Ja, die werden uns sehr wichtige Informationen liefern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10684, 'deDE', 'Akamas Handschrift... wollen wir mal sehen, was wir daraus erfahren können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10685, 'deDE', 'Ja! Die vier Fragmente des Medaillons. Und nun setzt sie zusammen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10686, 'deDE', 'Wir haben Euch erwartet, $N. Akama sagte, dass Ihr früher oder später kommen würdet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10687, 'deDE', 'Wollen wir uns diese Waffen einmal genauer ansehen, $N. Hmmm... das ist ziemlich beunruhigend.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10688, 'deDE', 'Das sollte uns genug Zeit verschaffen... hoffentlich reicht sie aus, um weitere Informationen zu sammeln.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10689, 'deDE', 'Ihr habt einen langen Weg hinter Euch, Fremder. Ich bin überrascht, dass derjenige, der Euch zu mir geschickt hat, von mir gehört hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10690, 'deDE', 'Unglaublich. Habt Ihr Rema ganz alleine getötet?$B$BSo wie Ihr ausseht, glaube ich das. Wisst Ihr, wir sind auf der Suche nach einem starken $C wie Ihr es seid, um uns hier ein wenig zu helfen. Besonders bei den ständigen Problemen, die wir mit den Ogern haben, könnten wir Euch brauchen. Setzt Euch mit mir in Verbindung, wenn Ihr Interesse habt.$B$BDas Kopfgeld, das auf dem Anschlag versprochen wurde, habt Ihr Euch jedenfalls verdient.$B$BBitte, wählt Euch etwas aus!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10691, 'deDE', 'Viele würden für das Buch, das Ihr bei Euch tragt, einen hohen Preis bezahlen. Es ist eine Schande, dass wir es zerstören müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10692, 'deDE', 'Ausgezeichnete Arbeit, $N! Euer Sieg über Varedis ist ein entscheidender Schritt in unserem Krieg gegen Illidan.$B$BNach dieser Tat wird euer Name sicher die Runde machen.$B$BBitte erlaubt mir, die Überreste des Buchs der teuflischen Namen an mich zu nehmen. Ich werde dafür sorgen, dass es ordnungsgemäß... entsorgt wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10701, 'deDE', 'Oh! Oh... Ihr habt Netherbrock erledigt. Das sind gute Nachrichten!$B$BJetzt, da dieser lästige Bergriese von der Bildfläche verschwunden ist, können wir die Rohstoffe der Schwindenden Weiten leichter ausbeut... äh, verwalten.$B$BIch bin froh, dass diese armen, unschuldigen Elementare da unten jetzt nicht mehr von ihm zerquetscht werden.$B$BWie kann ich Euch je dafür entlohnen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10702, 'deDE', 'Fantastisch! Wenn ich noch mehr Routinearbeiten zu erledigen habe, komme ich auf Euch zurück!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10703, 'deDE', 'Jep, gute Arbeit! Hier habt Ihr ein wenig Bares für Eure Mühen. Wenn ich noch mehr Drecksarbeit zu erledigen habe, weiß ich ja, wen ich rufen soll.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10704, 'deDE', 'Ich bin beeindruckt, $N, auch wenn ich von $Gdem Helden, der:der Heldin, die; den Kristall von Ata\'mal zurückgebracht hat, nichts anderes erwartet habe.$B$BGebt mir die Fragmente, damit ich sie zu ihrer endgültigen Form zusammenfügen kann. Dann werdet Ihr Zugang zur Arkatraz haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10705, 'deDE', 'Der Seher der Aschenzungen ist schon lange tot. Als Ihr Euch über seinen Körper beugt, erkennt Ihr, dass auf dem Boden etwas geschrieben steht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10706, 'deDE', 'Ja... natürlich! Jetzt wird alles klar.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10707, 'deDE', 'Der Kristall! Seine Macht... in meinen Händen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10708, 'deDE', '<Als Ihr A\'dal das Medaillon übergebt, verschwindet es mit einem Lichtblitz in seinem Geist.>$B$B<Für einen kurzen Moment erscheint eine Szene vor Euch...$B$Bvielleicht aus der Zukunft. Ihr seht, wie Akama und Maiev aus dem Kerker des Wächters heraustreten und sich zum Schwarzen Tempel durchschlagen. Eine dritte, in Schatten gehüllte Gestallt hilft ihnen dabei. Als Ihr genauer hinschaut, erkennt Ihr, dass Ihr diese Gestalt seid.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10709, 'deDE', 'Mein Vater ist also tatsächlich am Leben. Ich habe nicht erwartet, dass er mir verzeiht. Das war noch nie seine Art. Aber ich hatte gehofft, dass seine Wut über meine Abreise über die Jahre schwächer geworden ist.$B$BVor dreißig Jahren habe ich die Mok\'Nathal verlassen, um der Horde nach Azeroth zu folgen. Leoroxx war strikt dagegen, gab mir aber auch keinen Grund zu bleiben. Und doch hätte ich mir ein herzlicheres Willkommen gewünscht.$B$BEr wollte einen Mok\'Nathal als Sohn haben und hat immer noch einen, auch wenn er nichts davon wissen möchte.$B$BIch werde ihm die Augen öffnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10710, 'deDE', 'Wow! Ihr habt schon wieder überlebt! Ich bin ein besserer Ingenieur, als ich immer dachte!$B$BHier ist Eure Bezahlung! Und schaut doch später nochmal bei mir vorbei... Ich habe noch mehr Experimente, für die ich Versuchspersonen brauche!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10711, 'deDE', 'Oh, beeindruckend! So schnell schon zurück! Ich habe gesehen, wie Ihr abgehoben habt und wie eine Rakete in die Luft geschossen seid! Ich dachte, es würde mindestens einen Monat Genesung brauchen, bis Eure gebrochenen Beine wieder geheilt sind! Ihr seid hart im Nehmen, mutig und kühn! Aber vor allem... mutig!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10712, 'deDE', 'Oh, Ihr habt Aufzeichnungen mit der Netherwetterfahne gemacht? Ausgezeichnet! Die Daten dieses Instruments werden zusammen mit meinen Messungen druidischer Magie sicher viele Früchte tragen!$B$BOh, die Einsatzmöglichkeiten werden Euch um den Verstand bringen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10713, 'deDE', 'Danke, $N.$B$BWir werden uns darum kümmern, dass die Wildtiere sich selbst wieder schnell vermehren. Bei den Bäumen ist dies jedoch ein sehr viel zeitaufwändigerer Prozess.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10714, 'deDE', '<Geisterschwinge lässt sich auf Rexxars Schulter nieder, während Rexxar aufmerksam zuhört.>$B$BDie Söhne des Gruul stecken also hinter den Handlungen der Oger. Sie befehlen den Ogern der Blutschlägern, die Mok\'Nathal zu vernichten, um ihre Gunst zu erlangen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10715, 'deDE', 'Sehr gut, Ihr habt eine einfache, wenn nicht gar banale Aufgabe erfüllt. Nun gebt mir die Drüsen, damit ich den schwierigen Teil erledigen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10717, 'deDE', 'Oh, die sehen hervorragend aus. Diese Kultisten wissen wirklich, was wahre Handwerkskunst ist.$B$BZu schade, dass sie sie missbrauchen.$B$BJetzt, da wir die Netze haben, bräuchte ich Eure Hilfe bei ein oder zwei Angelegenheiten. Habt Ihr Lust?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10718, 'deDE', 'Wovon redet Ihr?$B$BGarm Wolfsbruder? Er war der letzte Häuptling der Donnerfürsten. Wenn Ihr mit seinem Geist gesprochen habt, muss es wahr sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10719, 'deDE', 'Das ist interessant, aber auch beunruhigend. Vielleicht sollten wir Samia fragen, wer dieser Kolphis Dunkelschuppe ist?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10720, 'deDE', 'Viele Jahre lang habe ich versucht, die Kommunikation mit der Natur zu perfektionieren. Dies ist nur ein Bruchteil dessen, was die Tiere für Euch tun können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10721, 'deDE', '<Baron Zobelmähne lugt in den Sack des Gronns und scheint zufrieden.>$B$BSehr gut, Ihr habt Euren Teil der Abmachung gehalten. Nun, da der Preis bezahlt ist, werde ich Rexxar geben, was er begehrt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10722, 'deDE', 'Uns angreifen? Uns auslöschen? Das glaube ich aber nicht!$B$BDieser Pechschwingenkoven muss noch viel lernen, wenn sie denken, dass man die Expedition des Cenarius so leicht loswerden kann!$B$BWie sagt man so schön? Wie du mir, so ich dir!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10723, 'deDE', 'Die Oger der Blutschläger und ihr Meister, Gorgrom, werden die Mok\'Nathal nie wieder belästigen.$B$BIch mache mir jedoch Sorgen über die Auswirkungen unserer Tat auf die anderen Gronn. Ich glaube, wir müssen diesem Kampf ein für alle Mal ein Ende setzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10724, 'deDE', 'Leokk hat uns den Kopf eines schwarzen Drachen von Drachenend gebracht, damit können wir Goc, den Gronn, der ihn gefangen genommen hat, erzürnen und ihn in die Schlacht locken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10742, 'deDE', 'Der Kampf war hart und Ihr habt Euch gut geschlagen, $N. Ich bin stolz, dass ich in der Schlacht gegen Goc an Eurer Seite kämpfen durfte.$B$BDie Mok\'Nathal sollten von diesen großartigen Siegen erfahren, aber ich bin noch nicht bereit, ihnen gegenüberzutreten. Ich kenne meinen Vater und ich kenne mein Herz. Es gibt immer noch vieles, was ich lernen und tun kann, um stärker zu werden und ihm zu beweisen, dass ich sein wahrer Sohn bin.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10744, 'deDE', '<Kurdran hört Euren Bericht an.>$B$BDas sind in der Tat gute Nachrichten! Noch vor ein paar Tagen hätte ich mir nie träumen lassen, dass wir der Belagerung der Legion ein Ende machen könnten.$B$BIhr habt nicht nur ihren Angriff verhindert, sondern auch noch ihre Maschinerie vernichtet! Für diesen Heldenmut habt Ihr den Dank der Wildhämmer, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10745, 'deDE', '<Der Oberanführer hört Euren Bericht an.>$B$BAusgezeichnete Nachrichten! Den Angriffen der Legion standzuhalten nahm einfach viel zu viele Leute in Anspruch. Ich habe zwar nie geglaubt, dass meine Leute versagen würden, aber sie standen unter großer Belastung.$B$BIhr habt heute bewiesen, wie wichtig Ihr für die Horde seid. Die Wache der Kor\'kron wird sich jederzeit geehrt fühlen, an Eurer Seite zu kämpfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10747, 'deDE', 'Ach herrje, das sind ja mehr, als ich gehofft hatte! Für Euren Heldenmut habt Ihr gewiss ein Lob verdient!$B$BDiese Welpenbrut sieht sehr gut aus. Sie sind wie gemacht für meine Untersuchungen.$B$BBitte, nehmt eine kleine Belohnung von mir an. Ich bestehe darauf!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10748, 'deDE', 'Jetzt, da der Anführer unserer Feinde tot ist, können wir endlich wieder ein wenig aufatmen. Und Ihr habt auch noch das gesamte Gebirge vor ihrer Verwüstung bewahrt.$B$BWas auch immer ihre endgültigen Pläne gewesen sein mögen, Ihr habt sie vereitelt!$B$BIhr habt unseren Dank, $N. Bitte nehmt dieses Zeichen unserer Wertschätzung sowie unsere ewig währende Gastfreundschaft.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10749, 'deDE', 'Die Verwendung von Giften ist ein dreckiges Geschäft. Aber so werden wir unsere Ziele erreichen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10750, 'deDE', 'Diese lästigen Hunde planen etwas Heimtückisches. Wir müssen weitere Nachforschungen anstellen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10751, 'deDE', 'Ihr werdet es nicht glauben, Grunzer!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10753, 'deDE', 'Es erfüllt mich nicht mit Stolz zu zerstören, was Elune erschaffen hat, aber die Verderbnis muss aufgehalten werden. Ihr habt Eure Arbeit gut gemacht, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10754, 'deDE', 'Kann das wahr sein? Lasst mich die Form einmal genauer betrachten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10759, 'deDE', '<Der Arakkoa kichert.>$B$BJa, ich bin der Deserteur, den der Kommandant in seinem Tagebuch erwähnt. Ich habe auf den Tag gewartet, an dem auch andere die Bedrohung erkennen, die von meinen einstigen Brüdern ausgeht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10760, 'deDE', '<Der Unteroffizier untersucht die Tagebuchseiten.>$B$BHier steht nicht viel Sinnvolles, aber ein paar Einträge könnten sich als nützlich erweisen. Wie es aussieht waren die Arakkoa dabei, ein kompliziertes magisches Ritual vorzubereiten, bis sie starben, aber warum? Hier steht auch etwas Merkwürdiges über einen \'Deserteur\'.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10761, 'deDE', '<Der Arakkoa kichert.>$B$BJa, ich bin der Deserteur, den der Kommandant in seinem Tagebuch erwähnt. Ich habe auf den Tag gewartet, an dem auch andere die Bedrohung erkennen, die von meinen einstigen Brüdern ausgeht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10762, 'deDE', 'Ein Schlüssel? Danath sollte uns eigentlich an Belagerungsmaschinen arbeiten lassen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10763, 'deDE', 'Dann wollen wir es mal versuchen. Mal sehen, was hinter der Schmiedekunst der Orcs steckt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10764, 'deDE', 'Ihr habt es geschafft, $GJunge:Mädel;! Jetzt müsst Ihr sie nur noch zur Höllenfeuerzitadelle bringen und ein paar Orcs erlegen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10765, 'deDE', 'Sie versuchen also, sich die Gunst der Riesen zu erschleichen, was? Ich habe einen Plan, der diese unheilige Verbindung ganz schnell wieder zerreißen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10766, 'deDE', 'Es freut mich, Euch kennen zu lernen, $N. Mein Name ist Plexi.$B$BIch werde Euch nicht mit Höflichkeiten langweilen. Wir wissen beide, warum wir hier sind. Und nun an die Arbeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10767, 'deDE', 'Ihr müsst derjenige sein, von dem Blutwache Gulmok gesprochen hat. Ich habe bereits einen Plan, aber ich brauche Eure Hilfe, um die Vorbereitungen abzuschließen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10768, 'deDE', 'Aha! Die werden funktionieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10769, 'deDE', 'Gut, gut, gut... Wenn das nicht der Grunzer ist, den ich zu den Feldern geschickt habe. Ihr seid heil zurück.$B$B<Or\'barokh nickt.>$B$BIch wusste, dass Ihr mich nicht enttäuschen würdet, Soldat. Ihr habt ein entscheidendes Vorrücken der Illidari aufgehalten und Euch damit eine Belohnung verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10770, 'deDE', 'Es gibt so viele, dass wir sie nie alle töten können, aber Ihr habt mir Hoffnung gegeben. Vielleicht sollte ich noch ein paar Jahrhunderte lang stärker versuchen, meinen geliebten Wald wieder zum Leben zu erwecken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10771, 'deDE', 'Ihr habt viele dieser verderbten Kreaturen getötet. Mit dieser Gewissheit kann ich nun etwas ruhiger schlafen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10772, 'deDE', 'Diese lästigen Hunde planen etwas Heimtückisches. Wir müssen weitere Nachforschungen anstellen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10773, 'deDE', 'Ihr werdet es nicht glauben, Soldat!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10774, 'deDE', 'Sie versuchen also, sich die Gunst der Reisen zu erschleichen, was? Ich habe einen Plan, der diese unheilige Verbindung ganz schnell wieder zerreißen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10775, 'deDE', 'Aha! Die werden funktionieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10776, 'deDE', 'Gut, gut, gut... Wenn das nicht der Soldat ist, den ich zu den Feldern geschickt habe. Ihr seid heil zurück.$B$B<Yoregar nickt.>$B$BIch wusste, dass Ihr mich nicht enttäuschen würdet, Soldat. Ihr habt ein entscheidendes Vorrücken der Illidari aufgehalten und Euch damit eine Belohung verdient.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10777, 'deDE', '<Parshah untersucht das Totem.>$B$BGut. Dieses alte Totem hat seine Macht über die Jahre nicht eingebüßt, doch es alleine reicht noch nicht aus, um den Dunklen Rat aufzuhalten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10778, 'deDE', 'Gut gemacht. Ein solcher Schatz verdient besseres, als in einer dunklen Kiste weggesperrt zu werden. Wir werden ihn für einen guten Zweck einsetzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10780, 'deDE', '<Parshah nimmt Euch die aschebestäubten Federn ab und schüttelt den Kopf.>$B$BEs wäre besser gewesen, wenn ich an diesem Tag gestorben wäre, aber die Dinge sind niemals so einfach. Dass Gul\'dans Magie sie in etwas verwandelt hat, das sie aufzuhalten versuchten, ist ein grausames Spiel des Schicksals.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10781, 'deDE', 'Wir werden weitere Nachforschungen über das Purpursiegel anstellen. Sie stellen eine Bedrohung für alles Leben in Draenor dar. Ich sehe einen Tag voraus, an dem ihr dunkler Herr für seine Verbrechen geradestehen muss. Vielleicht seid Ihr ja diejenige, der ihn der Gerechtigkeit zuführen wird, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10782, 'deDE', '<Parshah nimmt Euch das Kopfstück ab und hält es behutsam in den Händen.>$B$BDieses Kopfstück enthält die Macht, die wir brauchen, um die Pläne des Dunklen Rats im Basislager der Sketh\'lon zunichtezumachen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10783, 'deDE', 'Hallo, $R. Ich bin Baron Zobelmähne. Ein Freund Rexxars ist auch mein Freund.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10784, 'deDE', '<Tor\'chunk nickt und scheint dabei sichtlich zufrieden mit Eurer mörderischen Kühnheit.>$B$BIhr erstaunt mich immer wieder, $N. Jedes Mal, wenn einer dieser stinkenden Oger zu Boden geht, sind wir einen Schritt näher daran, einen unwürdigen Feind loszuwerden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10785, 'deDE', 'Hm, eine Falle, die aus der Essenz einer Drachenflamme gebaut wurde? Ich frage mich, wie Zobelmähne an eine so seltene Substanz gekommen ist!$B$BNun, ganz egal. Nicht egal ist allerdings, dass wir sie benutzen werden, um einen Sohn des Gruul zu töten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10786, 'deDE', '<Tor\'chunk grinst, als Ihr ihm von Euren Abenteuern in Fels\'mok erzählt.>$B$BAch, ich wünschte, ich hätte mit Euch kommen können. Ich will Euch etwas sagen, $N, lasst Euch nie auf Pflichten ein, die Euch vom Ruhm der Schlacht fernhalten!$B$BHa! Habt Ihr mir überhaupt noch ein paar Oger in den Bergen übrig gelassen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10791, 'deDE', 'Es ist unglaublich! Ich bin zu dieser Reise aufgebrochen, ohne auch nur die leiseste Ahnung zu haben, ob der Wolfgeist auf unsere Anrufung hin kommen würde. Und nun fühlt es sich an, als wäre er nie fort gewesen. Vielleicht war er das auch nie, $N.$B$BVielleicht hat er darauf gewartet, dass die Orcs verstehen, was ihre Entscheidung bewirkt hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10792, 'deDE', 'Hah! Ich konnte die Flammen über Zeth\'Gor bis hierher sehen! Mögen unsere Feinde des Blutenden Auges zu Asche zerfallen und keinem wahren Orc mehr unter die Augen kommen!$B$BVielen Dank, $N. Ihr habt geholfen, eine Beleidigung für den Geist eines jeden Orcs hinfort zu brennen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10793, 'deDE', 'Ihr habt ihren Eroberer getötet? Dann haben wir nicht viel Zeit...$B$BDas Purpursiegel besteht aus der Elite von Illidans Dienern. Sie stehen am oberen Ende der Befehlskette für Illidans Armeen außerhalb des Schwarzen Tempels. Diese Soldaten stehen in direktem Kontakt mit dem Verräter und führen seine Anweisung ohne Fragen zu stellen aus.$B$BSie sind diejenigen, die ohne mit der Wimper zu zucken einen Angriff auf diese Welt starten und dabei alles, was ihnen in Wege steht, dem Erdboden gleichmachen würden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10795, 'deDE', 'Jetzt, da Dorgok tot ist, sind die Oger der Blutschläger ohne Anführer und hoffentlich verwirrt, bis ein neuer Anführer aus ihren Rängen gewählt wird.$B$BVielen Dank, $C. Ich glaube, wir können nun ein wenig aufatmen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10796, 'deDE', '<Der Leutnant nickt und scheint mit Eurer mörderischen Kühnheit sichtlich zufrieden.>$B$BIch bin beeindruckt, $N. Euer Ruf scheint wohlverdient zu sein.$B$BJedes Mal, wenn einer dieser Oger zu Boden geht, sind wir einen Schritt näher daran, einen Feind loszuwerden, der uns niemals in Frieden lassen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10797, 'deDE', 'Oh, das ist aber hübsch. Sieht ein bisschen aus wie diese Gronn, die die Oger der Speerspießer immer durch die Gegend scheuchen.$B$BKomisch, dass Ihr es in der Hand eines Anführers der Blutschläger gefunden habt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10798, 'deDE', 'Ah, ein Gesandter der gerühmten Allianz. Sagt mir, Lakai, warum seid Ihr es, der hierhergekommen ist und mich um dieses Ding bittet, und nicht Eurer illustrer Kommandant?$B$BKann es etwa sein, dass er Angst vor mir hat? Irgendetwas an Euch sagt mir, dass Ihr keine habt, aber ich weiß noch nicht, was das ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10799, 'deDE', 'Sehr gut, Ihr habt eine einfache, wenn nicht gar banale Aufgabe erfüllt. Nun gebt mir die Drüsen, damit ich den schwierigen Teil erledigen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10800, 'deDE', '<Baron Zobelmähne lugt in den Sack des Gronns und scheint zufrieden.>$B$BSehr gut, Ihr habt Euren Teil der Abmachung gehalten. Nun werde ich Euren Kommandanten mit der Falle beschenken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10801, 'deDE', 'Hm, eine Falle, die aus der Essenz einer Drachenflamme gebaut wurde? Ich frage mich, wie Zobelmähne an eine so seltene Substanz gekommen ist!$B$BNun, ganz egal. Nicht egal ist allerdings, dass wir sie benutzen werden, um einen Sohn des Gruul zu töten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10802, 'deDE', 'Gut gemacht, $N. Sehr gut gemacht!$B$BIch nehme an, dass wir nun nicht mehr von den Ogern und ihrem Herrn hören werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10803, 'deDE', '<Leutnant Schönwetter grinst, als Ihr ihr von Euren Abenteuern in Fels\'mok erzählt.>$B$BAch, ich wünschte, ich hätte mit Euch kommen können. Ich will Euch etwas sagen, $N, lasst Euch nie auf Pflichten ein, die Euch vom Ruhm der Schlacht fernhalten!$B$BHa! Habt Ihr mir überhaupt noch ein paar Oger in den Bergen übrig gelassen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10804, 'deDE', 'Ihr seid ein freundlicher und mitfühlender $R, mein Freund.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10805, 'deDE', 'Sehr gut. Ich habe eine weise Wahl getroffen, als ich Euch zur Speerspitze meines Kampfes gemacht habe. Ich schätze, es ist an der Zeit, die Dinge auf eine ganz neue Ebene zu tragen.$B$BErinnert Ihr Euch an den kleinen Leckerbissen, den Ihr Grolloc für mich unter der Nase weggeschnappt habt? Ihr werdet die Gelegenheit bekommen, ihn sinnvoll einzusetzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10806, 'deDE', 'Für jemanden von Eurem Schlag habt Ihr erstaunlich gut gekämpft. Es war mir eine Ehre, Euch an meiner Seite zu wissen. Meine Verwandlung muss Euch wohl ein wenig überrascht haben. Ich hoffe, ich habe Euch nicht allzu sehr erschreckt.$B$BWir sollten meine wahre Identität jedoch für uns behalten. Als Belohnung für Eure treuen Dienste biete ich Euch eines dieser Schmuckstücke an.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10807, 'deDE', 'Ehre den Sehern, $N. Ihr habt den Willen des Lichts ausgeführt und Illidans Anhänger vernichtet.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10808, 'deDE', 'Ich habe jahrelang nach einem Weg gesucht, um den Dunklen Rat aufzuhalten. Ihr habt geschafft, wobei ich versagt habe. Die finsteren Rituale des Dunklen Rats werden nie wieder zu einer Bedrohung für uns.$B$BIch fühle mich oft schuldig, weil ich meine Kameraden vor all diesen Jahren verlassen habe, aber nun weiß ich endlich, dass es die richtige Entscheidung war. Hätte mein Gewissen damals nicht zu mir gesprochen, wäre ich nun vielleicht ein Schatten unter ihnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10809, 'deDE', 'Ihr habt also den Tunichtgut Kruush erschlagen! Gut gemacht, $N! Sehr gut! Sein Tod wird seinen verfluchten Worgreitern die Giftzähne ziehen! Ich hoffe, Ihr habt auch ein paar von ihnen erledigt, als Ihr Euren kleinen Ausflug nach Zeth\'Gor gemacht habt!$B$BHier ist Eure Belohnung. Ihr habt sie Euch verdient!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10810, 'deDE', 'Ah, was habt Ihr denn da? Lasst mich das mal genauer ansehen, $C. Ja, ja... es ist genau das, was ich dachte. Lasst mich die Maske für Euch reparieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10811, 'deDE', 'Meine Kinder haben mir von Eurer heldenhaften Tat erzählt, $R. Es gibt noch mehr, was Ihr tun könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10812, 'deDE', 'Diese Maske, die Ihr da in den Händen haltet, ist eine Gasmaske der Teufelsbrut! Und wie es aussieht, ist sie nicht beschädigt! Der Ärger, den wir damit im Konstruktionslager: Groll anrichten können, ist grenzenlos! Habt Ihr Lust, uns dabei zu helfen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10813, 'deDE', 'Ich stehe tief in Eurer Schuld, $N. Ihr habt ein weiteres Mal über Zeth\'Gor triumphiert und seine Dunkelheit nahe an Euer Herz gelassen. Ich werde das Auge untersuchen und damit hoffentlich die Geheimnisse seines Meisters Grillok lüften.$B$BHoffentlich kann es seine Magie nicht länger einsetzen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10814, 'deDE', 'Werdet Ihr uns also helfen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10816, 'deDE', 'Ausgezeichnete Arbeit, $C. Möge das Licht Euch beschützen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10817, 'deDE', 'Ihr habt meinen höchsten Respekt verdient, $N.$B$BEinen Höllenorc alleine zu töten ist schon keine leichte Aufgabe. Eine ganze Meute von ihnen zu töten ist, nun... heroisch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10818, 'deDE', 'Ah, wie ich sehe habt Ihr beschlossen, Euch ganz schön Zeit zu lassen, bis Ihr meinem Aufruf Folge geleistet habt.$B$BWie auch immer, ich hatte genug Zeit, um an meinen Racheplänen zu feilen, und Ihr sollt in der kommenden Schlacht mein Vollstrecker sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10819, 'deDE', 'Was soll das bedeuten? Niemand ruft mich! Sprecht, oder ich werde Euch für immer zum Schweigen bringen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10820, 'deDE', 'Das wird ihnen sicher zeigen, dass sie besser tun sollten, was ich ihnen sage...$B$BÜbrigens... wo ist Schicksalsrufer? Warum habt Ihr mir von dieser Revolte berichtet und nicht sie?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10821, 'deDE', 'Das sind wirklich großartige Nachrichten, $N. Ich hätte es mir nicht besser wünschen können. Eure Dienste gegenüber meinem Volk sind sehr geschätzt. Bitte wählt Euch einen dieser Gegenstände aus.$B$BEuer Name wird für immer in den Herzen unseres Volkes klingen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10822, 'deDE', 'Sieg für die Seher! Kaels Streitmächte werden bald fallen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10823, 'deDE', 'Ihr macht Euch einen Namen, $N. Weiter so!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10824, 'deDE', 'Kaels Armee des Sonnenzorns ist sehr gut ausgebildet. Ausgezeichnete Arbeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10825, 'deDE', 'Ja, es ist die Kugel, die Ihr da habt! Merkwürdig, sie scheint von den Arakkoa zu stammen. Wart Ihr kürzlich in Grishnath?$B$BAh, das erklärt das Ganze. Aber ich frage mich, welchem teuflischen Zweck dieses Objekt dient. Obwohl das Böse eindeutig darin schlummert, scheint sie doch mit der Natur verbunden zu sein.$B$BBitte erlaubt mir zu versuchen, sie zu aktivieren. Das Böse darin ist so stark, es erinnert mich an etwas...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10826, 'deDE', 'Sich den Dämonen der Brennenden Legion und den wahnsinnigen Kultisten, die sie verehren, zu stellen ist keine geringe Tat, $N. Ihr habt viel Hingabe und Mut bewiesen. Macht so weiter, und Euer Ruf bei den Aldor wird weiter steigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10827, 'deDE', 'Beweist Euch weiterhin als würdig, $N. Besiegt die Feinde des Lichts, wo immer Ihr sie findet. Eure Taten sollen angemessen belohnt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10828, 'deDE', 'Ihr beweist Euch weiterhin als würdig, $N. Besiegt die Feinde des Lichts, wo immer Ihr sie findet. Eure Taten sollen angemessen belohnt werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10829, 'deDE', 'Grüße, kleiner $R. Die Vögel in meinen Zweigen haben mir zugeflüstert, dass Ihr kommen würdet.$B$BIhr seid hier, um die Bäume des Waldes von ihrer Besessenheit zu heilen?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10830, 'deDE', 'Das Böse verschwindet aus dem Rabenwald! Könnt Ihr es fühlen, $N?$B$BIhr habt uns und alle Wildtiere hier vor der unweigerlichen Zerstörung gerettet, kleines Wesen!$B$BFür solche Gelegenheiten trage ich vier magische Ringe in meinen Zweigen und verschenke sie, wenn ein Held sich erhebt, um eine große Tat zu vollbringen.$B$BIhr seid solch ein Held! Im Namen des gesamten Rabenwaldes danke ich Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10834, 'deDE', 'Ah ja. Ich frage mich, ob Grillok in seinen dunklen, dunklen Träumen immer noch mit seinem verlorenen Auge verbunden ist, wie jemand, der eine Hand oder ein Bein in der Schlacht verloren hat...$B$BAuch ich werde davon träumen. Und wenn das Schicksal auf unserer Seite steht, werden wir dadurch erfahren, was Grillok und die Orcs des Blutenden Auges dazu gebracht hat, sich den Dämonen zu unterwerfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10835, 'deDE', 'Ah, ein Bericht von Albreck? Sehr gut. Die königliche Apothekervereinigung versucht verzweifelt herauszufinden, wie die Orcs zu Höllenorcs geworden sind. Ihr Verrat ist unverzeihlich... und wir müssen sicherstellen, dass unsere Orcfreunde für alle Zeit vor dieser Verderbnis sicher sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10836, 'deDE', 'Gut gemacht, $N. Ich habe einen Weg gefunden, wie wir die versklavten Drachen in der Festung des Drachenmals befreien können.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10837, 'deDE', '<Neltharaku nimmt Euch die Kristalle ab.>$B$BIch werde nun die Kristalle mit meiner Magie erfüllen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10838, 'deDE', 'Ihr habt die Messung? Ausgezeichnet. Ich bin mir sicher, dass diese Daten sich für unsere Forschungen als unersetzlich erweisen werden. Ich werde sie gleich an Apothekerin Zelana und Apotheker Albreck weiterleiten.$B$BIhr solltet stolz auf Euch sein, $N. Eure Stärke und Euer Mut steht außer Frage... genauso wie Eure Leistungen gegenüber der Horde.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10839, 'deDE', 'Ich habe bis hierher die Explosion hören können. Nicht mit meinen Ohren, sondern mit meinem Herzen.$B$BWenn die Berührung des gesegneten Naaru A\'dal nicht ausreicht, um die Arakkoa zu erlösen, dann kann nichts auf der Welt das schaffen. Diejenigen, die ihre Seele nicht dem Licht ausgeliefert haben, sind nichts als Diener des Bösen.$B$BSie müssen vernichtet werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10840, 'deDE', 'Hier in der Wildnis der Scherbenwelt sind wir schwach. Nur wenige Helden verteidigen unsere Rechte, aber Ihr habt ihnen gezeigt, dass sie sich fürchten müssen, $C. Ich glaube nicht, dass die Astralen Euren starken Arm so schnell vergessen werden, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10842, 'deDE', 'Ich danke Euch im Namen der gequälten Seelen, die Ihr befreit habt, $R.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10843, 'deDE', '<Leoroxx mustert Euch aufmerksam.>$B$BGnosh Brognats Tod ist ein Segen für alle Mok\'Nathal. Das ist gut für Euch.$B$BMal schauen, ob Ihr immer noch so heldenhaft seid, wenn wir die Messlatte etwas anheben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10845, 'deDE', 'Nein! Ihr habt Unheilschwinge getötet? Vielleicht habe ich mich in Euch getäuscht, $C.$B$BVielleicht.$B$BDennoch habt Ihr die Anführer der drei größten Bedrohungen für unser Volk erschlagen. Darauf könnt Ihr stolz sein.$B$BIch werde Euch ein Zeichen meiner Wertschätzung geben, aber lasst es Euch nicht zu Kopf steigen. Ihr habt immer noch keine Ahnung davon, was es bedeutet, ein Mok\'Nathal zu sein. Vielleicht werden wir immer noch auf Eure Fähigkeiten zurückkommen müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10846, 'deDE', 'Die Vekh\'nir sind noch die harmlosesten unserer Feinde.$B$BIhr habt also einen übergroßen Vogel getötet. Das macht Euch noch lange nicht zu einem wahren Krieger. Das lässt Euch auch nicht unser Wesen verstehen.$B$BAber es ist ein Anfang.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10847, 'deDE', 'Euer Mut sollte belohnt werden. Die Wachen von Skettis rücken ihre Besitztümer nur ungern heraus.$B$BAber die Heldentaten der Vergangenheit sind nun nicht von Belang. Wir sollten uns lieber darum kümmern, dass dieser Heldenmut auch in der Zukunft weiter herrscht, denn Terokks Blick richtet sich gen Süden.$B$BDiese Augen sehen alles.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10848, 'deDE', 'Diese verderbten Geister haben es verdient zu sterben. Der Tod, den sie über alle anderen gebracht hätten, ist dafür Grund genug.$B$BEs besteht keine Hoffnung, dass wir die, die unter Terokks Einfluss stehen, erlösen können. Aber wir werden ihnen im Namen des Lichts ein Ende setzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10849, 'deDE', 'Rilaks Geschichte ist grausam, Reisender. Wie Ihr am Zustand der Karawane sehen könnt, gibt es dieser Tage viel Leid und Düsterkeit in den Wäldern von Terokkar.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10850, 'deDE', 'Als Ihr den falschen Treibstoff einfüllt, beginnt der Motor des Teufelshäschers zu rumpeln und zu stottern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10851, 'deDE', 'Das sieht nach einer guten Sammlung aus. Wir sollten einen Weg finden können, sie respektvoll einzusetzen.$B$BIn der Tat habe ich sogar schon eine Idee!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10852, 'deDE', 'Ihr habt all meine Freunde gefunden! Jetzt habe ich wieder jemanden, der mit mir spielt. Vielen Dank, Herr $N.$B$BDa ich jetzt wieder andere Kinder zum Spielen habe, könnt Ihr ja eins meiner Spielzeuge haben. Dann habt Ihr auch etwas zum Spielen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10853, 'deDE', 'Ihr habt heute eine große Tat vollbracht, $C. Die Geister der Drachen werden nun wieder singen können, denn sie sind frei. Und die Überreste ihrer Geister, die sie hinterlassen, dienen als mächtiges Heilmittel.$B$BHabt Ihr vielleicht Lust auf eine Reise in den Norden? Es gibt da eine Sache im Zusammenhang mit den Astralen, die mich brennend interessiert.$B$BIch fühle großen Schmerz aus dieser Richtung kommen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10854, 'deDE', '<Neltharaku lacht.>$B$BDie Orcs müssen einen ganz schönen Schreck bekommen haben, als die Drachen sich plötzlich gegen sie gewendet haben. Gut gemacht, $N. Vielleicht seid Ihr wirklich der Held unseres Schwarms.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10855, 'deDE', 'Das sind ausgezeichnete Nachrichten, $N. Jetzt, da wir wissen, wie wir mit ihnen zu verfahren haben, kann ich ein paar Leute anheuern, um die übrigen Häscher zu sabotieren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10856, 'deDE', 'Gute Arbeit, $N. Macht weiter so, dann werde ich beim Nexusprinzen ein gutes Wort für Euch einlegen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10857, 'deDE', 'Dank Euch kann ich wieder etwas durchatmen, $N. Das meine ich natürlich im übertragenen Sinne!$B$BIch nehme an, Ihr wollt nun eine Art Belohnung, oder?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10858, 'deDE', 'Es sind die Ketten. Sie berauben mich meiner Macht. Der einzige Ausweg ist, den Schlüssel von Zuluhed zu beschaffen und mich loszuketten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10859, 'deDE', 'Etwas fühlt sich hier falsch an.$B$BBitte, $N, reicht mir das Totem. Ich muss diese Kugeln untersuchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10860, 'deDE', 'Mmm, ich kann sie schon schmecken! Schnell, reicht mir die Zutaten... Ich werde sie rasch klein würfeln und dann ab damit aufs Feuer!$B$BZu Eurem Glück hält sich das Zeug lange, und ich meine damit sehr lange! So, nehmt dies. Und da Ihr so freundlich wart, meine Speisekammer aufzufüllen, gebe ich Euch die Rezepte gleich noch dazu.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10861, 'deDE', 'Es ist eine grausame Aufgabe, Jungtiere zu quälen, und doch wäre es unverzeihlich, das wachsende Böse zu ignorieren. Ihr habt gute Arbeit geleistet. A\'dals Gunst leuchtet auf Euch herab.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10862, 'deDE', 'Euer Volk ist wütend, aber ich kann nicht viel dagegen tun. Einige von uns wurden von der Macht der Naaru berührt und für alle Zeiten verändert. Doch diejenigen von uns, die in der Wildnis leben, sind noch immer so, wie wir damals waren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10863, 'deDE', 'Es war sehr weise von Euch, mich aufzusuchen. Es gibt vieles, was ich Euch zeigen kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10864, 'deDE', 'Gut gemacht, $N. Eure Seele ist mit vielen Toden belastet... und der dämonische Seher wird nun seine Pflicht für Euch erfüllen.$B$BWollen wir hoffen, dass Ihr für das Folgende gewappnet sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10865, 'deDE', 'Ist das, was Ihr da sagt, überhaupt möglich? Was sage ich da? Natürlich ist es das, wenn der Geistrufer davon überzeugt ist.$B$BErinnert Ihr Euch noch, als ich sagte, dass wir vielleicht wieder Eure Hilfe brauchen würden? Wie es scheint, kann ich in die Zukunft sehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10866, 'deDE', 'Ich bin frei! Ihr habt uns gerettet, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10867, 'deDE', 'Es ist gut, dass der Abschaum der Astralen und ihr Anführer tot sind. Ich wünsche ihren Brüdern tausend Plagen auf den Hals!$B$BIhr sollt für Eure Taten im Namen aller Mok\'Nathal belohnt werden, $N! Ihr seid wirklich ein Held für uns!$B$BLasst uns nun die Seelen unserer Vorfahren dem reinigenden Feuer übergeben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10868, 'deDE', 'Gut gemacht, $C. Die Arakkoa haben gelernt, die Macht der Horde zu fürchten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10869, 'deDE', 'Gut gemacht, $C. Die Arakkoa haben gelernt, die Macht der Allianz zu fürchten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10870, 'deDE', 'Ihr habt Euch als Verbündeter der Netherschwingen erwiesen. Meine Mutter ist frei und meine Brüder und Schwestern gerettet!$B$BVielleicht werde ich Euch eines Tages erneut rufen. Wenn dieser Tag kommt, werdet Ihr mit offenen Armen begrüßt werden, als Bruder des Drachenschwarms der Netherschwingen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10873, 'deDE', 'Ihr habt so viele gerettet. Ich habe nicht geglaubt, dass wir sie je wieder sehen würden. Wir können Euch nicht genug danken, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10874, 'deDE', 'Wir haben gesehen, wie der verfluchte Rauch aufgestiegen ist. Ihr seid außergewöhnlich mutig, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10875, 'deDE', 'Es ist schön, von Euren Schachzügen gegen die Höllenorcs zu erfahren, $N. Die Apotheker haben viel Zeit und viel Mühe aufgewendet, um hinter den Grund der Verderbnis zu kommen, und auch wenn diese Informationen sicher unersetzlich sind... schreit mein Orcblut danach, diesen Verrätern einen anständigen Schlag zu verpassen!$B$BHört genau zu, wenn ich Euch Eure Aufgabe erkläre...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10876, 'deDE', 'Ihr habt eine große Tat geleistet, $N. Die Höllenorcs sind eine Schande für alle wahren Orcs. Wenn wir eine Angst haben, so ist es die, erneut einer dämonischen Verderbnis zu verfallen. Unser Krieg gegen die Höllenorcs ist also mehr als nur eine Schlacht gegen schlimme Feinde, es ist eine Schlacht in uns selbst.$B$BUnd mit einer Stärke, wie Ihr sie heute bewiesen habt, werden wir diese Schlacht gewinnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10877, 'deDE', 'Es ist unglaublich, dass Ihr es geschafft habt. Das Schreckensrelikt ist viel mächtiger, als ich befürchtet hatte. Nur ein starker Held hätte die lange Rückreise mit so einem blasphemischen Gegenstand überlebt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10878, 'deDE', 'Vorerst kann ich erleichtert durchatmen, $N. Der Schattenrat wird sich bis auf weiteres zurückhalten.$B$BSie sind Mörder und Feiglinge. Eure Zurschaustellung von Mut wird sie einschüchtern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10879, 'deDE', 'Ich ziehe meinen Hut vor Euren Kampfkünsten, $C. Ihr habt Euch als wahrer Verteidiger des Lichts bewiesen. Möge A\'dals Segen in Euren dunkelsten Stunden auf Euch ruhen.$B$BDoch seht zum fernen Horizont. Dunkle Wolken ziehen unheilvoll über Skettis herauf. Sicher plant Terokk schon seinen nächsten Schachzug. Für heute ist Shattrath gerettet. Doch wer weiß schon, welch Verderben der nächste Tag über uns alle bringen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10880, 'deDE', 'Ah, ja... dieser Text wurde in einer einfachen Form der Geheimschrift der Schatten geschrieben. Mein Wissen darüber ist nicht perfekt, aber es sollte ausreichen, um sie zu übersetzen.$B$BMan kann viel von den zwielichtigen Gestalten lernen, wenn man unter den Ausgestoßenen und Flüchtlingen im Unteren Viertel lebt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10881, 'deDE', 'Das Licht hat mich vielleicht vergessen, aber ich habe das Licht nicht vergessen. Diese Relikte waren meinem Volk einst sehr heilig.$B$BDem Schattenrat zu erlauben, sie für Böses einzusetzen ist... undenkbar!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10882, 'deDE', '<Das kristallene Klingen von A\'dals Stimme fließt in einer deutlich ruhigeren Melodie als die letzten beiden Male, in denen Ihr miteinander gesprochen habt.>$B$BWieder einmal habt Ihr Euren Eifer bewiesen. Wenn Herold Horizontiss ausgebrochen wäre, wären Tausende dem Konflikt zum Opfer gefallen, genauso, wie es bei einem anderen Diener der alten Götter, Skeram, auf Eurer Welt Azeroth geschehen ist.$B$B$N, was ich Euch als Belohnung anbiete, scheint im Vergleich erbärmlich zu sein, aber seid Euch bewusst, dass die ewige Dankbarkeit der Sha\'tar damit verbunden ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10883, 'deDE', 'Die Festung der Stürme ist eine Erfindung der Naaru, Sterbliche. Zutritt zu der Festung zu gewähren lag schon immer alleine im Ermessen der Naaru. Eine Rückkehr zur Festung der Stürme erschien uns jedoch unnötig. Vielleicht mag das für eine Sterbliche Rasse wie Stolz aussehen, doch wir Naaru halten nur wenig von solchen Dingen.$B$BWir gehen nun, weil wir es müssen. Kael\'thas darf die Litanei der Verdammnis niemals vorlesen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10884, 'deDE', 'Gut gemacht, $N. Ihr habt die Prüfung des Erbarmens abgeschlossen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10885, 'deDE', 'Gut gemacht, $N. Ihr habt die Prüfung der Stärke abgeschlossen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10886, 'deDE', 'Gut gemacht, $N. Ihr habt die Prüfung der Zuverlässigkeit abgeschlossen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10887, 'deDE', 'Ihr habt Akuno, meinen geschätzten Freund, errettet. Dafür stehe ich in Eurer Schuld, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10888, 'deDE', 'Ihr habt Euch als Wesen mit großer Macht bewiesen. Die Naaru gewähren Euch Einlass in die Festung der Stürme.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10889, 'deDE', 'Die Wachen von Skettis werden langsam unruhig. Shattrath steckt in Schwierigkeiten. Wir werden Terokks Rache sicher eiskalt zu schmecken bekommen.$B$BStellt schnell eine Verteidigung auf die Beine! Sprecht mit Verteidiger Grashna und lasst ihn wissen, dass Ihr bereit seid, die Waffen gegen unsere Angreifer zu erheben!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10893, 'deDE', 'Nun, da Draaca unschädlich gemacht wurde, sollten wir in der Lage sein, unseren Vorteil aus der Situation zu ziehen. Sie werden sich jetzt untereinander darum streiten, wer die Leitung übernehmen soll, und das wird uns viel Druck nehmen.$B$BEs sei denn der Aufseher aus dieser Einladung, die Ihr mir gegeben habt, nimmt ihren Platz ein.$B$BWir sollten sicherstellen, dass das niemals passieren wird!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10894, 'deDE', 'Es ist genau so, wie ich es befürchtet habe, und das ist nicht gut!$B$BIch habe schon eine Idee, wie ich Euch helfen kann, aber vielleicht könnt zunächst Ihr uns helfen?$B$BEine Hand wäscht die andere.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10895, 'deDE', 'Ich konnte von hier aus den Rauch und die Flammen sehen! Gute Arbeit, $N! Ihr verdient mehr als nur ein paar Lobesworte von unseren Greifenreitern. Was Ihr da getan habt, erfordert eine gehörige Portion Mut.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10896, 'deDE', 'Ihr habt viel zur Rettung der Wälder von Terokkar beigetragen, $N. Jetzt, da die schlimmsten Milbenkolonien vernichtet sind, können wir vielleicht dieses öde Land zurückerobern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10898, 'deDE', 'Also stand der arme Wolkenschwinge unter dem schrecklichen Fluch von Luanga dem Kerkermeister!$B$BWolkenschwinge hatte sich auf den Weg ins Shalasversteck gemacht, um zu versuchen, die anderen auf den Weg des Lichts zu bringen. Sie haben seine Versuche nicht gerade positiv aufgenommen, vor allem nicht, da sie direkt am Fuße von Skettis liegen.$B$BLuanga war einer von Terokks gefürchtetsten Dienern. Es war gut von Euch Wolkenschwinge zu befreien! Ich danke Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10903, 'deDE', 'Ja, es ist wahr. Oberst Jules\' Zustand hat sich in den letzten Tagen stark verschlechtert. Anachoret Barada betet schon die ganze Zeit für ihn... Wir hoffen, dass er geheilt werden kann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10904, 'deDE', 'Diese Dinger stinken ja schlimmer, als ich dachte!$B$BSchnell, gebt sie mir, damit ich die mit der Macht der Natur erfüllen kann. Dann werden sie zu tödlichen Waffen gegen die teuflischen Meister und ihre unnatürlichen Schöpfungen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10908, 'deDE', 'So treffen wir uns also, $N. Bitte vergebt mir meine fehlenden Manieren, aber die Zeit drängt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10909, 'deDE', 'Die Orcs der Zerschmetterten Hand sind verderbt und nicht mehr zu retten. Und dennoch erfüllt es mein Herz mit Traurigkeit, dass die Rettung von Oberst Jules ein solches Blutvergießen erfordert.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10910, 'deDE', 'Ich bin sehr erleichtert, dass Wildfürst Antelarion Euch zu uns geschickt hat. Das Problem ist noch viel schlimmer, als wir befürchtet haben!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10911, 'deDE', 'Euer Heldenmut ist beeindruckend!$B$BSehr gut. Nun, da die Warpportale außer Gefecht sind, bleibt nur noch eines zu tun.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10912, 'deDE', 'Ihr seid wirklich ein ganz erstaunlicher $R! Wenn ich schon zuvor dachte, dass wir in Eurer Schuld stehen, so gibt es nun einfach keinen Weg mehr, Euch je für Eure Taten zu danken.$B$BAber wir wollen es dennoch versuchen. Vielen Dank, Held des Ewigen Hains!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10913, 'deDE', '<Kommandant Ra\'vaj schüttelt traurig den Kopf.>$B$BEs ist nicht genug... Es ist einfach nicht genug.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10914, 'deDE', 'Ihr habt es geschafft, $N! Dank Euch konnten wir eine neue Entdeckung machen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10915, 'deDE', 'Der Sieg ist unser! Diese Niederlage wird die Auchenai um mehrere Wochen zurückwerfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10916, 'deDE', 'Ihr habt die Gebetsperlen gefunden! Gut gemacht, $N. Ihr seid in der Tat ein Wunder. Im einen Moment erschlagt Ihr die Schrecken der Höllenfeuerhalbinsel, im anderen findet Ihr verlorene Schätze. Euer Volk ist wirklich sehr vielseitig!$B$BEs ist gut, dass Ihr diese Perlen gefunden habt... Sie sind für das folgende Exorzismusritual von äußerster Wichtigkeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10917, 'deDE', '<Vekax krächzt vor Freude, als Ihr ihm den Beweis für den Tod seiner Feinde übergebt.>$B$BJa, das wird Skettis zeigen, dass wir Ausgestoßenen ihre Bestrafung nicht lammfromm hinnehmen. Hier ist die Belohnung, die ich Euch versprochen habe. Ich kann Euch noch mehr geben, wenn Ihr mir weitere Federn bringt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10918, 'deDE', '<Vekax krächzt vor Freude, als Ihr ihm den Beweis für den Tod seiner Feinde übergebt.>$B$BJa, das wird Skettis zeigen, dass wir Ausgestoßenen ihre Bestrafung nicht lammfromm hinnehmen. Hier ist die Belohnung, die ich Euch versprochen habe. Ich kann Euch noch mehr geben, wenn Ihr mir weitere Federn bringt.$B$B<Diese Quest kann wiederholt werden, bis Ihr einen wohlwollenden Ruf erlangt habt.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10919, 'deDE', '<Fei-Fei bellt glücklich und schnappt sich das Hundeleckerli. Er schaut nach links und rechts, um zu entscheiden, wo er seinen neuen Schatz vergraben soll...>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10920, 'deDE', 'Ich habe die Geräusche Eures Kampfes bis hierher hören können, $C. Der Klang Eures Sieges hat mein Herz mit Hoffnung erfüllt. Wenn Ihr gegen eine solch gewaltige Überzahl bestehen könnt, kann auch ich vielleicht noch die Kraft finden, um meine Kameraden von diesem schrecklichen Ort fort zu führen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10921, 'deDE', 'Die Schreckensspinnen wurden geschlagen. Ihr habt so viele von ihnen getötet und nun auch noch ihre verderbte Mutter erlegt. Meine Vergiftungen sind zu schwer, als dass ich mich zurück in die Freiheit kämpfen könnte.$B$BBitte, nehmt etwas von meiner Ausrüstung. Ich werde mein Bündel erleichtern und Euch die nötigen Werkzeuge geben, um heil zum Basislager der Sha\'tari zu gelangen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10922, 'deDE', 'Ein Knochenwurm! Fantastisch! Das könnte tatsächlich das erste Mal seit Beginn der Geschichtsschreibung sein, dass Letoll tatsächlich eine Entdeckung gemacht hat!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10923, 'deDE', 'Terokkar wurde von einem schlimmen Übel befreit. Die Sha\'tar stehen in Eurer Schuld.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10924, 'deDE', 'Das sollte genügend Vorrat für meine Zwecke sein.$B$BIch hoffe, der Wichtel hat Euch nicht allzu viel Ärger gemacht. Er hat manchmal Haare auf den Zähnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10926, 'deDE', 'Es ist gut zu wissen, dass einige unserer Krieger tapfer gegen die Schreckenswitwen gekämpft und überlebt haben. Wir werden sofort eine Rettungstruppe nach ihnen schicken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10927, 'deDE', 'Gute Arbeit, $C. Dieser Tunnel ist unsere direkte Verbindung zum Sumpf.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10928, 'deDE', 'Gute Arbeit, $C. Dieser Tunnel ist unsere direkte Verbindung zum Sumpf.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10929, 'deDE', 'Sandgnome? Ja, klar... Die Wüste kann schon schlimme Dinge mit den Leuten anstellen.$B$BIch glaube, wir werden mit diesen Würmern hier einen wahren Durchbruch erzielen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10930, 'deDE', 'Erstaunlich! Schaut Euch das an! Dieses Wasauchimmer hat eine Art Staub in seiner Wiemanesauchnennenmag. Aber ich will Euch nicht mit meinen wissenschaftlichen Fachbegriffen langweilen. Ich habe den kleineren Würmern ein paar Zähne gezogen und daraus diese unglaublich scharfen Messer gemacht. Wollt Ihr eins?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10935, 'deDE', 'Ihr habt es geschafft, $N. Ihr habt Oberst Jules\' Seele gerettet und die Dunkelheit in ihm vertrieben. Das ist eine großartige und selbstlose Tat! Die Tat eines Helden!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10936, 'deDE', 'Das wird auch langsam Zeit! Ich habe davon erfahren, was Ihr und dieser Draeneipriester angestellt habt! Ihr habt meinen Boten völlig schockiert!$B$BJetzt, da Ihr damit fertig seid, habe ich einen kleinen Auftrag in der Höllenfeuerzitadelle für Euch.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10937, 'deDE', 'Ich wollte es nicht glauben, bis ich es nicht von Euch persönlich gehört habe. Unsere Späher berichten uns jetzt schon, dass die Zerschmetterte Hand ohne ihren geschätzten Drillmeister, der ihnen sagt, was zu tun ist, völlig überfordert ist.$B$BIhr habt einen langen Weg zurückgelegt, $N. Ich vertraue darauf, dass Ihr diese Rüstung zusammen mit meinem Dank annehmt. Tragt sie mit Stolz, denn Ihr habt sie verdient!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10944, 'deDE', 'Ich danke Euch, $N. Olum ist einer meiner engsten Freunde und meiner treuesten Anhänger. Sein Beitrag zu unserem Werk ist für unsere Pläne unverzichtbar.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10949, 'deDE', '<Xi\'ri scheint Eure Anwesenheit zu bemerken. Offensichtlich konzentriert er sich auf die Schlacht in der Umgebung.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10969, 'deDE', 'Ja, das stimmt. Doch das Konsortium ist nicht die einzige Gruppierung, die Verluste zu vermelden hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10970, 'deDE', 'Tretet zurück, $N. Es könnte auch eine Falle des Astraleums sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10971, 'deDE', 'Es scheint sich hierbei um mehr als eine einfache Identifizierungsmarke zu handeln. Auf den Marken ist eine Art Code zu sehen. Ich stehe kurz davor, ihn zu entschlüsseln. Wenn ich doch nur mehr Marken hätte!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10972, 'deDE', 'Wir sind der Wahrheit auf der Spur, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10973, 'deDE', '<Ameer fügt die Schlüssel geschickt zusammen und betrachtet die Markierungen auf der so hergestellten Schlüsseltafel.>$B$B\"Tausend Welten zerschlagen, tausend weitere noch zu bezwingen... So lautet der Wille des Nexuskönigs.\"$B$B<Ameer dreht die Tafel um und liest die Rückseite.>$B$BStasiskammern von Bash\'ir?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10974, 'deDE', '<Das Bild von Kommandant Ameer kramt in den Beweisstücken.>$B$BEs ist schlimmer, als ich dachte... Diese Kammern enthalten wilde Bestien und Kreaturen von vielen verschiedenen Welten. Das Astraleum hofft, eines Tages Kontrolle über diese Bestien zu gewinnen und sie ihrem Willen zu unterwerfen. Wir müssen sie alle vernichten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10975, 'deDE', 'Es gibt immer noch mehr Arbeit, die erledigt werden muss, $N. Begebt Euch nun auf die Suche nach einer Stasiskammer und vernichtet, was auch immer darin lauern mag!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10976, 'deDE', 'Endlich!$B$B<Kommandant Ameer liest die Inschrift auf dem Abzeichen des Nexuskönigs.>$B$BZwei Gefängnisse? Schon der Gedanke an die Schrecken, die darin hausen mögen, lässt mich erzittern...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10977, 'deDE', 'Ich habe von Euren Heldentaten erfahren, $N. Haramad und ich sind uns beide einig, dass Ihr dafür eine großartige Belohnung verdient habt.$B$BObwohl... Ach, Ihr habt schon genug getan. Ich kann Euch nicht guten Gewissens um noch mehr bitten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10982, 'deDE', 'Ihr habt viel für das Protektorat und das Konsortium getan, $N. Daher ist es nur gerecht, dass einer unserer neuen Schlüssel an Euch geht. Mit diesem Schlüssel könnt Ihr Shaffars persönliche Stasiskammer jederzeit öffnen, ohne den Schlüssel dabei zu zerstören.$B$BEr ist von Dauer und wird auf ewig Euch gehören. ', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10983, 'deDE', 'Grok sagt, ich bin weise? Ich weiß ja nicht so recht.$B$BVielleicht liegt das daran, dass ich der Einzige meines Klans bin, der aufrichtig versucht uns vor der Vernichtung durch den Speerspießerklan zu retten. Und natürlich vor Gruul und seinen Söhnen, die sie unterstützen.$B$BIch hoffe, dass Ihr gekommen seid, um uns aus der unaufhaltsamen Verdammnis zu erretten, $C.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10984, 'deDE', 'Ihr helfen Grok? Grok brauchen Hilfe! Blutschläger brauchen Hilfe!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10985, 'deDE', '<Xi\'ri pulsiert vor Energie, Ihr fühlt, wie ein Gegenstand in Euren Händen Gestalt annimmt. Es ist das Medaillon, das Ihr A\'dal im Namen von Akama gegeben habt. Seine Macht hat sich durch die Magie der Naaru noch verstärkt. Die Sha\'tar haben Euch das Medaillon von Karabor anvertraut, und damit den Zugang zum Schwarzen Tempel.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10989, 'deDE', 'Endlich hat Chort mir jemanden geschickt, der in der Lage sein könnte, mir zu helfen. Ich bin bemüht, die Blutschläger vor der Auslöschung durch die Speerspießer zu bewahren. Und natürlich durch Gruul und seine Söhne, die sie unterstützen.$B$BIch vertraue fest darauf, dass Ihr unserer Geheimorganisation helfen und uns in die Freiheit führen könnt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10995, 'deDE', 'Das muss ein harter Kampf gewesen sein, $C. Ich bin sehr erleichtert, dass er uns nun nicht mehr auf die Pelle rücken wird.$B$BIch werde diesen Schädel zu Chort schicken, damit er auf ihn aufpasst. Ich glaube, dass wir unser Ziel mit eurer Hilfe erreichen können!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10996, 'deDE', 'Sie war leer? Was ein Pech! Aber nun habt Ihr eine Ahnung von der sinnlosen Gewalt, unter der wir leiden müssen.$B$BJetzt, da Maggoc tot ist, sind wir meinem Traum von einem Zuhause, in dem wir Oger unser Schicksal selbst schmieden können, einen entscheidenden Schritt näher gekommen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10997, 'deDE', 'Ich bin erleichtert, dass Slaag nicht mehr unter uns weilt. Nun müssen wir nicht länger in Angst vor seiner drohenden Rückkehr leben!$B$BWenn Ihr nichts dagegen habt, würde ich die Standarte gerne als Symbol der Hoffnung für alle Oger dieser Berge entgegennehmen.$B$BVielen Dank, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (10998, 'deDE', 'Ich scheue mich davor, ein Ding von solcher Abscheulichkeit auch nur anzufassen. Und doch müssen wir den Folianten lesen, wenn wir sein Wissen erkunden und Skulloc aus seinem Versteck locken möchten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11000, 'deDE', 'Es ist also vorüber. Ihr habt uns von den Fesseln der Sklaverei durch die Söhne von Gruul befreit. Ihr habt den Klan der Blutschläger vor der sicheren Auslöschung bewahrt.$B$BEs gibt keine Worte, um zu beschreiben, wie tief ALLE Oger des Schergrats, Blutschläger wie Speerspießer, in Eurer Schuld stehen, $N.$B$BSchaut dort, wie all die Oger sich versammeln, um Euch Tribut zu zollen! Sollen Gruul und seine Marionette, der alte König Maulgar, sich ruhig in ihrem Unterschlupf verkriechen. Geht zu den Ogern als ihr neuer König!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11004, 'deDE', 'Ich danke Euch, $N. Ich werde dem Kommandanten eine kleine Menge zukommen lassen... damit er seinen Willen bekommt. Ihr könnt den Rest behalten, vielleicht findet Ihr ja eine Verwendung dafür.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11005, 'deDE', 'Ihr habt Euch mit Bravour geschlagen, $N. Durch den Verlust der Krallenpriester wurde dem Feind ein empfindlicher Schlag versetzt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11006, 'deDE', 'Ihr könnt mir auch weiterhin noch Staub bringen. Ich werde so viele Elixiere für Euch herstellen, wie Ihr benötigt.$B$BAuf Befehl des Kommandanten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11008, 'deDE', 'Ausgezeichnete Arbeit, $N! Das wird diesen Vogelwesen zeigen, wer die wahren Herren der Lüfte sind!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11009, 'deDE', 'Mog\'dorg hat eine Nachricht voraus geschickt, um mich über Euer Kommen zu informieren. Ich bin froh, dass Ihr hier seid.$B$BNach dem Fall der Söhne des Gruul, ist es nur noch eine Frage der Zeit - es dürfte nicht sehr lange dauern - bevor die unterschiedlichen Bewohner dieser Bergterrasse und die des Nordens beginnen, Jagd auf unsere Ogerbrüder dort unten zu machen.$B$BDies gilt es zu verhindern und ich vertraue auf Eure Unterstützung, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11010, 'deDE', 'Gut, gut, anscheinend seid Ihr doch härter im Nehmen, als ich dachte. Ausgezeichnete Arbeit. Möglicherweise hatte der alte Keller doch Unrecht, was Euch anbelangt.$B$B<Himmelsoffizierin Vanderlip grinst.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11012, 'deDE', 'Unser Land ist verloren. Man entführt unsere Kinder in der Nacht, versklavt sie - oder schlimmer...$B$B<Mordenais Stimme wird angespannt.>$B$BEs ist an der Zeit, mein Freund. Zeit, uns wieder das zu nehmen, was einst unser war! Ihr habt Euch als tapferer Kämpfer und verständnisvolle Seele erwiesen.$B$BWerdet Ihr schwören, dem Drachenschwarm der Netherschwingen beim Kampf um unser Land und den Wiederaufbau unserer Heimstätten zu helfen? Werdet Ihr schwören, über den Schwarm zu wachen, damit unser Fleisch und Blut aufs Neue zum Leben erwachen kann? Schwört und lasst uns im Namen unserer Heimat und unserer Familien kämpfen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11013, 'deDE', '<Mor\'ghor überfliegt das Schreiben und lacht.>$B$BEin Todesritter? Ihr könnt einem Todesritter nicht mal das Wasser reichen, Wurm.$B$B<Mor\'ghor mustert Euch scharf.>$B$BNun gut... Ihr könntet es vielleicht noch zum Peon schaffen. Im schlimmsten Fall werfe ich Euch in die Grube und lasse Euch dort verrotten...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11014, 'deDE', 'Varkule findet schon was für Euch, Grunzer. Euch steht eine Aufgabe zu, die Euren Fertigkeiten am besten gerecht wird und unserer Kristallförderung zu Gute kommt. Ihr müsst Euren Arbeitsauftrag einmal am Tag ausfüllen.$B$BJa, es gibt da einen Haufen Drecksarbeit zu erledigen, aber auch die Ahnen haben mal als Peon begonnen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11015, 'deDE', 'Das war\'s für heute, Kindchen. Kommt morgen wieder, wenn Ihr noch am Leben seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11016, 'deDE', 'Das war\'s für heute, Kindchen. Kommt morgen wieder, wenn Ihr noch am Leben seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11017, 'deDE', 'Das war\'s für heute, Kindchen. Kommt morgen wieder, wenn Ihr noch am Leben seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11018, 'deDE', 'Das war\'s für heute, Kindchen. Kommt morgen wieder, wenn Ihr noch am Leben seid.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11019, 'deDE', 'Ihr habt doch nicht etwa geglaubt, dass wir Euch den Armeen der Höllenorcs ganz alleine überlassen würden, oder?$B$B<Yarzills Augen flackern in einem durchscheinenden Blau.>$B$BGenau, wir sind hier an Eurer Seite, $N. Bei jedem Dienst, den Ihr den Höllenorcs bei Eurem Versuch, die Weiten der Netherschwingen zurückzuerobern, erweist, werden wir dafür sorgen, dass sie einen ausreichenden Rückschlag erleiden.$B$BIhr müsst Euch sehr unauffällig verhalten, um keinerlei Aufmerksamkeit während Euren Sabotageeinsätzen auf Euch zu ziehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11020, 'deDE', '<Yarzill flüstert ganz leise.>$B$BAusgezeichnete Arbeit, $N. Verhaltet Euch fürs Erste ruhig. Kommt morgen wieder zu mir, dann können wir das Ganze noch einmal machen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11021, 'deDE', 'Was habt Ihr mir da gebracht? Die Sprache dieses Folianten ist mir fremd, $N... mein Blutverlust... muss meinen Geist verschleiert haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11022, 'deDE', 'Mein werter Herr, es freut mich, dass Ihr vor Eurer Abreise noch einmal mit mir zu sprechen gedenkt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11023, 'deDE', 'Hervorragend, $N! Ich würde Euch ja sofort wieder in die Luft schicken und ein paar Bomben werfen lassen, aber unsere Richtlinien hier schreiben vor, dass unsere Piloten ausreichend Ruhe und Erholung erhalten müssen. Es tut mir leid, ich mache die Regeln nicht, aber lasst Euch versichern, dass ich sie durchsetzen werde!$B$BSehen wir uns morgen wieder, Sportskanone?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11024, 'deDE', 'Das kann nicht sein... dies war einst Eigentum eines Krallenpriesters. Wie ist es nur in Eure Hände gelangt?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11025, 'deDE', '<Chu\'a\'lors linker Kopf beginnt zu sprechen.>$B$BDiese sind genau richtig.$B$BDenkt daran, $N, der Wert dieser Splitter liegt nicht in ihrem Verkaufspreis. Es ist nicht einmal das, was sie für Euch tun können, sobald sie ordnungsgemäß zusammengeschmiedet wurden... auch wenn sich darüber streiten lässt.$B$B$B$BDer wahre Wert liegt in dem Unterfangen, das es auf sich zu nehmen gilt, um in den Besitz dieser Splitter zu gelangen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11026, 'deDE', 'Das wird ihnen eine Lehre gewesen sein! Kommen wir nun zu Eurer Belohnung.$B$BDie Dämonen des Konstruktionslagers: Rache im Norden haben an ihrer südlichen Grenze einen besonderen Transporter errichtet. Sie verwenden dieses experimentelle Transporttor, um den Einfluss des Lagers weiter auszudehnen. Wir brauchen Euch wohl nicht erst erklären, was passieren wird, wenn sie sich zu weit ausbreiten.$B$BAlso, wenn wir Ihr wären, würden wir diese Dunkelrune zu Gahk schaffen und ihn Fragen, wie Ihr helfen könnt. Geht es langsam mit ihm an, $N, er ist ebenfalls neu hier.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11027, 'deDE', 'Haha, gut! Gahk mögen Dunkelrunen! Ihr nehmen kristallgeschmiedete Dunkelrune, die Gahk kürzlich gemacht haben.$B$BNicht vergessen, Tokru, erst beherrschen Zerrütter und dann zerschlagen magisches Schild von Shartuuls Transporter. Andere Dämon wird frei sein und dann Ihr auch ihn bekämpfen und beherrschen! Dann Ihr müssen mehr Dämonen bekämpfen und kontrollieren, bis keine mehr kommen!$B$BDann Ihr Ogri\'la erretten!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11028, 'deDE', 'Die Arakkoa möchten Terokk zurück aus dem Jenseits der Zeit holen und Rilak... möchte einen Weg finden, um diesen Vorgang zu beschleunigen? Hat er denn seinen Verstand verloren?$B$B<Adaris legt sich geschwächt nieder.>$B$BIhr habt Eure Pflicht erfüllt, $N. Es ist an der Zeit, dass Ihr die Sache meinen Männern überlasst. Das ist jetzt eine rein militärische Angelegenheit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11029, 'deDE', 'Ausgezeichnet! Das Buch beinhaltet eine Aufstellung der Nachfahren von Terokks alten Feinden. Es wurde vorhergesagt, dass ihr Tod Terokks Rückkehr ankündigen wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11030, 'deDE', 'Ihr seid ein wahrer Lebensretter, $N!$B$BUnsere Jungs werden von dieser Neuigkeit begeistert sein!$B$BOkay, eines geschafft und eines fehlt noch. Wir haben Euch doch bestimmt von dem anderen Fläschchen erzählt, das sie benötigen, nicht wahr?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11035, 'deDE', '<Yarzill flüstert.>$B$BIhr habt den Netherschwingen einen großen Dienst erwiesen, $N. Der Fall des Drachenmals rückt in greifbare Nähe. Von innen heraus breitet sich nun eine Krankheit aus - eine unheilbare Krankheit...$B$BSolltet Ihr wieder an Arbeit bei dem Himmelspfads des Drachenmals interessiert sein, so kommt morgen wieder.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11036, 'deDE', '<Der Raketenchef überprüft den Inhalt der Kiste.>$B$BSieht soweit gut aus. Wieder etwas, das ich von der Liste streichen kann. Nun müssen wir noch nur dafür sorgen, dass die Rakete vom Boden abhebt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11037, 'deDE', '<Der Raketenchef hört Euch aufmerksam zu, als Ihr ihm von der Vision des Sehers erzählt.>$B$BNun, das ist alles völlig neu für mich, aber Eure Hilfe können wir allemal gebrauchen. Seht Euch die Rakete hinter mir an! Das ist die X-52...$B$BIst sie nicht das Schönste, was Ihr je gesehen habt?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11038, 'deDE', 'So, Ihr seid also hierhergekommen, um unsere Untersuchungen über Kael\'thas Pläne zu unterstützen? Eure Hilfe ist uns sehr willkommen. Der Nethersturm ist voll von Agenten der Blutelfen, die nichts unversucht lassen, um das Land ins Chaos zu stürzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11039, 'deDE', '<Einen Augenblick lang huscht ein Ausdruck der Enttäuschung über das Gesicht des Spionagemeisters.>$B$BIch hatte wenigstens auf eine ganze Einsatzgruppe gehofft, aber wenn Voren\'thal es für sinnvoll hielt, Euch alleine zu entsenden, werde ich meine Pläne entsprechend anpassen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11040, 'deDE', 'Ich weiß nicht einmal, was einige dieser Teile bewirken! Einige von ihnen werden mir sicherlich sehr nutzen. Ich hätte niemals gedacht, dass ich mal lernen müsste, wie ein Gnom zu denken!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11041, 'deDE', 'Ihr habt also bei den Überresten einer meiner Aufseher eine Anordnung gefunden und die Sache selbst in die Hand genommen? Ihr habt es geschafft, Mor\'ghor zu beeindrucken. Gut gemacht...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11042, 'deDE', '<Der Raketenchef hört Euren Ausführungen über die Vision des Sehers aufmerksam zu.>$B$BNun, das ist alles völlig neu für mich, aber Eure Hilfe können wir allemal gebrauchen. Seht Euch das Ungetüm hinter mir an. Das ist die X-52...$B$BIst sie nicht das Schönste, was Ihr je gesehen habt?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11043, 'deDE', '<Brunns Gesicht errötet, bis es nicht länger von seinem Bart zu unterscheiden ist.>$B$BEr möchte WAS mit meinen Greifen anstellen?$B$BWenn diese kleine Ratte auch nur versucht, irgendetwas anderes als einen Sattel auf meinen Greifen zu befestigen, reise ich persönlich zum Schergrat und stopfe ihm mit seinen Raketen das Maul!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11044, 'deDE', 'Eine Vision sagt Ihr? Es interessiert mich nicht, ob er es in einer Vision gesehen, in einem Brief gelesen oder es aus dem Mund eines Grubenlords vernommen hat, aber er hat den Nagel auf den Kopf getroffen! Was führt Euch hierher, Freund? Oh, und wir sind für jede Unterstützung dankbar!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11045, 'deDE', 'Fantei spricht die Wahrheit, Eure Hilfe kommt mir sehr gelegen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11046, 'deDE', 'Fantei hat ein gutes Gedächtnis. Es ist schon Monate her, dass ich in Shattrath war, um Zutaten zu kaufen. Allerdings hat er Recht. Ich könnte etwas Hilfe gebrauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11047, 'deDE', '<Dama hört sich Agadais Bitte an.>$B$BIch kann nicht dafür garantieren, dass wir über genügend Windreiter verfügen, aber ich werde sehen, was ich tun kann. In der momentanen Situation haben wir Schwierigkeiten, die Nachfrage der verschiedenen Käufer und Außenposten abzudecken.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11048, 'deDE', '<Gulmok beginnt zu murren, als er von Kroghans Entscheidung hört.>$B$BIch verstehe durchaus seinen Standpunkt, doch unsere Schützengräben besetzen sich nicht von selbst! Die Legion bombardiert uns Tag und Nacht mit Höllenbestien. Wenn Kroghan sich verspätet, könnt Ihr ja seinen Platz auf dem Schlachtfeld einnehmen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11049, 'deDE', 'Neltharaku wird höchst erfreut sein, $N. Gut gemacht.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11050, 'deDE', 'Ihr seid ein wahrer Held, $N.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11051, 'deDE', 'Wir wünschten uns, der Herstellungsprozess für Runen der Dunkelheit wäre narrensicher, $N. Unglücklicherweise ist er das nicht. Nehmt bitte diesen Sack und seht mal, was wir heute hergestellt haben. Wir haben es nicht übers Herz gebracht, selbst nachzusehen.$B$BWenn Ihr eine Rune der Dunkelheit erhaltet, vergesst nicht, Gahk aufzusuchen und sie bei ihm gegen eine kristallgeschmiedete Rune der Dunkelheit einzutauschen. Mit ihr könntet Ihr Shartuuls Transporter erneut ausschalten.$B$BOh, und $N, denkt daran, morgen wiederzukommen und den Bannkristall abzuholen. Es sind genug Dämonen da, die gebannt werden möchten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11053, 'deDE', 'Ich habe Eure Handlungen mit einem wachsamen Auge verfolgt, $N. Ihr habt bewiesen, dass Ihr ein unschätzbarer Gewinn für das Drachenmal seid. Daher werde ich Euch zum Aufseher befördern. Ein neuer Rang bedeutet natürlich auch neue Verantwortungen, denen Ihr gerecht werden müsst.$B$BErhebt Euch, Aufseher $N! Erhebt Euch und sucht diejenigen auf, die Eure Hilfe hier im Basislager brauchen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11054, 'deDE', 'Ahh! Vielleicht habt Ihr ja doch das Zeug zum Aufseher. Diese übergroße Echse war schon das Leid vieler Orcs!$B$B<Chefvorarbeiter Lehmklump beginnt mit der Herstellung der Waffe.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11055, 'deDE', 'Ein Tag harter Arbeit! Es zahlt sich aber aus, oder? Beim Anblick der schuftenden Taugenichtse bei den Kristallen wird einem richtig Warm um\'s Herz... Nun ja, das ist alles für heute. Kommt morgen wieder, dann könnt Ihr ein weiteres Mal den Schuhmerang schwingen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11056, 'deDE', 'Ausgezeichnet, $N. Ihr werdet sehen, dass ich mein Wort halte.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11057, 'deDE', 'Man hat Euch von hoch oben zu mir geschickt? Wahrlich, meine Mission ist gesegnet! Ich versuche die Blutschläger vor der Ausrottung durch den Speerspießerklan und Gruuls Söhne zu bewahren.$B$BIch nehme an, dass Ihr unsere geheime Organisation unterstützen und uns die Freiheit bringen werdet?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11058, 'deDE', '<Chu\'a\'lors Köpfe nicken Euch anerkennend zu.>$B$BIhr habt einen scharfen Verstand, $N. Wir haben erheblich länger gebraucht, um das Relikt erfolgreich zu benutzen.$B$BNun, da Ihr wisst wie, könnt Ihr es so oft Ihr wollt verwenden. Denkt jedoch daran, dass für die Aktivierung eines Relikts immer ein Apexissplitter erforderlich ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11059, 'deDE', '<Chu\'a\'lor mustert Euch voller Respekt.>$B$BEure und die geistige Gewandtheit Eurer Freunde ist wahrlich beeindruckend. Dafür, dass Ihr uns und unsere Lebensweise verteidigt habt, stehen wir, nein, stehen ganz Ogri\'la und die Himmelswache in Eurer Schuld.$B$BDenkt daran $N, Ihr könnt jederzeit mit gesammelten Apexissplittern zurückkehren, um die großen Apexismonumente zu benutzen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11060, 'deDE', 'Kleiner $R, nicht vergessen, wenn Ihr einen Zerrütter kontrollieren, Ihr müssen seinen Hammer dazu benutzen, um die Schilde von Warptor zu zerschlagen und den gefangenen Dämonen freizulassen.$B$BDann Ihr müssen zerschlagen diesen Dämon und ihn beherrschen. Dann kommen neuer Dämon, den Ihr auch beherrschen müssen, bis der Aufseher der Eredar auftauchen.$B$BDann Ihr auch ihn erschlagen werdet!!!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11061, 'deDE', 'Wir können Euch gar nicht genug danken, $N!$B$BSo instabil diese zwei Fläschchen auch sein mögen, mit ihrer Hilfe können wir nun einen unserer Jungs nach Norden zum Außenposten der Himmelswache schicken.$B$BWartet einen kleinen Augenblick, während wir einen von ihnen rufen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11062, 'deDE', 'Willkommen im Außenposten der Himmelswache. Wisst Ihr, ich habe den gesamten Posten mit meinen eigenen Händen errichtet.$B$BSchon richtig gehört, alles was Ihr hier vor Euch seht!$B$B<Dem Himmelskommandanten scheint es ernst zu sein.>$B$BIhr müsst ja ganz schön scharf auf einen Kampf sein, wenn Ihr extra hierhergekommen seid, um mit mir zu sprechen. Es war nett vom alten Chu\'a\'lor, Euch vorbeizuschicken. Wir können hier immer etwas Frischfleisch gebrauchen.$B$BWenn es Euch nichts ausmacht, würde ich vorschlagen, Ihr unterhaltet Euch ein wenig mit meinem Himmelsoffizier Vanderlip. Stört Euch nicht an ihrem Gebaren, ihre Zunge ist womöglich schärfer als das Breitschwert, das sie bei sich trägt.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11063, 'deDE', 'Ihr möchtet also zu den Himmelsteilern gehören, ja? Ihr habt Euch mit Sicherheit als fähiger Anhänger des Drachenmals bewiesen, aber in den Lüften der Scherbenwelt ist dies bedeutungslos. Es gibt eine Frage zu klären: KÖNNT IHR FLIEGEN?$B$BUnd ich frage nicht etwa, ob Ihr auf einen Netherdrachen steigen und wie diese Transportertrottel eine Ladung Kristalle zu der Festung liefern könnt. Ich rede davon, der Beste zu sein... der Toporc...$B$BDort drüben im Westen gibt es sechs Reiter. Besiegt sie alle und ich werde Euch Flügel der Himmelsteiler geben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11064, 'deDE', 'Ein Kinderspiel? Was ist nur aus den Helden geworden... Ich bin mir sicher, dass die anderen Reiter eine größere Herausforderung sein werden.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11065, 'deDE', 'Juhuu! Gute Arbeit, $N! Diese Rochen werden ein paar hervorragende Reittiere abgeben!$B$BBleibt ruhig noch ein wenig, die Himmelswache der Sha\'tari kann Männer mit Euren Talenten immer gut gebrauchen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11066, 'deDE', 'Ihr erstaunt mich immer wieder! Ich sage Euch was, warum lasst Ihr das Lasso nicht für heute ruhen und wir sehen uns morgen wieder?$B$B<Khatie lacht.>$B$BNochmals vielen Dank, $N!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11067, 'deDE', 'Interessant... Euer nächstes Rennen wird sich zweifellos als viel schwieriger erweisen. Corlok ist kein Weichei.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11068, 'deDE', 'Die nächsten zwei Reiter sind die besten Piloten, die die Zwerge und Orcs von Azeroth zu bieten hatten. Ihr habt keine Chance!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11069, 'deDE', 'Ich glaube es nicht! Mulverick ist Eure nächste Herausforderung. Dieses Rennen werdet Ihr auf keinen Fall überleben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11070, 'deDE', 'Nun Grunzer, es sieht ganz so aus, als gäbe es jetzt nur noch Euch und den Hauptmann. Viel Glück! Ihr werdet es brauchen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11071, 'deDE', 'Ich hätte es mir nie träumen lassen, dass es jemanden gibt, der talentiert genug ist und Himmelsdonner besiegen kann. Wisst Ihr was das bedeutet, ja? Ihr seid jetzt der Toporc! Ihr müsst Euren Titel verteidigen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11072, 'deDE', 'Hervorragend! Hier, nehmt dies. Ich habe dieses Bündel aus den Gegenständen erstellt, die Ihr mir gebracht habt. Damit werdet Ihr Terokk beschwören können.$B$BSeid auf der Hut, $N. Er ist der mächtigste Arakkoa aller Zeiten. Unterschätzt ihn nicht!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11073, 'deDE', 'Ihr habt uns alle sehr stolz gemacht, $N. Ich werde die Kunde von Euren Taten in Shattrath verbreiten. Die Himmelswache steht für immer in Eurer Schuld.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11074, 'deDE', 'Hervorragend! Hier, nehmt dies. Ich habe dieses Bündel aus den Gegenständen erstellt, die Ihr mir gebracht habt. Damit werdet Ihr Terokk beschwören können.$B$BSeid auf der Hut, $N. Er ist der mächtigste Arakkoa aller Zeiten. Unterschätzt ihn nicht!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11075, 'deDE', 'Die Minenarbeiter leisten harte Arbeit, aber keiner von ihnen wagt es, einen Schritt tiefer in die Minen zu setzen. Sie sterben lieber, als dass sie sich tiefer in die Minen zwingen lassen! Es wird Eure Aufgabe sein, die von ihnen vernachlässigten Pflichten zu erfüllen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11076, 'deDE', 'Gut gemacht, $N. Kommt morgen für einen weiteren Einsatz in den Tiefen der Mine wieder.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11078, 'deDE', 'Ja! Diese Zähne sehen scharf aus, als könnten sie beinahe alles wie Butter durchschneiden!$B$BErlaubt mir, Euch und Eure Freunde dazu zu ermuntern, weiterhin so gute Arbeit zu leisten! Diese Drachen sind gefährliche Raubtiere, die unseren Himmel lange genug unsicher gemacht haben.$B$BEuch sind sicherlich die Drachenschuppen aufgefallen. Wie ich hörte, kann man aus ihnen einen mächtigen Umhang herstellen, sofern man eine Schuppe von jedem der Drachen besitzt. Sollte Euch der Umhang nicht zusagen, bin ich jederzeit bereit, ihn gegen einen Apexiskristall einzutauschen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11079, 'deDE', 'Gahk mögen Peitsche. Vielleicht Gahk nehmen Peitsche und bearbeiten ein paar Dämonen!$B$BMich sagen zu $R, dass $R kann jederzeit beschwören Dämonenanführer, solange $R haben viele Freunde und \'ne Menge Splitter.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11080, 'deDE', 'Euer Geschick im Umgang mit den Relikten erstaunt uns immer wieder, $N. Dürften wir Euch vorschlagen, mindestens einmal am Tag den Gebrauch der Relikte zu üben, damit Euer Verstand seine Schärfe bewahrt?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11081, 'deDE', 'Ausgezeichnete Arbeit, Aufseher. Man wird Mor\'ghor von Euren herausragenden Taten für das Drachenmal berichten.$B$BLasst uns jetzt wieder auf diese Hunde der Finsterblut zu sprechen kommen. Sie planen ihre Flucht, ja? Sie wagen es, sich dem einzig wahren Fürsten der Scherbenwelt zu widersetzen? Ihre Meister werden dafür bezahlen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11082, 'deDE', 'Nichts zu sagen? Vielleicht erinnert er sich ja, wenn er auf dem Boden dieser verfluchten Mine zu Tode blutet... Vergesst nie, was es bedeutet, die Mächte Illidans herauszufordern!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11083, 'deDE', 'Ja, ich verstehe das nicht... Man würde doch meinen, dass sie nach zwei Tagen nicht derart ausgehungert sein können. Finsterblut...$B$B<Ronag schüttelt den Kopf.>$B$BSo was von dämlich...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11084, 'deDE', '<Mor\'ghor nickt.>$B$BGanz recht, ich habe Hauptmann gesagt. Ihr habt Euch eine weitere Beförderung verdient, $N.$B$BIhr arbeitet wirklich wie keiner der Höllenorcs, die ich bis jetzt gesehen habe. Macht weiter so, dann schafft Ihr es vielleicht eines Tages zum Oberanführer.$B$BZieht jetzt los und übernehmt das Kommando. Ich schlage vor, dass Ihr versucht, Euch Eure Flügel der Himmelsteiler zu verdienen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11086, 'deDE', 'Ausgezeichnete Arbeit, Hauptmann! Fürst Illidan wird von Euren Heldentaten erfahren!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11089, 'deDE', '<Balthas fügt die Elemente, die Ihr ihm gebracht habt, geschickt zusammen.>$B$BIhr seid jetzt bereit für den zweiten Teil des Plans, Hauptmann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11090, 'deDE', 'Er wird zurückkehren, aber für den Moment hat der Krieg der Legion gegen Fürst Illidan eine Schwäche erfahren. Man wird ihm von Euren Taten berichten, Hauptmann.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11091, 'deDE', 'Hey, Mann, das ist toll! Wir haben viel von Euren guten Taten gehört. Das ist fantastisch. Wir haben da so ein Gefühl, dass Ihr für Ogri\'la alles zum Guten wenden werdet. Ihr werdet uns beschützen und alles wird heiter und sonnig!$B$BHier, nehmt das. Es ist ein kleines Überlebenspaket, dass wir zum Dank für Euch zusammengestellt haben.$B$BWerft doch bitte einen Blick auf unsere Waren. Wir haben eine reichhaltige Auswahl der erlesensten Gegenstände, von denen Euch sicherlich das eine oder andere Stück interessieren wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11092, 'deDE', 'Fürst Illidan hat mich höchstpersönlich mit Eurer Beförderung zum Kommandanten beauftragt! So etwas hat es noch nie gegeben. Ihr seid der Erste des Drachenmals, der solch einen Rang außerhalb des Schwarzen Tempels erlangt hat.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11093, 'deDE', 'Vielen Dank $N, dass Ihr Euch um den Rochen gekümmert habt. Mit vollem Magen fliegen diese Burschen gleich viel besser. Schließlich sollen unsere Jungs nicht abgeschossen werden, nur weil ihre Netherrochen zum Fliegen zu schwach waren.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11094, 'deDE', 'Es war gut, dass Ihr zu uns gekommen seid. Vielleicht können wir diesen Angriff des Drachenmals zu unserem Vorteil nutzen und den Spieß umdrehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11095, 'deDE', '<Hobb grinst.>$B$BDie tödlichste Falle aller Zeiten...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11096, 'deDE', 'Gute Arbeit, Fliegerass! Ich habe das Gefühl, dass Ihr hier sehr gut hineinpasst.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11097, 'deDE', '<Mor\'ghor lacht.>$B$BHAHA! Ich habe gewusst, dass ich auf Euch zählen kann, Kommandant! Ich möchte, dass Ihr das Sanktum der Sterne mindestens einmal pro Tag überfallt. Sie werden keine andere Wahl haben und das Schattenmondtal verlassen müssen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11098, 'deDE', 'Danke für den Nachschub, wir werden ihn zu verwenden wissen! Ein neuer Rekrut? Dann wollen wir doch mal sehen, aus welchem Holz Ihr geschnitzt seid!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11099, 'deDE', 'Es war gut, dass Ihr zu uns gekommen seid. Vielleicht können wir diesen Angriff des Drachenmals zu unserem Vorteil nutzen und den Spieß umdrehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11100, 'deDE', '<Arcus grinst.>$B$BDie tödlichste Falle aller Zeiten...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11101, 'deDE', '<Mor\'ghor lacht.>$B$BHAHA! Ich habe gewusst, dass ich auf Euch zählen kann, Kommandant! Ich möchte, dass Ihr den Altar der Sha\'tar mindestens einmal pro Tag überfallt. Sie werden keine andere Wahl haben und das Schattenmondtal verlassen müssen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11107, 'deDE', 'Ihr seid der erste Hochlord des Drachenmals, $N. Der Meister hat beschlossen höchstpersönlich hierher zu kommen, um Euch zu befördern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11108, 'deDE', 'Ich war der Erste, wisst Ihr. Das verlassene Kind eines Monsters...$B$B<Barthamus schüttelt seinen Kopf.>$B$BWir haben Euch alles zu verdanken, $N. Ganz allein habt Ihr das Reich des Drachenmals zerschmettert und dabei genug Informationen gesammelt, die meine Brüder mehr als ein Leben lang beschäftigen werden.$B$BEs ist zwar nicht viel, aber es gibt da etwas, das wir Euch anbieten können... Ein jeder meines Schwarms hat sich dazu bereit erklärt, Euch bei Euren Abenteuern in der Scherbenwelt zu begleiten. Fragt sie einfach und sie werden mit Euch einen Bund eingehen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11109, 'deDE', 'Es ist eine Ehre, Euch zu treffen, $N. Wir alle haben Eure Abenteuer mit großer Aufmerksamkeit verfolgt. Wir sind äußerst dankbar für alles, was Ihr für den Drachenschwarm der Netherschwingen getan habt.$B$BWenn Ihr mich zu Eurem Weggefährten macht, werde ich Euch bis ans Ende dieser Welt und wieder zurück fliegen. Was auch immer Ihr von mir verlangt, ich werde mein Bestes tun, um Euren Wunsch zu befolgen.$B$BIhr sollt jedoch wissen, dass Ihr nur einen von uns für Eure Reisen in der Scherbenwelt erwählen könnt. Habt Ihr Euch einmal entschieden, so könnt Ihr Eure Meinung nicht mehr ändern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11110, 'deDE', 'Es ist eine Ehre, Euch zu treffen, $N. Wir alle haben Eure Abenteuer mit großer Aufmerksamkeit verfolgt. Wir sind äußerst dankbar für alles, was Ihr für den Drachenschwarm der Netherschwingen getan habt.$B$BWenn Ihr mich zu Eurem Weggefährten macht, werde ich Euch bis ans Ende dieser Welt und wieder zurück fliegen. Was auch immer Ihr von mir verlangt, ich werde mein Bestes tun, um Euren Wunsch zu befolgen.$B$BIhr sollt jedoch wissen, dass Ihr nur einen von uns für Eure Reisen in der Scherbenwelt erwählen könnt. Habt Ihr Euch einmal entschieden, so könnt Ihr Eure Meinung nicht mehr ändern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11111, 'deDE', 'Es ist eine Ehre, Euch zu treffen, $N. Wir alle haben Eure Abenteuer mit großer Aufmerksamkeit verfolgt. Wir sind äußerst dankbar für alles, was Ihr für den Drachenschwarm der Netherschwingen getan habt.$B$BWenn Ihr mich zu Eurem Weggefährten macht, werde ich Euch bis ans Ende dieser Welt und wieder zurück fliegen. Was auch immer Ihr von mir verlangt, ich werde mein Bestes tun, um Euren Wunsch zu befolgen.$B$BIhr sollt jedoch wissen, dass Ihr nur einen von uns für Eure Reisen in der Scherbenwelt erwählen könnt. Habt Ihr Euch einmal entschieden, so könnt Ihr Eure Meinung nicht mehr ändern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11112, 'deDE', 'Es ist eine Ehre, Euch zu treffen, $N. Wir alle haben Eure Abenteuer mit großer Aufmerksamkeit verfolgt. Wir sind äußerst dankbar für alles, was Ihr für den Drachenschwarm der Netherschwingen getan habt.$B$BWenn Ihr mich zu Eurem Weggefährten macht, werde ich Euch bis ans Ende dieser Welt und wieder zurück fliegen. Was auch immer Ihr von mir verlangt, ich werde mein Bestes tun, um Euren Wunsch zu befolgen.$B$BIhr sollt jedoch wissen, dass Ihr nur einen von uns für Eure Reisen in der Scherbenwelt erwählen könnt. Habt Ihr Euch einmal entschieden, so könnt Ihr Eure Meinung nicht mehr ändern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11113, 'deDE', 'Es ist eine Ehre, Euch zu treffen, $N. Wir alle haben Eure Abenteuer mit großer Aufmerksamkeit verfolgt. Wir sind äußerst dankbar für alles, was Ihr für den Drachenschwarm der Netherschwingen getan habt.$B$BWenn Ihr mich zu Eurem Weggefährten macht, werde ich Euch bis ans Ende dieser Welt und wieder zurück fliegen. Was auch immer Ihr von mir verlangt, ich werde mein Bestes tun, um Euren Wunsch zu befolgen.$B$BIhr sollt jedoch wissen, dass Ihr nur einen von uns für Eure Reisen in der Scherbenwelt erwählen könnt. Habt Ihr Euch einmal entschieden, so könnt Ihr Eure Meinung nicht mehr ändern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11114, 'deDE', 'Es ist eine Ehre, Euch zu treffen, $N. Wir alle haben Eure Abenteuer mit großer Aufmerksamkeit verfolgt. Wir sind äußerst dankbar für alles, was Ihr für den Drachenschwarm der Netherschwingen getan habt.$B$BWenn Ihr mich zu Eurem Weggefährten macht, werde ich Euch bis ans Ende dieser Welt und wieder zurück fliegen. Was auch immer Ihr von mir verlangt, ich werde mein Bestes tun, um Euren Wunsch zu befolgen.$B$BIhr sollt jedoch wissen, dass Ihr nur einen von uns für Eure Reisen in der Scherbenwelt erwählen könnt. Habt Ihr Euch einmal entschieden, so könnt Ihr Eure Meinung nicht mehr ändern.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11119, 'deDE', 'Egal, was Keller dazu meint, ich bevorzuge es, unsere Einsätze als Forschungsexkursionen zu betrachten.$B$BEs stimmt allerdings, dass wir dort Vorräte für die Himmelswache beschaffen, jedenfalls, wenn wir lange genug dort bleiben können.$B$BIhr seht so aus, als wäret Ihr bereit, uns den Rücken gegen die Astralen freizuhalten. Wenn Ihr uns die Astralen lange genug vom Leib haltet, werden wir Euch alle zusätzlich an der Kristallschmiede hergestellten Gegenstände zum Verkauf anbieten, also bringt Eure Apexissplitter und Kristalle mit!$B$BWir ziehen in 2 Stunden los.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11130, 'deDE', '<Budd liest die Notiz.>$B$BAhh! $GEin Freund:Eine Freundin; von Gaunah? Willkommen!$B$BIhr kommt genau richtig, mein Freund. Wie es das Schicksal so will, habe ich gerade erst meine Kollegen verloren. Tragisch, wirklich, aber außergewöhnliche Belohnungen haben oft ihren Preis. Lasst uns nicht zu sehr ans Negative denken!$B$BIhr habt sicherlich schon von meinen zahlreichen Ausbeuten und Entdeckungen gehört. Nun, das war alles nichts im Vergleich zu dem hier! Ich sage es Euch, wir sind nahe dran, hier in Zul\'Aman Geschichte zu schreiben. Ihr hattet das Glück, rechtzeitig zu kommen, um auf der untersten Ebene dabei zu sein!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11131, 'deDE', 'Oh, vielen Dank! Möge das Licht Eure guten Taten segnen, gutherzige Dame. Der kopflose Reiter wirft zwar noch immer seinen bedrohlichen Schatten voraus, aber das Dorf ist jetzt erst einmal vor seinen Flammen sicher.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11135, 'deDE', 'Der Ursprung dieses Schreins ist unbekannt, aber es besteht kein Zweifel, wem hier gehuldigt wird...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11216, 'deDE', 'Danke, dass Ihr Euch die Zeit genommen habt, um uns hier zur Hilfe zu kommen. Vor uns liegt eine Menge wichtiger Arbeit.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11219, 'deDE', 'Die Feuer sind erloschen! Ihr wart mit Eurer Brandwache erfolgreich! Hah!$B$BDer Angriff des kopflosen Reiters ist fehlgeschlagen, aber solange er und sein Kopf nicht vernichtet werden, wird er wieder zurückkehren.$B$BLasst uns bis dahin Trost in der Sicherheit finden, die Ihr uns und unseren Kindern beschert habt. Es war mir eine Ehre, heute Zeuge Eurer Taten zu sein.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11220, 'deDE', 'Der Ursprung dieses Schreins ist unbekannt, aber es besteht kein Zweifel, wem hier gehuldigt wird...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11242, 'deDE', 'Was sagt Ihr? Dieser heilige Foliant gehörte einst einem gefallenen Paladin der Allianz. War er der kopflose Reiter? Also wurde er endlich besiegt?$B$BWas für ein glorreicher Tag, $N! Eure Legende wird wachsen! Möge man noch von Euch berichten, wenn die Schreckensherrschaft des kopflosen Reiters längst vergessen ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11356, 'deDE', 'Ihr seid hier, um die Kinder zu besuchen! Wie wundervoll! In ihrem kurzen Leben ist ihnen so viel Kummer widerfahren. Es ist gut, dass sie einen wahren Helden wie Euch sehen. Es hellt ihr Gemüt wirklich auf!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11357, 'deDE', 'Die Kinder lieben es, wenn sie Helden bei ihrer Arbeit zusehen können. Ich hoffe, dass ein jedes dieser Kinder einmal ein starkes Mitglied der Horde sein und letztendlich in einer glorreichen Schlacht sterben wird!$R$RAh, der Gedanke an ein solch ehrbares Schicksal rührt mich zu Tränen...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11360, 'deDE', 'Du bist nass und mit Ruß verschmiert! Du musst die Brände gelöscht haben!$B$BGut gemacht! Als Ehrenmitglied der Feuerwehr, bitte ich dich wenn das Dorf dich braucht immer hier her zurück zu kommen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11361, 'deDE', 'Gut gemacht, $N! Kinder, seht Euch diesen Helden gut an. Werdet alle so stark und mutig wie er, dann werdet auch Ihr eines Tages für die Horde kämpfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11372, 'deDE', 'Diese Federn werden dem Kopfschmuck des Häuptlings den letzten Schliff geben. Ihr habt Euch Eure Bezahlung redlich verdient, $C.$B$BKommt morgen wieder und ich werde einen weiteren Auftrag für Euch bereithalten.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11383, 'deDE', 'Anscheinend habt Ihr Euren Weg in die Vergangenheit und wieder zurück gefunden. Eure Fähigkeiten als $C sind bemerkenswert. Die Belohnung gehört Euch.$B$BKehrt morgen zu mir zurück, wenn die Winde Mah\'duun ihren Willen offenbart haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11385, 'deDE', 'Mit den Kanalisierern ist es aus. Der, der aus dem Nether zu mir spricht ist zufrieden und Ihr habt Euch Eure Belohnung redlich verdient.$B$BKehrt morgen zu mir zurück, wenn die Winde Mah\'duun ihren Willen offenbart haben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11392, 'deDE', 'Werdet Ihr die Kerze niederlegen und den kopflosen Reiter aus seiner unseligen Ruhe erwecken?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11401, 'deDE', 'Werdet Ihr die Kerze niederlegen und den kopflosen Reiter aus seiner unseligen Ruhe erwecken?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11403, 'deDE', 'Was sagt Ihr? Dieser heilige Foliant gehörte einst einem gefallenen Paladin der Allianz. War er der kopflose Reiter? Also wurde er endlich besiegt?$B$BWas für ein glorreicher Tag, $N! Eure Legende wird wachsen! Möge man noch von Euch berichten, wenn die Schreckensherrschaft des kopflosen Reiters längst vergessen ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11404, 'deDE', 'Werdet Ihr die Kerze niederlegen und den kopflosen Reiter aus seiner unseligen Ruhe erwecken?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11405, 'deDE', 'Werdet Ihr die Kerze niederlegen und den kopflosen Reiter aus seiner unseligen Ruhe erwecken?', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11439, 'deDE', 'Du bist nass und mit Ruß verschmiert! Du musst die Brände gelöscht haben!$B$BGut gemacht! Als Ehrenmitglied der Feuerwehr, bitte ich dich wenn das Dorf dich braucht immer hier her zurück zu kommen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11440, 'deDE', 'Du bist nass und mit Ruß verschmiert! Du musst die Brände gelöscht haben!$B$BGut gemacht! Als Ehrenmitglied der Feuerwehr, bitte ich dich wenn das Dorf dich braucht immer hier her zurück zu kommen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11449, 'deDE', 'Gut gemacht, $N! Kinder, seht Euch diesen Helden gut an. Werdet alle so stark und mutig wie er, dann werdet auch Ihr eines Tages für die Horde kämpfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11450, 'deDE', 'Gut gemacht, $N! Kinder, seht Euch diesen Helden gut an. Werdet alle so stark und mutig wie er, dann werdet auch Ihr eines Tages für die Horde kämpfen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11481, 'deDE', 'Noch ein Soldat aus Shattrath? Welch willkommener Anblick!$B$BWünschte es gäbe mehr wie Euch, aber wir müssen mit dem auskommen, was uns gegeben ist. Was auch immer dort draußen geschieht, es wird nicht darauf warten, dass wir vorbereitet sind.$B$BSeht Euch ein wenig um, $C. Es gibt viel zu erledigen. Packt mit an und tut Euren Teil.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11482, 'deDE', 'Willkommen auf dem Sonnenbrunnenplateau, Anfänger der... Wie bitte? Oh - Anhänger der Seher, natürlich. Habe ich das nicht gesagt?$B$BNun, gut, kommen wir gleich zur Sache. Hinter diesen Mauern geht es ernsthaft zur Sache, und das ist für unsere beiden Völker von großem Interesse. Und da keiner von uns über genügend Streitkräfte verfügt, um die Sache alleine anzugehen, werden wir ZUSAMMENARBEITEN. Verstanden?$B$BNa dann fangen wir doch einmal an.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11497, 'deDE', 'So, mein Junge Nutral schickte dich vorbei, stimmts? Guter Mann... Ich muss daran denken ihm einen auszugeben, für all die Geschäfte die er mir vermittelte.$B$BWenn es darum geht wie man richtig und ordnungsgemäß fliegen lernt, bist du hier genau richtig. Niemand fliegt feiner als wir Wildhammer und die, die wir trainieren. Gegen eine Gebühr, die nicht gerade gering ausfällt, werde ich dir lehren wie man durch die Lüfte steigt!$B$BUnd wenn du fertig bist, vergiss nicht mit Brunn dort drüben über den Kauf einer dieser schönen Greifen zu sprechen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11498, 'deDE', 'Blut und Donner, Nutral hat mir schon wieder einen Boden-Grunzer geschickt! Sehr gut... für einen Draenei.$B$B<Olrokk spuckt auf den Boden neben Euch.>$B$BWenn Ihr wissen wollt, wie man richtig fliegt, dann seid Ihr am richtigen Ort. Für einen großen Sack Gold bringe ich Euch genug bei, um nicht unehrenhaft in den Tod zu stürzen.$B$BUnd wenn Ihr fertig seid, dann vergesst nicht, Dama Wildmähne einen unserer Windreiter abzukaufen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11505, 'deDE', 'Die Geister sind ihrer Ruhe einen Schritt näher. Es ist gut, ihre Gunst zu erlangen - besonders dann, wenn so nahe an ihrer Ruhestätte Krieg geführt wird.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11506, 'deDE', 'Die Geister sind einen Schritt näher daran, ihre Ruhe zu finden, und haben uns deswegen ihre Gunst verliehen.$B$BEs muss eine Demütigung für unseren Feind sein, dass sich seine eigenen Urahnen gegen ihn wenden - auch, wenn es nur vorübergehend ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11515, 'deDE', 'Narren. Sie haben gelernt, wie man Teufelsenergie entzieht, aber nicht, wie man sie behält.$B$BWir haben Glück, $N. Ein erfahrener Streiter des Teufelsbluts hätte gewiss einen beeindruckenden Gegner abgegeben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11516, 'deDE', 'Ausgezeichnete Arbeit, $N. Die Dämonen werden den Durchgang womöglich rechtzeitig reparieren. Na dann werden wir ihn wohl noch einmal in die Luft jagen müssen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11665, 'deDE', 'Was für eine miese kleine Kreatur! Ich bin mir sicher, dass der Rokk irgendwas Leckeres aus ihr machen wird.$B$BIch mach natürlich nur Spaß.$B$B<Der alte Barlo zwinkert neckisch.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11666, 'deDE', 'Nun sieh mal einer an... Ihr habt einen Großen gefangen! Dieser alte Mann wird heute Abend gut essen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11667, 'deDE', 'Da ist er! Diese Narbe würde ich immer wiedererkennen.$B$BAber um ganz ehrlich zu sein, habe ich ihn mir... größer vorgestellt. Tja - denke, dass ich ihn freilassen und es an einem anderen Tag noch einmal versuchen werde.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11668, 'deDE', 'Ihr könnt mit Haken und Messer gut umgehen. Reicht mir die süßen Leckerbissen und ich werde Euch davon kosten lassen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11669, 'deDE', 'Das ist der größte und hässlichste Fisch, den ich je gesehen habe. Ich kann mir gar nicht vorstellen, was Ihr als Köder benutzt habt.$B$BLegt das Biest einfach auf den Boden und ich werde mich darum kümmern, sobald ich mir sicher sein kann, dass es tot ist.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11877, 'deDE', '<Lord Torvos nimmt die Pläne entgegen und sieht sie sich an.>$B$BIhr habt der Offensive einen großen Dienst erwiesen, $N. Wir sollten uns jedoch keine Ruhe gönnen. Unsere Feinde werden in Zukunft sicherlich noch mehr Unheil über uns bringen.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11880, 'deDE', 'Danke für Eure Hilfe. Ihr wisst gar nicht, wie es ist, wenn man sich mit \'Doktor\' Waffelfritte dort drüben auseinandersetzen muss. Wenn er nicht gerade damit beschäftigt ist, meinen Fortschritt zu \'überprüfen\', verhökert er gerade eines seiner Geräte - die übrigens alle Erfindungen für militärische Zwecke sind.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (11885, 'deDE', 'Hervorragend! Hier, nehmt dies. Ich habe dieses Bündel aus den Gegenständen erstellt, die Ihr mir gebracht habt. Damit werdet Ihr Terokk beschwören können.$B$BSeid auf der Hut, $N. Er ist der mächtigste Arakkoa aller Zeiten. Unterschätzt ihn nicht!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12133, 'deDE', 'Ihr habt das in der Kürbislampe des kopflosen Reiters gefunden? Es ist ein altes Symbol des Lichts. Es muss einst dem Reiter gehört haben, bevor er verflucht und zu dem Monster wurde, das er heute ist. Habt Dank, $N. Dieses Symbol gehört in Paladinhände. Ich werde sicherstellen, dass sie es erhalten.$B$BOh, und das hätte ich fast vergessen! Ihr habt einen stillen Bewunderer...$B$BEines der Kinder wollte, dass Ihr dies erhaltet. Sie war zu schüchtern, es Euch selbst zu geben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12135, 'deDE', 'Der kopflose Reiter wird das Dorf jede Sekunde angreifen. Überall werden Feuer brennen!$B$BBitte, $N, stellt Ihr Euch den Feuern des kopflosen Reiters entgegen? Wenn er kommt, müsst Ihr Euch der Brandwache anschließen. Schnappt Euch einen Eimer Wasser und löscht die Feuer damit. Ihr könnt den Eimer auch an einen Freund weitergeben, der näher an den Flammen steht. Wenn Ihr alle Feuer löscht, sind wir vielleicht schon gerettet!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12139, 'deDE', 'Der kopflose Reiter wird das Dorf jede Sekunde angreifen. Überall werden Feuer brennen!$B$BBitte, $N, stellt Ihr Euch den Feuern des kopflosen Reiters entgegen? Wenn er kommt, müsst Ihr Euch der Brandwache anschließen. Schnappt Euch einen Eimer Wasser und löscht die Feuer damit. Ihr könnt den Eimer auch an einen Freund weitergeben, der näher an den Flammen steht. Wenn Ihr alle Feuer löscht, sind wir vielleicht schon gerettet!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12155, 'deDE', 'Ihr habt das in der Kürbislampe des kopflosen Reiters gefunden? Es ist ein altes Symbol des Lichts. Es muss einst dem Reiter gehört haben, bevor er verflucht und zu dem Monster wurde, das er heute ist. Habt Dank, $N. Dieses Symbol gehört in Paladinhände. Ich werde sicherstellen, dass sie es erhalten.$B$BOh, und das hätte ich fast vergessen! Ihr habt einen stillen Bewunderer...$B$BEines der Kinder wollte, dass Ihr dies erhaltet. Sie war zu schüchtern, es Euch selbst zu geben.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12286, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12331, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12332, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12333, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12334, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12335, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12336, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12337, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12338, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12339, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12340, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12341, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12342, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12343, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12344, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12345, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12346, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12347, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12348, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12349, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12350, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12351, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12352, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12353, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12354, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12355, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12356, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12357, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12358, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12359, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12360, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12361, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12362, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12363, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12364, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12365, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12366, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12367, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12368, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12369, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12370, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12371, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12373, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12374, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12375, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12376, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12377, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12378, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12379, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12380, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12381, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12382, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12383, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12384, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12385, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12386, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12387, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12388, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12389, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12390, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12391, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12392, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12393, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12394, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12395, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12396, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12397, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12398, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12399, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12400, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12401, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12402, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12403, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12404, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12405, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12406, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12407, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12408, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12409, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12410, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12940, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12941, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12944, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12945, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12946, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12947, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (12950, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13408, 'deDE', 'Gut gemacht, $N. Eure Taten auf dem Schlachtfeld sind für unseren Kampf auf der Höllenfeuerhalbinsel sehr hilfreich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13409, 'deDE', 'Gute Arbeit, $N. Ich konnte fast die Kampfschreie an den Befestigungsanlagen hören. Ich wünschte, ich wäre dabei gewesen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13410, 'deDE', 'Gut gemacht, $N. Eure Taten auf dem Schlachtfeld sind für unseren Kampf auf der Höllenfeuerhalbinsel sehr hilfreich.', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13411, 'deDE', 'Gute Arbeit, $N. Ich konnte fast die Kampfschreie an den Befestigungsanlagen hören. Ich wünschte, ich wäre dabei gewesen!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13429, 'deDE', '<Xi\'ri pulsiert vor Energie, Ihr fühlt, wie ein Gegenstand in Euren Händen Gestalt annimmt. Es ist das Medaillon, das Ihr A\'dal im Namen von Akama gegeben habt. Seine Macht hat sich durch die Magie der Naaru noch verstärkt. Die Sha\'tar haben Euch das Medaillon von Karabor anvertraut, und damit den Zugang zum Schwarzen Tempel.>', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13430, 'deDE', 'Ihr habt Euch als Wesen mit großer Macht bewiesen. Die Naaru sind sich einig...', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13433, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13434, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13435, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13436, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13437, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13438, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13439, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13448, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13452, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13456, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13459, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13460, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13461, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13462, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13463, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13464, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13465, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13466, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13467, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13468, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13469, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13470, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13471, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13472, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13473, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13474, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13501, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (13548, 'deDE', 'Süßigkeiteneimer wie diesen hier gibt es in jeder Gaststätte zu finden. Na los... greift zu!', 26972);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14022, 'deDE', 'Wenn Ihr an der Zubereitung traditioneller Pilgerfreudengerichte interessiert seid, kann ich Euch helfen. Falls Ihr noch keine Kochkenntnisse besitzt, braucht ihr nur ein wenig zu üben und im Nu seid Ihr ein richtiger Koch!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14023, 'deDE', 'Ausgezeichnet. Genau was wir brauchen! Es ist harte Arbeit, dafür zu sorgen, dass die Tische niemals leer werden, doch es lohnt sich!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14024, 'deDE', 'Der Kürbiskuchen ist hier oben ausgesprochen beliebt. Ich habe noch nie zuvor gesehen, dass Zwerge über ein Gemüsegericht so aus dem Häuschen geraten!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14028, 'deDE', 'Endlich, das versprochene Moosbeerenchutney! Ihr glaubt ja nicht, wie schnell die Feiernden das immer verputzen!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14030, 'deDE', 'Vielen Dank für alles! Ich hatte schon begonnen, mir Sorgen zu machen.$B$BDa Ihr schon mal hier seid, könntet Ihr gleich auch noch Euer Glück mit der Zubereitung kandierter Süßkartoffeln versuchen.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14033, 'deDE', 'Aaah, kandierte Süßkartoffeln! Meine Leibspeise! Hat Isaac Euch davon erzählt?', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14035, 'deDE', 'Die sind grandios! Und sie kommen genau rechtzeitig, um hungrige Mäuler zu stopfen. Danke, $N! Ihr habt wahrlich alle Gänge eines traditionellen Pilgerfestmahls gemeistert.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14036, 'deDE', 'Wenn Ihr an der Zubereitung traditioneller Pilgerfreudengerichte interessiert seid, kann ich Euch helfen. Falls Ihr noch keine Kochkenntnisse besitzt, braucht ihr nur ein wenig zu üben und im Nu seid Ihr ein richtiger Koch!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14037, 'deDE', 'Dafür zu sorgen, dass die ganze Festtafel immer schön gefüllt bleibt, ist keine einfache Aufgabe. Und wenn man bedenkt, dass wir eigentlich gar nicht mehr zu essen brauchen, kommt es einem besonders eigenartig vor.$B$B<William zuckt mit den Achseln.>$B$BTradition ist Tradition.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14040, 'deDE', 'Der Kuchen geht weg wie warme Semmeln. Ich glaube ja, die Leute halten sich gar nicht erst mit dem Hauptgericht auf, sondern gehen gleich über zum Nachtisch. Habt Ihr den Kuchen denn schon selbst einmal versucht?', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14041, 'deDE', 'Ah, endlich, mehr Moosbeerenchutney! Es ist unfassbar, wie schnell die Feiernden es vertilgen.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14043, 'deDE', 'Dokin hat Euch also dazu überredet, mit den kandierten Süßkartoffeln auszuhelfen?$B$B<Francis lächelt.>$B$BEs ist der einzige Weg, wie er mithalten kann. Danke, dass Ihr sie gebracht habt.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14044, 'deDE', 'Vielen Dank für alles, was Ihr gebracht habt. Einige der Tische machen schon langsam einen etwas kahlen Eindruck.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14047, 'deDE', 'Die sehen köstlich aus. Vielen Dank, $N. Ihr habt wahrlich alle Gänge eines traditionellen Pilgerfestmahls gemeistert.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14048, 'deDE', 'Genau das Richtige, vielen Dank, $N. Ihr habt es genau getroffen.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14051, 'deDE', 'Ein Glück, Ihr habt es geschafft! Ohne Gewürzbrotfüllung wäre das ganze Festmahl ein einziger Reinfall.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14053, 'deDE', 'Danke. Das sieht wirklich köstlich aus, und Ihr seid ein ganzes Stück schneller als Jasper - aber verratet Ihm nicht, dass ich das gesagt habe.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14054, 'deDE', 'Die sind wunderbar. Isaac wird begeistert sein, und nicht nur er!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14055, 'deDE', 'Die sind genau richtig! Vielen Dank für Eure Hilfe, $N. Das Festmahl wird rechtzeitig fertig sein, und Ellen wird sich sicher freuen!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14058, 'deDE', 'Vielen Dank, $N. Ich kann der Gastgeberin helfen und brauche Roberta dennoch nicht zu enttäuschen!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14059, 'deDE', 'Vielen Dank für Eure Hilfe, und gebt mir Bescheid, falls Ihr jemals hinter das Geheimnis des ständig verschwindenden Chutneys kommen solltet!', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14060, 'deDE', 'Die sind fantastisch. Danke für Eure Hilfe, $N.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14061, 'deDE', 'Prächtige Truthähne, genau was ich brauche! Ihr habt mir wirklich aus der Klemme geholfen.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14062, 'deDE', 'Gerade rechtzeitig! Ich hätte das Festmahl ohne Gewürzbrotfüllung gar nicht auftischen können.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14064, 'deDE', 'Was für ein Festmahl, hm?$B$BEs freut mich, dass Ihr zusammen mit uns die Bedeutung des Pilgerfreudenfests zelebrieren konntet.', 28153);

INSERT INTO `quest_offer_reward_locale`(`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (14065, 'deDE', 'Was für ein Festmahl, hm?$B$BEs freut mich, dass Ihr zusammen mit uns die Bedeutung des Pilgerfreudenfests zelebrieren konntet.', 28153);

UPDATE `quest_offer_reward_locale` SET `RewardText` = 'Ah, wie schön, $Gein:eine; $C. Ich habe Euch bereits erwartet.$B$BIch hätte da ein paar Aufgaben zu vergeben, für die Ihr Euch besonders gut eignet.', `VerifiedBuild` = 26972 WHERE `ID` = 10068 AND `locale` = 'deDE';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
