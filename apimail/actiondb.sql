# ************************************************************
# Sequel Pro SQL dump
# バージョン 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# ホスト: 192.168.99.100 (MySQL 5.6.27)
# データベース: actiondb
# 作成時刻: 2015-11-26 10:31:25 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# テーブルのダンプ action_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `action_logs`;

CREATE TABLE `action_logs` (
  `notify_timestamp` timestamp NOT NULL DEFAULT '2006-12-31 15:00:00' COMMENT 'Action日時',
  `token` char(64) NOT NULL COMMENT 'token : アクション識別子\n(client_id+#+client_task_id+#service_id#customer_id)',
  `client_id` int(11) NOT NULL COMMENT 'クライアントID',
  `client_task_id` varchar(20) NOT NULL COMMENT 'クライアント設定タスクID',
  `service_id` varchar(25) NOT NULL COMMENT 'サービス識別ID',
  `action` varchar(32) NOT NULL COMMENT 'Action',
  `url` text NOT NULL COMMENT 'クリックURL',
  `customer_id` varchar(64) NOT NULL COMMENT '顧客識別ID',
  `pos` varchar(5) NOT NULL DEFAULT '-' COMMENT 'URL位置',
  `personal_flg` char(1) NOT NULL DEFAULT '0' COMMENT 'パーソナルフラグ : 0=通常 1=パーソナル',
  `data_file` varchar(128) NOT NULL COMMENT 'data_file',
  `price` int(11) NOT NULL DEFAULT '0',
  `req_usr_agt` text COMMENT 'ユーザーエージェント',
  `req_addrs` varchar(30) DEFAULT NULL COMMENT 'リモートアドレス',
  `work_flg` char(1) NOT NULL DEFAULT '0' COMMENT '処理済フラグ : 0=未処理 1=処理済',
  `created_at` datetime NOT NULL COMMENT '登録日時 : データ登録日時',
  `updated_at` datetime NOT NULL COMMENT '更新日時 : データ更新日時',
  PRIMARY KEY (`notify_timestamp`,`token`,`client_id`,`client_task_id`,`service_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Action通知ログ';



# テーブルのダンプ click_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `click_logs`;

CREATE TABLE `click_logs` (
  `last_timestamp` timestamp NOT NULL DEFAULT '2006-12-31 06:00:00' COMMENT 'Action日時',
  `token` varchar(64) NOT NULL COMMENT 'token : アクション識別子\n(client_id+#+client_task_id+#service_id#customer_id)',
  `work_flg` char(1) NOT NULL DEFAULT '0' COMMENT '処理済フラグ : 0=未処理 1=処理済',
  `created_at` datetime NOT NULL COMMENT '登録日時 : データ登録日時',
  `updated_at` datetime NOT NULL COMMENT '更新日時 : データ更新日時',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Action通知ログ';



# テーブルのダンプ cv_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cv_logs`;

CREATE TABLE `cv_logs` (
  `last_timestamp` timestamp NOT NULL DEFAULT '2006-12-30 21:00:00' COMMENT 'Action日時',
  `token` varchar(64) NOT NULL COMMENT 'token : アクション識別子\n(client_id+#+client_task_id+#service_id#customer_id)',
  `work_flg` char(1) NOT NULL DEFAULT '0' COMMENT '処理済フラグ : 0=未処理 1=処理済',
  `created_at` datetime NOT NULL COMMENT '登録日時 : データ登録日時',
  `updated_at` datetime NOT NULL COMMENT '更新日時 : データ更新日時',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cv通知ログ';



# テーブルのダンプ open_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `open_logs`;

CREATE TABLE `open_logs` (
  `last_timestamp` timestamp NOT NULL DEFAULT '2006-12-31 06:00:00' COMMENT 'Action日時',
  `token` varchar(64) NOT NULL COMMENT 'token : アクション識別子\n(client_id+#+client_task_id+#service_id#customer_id)',
  `work_flg` char(1) NOT NULL DEFAULT '0' COMMENT '処理済フラグ : 0=未処理 1=処理済',
  `created_at` datetime NOT NULL COMMENT '登録日時 : データ登録日時',
  `updated_at` datetime NOT NULL COMMENT '更新日時 : データ更新日時',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Action通知ログ';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
