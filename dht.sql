SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- 数据库: `dht`
--

-- --------------------------------------------------------

--
-- 表的结构 `search_filelist`
--

CREATE TABLE IF NOT EXISTS `search_filelist` (
  `info_hash` varchar(40) NOT NULL,
  `file_list` longtext NOT NULL,
  PRIMARY KEY (`info_hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `search_hash`
--

CREATE TABLE IF NOT EXISTS `search_hash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info_hash` varchar(40) NOT NULL,
  `category` varchar(20) NOT NULL,
  `data_hash` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `extension` varchar(20) NOT NULL,
  `classified` tinyint(1) NOT NULL,
  `source_ip` varchar(20) DEFAULT NULL,
  `tagged` tinyint(1) NOT NULL,
  `length` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `last_seen` datetime NOT NULL,
  `requests` int(10) unsigned NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `info_hash` (`info_hash`),
  KEY `search_hash_tagged_50480647a28d03e1_uniq` (`tagged`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `search_statusreport`
--

CREATE TABLE IF NOT EXISTS `search_statusreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `new_hashes` int(11) NOT NULL,
  `total_requests` int(11) NOT NULL,
  `valid_requests` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `search_statusreport_date_625dc87b8a52c947_uniq` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

