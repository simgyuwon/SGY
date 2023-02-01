/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 10.4.24-MariaDB : Database - kor_sb_2022_t
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`kor_sb_2022_t` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `kor_sb_2022_t`;

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `boardId` int(10) unsigned NOT NULL,
  `title` char(100) DEFAULT NULL,
  `body` text NOT NULL,
  `hitCount` int(10) unsigned NOT NULL DEFAULT 0,
  `goodReactionPoint` int(10) unsigned NOT NULL DEFAULT 0,
  `badReactionPoint` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `article` */

insert  into `article`(`id`,`regDate`,`updateDate`,`memberId`,`boardId`,`title`,`body`,`hitCount`,`goodReactionPoint`,`badReactionPoint`) values 
(1,'2022-08-31 21:30:46','2022-08-31 21:30:46',2,1,'제목1','내용1',0,1,2),
(2,'2022-08-31 21:30:46','2022-08-31 21:30:46',2,1,'제목2','내용2',0,2,0),
(3,'2022-08-31 21:30:46','2022-08-31 21:30:46',2,2,'제목3','내용3',0,0,0),
(4,'2022-08-31 21:43:45','2022-08-31 21:43:45',1,1,'amdin','amdin',0,0,0),
(5,'2022-09-01 20:22:47','2022-09-01 20:24:23',1,1,'ㅇㄴㄹㅇㄹ','![image](https://i.postimg.cc/KzkMSh92/cat.jpg)\r\n고양이 이미지\r\n\r\n![image](https://i.postimg.cc/KzkMSh92/cat.jpg)ㅇㄹㄴㅇㄹ',0,0,0);

/*Table structure for table `attr` */

DROP TABLE IF EXISTS `attr`;

CREATE TABLE `attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `relTypeCode` char(20) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `typeCode` char(30) NOT NULL,
  `type2Code` char(70) NOT NULL,
  `value` text NOT NULL,
  `expireDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relTypeCode` (`relTypeCode`,`relId`,`typeCode`,`type2Code`),
  KEY `relTypeCode_2` (`relTypeCode`,`typeCode`,`type2Code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `attr` */

insert  into `attr`(`id`,`regDate`,`updateDate`,`relTypeCode`,`relId`,`typeCode`,`type2Code`,`value`,`expireDate`) values 
(1,'2022-08-31 21:31:00','2022-08-31 21:43:34','member',1,'extra','memberModifyAuthKey','cqlsakfb43','2022-08-31 21:48:34'),
(3,'2022-08-31 21:32:29','2022-08-31 21:36:29','member',4,'extra','memberModifyAuthKey','424jwculvi','2022-08-31 21:41:29');

/*Table structure for table `board` */

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `code` char(50) NOT NULL COMMENT 'notice(공지사항), free1(자유게시판1), free2(자유게시판2),...',
  `name` char(50) NOT NULL COMMENT '게시판 이름',
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '삭제여부(0=탈퇴전, 1=탈퇴)',
  `delDate` datetime DEFAULT NULL COMMENT '삭제날짜',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `board` */

insert  into `board`(`id`,`regDate`,`updateDate`,`code`,`name`,`delStatus`,`delDate`) values 
(1,'2022-08-31 21:30:46','2022-08-31 21:30:46','notice','공지사항',0,NULL),
(2,'2022-08-31 21:30:46','2022-08-31 21:30:46','free1','자유',0,NULL);

/*Table structure for table `genFile` */

DROP TABLE IF EXISTS `genFile`;

CREATE TABLE `genFile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `relTypeCode` char(50) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `originFileName` varchar(100) NOT NULL,
  `fileExt` char(10) NOT NULL,
  `typeCode` char(20) NOT NULL,
  `type2Code` char(20) NOT NULL,
  `fileSize` int(10) unsigned NOT NULL,
  `fileExtTypeCode` char(10) NOT NULL,
  `fileExtType2Code` char(10) NOT NULL,
  `fileNo` smallint(2) unsigned NOT NULL,
  `fileDir` char(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relId` (`relTypeCode`,`relId`,`typeCode`,`type2Code`,`fileNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `genFile` */

insert  into `genFile`(`id`,`regDate`,`updateDate`,`delDate`,`delStatus`,`relTypeCode`,`relId`,`originFileName`,`fileExt`,`typeCode`,`type2Code`,`fileSize`,`fileExtTypeCode`,`fileExtType2Code`,`fileNo`,`fileDir`) values 
(2,'2022-08-31 21:36:34','2022-08-31 21:36:34',NULL,0,'member',4,'pf.jpg','jpg','extra','profileImg',500171,'img','jpg',1,'2022_08'),
(3,'2022-08-31 21:43:38','2022-08-31 21:43:38',NULL,0,'member',1,'cat.jpg','jpg','extra','profileImg',5236,'img','jpg',1,'2022_08');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `loginId` char(20) NOT NULL,
  `loginPw` varchar(100) NOT NULL,
  `authLevel` smallint(2) unsigned DEFAULT 3 COMMENT '권한레벨(3=일반, 7=관리자)',
  `name` char(20) NOT NULL,
  `nickname` char(20) NOT NULL,
  `cellphoneNo` char(20) NOT NULL,
  `email` char(50) NOT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '탈퇴여부(0=탈퇴전, 1=탈퇴)',
  `delDate` datetime DEFAULT NULL COMMENT '탈퇴날짜',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `member` */

insert  into `member`(`id`,`regDate`,`updateDate`,`loginId`,`loginPw`,`authLevel`,`name`,`nickname`,`cellphoneNo`,`email`,`delStatus`,`delDate`) values 
(1,'2022-08-31 21:30:46','2022-08-31 21:43:38','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',7,'관리자','관리자','01011112222','admin@gmail.com',0,NULL),
(2,'2022-08-31 21:30:46','2022-08-31 21:30:46','user1','0a041b9462caa4a31bac3567e0b6e6fd9100787db2ab433d96f6d178cabfce90',3,'사용자1','사용자1','01011112222','test1@gmail.com',0,NULL),
(3,'2022-08-31 21:30:46','2022-08-31 21:30:46','user2','6025d18fe48abd45168528f18a82e265dd98d421a7084aa09f61b341703901a3',3,'사용자2','사용자2','01011112222','test2@gmail.com',0,NULL),
(4,'2022-08-31 21:31:51','2022-08-31 21:36:34','user','04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb',3,'user','user','010-1234-1234','user@user',0,NULL);

/*Table structure for table `reactionPoint` */

DROP TABLE IF EXISTS `reactionPoint`;

CREATE TABLE `reactionPoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `point` smallint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `reactionPoint` */

insert  into `reactionPoint`(`id`,`regDate`,`updateDate`,`memberId`,`relTypeCode`,`relId`,`point`) values 
(1,'2022-08-31 21:30:46','2022-08-31 21:30:46',1,'article',1,-1),
(2,'2022-08-31 21:30:46','2022-08-31 21:30:46',1,'article',2,1),
(3,'2022-08-31 21:30:46','2022-08-31 21:30:46',2,'article',1,-1),
(4,'2022-08-31 21:30:46','2022-08-31 21:30:46',2,'article',2,1),
(5,'2022-08-31 21:30:46','2022-08-31 21:30:46',3,'article',1,1);

/*Table structure for table `reply` */

DROP TABLE IF EXISTS `reply`;

CREATE TABLE `reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `body` text NOT NULL,
  `goodReactionPoint` int(10) unsigned NOT NULL DEFAULT 0,
  `badReactionPoint` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `relTypeCode` (`relTypeCode`,`relId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `reply` */

insert  into `reply`(`id`,`regDate`,`updateDate`,`memberId`,`relTypeCode`,`relId`,`body`,`goodReactionPoint`,`badReactionPoint`) values 
(1,'2022-08-31 21:30:46','2022-08-31 21:30:46',1,'article',1,'댓글 1',0,0),
(2,'2022-08-31 21:30:46','2022-08-31 21:30:46',1,'article',1,'댓글 2',0,0),
(3,'2022-08-31 21:30:46','2022-08-31 21:30:46',2,'article',1,'댓글 3',0,0),
(4,'2022-08-31 21:30:46','2022-08-31 21:30:46',3,'article',2,'댓글 4',0,0),
(5,'2022-08-31 21:45:59','2022-08-31 21:45:59',1,'article',4,'admin',0,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
