CREATE TABLE IF NOT EXISTS `events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `wf_id` int(11) NOT NULL,
  `event_msg` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`)
);

CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `notice_msg` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notice_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`notification_id`)
);