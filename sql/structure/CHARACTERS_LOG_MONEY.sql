CREATE TABLE `log_money` (
  `sender_acc` int(11) unsigned NOT NULL,
  `sender_guid` int(11) unsigned NOT NULL,
  `sender_name` char(32) CHARACTER SET utf8 NOT NULL,
  `sender_ip` char(32) CHARACTER SET utf8 NOT NULL,
  `receiver_acc` int(11) unsigned NOT NULL,
  `receiver_name` char(32) CHARACTER SET utf8 NOT NULL,
  `money` bigint(20) unsigned NOT NULL,
  `topic` char(255) CHARACTER SET utf8 NOT NULL,
  `date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
