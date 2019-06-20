-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: mdm
-- ------------------------------------------------------
-- Server version	5.7.17-enterprise-commercial-advanced-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `你好`
--
use mdm;
DROP TABLE IF EXISTS `你好`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `你好` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `字段1` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `你好`
--

LOCK TABLES `你好` WRITE;
/*!40000 ALTER TABLE `你好` DISABLE KEYS */;
/*!40000 ALTER TABLE `你好` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_attribute`
--

DROP TABLE IF EXISTS `m_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_attribute` (
  `id` varchar(64) NOT NULL,
  `name` varchar(250) DEFAULT NULL COMMENT '名称',
  `showName` varchar(250) DEFAULT NULL COMMENT '显示名称',
  `desc` varchar(512) DEFAULT NULL COMMENT '说明',
  `type` varchar(45) DEFAULT NULL COMMENT '属性类型',
  `dataType` varchar(45) DEFAULT NULL COMMENT '数据类型',
  `dataLimit` int(11) DEFAULT NULL COMMENT '数据限制',
  `entityId` varchar(64) DEFAULT NULL COMMENT '所属实体id',
  `createId` int(11) DEFAULT NULL COMMENT '创建者id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) DEFAULT NULL COMMENT '更新者id',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_attribute`
--

LOCK TABLES `m_attribute` WRITE;
/*!40000 ALTER TABLE `m_attribute` DISABLE KEYS */;
INSERT INTO `m_attribute` VALUES ('03467bec10c24565b02cad046ed46771','createId','createId',NULL,'hide','varchar',NULL,'d9e1f3c4bbb143fbb166e9448b72648b',4,'2019-05-05 09:50:54',4,'2019-05-05 09:50:54'),('12492dc7bdcb46c1a51da029cff2cc07','Name','Name',NULL,'sys','varchar',250,'d9e1f3c4bbb143fbb166e9448b72648b',4,'2019-05-05 09:50:54',4,'2019-05-05 09:50:54'),('1bca11d755734451aee34eb8dcbb2ecd','Name','Name',NULL,'sys','VARCHAR',250,'14100c5012134c0d9942278b59b7d5bc',4,'2019-04-19 10:44:10',4,'2019-04-19 10:44:10'),('66c133ebe0874b659b71249f41caa7e9','updateId','updateId',NULL,'hide','varchar',NULL,'d9e1f3c4bbb143fbb166e9448b72648b',4,'2019-05-05 09:50:54',4,'2019-05-05 09:50:54'),('7b6d370bd10441f8a7f6f8c54712409d','Code','Code',NULL,'sys','VARCHAR',250,'14100c5012134c0d9942278b59b7d5bc',4,'2019-04-19 10:44:10',4,'2019-04-19 10:44:10'),('82f8dff473b54c339d5f145e1f3dfdf2','Code','Code',NULL,'sys','varchar',250,'d9e1f3c4bbb143fbb166e9448b72648b',4,'2019-05-05 09:50:54',4,'2019-05-05 09:50:54'),('b325f76c022a4a439774a78407a23102','age','age','年龄','self','int',3,'14100c5012134c0d9942278b59b7d5bc',4,'2019-04-19 10:45:46',NULL,NULL),('ce6f915082e84cb68c1068acd3a99ad8','updateTime','updateTime',NULL,'hide','datetime',NULL,'d9e1f3c4bbb143fbb166e9448b72648b',4,'2019-05-05 09:50:54',4,'2019-05-05 09:50:54'),('d02431c7eafa499d84ab80ad87c1118e','createTime','createTime',NULL,'hide','datetime',NULL,'d9e1f3c4bbb143fbb166e9448b72648b',4,'2019-05-05 09:50:54',4,'2019-05-05 09:50:54'),('eae24c07aacc4d1688fa7c31338627ad','classs','class','班级','self','varchar',64,'14100c5012134c0d9942278b59b7d5bc',4,'2019-04-30 10:03:32',NULL,NULL);
/*!40000 ALTER TABLE `m_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_brule`
--

DROP TABLE IF EXISTS `m_brule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_brule` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL COMMENT '规则名称',
  `desc` varchar(45) DEFAULT NULL COMMENT '说明',
  `publish` char(1) DEFAULT NULL COMMENT '是否发布',
  `createId` int(11) DEFAULT NULL COMMENT '创建者',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_brule`
--

LOCK TABLES `m_brule` WRITE;
/*!40000 ALTER TABLE `m_brule` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_brule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entities`
--

DROP TABLE IF EXISTS `m_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entities` (
  `id` varchar(64) NOT NULL,
  `name` varchar(45) DEFAULT NULL COMMENT '实体名称',
  `desc` varchar(512) DEFAULT NULL COMMENT '实体说明',
  `hasTempTable` char(1) DEFAULT NULL COMMENT '是否有临时表',
  `tempTable` varchar(45) DEFAULT NULL COMMENT '临时表名称',
  `codeAutomatic` char(1) DEFAULT NULL COMMENT '是否自动创建代码值：0否，1是\n',
  `codeAutomaticStart` int(11) DEFAULT NULL COMMENT '添加实例时，选择自动生成代码，设定的起始值',
  `createId` int(11) DEFAULT NULL COMMENT '创建者id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) DEFAULT NULL COMMENT '更新者id',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `modelId` varchar(64) NOT NULL COMMENT '所属模型id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entities`
--

LOCK TABLES `m_entities` WRITE;
/*!40000 ALTER TABLE `m_entities` DISABLE KEYS */;
INSERT INTO `m_entities` VALUES ('14100c5012134c0d9942278b59b7d5bc','user','用户','1',NULL,'1',NULL,4,'2019-04-19 10:44:10',NULL,NULL,'06f3abd6e8e74be0a2dd340ed95b3551'),('d9e1f3c4bbb143fbb166e9448b72648b','test','ceshi','1',NULL,'1',NULL,4,'2019-05-05 09:50:54',NULL,NULL,'b81f5c0fbf34409f8e156160aa4f8c8b');
/*!40000 ALTER TABLE `m_entities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_entity_sync`
--

DROP TABLE IF EXISTS `m_entity_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_entity_sync` (
  `id` varchar(64) NOT NULL,
  `sourceModelId` varchar(64) DEFAULT NULL COMMENT '源模型id',
  `sourceEntityId` varchar(64) DEFAULT NULL COMMENT '源实体id',
  `targetModelId` varchar(64) DEFAULT NULL COMMENT '目标模型id',
  `targetEntityId` varchar(64) DEFAULT NULL COMMENT '目标实体id',
  `name` varchar(250) DEFAULT NULL COMMENT '名称',
  `syncStyle` char(1) DEFAULT NULL COMMENT '同步方式：0自动同步（需设定频率）\n1手动同步（按需同步）',
  `syncInterval` int(11) DEFAULT NULL COMMENT '同步间隔',
  `intervalUnit` char(1) DEFAULT NULL COMMENT '间隔单位（小时/天）0/1',
  `createId` int(11) DEFAULT NULL COMMENT '创建者id',
  `updateId` int(11) DEFAULT NULL COMMENT '更新者id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `status` char(1) DEFAULT NULL COMMENT '状态（0：未执行，1：执行中）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_entity_sync`
--

LOCK TABLES `m_entity_sync` WRITE;
/*!40000 ALTER TABLE `m_entity_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_entity_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_index`
--

DROP TABLE IF EXISTS `m_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_index` (
  `id` varchar(64) NOT NULL,
  `name` varchar(250) DEFAULT NULL COMMENT '名称',
  `isSingle` char(1) DEFAULT NULL COMMENT '是否唯一（0：否，1：是）',
  `createId` int(11) DEFAULT NULL COMMENT '创建者id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) DEFAULT NULL COMMENT '更新者id',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `status` char(1) DEFAULT NULL COMMENT '状态',
  `m_entities_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_index`
--

LOCK TABLES `m_index` WRITE;
/*!40000 ALTER TABLE `m_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_index_attr`
--

DROP TABLE IF EXISTS `m_index_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_index_attr` (
  `id` varchar(64) NOT NULL,
  `indexId` varchar(64) DEFAULT NULL COMMENT '索引的id',
  `attrId` varchar(64) DEFAULT NULL COMMENT '属性id',
  `m_index_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_index_attr`
--

LOCK TABLES `m_index_attr` WRITE;
/*!40000 ALTER TABLE `m_index_attr` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_index_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_model`
--

DROP TABLE IF EXISTS `m_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_model` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(64) DEFAULT '' COMMENT '模型名称',
  `description` varchar(512) DEFAULT NULL COMMENT '描述，说明',
  `createId` int(11) DEFAULT NULL,
  `updateId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `logSave` char(1) DEFAULT NULL COMMENT '是否保存日志：0：否，1：是',
  `saveDays` int(11) DEFAULT NULL COMMENT '日志保留天数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_model`
--

LOCK TABLES `m_model` WRITE;
/*!40000 ALTER TABLE `m_model` DISABLE KEYS */;
INSERT INTO `m_model` VALUES ('06f3abd6e8e74be0a2dd340ed95b3551','模型1','a',4,4,'2019-04-19 10:43:53','2019-04-21 22:14:43','1',6),('0960769729374dcd98406df6d46bce22','qwe','qwe',4,NULL,'2019-04-28 10:51:25',NULL,'1',3),('475832a81468441f98826ff843e64471','asd','asd',4,NULL,'2019-04-28 10:53:41',NULL,'0',1),('b81f5c0fbf34409f8e156160aa4f8c8b','模型二','模型',4,NULL,'2019-04-30 09:52:00',NULL,'1',12);
/*!40000 ALTER TABLE `m_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_rule_script`
--

DROP TABLE IF EXISTS `m_rule_script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_rule_script` (
  `id` varchar(64) NOT NULL,
  `ruleId` varchar(64) DEFAULT NULL COMMENT '规则id',
  `type` varchar(64) DEFAULT NULL COMMENT 'if/then/else',
  `script` varchar(250) DEFAULT NULL COMMENT '语句',
  `link` varchar(3) DEFAULT NULL COMMENT '连接符号：and、or、not',
  `m_bRule_id` varchar(64) NOT NULL,
  `publish` char(1) DEFAULT NULL COMMENT '是否发布：0/未发布，1/发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_rule_script`
--

LOCK TABLES `m_rule_script` WRITE;
/*!40000 ALTER TABLE `m_rule_script` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_rule_script` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_view`
--

DROP TABLE IF EXISTS `m_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_view` (
  `id` varchar(64) NOT NULL,
  `name` varchar(250) DEFAULT NULL COMMENT '视图名称',
  `modelId` varchar(64) DEFAULT NULL COMMENT '模型id',
  `includeDelete` char(1) DEFAULT NULL COMMENT '是否包含被删除成员',
  `entityId` varchar(64) DEFAULT NULL COMMENT '实体id',
  `createId` int(11) DEFAULT NULL COMMENT '创建者id',
  `createTime` datetime DEFAULT NULL,
  `updateId` int(11) DEFAULT NULL COMMENT '更新者id',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_view`
--

LOCK TABLES `m_view` WRITE;
/*!40000 ALTER TABLE `m_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `Name` varchar(250) NOT NULL,
  `Code` varchar(250) NOT NULL,
  `createId` varchar(0) NOT NULL,
  `updateId` varchar(0) NOT NULL,
  `createTime` datetime NOT NULL,
  `updateTime` datetime NOT NULL,
  PRIMARY KEY (`Code`),
  UNIQUE KEY `Code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `Name` varchar(250) NOT NULL,
  `Code` varchar(250) NOT NULL,
  `age` int(3) NOT NULL,
  `classs` varchar(64) NOT NULL,
  PRIMARY KEY (`Code`),
  UNIQUE KEY `Code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('jhon','0028',25,'202-5'),('疲劳','52',25,'202-6'),('566','655',656,''),('656','665',656,''),('67','76',67,''),('000','888',888,''),('808','929',999,''),('你好','93',89,''),('asdasd ','asdsa',122,''),('ssss','dddd',4,''),('qqqq','qqqq',44,''),('qq','ww',12,'');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-16 15:52:20
