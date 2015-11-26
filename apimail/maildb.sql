# ************************************************************
# Sequel Pro SQL dump
# バージョン 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# ホスト: 192.168.99.100 (MySQL 5.6.27)
# データベース: maildb
# 作成時刻: 2015-11-24 11:08:19 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# テーブルのダンプ admins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '管理者名',
  `email` varchar(255) NOT NULL COMMENT 'e-mail',
  `password` varchar(255) NOT NULL COMMENT 'パスワード',
  `from_name` varchar(255) NOT NULL COMMENT '差出人名',
  `from_email` varchar(255) NOT NULL COMMENT '差出人メールアドレス',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  `delete_flg` tinyint(4) DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理者';

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;

INSERT INTO `admins` (`id`, `name`, `email`, `password`, `from_name`, `from_email`, `created_at`, `updated_at`, `delete_flg`)
VALUES
	(1,'admin','mta.dragon@dragon.jp','5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8','members support team','mta.dragon@dragon.jp','2013-09-02 11:55:46','2013-09-02 11:55:50',0);

/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;


# テーブルのダンプ bounce_mails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bounce_mails`;

CREATE TABLE `bounce_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL COMMENT 'クライアントID',
  `task_id` varchar(11) NOT NULL COMMENT 'タスクID',
  `client_task_id` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL COMMENT 'E-Mailアドレス',
  `reason` varchar(128) NOT NULL COMMENT '差戻理由',
  `delete_flg` char(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`,`client_id`,`task_id`,`email`,`client_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='バウンスメール'
/*!50100 PARTITION BY HASH (client_id)
PARTITIONS 120 */;



# テーブルのダンプ clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) NOT NULL COMMENT 'クライアント名',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:利用中 1:一時停止中 3:解約',
  `split` int(11) unsigned NOT NULL DEFAULT '100000' COMMENT '分割単位',
  `plan_id` int(11) NOT NULL COMMENT 'プランID',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT 'グループID',
  `delete_flg` tinyint(4) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# テーブルのダンプ deliveries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deliveries`;

CREATE TABLE `deliveries` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `client_id` int(11) unsigned NOT NULL,
  `task_id` varchar(11) NOT NULL COMMENT 'MTAタスクID',
  `client_task_id` varchar(20) NOT NULL,
  `reception_host` varchar(128) NOT NULL COMMENT '処理受付ホスト',
  `data_file` varchar(128) NOT NULL COMMENT 'data_file',
  `list_size` int(11) NOT NULL COMMENT 'リスト数',
  `delivery_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '配信ステータス : 1=配信待,2=配信中,3=配信済,4=配信停止,5=MTAエラー',
  `type` varchar(64) NOT NULL COMMENT '配信タイプ',
  `delivery_time` datetime DEFAULT NULL COMMENT '配信予定日時',
  `interval_sec` int(11) NOT NULL DEFAULT '1' COMMENT '配信間隔',
  `split_flg` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:通常 1:分割',
  `mta_id` int(11) DEFAULT NULL COMMENT '配信先MTA_ID',
  `mta_start_time` datetime DEFAULT NULL COMMENT 'MTA配信開始日時',
  `mta_finish_time` datetime DEFAULT NULL COMMENT 'MTA配信終了日時',
  `mta_stop_time` datetime DEFAULT NULL COMMENT 'MTA配信停止日時',
  `mta_request_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTA配信要求数',
  `mta_current_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTA現在の配信数',
  `mta_delivery_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTA総配信数',
  `mta_error_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTAエラー数',
  `mta_error_reason` varchar(255) DEFAULT NULL COMMENT 'MTAエラー事由',
  `service_id` varchar(20) DEFAULT NULL COMMENT 'ServiceID',
  `track_click` char(1) NOT NULL DEFAULT '0' COMMENT '0=off 1=0n',
  `track_open` char(1) NOT NULL DEFAULT '0' COMMENT '0=off 1=0n',
  `open_count` int(11) NOT NULL DEFAULT '0',
  `open_uu_count` int(11) NOT NULL DEFAULT '0',
  `click_count` int(11) NOT NULL DEFAULT '0',
  `click_uu_count` int(11) NOT NULL DEFAULT '0',
  `work_flg` char(1) NOT NULL DEFAULT '0',
  `delete_flg` char(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`,`task_id`,`client_id`,`client_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# テーブルのダンプ groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) NOT NULL COMMENT 'グループ名称',
  `delete_flg` char(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='GROUP';



# テーブルのダンプ ip_addrs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ip_addrs`;

CREATE TABLE `ip_addrs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `client_id` int(10) unsigned NOT NULL,
  `ip_addrs` varchar(30) NOT NULL COMMENT 'ip_addrs',
  `delete_flg` tinyint(4) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`,`ip_addrs`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接続許可IP';



# テーブルのダンプ jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'JobID',
  `delivery_id` int(11) NOT NULL COMMENT '配信ID',
  `message_id` varchar(128) NOT NULL COMMENT 'messageID',
  `status` varchar(50) NOT NULL COMMENT 'status',
  `mta_id` int(5) DEFAULT NULL COMMENT '配信先MTA',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Job管理';



# テーブルのダンプ mixs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mixs`;

CREATE TABLE `mixs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `delivery_id` int(11) NOT NULL COMMENT '配信ID',
  `task_id` varchar(11) NOT NULL DEFAULT '' COMMENT 'MTAタスクID',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '配信ステータス : 1=配信中,2=配信済',
  `mta_finish_time` datetime DEFAULT NULL COMMENT 'MTA配信終了日時',
  `mta_delivery_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTA総配信数',
  `mta_error_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTAエラー数',
  `delete_flg` char(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`,`delivery_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mix配信用';



# テーブルのダンプ mtas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mtas`;

CREATE TABLE `mtas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `host` varchar(30) NOT NULL COMMENT 'IPアドレス',
  `name` varchar(64) NOT NULL COMMENT 'MTA名称',
  `mta_type` char(1) NOT NULL DEFAULT '0' COMMENT 'MTA種別 : 0:共有 1:専有',
  `mta_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:稼働中 1:待機中',
  `notes` text COMMENT '備考',
  `client_id` int(11) DEFAULT NULL COMMENT '専有クライアントID',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '配信状況ステータス : 1=待機中,2=利用中',
  `threshold` double NOT NULL DEFAULT '2' COMMENT '閾値',
  `delivery_rest` int(11) NOT NULL DEFAULT '0' COMMENT '配信残数制限',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT 'グループID',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  `delete_flg` char(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  PRIMARY KEY (`id`,`host`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='MTA';



# テーブルのダンプ plans
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plans`;

CREATE TABLE `plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL COMMENT 'プラン名',
  `list_limit` int(11) unsigned NOT NULL COMMENT 'リスト上限',
  `send_limit` int(11) unsigned NOT NULL COMMENT '配信上限',
  `amount` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '金額',
  `delete_flg` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`name`,`send_limit`,`list_limit`,`amount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;

INSERT INTO `plans` (`id`, `name`, `list_limit`, `send_limit`, `amount`, `delete_flg`, `created_at`, `updated_at`)
VALUES
	(1,'5万通プラン',50000,50000,50000,0,'2013-10-18 16:24:12','2013-10-18 16:24:18'),
	(2,'6万通プラン',60000,120000,60000,0,'2013-10-18 16:27:09','2013-10-18 16:27:41'),
	(3,'10万通プラン',100000,100000,100000,0,'2013-12-09 10:34:44','2013-12-09 10:34:55'),
	(4,'EAプラン',100000,100000,1,0,'2014-01-17 10:43:51','2015-05-12 16:34:38');

/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;


# テーブルのダンプ short_urls
# ------------------------------------------------------------

DROP TABLE IF EXISTS `short_urls`;

CREATE TABLE `short_urls` (
  `short_url` varchar(11) NOT NULL COMMENT 'short url',
  `redirect_url` text NOT NULL COMMENT 'redirect先',
  `client_id` int(10) unsigned NOT NULL COMMENT 'clientId',
  `client_task_id` varchar(20) NOT NULL COMMENT 'client設定TaskId',
  `service_id` varchar(20) NOT NULL COMMENT 'service_id',
  `pos` int(10) unsigned NOT NULL COMMENT 'URL位置',
  `data_file` varchar(128) NOT NULL COMMENT 'datafile',
  `delete_flg` tinyint(4) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`short_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短縮URL';



# テーブルのダンプ splitters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `splitters`;

CREATE TABLE `splitters` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `delivery_id` int(11) NOT NULL COMMENT '配信ID',
  `task_id` varchar(11) DEFAULT NULL COMMENT 'MTAタスクID',
  `splitter_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '配信ステータス : 1=未配信,2=配信中,3=配信済,4=配信エラー',
  `mta_id` int(11) NOT NULL COMMENT '配信先MTA_ID',
  `mta_start_time` datetime DEFAULT NULL COMMENT 'MTA配信開始日時',
  `mta_finish_time` datetime DEFAULT NULL COMMENT 'MTA配信終了日時',
  `mta_request_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTA配信要求数',
  `mta_delivery_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTA総配信数',
  `mta_error_count` int(11) NOT NULL DEFAULT '0' COMMENT 'MTAエラー数',
  `mta_error_reason` varchar(255) DEFAULT NULL COMMENT 'MTAエラー事由',
  `delete_flg` char(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`,`delivery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分割配信用';



# テーブルのダンプ task_ids
# ------------------------------------------------------------

DROP TABLE IF EXISTS `task_ids`;

CREATE TABLE `task_ids` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `task_ids` WRITE;
/*!40000 ALTER TABLE `task_ids` DISABLE KEYS */;

INSERT INTO `task_ids` (`id`)
VALUES
	(100294);

/*!40000 ALTER TABLE `task_ids` ENABLE KEYS */;
UNLOCK TABLES;


# テーブルのダンプ task_keys
# ------------------------------------------------------------

DROP TABLE IF EXISTS `task_keys`;

CREATE TABLE `task_keys` (
  `task_key` varchar(11) NOT NULL COMMENT '配信識別子',
  `client_id` int(10) unsigned NOT NULL COMMENT 'clientId',
  `client_task_id` varchar(20) NOT NULL COMMENT 'client設定TaskId',
  `service_id` varchar(20) NOT NULL COMMENT 'service_id',
  `data_file` varchar(128) NOT NULL COMMENT 'datafile',
  `delete_flg` tinyint(4) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`task_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配信識別子';



# テーブルのダンプ web_hooks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `web_hooks`;

CREATE TABLE `web_hooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `client_id` int(11) NOT NULL COMMENT 'クライアントID',
  `hook_url` varchar(256) NOT NULL COMMENT '通知先URL',
  `delete_flg` tinyint(4) NOT NULL DEFAULT '0' COMMENT '削除フラグ : 0=未削除,1=削除',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
