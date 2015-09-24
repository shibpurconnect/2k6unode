CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_description` (`role_description`)
);

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE IF NOT EXISTS `workflows` (
  `wf_id` int(11) NOT NULL AUTO_INCREMENT,
  `wf_description` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `wf_parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`wf_id`),
  UNIQUE KEY `wf_description` (`wf_description`)
);

INSERT INTO `roles` (`role_id`, `role_description`) VALUES
(3, 'Approver-Object1'),
(4, 'Approver-Object2'),
(1, 'Common-User'),
(2, 'Subscriber-Object1'),
(5, 'Subscriber-object2');

INSERT INTO `users` (`user_id`) VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO `workflows` (`wf_id`, `wf_description`, `wf_parent_id`) VALUES
(1, 'BroadcastToEverybody', NULL),
(2, 'Start-Object1', NULL),
(3, 'Start-Object2', NULL),
(4, 'Approve-object1', 2),
(5, 'Approve-object2', 3);

CREATE TABLE IF NOT EXISTS `userroles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `FK_userroles_users` (`user_id`),
  KEY `FK_userroles_roles` (`role_id`)
);

INSERT INTO `userroles` (`user_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(4, 4),
(4, 5),
(5, 1),
(5, 2),
(5, 5);

CREATE TABLE IF NOT EXISTS `wfroutings` (
  `wf_id` int(11) NOT NULL,
  `from_role_id` int(11) DEFAULT NULL,
  `to_role_id` int(11) NOT NULL,
  KEY `FK_wfroutings_workflows` (`wf_id`),
  KEY `FK_wfroutings_roles` (`from_role_id`),
  KEY `FK_wfroutings_roles_2` (`to_role_id`)
);

INSERT INTO `wfroutings` (`wf_id`, `from_role_id`, `to_role_id`) VALUES
(1, 1, 1),
(2, 1, 3),
(3, 1, 4),
(4, 3, 2),
(5, 4, 5);