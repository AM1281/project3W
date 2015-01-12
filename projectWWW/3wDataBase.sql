-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.5-10.0.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for rent_a_book
CREATE DATABASE IF NOT EXISTS `rent_a_book` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `rent_a_book`;


-- Dumping structure for table rent_a_book.account
CREATE TABLE IF NOT EXISTS `account` (
  `uname` char(50) NOT NULL,
  `dname` char(100) NOT NULL,
  `rating` float DEFAULT NULL,
  `rsum` float NOT NULL DEFAULT '0',
  `rnum` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uname`),
  KEY `uname` (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table rent_a_book.book
CREATE TABLE IF NOT EXISTS `book` (
  `owner` char(20) NOT NULL,
  `isbn` char(10) NOT NULL,
  `available` bit(1) NOT NULL DEFAULT b'1',
  `title` char(20) NOT NULL,
  `url` char(255) DEFAULT NULL,
  `writer` char(50) DEFAULT NULL,
  PRIMARY KEY (`isbn`,`owner`),
  KEY `FK_book_account` (`owner`),
  CONSTRAINT `FK_book_account` FOREIGN KEY (`owner`) REFERENCES `account` (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table rent_a_book.on_rent
CREATE TABLE IF NOT EXISTS `on_rent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `afrom` char(50) NOT NULL DEFAULT '0',
  `ato` char(50) NOT NULL DEFAULT '0',
  `isbn` char(10) NOT NULL DEFAULT '0',
  `expires` datetime NOT NULL,
  `returned` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_on_rent_account` (`afrom`),
  KEY `FK_on_rent_account_2` (`ato`),
  CONSTRAINT `FK_on_rent_account` FOREIGN KEY (`afrom`) REFERENCES `account` (`uname`),
  CONSTRAINT `FK_on_rent_account_2` FOREIGN KEY (`ato`) REFERENCES `account` (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table rent_a_book.request
CREATE TABLE IF NOT EXISTS `request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reqto` char(50) NOT NULL,
  `seen` bit(1) NOT NULL DEFAULT b'0',
  `reqfrom` char(50) NOT NULL,
  `isbn` char(10) NOT NULL,
  `accepted` bit(1) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_request_account` (`reqto`),
  KEY `FK_request_account_2` (`reqfrom`),
  CONSTRAINT `FK_request_account` FOREIGN KEY (`reqto`) REFERENCES `account` (`uname`),
  CONSTRAINT `FK_request_account_2` FOREIGN KEY (`reqfrom`) REFERENCES `account` (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
