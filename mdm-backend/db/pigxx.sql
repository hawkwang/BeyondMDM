-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: pigxx
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
-- Table structure for table `job_execution_log`
--
use pigxx;
DROP TABLE IF EXISTS `job_execution_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_execution_log` (
  `id` varchar(40) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `sharding_item` int(11) NOT NULL,
  `execution_source` varchar(20) NOT NULL,
  `failure_cause` varchar(4000) DEFAULT NULL,
  `is_success` int(11) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `complete_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='任务日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_execution_log`
--

LOCK TABLES `job_execution_log` WRITE;
/*!40000 ALTER TABLE `job_execution_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_execution_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_status_trace_log`
--

DROP TABLE IF EXISTS `job_status_trace_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_status_trace_log` (
  `id` varchar(40) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `original_task_id` varchar(255) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `slave_id` varchar(50) NOT NULL,
  `source` varchar(50) NOT NULL,
  `execution_type` varchar(20) NOT NULL,
  `sharding_item` varchar(100) NOT NULL,
  `state` varchar(20) NOT NULL,
  `message` varchar(4000) DEFAULT NULL,
  `creation_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `TASK_ID_STATE_INDEX` (`task_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='任务轨迹表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_status_trace_log`
--

LOCK TABLES `job_status_trace_log` WRITE;
/*!40000 ALTER TABLE `job_status_trace_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_status_trace_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
  `dept_id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  `parent_id` int(11) DEFAULT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (1,'山东农信',NULL,'2018-01-22 11:00:23','2019-04-15 05:34:09','1',0,1),(2,'沙县国际',NULL,'2018-01-22 11:00:38','2019-04-15 05:34:12','1',0,1),(3,'潍坊农信',NULL,'2018-01-22 11:00:44','2019-04-15 05:34:09','1',1,1),(4,'高新农信',NULL,'2018-01-22 11:00:52','2019-04-15 05:34:09','1',3,1),(5,'院校农信',NULL,'2018-01-22 11:00:57','2019-04-15 05:34:09','1',4,1),(6,'潍院农信',NULL,'2018-01-22 11:01:06','2019-01-09 02:58:18','1',5,1),(7,'山东沙县',NULL,'2018-01-22 11:01:57','2019-04-15 05:34:12','1',2,1),(8,'潍坊沙县',NULL,'2018-01-22 11:02:03','2019-04-15 05:34:12','1',7,1),(9,'高新沙县',NULL,'2018-01-22 11:02:14','2018-09-12 17:46:44','1',8,1),(10,'租户2',NULL,'2018-11-18 05:27:11','2018-11-18 05:42:19','0',0,2),(11,'院校沙县',NULL,'2018-12-10 13:19:26','2019-04-15 05:34:12','1',8,1),(12,'管理部门',0,'2019-04-15 05:34:29',NULL,'0',2,1),(13,'管理部门',0,'2019-04-15 05:35:56',NULL,'0',2,1),(14,'管理部门',1,'2019-04-15 05:36:48',NULL,'0',0,1),(15,'技术部',1,'2019-04-15 05:40:51',NULL,'0',0,1);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept_relation`
--

DROP TABLE IF EXISTS `sys_dept_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept_relation` (
  `ancestor` int(11) NOT NULL COMMENT '祖先节点',
  `descendant` int(11) NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`,`descendant`) USING BTREE,
  KEY `idx1` (`ancestor`) USING BTREE,
  KEY `idx2` (`descendant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept_relation`
--

LOCK TABLES `sys_dept_relation` WRITE;
/*!40000 ALTER TABLE `sys_dept_relation` DISABLE KEYS */;
INSERT INTO `sys_dept_relation` VALUES (10,10),(12,12),(13,13),(14,14),(15,15);
/*!40000 ALTER TABLE `sys_dept_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` int(10) NOT NULL COMMENT '排序（升序）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属租户',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`label`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict`
--

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
INSERT INTO `sys_dict` VALUES (1,'9','异常','log_type','日志异常',1,'2018-07-08 22:16:14','2018-11-23 23:25:11','日志异常','0',1),(2,'0','正常','log_type','正常',0,'2018-07-08 22:15:40','2018-11-23 23:25:14','正常','0',0),(3,'WX','微信','social_type','微信登录',0,'2018-08-16 06:01:45','2018-11-23 23:25:16','微信登录','0',0),(4,'QQ','QQ','social_type','QQ登录',1,'2018-07-08 22:15:40','2018-11-23 23:25:18','QQ登录','0',0),(5,'0','正常','log_type','日志类型',0,'2018-09-29 18:33:53','2018-11-23 23:25:20','日志正常','0',1),(6,'0','未提交','leave_status','请假状态',0,'2018-09-29 18:34:45','2018-11-23 23:25:23','请假状态','0',1),(7,'1','审批中','leave_status','请假状态',1,'2018-09-29 18:35:16','2018-11-23 23:25:25','请假状态','0',1),(8,'2','完成','leave_status','请假状态',2,'2018-09-29 18:35:58','2018-11-23 23:25:28','请假状态','0',1),(9,'9','驳回','leave_status','请假状态',9,'2018-09-29 18:36:31','2018-11-23 23:25:31','请假状态','0',1);
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `service_id` varchar(32) DEFAULT NULL COMMENT '服务ID',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `time` mediumtext COMMENT '执行时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  `exception` text COMMENT '异常信息',
  `tenant_id` int(11) DEFAULT '0' COMMENT '所属租户',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_log_create_by` (`create_by`) USING BTREE,
  KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
  KEY `sys_log_type` (`type`) USING BTREE,
  KEY `sys_log_create_date` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
INSERT INTO `sys_log` VALUES (51,'0','添加角色','test','admin','2019-01-24 20:56:43',NULL,'0:0:0:0:0:0:0:1','PostmanRuntime/7.6.0','/role','POST','Authorization=%5B%5D','65','0',NULL,1),(52,'0','修改路由','pig','admin','2019-04-08 14:52:36',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/route','PUT','','232','0',NULL,1),(53,'0','修改路由','pig','admin','2019-04-08 14:52:36',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/route','PUT','','1423','0',NULL,1),(54,'0','添加角色','pig','admin','2019-04-11 11:07:13',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/role','POST','','32','0',NULL,1),(55,'0','更新角色菜单','pig','admin','2019-04-11 11:07:47',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/role/menu','PUT','roleId=%5B3%5D&menuIds=%5B5000%2C5003%2C9999%2C%5D','90','0',NULL,1),(56,'0','添加用户','pig','admin','2019-04-11 11:08:58',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/user','POST','','216','0',NULL,1),(57,'0','添加用户','pig','admin','2019-04-11 13:36:34',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/user','POST','','115','0',NULL,1),(58,'0','修改角色','pig','admin','2019-04-11 13:50:35',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/role','PUT','','32','0',NULL,1),(59,'0','修改路由','pig','admin','2019-04-11 14:04:28',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/route','PUT','','91','0',NULL,1),(60,'0','修改路由','pig','admin','2019-04-11 14:33:52',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/route','PUT','','110','0',NULL,1),(61,'0','新增菜单','pig','admin','2019-04-11 14:49:26',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','21','0',NULL,1),(62,'0','更新角色菜单','pig','admin','2019-04-11 14:49:58',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/role/menu','PUT','roleId=%5B1%5D&menuIds=%5B2%2C1000%2C1100%2C1101%2C1102%2C1103%2C1200%2C1201%2C1202%2C1203%2C1300%2C1301%2C1302%2C1303%2C1304%2C1400%2C1401%2C1402%2C1403%2C2000%2C2100%2C2101%2C2200%2C2201%2C2202%2C2203%2C2300%2C2400%2C2401%2C2402%2C2403%2C2500%2C2501%2C2502%2C2503%2C2600%2C2601%2C2700%2C3000%2C3100%2C3200%2C3300%2C3400%2C3500%2C3600%2C3601%2C3700%2C3800%2C3900%2C3901%2C4000%2C4100%2C4101%2C4200%2C4201%2C4300%2C4301%2C4302%2C4303%2C4400%2C4401%2C9999%2C%5D','81','0',NULL,1),(63,'0','删除菜单','pig','admin','2019-04-11 15:42:01',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu/2','DELETE','','46','0',NULL,1),(64,'0','新增菜单','pig','admin','2019-04-11 15:43:57',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','13','0',NULL,1),(65,'0','更新菜单','pig','admin','2019-04-11 15:44:37',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','26','0',NULL,1),(66,'0','更新菜单','pig','admin','2019-04-11 15:45:23',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(67,'0','新增菜单','pig','admin','2019-04-11 15:48:01',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','14','0',NULL,1),(68,'0','新增菜单','pig','admin','2019-04-11 15:48:39',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','12','0',NULL,1),(69,'0','新增菜单','pig','admin','2019-04-11 15:52:16',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','5','0',NULL,1),(70,'0','新增菜单','pig','admin','2019-04-11 16:09:18',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','13','0',NULL,1),(71,'0','新增菜单','pig','admin','2019-04-11 16:09:49',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','13','0',NULL,1),(72,'0','新增菜单','pig','admin','2019-04-11 16:10:19',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','11','0',NULL,1),(73,'0','新增菜单','pig','admin','2019-04-11 16:10:49',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','6','0',NULL,1),(74,'0','新增菜单','pig','admin','2019-04-11 16:11:27',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','13','0',NULL,1),(75,'0','更新角色菜单','pig','admin','2019-04-11 16:15:20',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/role/menu','PUT','roleId=%5B3%5D&menuIds=%5B5000%2C5003%2C7000%2C7100%2C7200%2C7300%2C7400%2C7500%2C7600%2C8000%2C9000%2C9999%2C%5D','38','0',NULL,1),(76,'0','更新菜单','pig','admin','2019-04-11 16:23:32',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','17','0',NULL,1),(77,'0','更新菜单','pig','admin','2019-04-11 16:23:45',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','15','0',NULL,1),(78,'0','更新菜单','pig','admin','2019-04-11 16:24:35',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','17','0',NULL,1),(79,'0','更新菜单','pig','admin','2019-04-11 16:24:50',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','15','0',NULL,1),(80,'0','更新菜单','pig','admin','2019-04-11 16:25:05',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(81,'0','更新菜单','pig','admin','2019-04-11 16:25:16',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','17','0',NULL,1),(82,'0','更新菜单','pig','admin','2019-04-11 16:27:13',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','17','0',NULL,1),(83,'0','更新角色菜单','pig','admin','2019-04-11 16:28:52',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/role/menu','PUT','roleId=%5B3%5D&menuIds=%5B7000%2C7100%2C7200%2C7300%2C7400%2C7500%2C7600%2C8000%2C9000%2C%5D','28','0',NULL,1),(84,'0','更新菜单','pig','admin','2019-04-11 16:31:54',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(85,'0','修改路由','pig','admin','2019-04-12 10:13:38',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/route','PUT','','161','0',NULL,1),(86,'0','更新菜单','pig','admin','2019-04-12 10:49:02',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','48','0',NULL,1),(87,'0','更新菜单','pig','admin','2019-04-12 10:51:19',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','18','0',NULL,1),(88,'0','更新菜单','pig','admin','2019-04-12 10:51:29',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(89,'0','更新菜单','pig','admin','2019-04-12 10:51:46',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','18','0',NULL,1),(90,'0','更新菜单','pig','admin','2019-04-12 10:51:57',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(91,'0','删除部门','pig','admin','2019-04-15 13:34:10',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept/1','DELETE','','119','0',NULL,1),(92,'0','删除部门','pig','admin','2019-04-15 13:34:12',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept/2','DELETE','','33','0',NULL,1),(93,'0','添加部门','pig','admin','2019-04-15 13:34:29',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept','POST','','50','0',NULL,1),(94,'0','添加部门','pig','admin','2019-04-15 13:35:56',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept','POST','','29','0',NULL,1),(95,'0','删除部门','pig','admin','2019-04-15 13:36:07',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept/0','DELETE','','16','0',NULL,1),(96,'0','删除部门','pig','admin','2019-04-15 13:36:12',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept/0','DELETE','','14','0',NULL,1),(97,'0','添加部门','pig','admin','2019-04-15 13:36:48',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept','POST','','33','0',NULL,1),(98,'0','添加部门','pig','admin','2019-04-15 13:40:51',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/dept','POST','','27','0',NULL,1),(99,'0','更新用户信息','pig','admin','2019-04-15 13:41:20',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/user','PUT','','95','0',NULL,1),(100,'0','更新用户信息','pig','admin','2019-04-15 13:41:27',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/user','PUT','','33','0',NULL,1),(101,'0','更新用户信息','pig','admin','2019-04-15 13:41:32',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/user','PUT','','35','0',NULL,1),(102,'0','更新菜单','pig','admin','2019-04-15 16:22:12',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','35','0',NULL,1),(103,'0','更新菜单','pig','admin','2019-04-15 16:22:29',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','21','0',NULL,1),(104,'0','更新菜单','pig','admin','2019-04-15 16:26:29',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','8','0',NULL,1),(105,'0','添加终端','pig','admin','2019-04-16 10:31:42',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/client','POST','','24','0',NULL,1),(106,'0','新增菜单','pig','admin','2019-05-06 17:58:36',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','23','0',NULL,1),(107,'0','更新菜单','pig','admin','2019-05-06 17:59:06',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','41','0',NULL,1),(108,'0','更新菜单','pig','admin','2019-05-06 17:59:19',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(109,'0','新增菜单','pig','admin','2019-05-06 17:59:57',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','8','0',NULL,1),(110,'0','更新菜单','pig','admin','2019-05-06 18:00:11',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','10','0',NULL,1),(111,'0','新增菜单','pig','admin','2019-05-06 18:00:49',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','14','0',NULL,1),(112,'0','更新菜单','pig','admin','2019-05-06 18:01:01',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','14','0',NULL,1),(113,'0','新增菜单','pig','admin','2019-05-06 18:03:41',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','13','0',NULL,1),(114,'0','更新菜单','pig','admin','2019-05-06 18:03:53',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','18','0',NULL,1),(115,'0','新增菜单','pig','admin','2019-05-06 18:04:28',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','POST','','16','0',NULL,1),(116,'0','更新菜单','pig','admin','2019-05-06 18:04:45',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','9','0',NULL,1),(117,'0','更新角色菜单','pig','admin','2019-05-06 18:06:04',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/role/menu','PUT','roleId=%5B3%5D&menuIds=%5B7000%2C7100%2C7200%2C7300%2C7400%2C7500%2C7600%2C8000%2C9000%2C9100%2C9200%2C9300%2C9400%2C9500%2C%5D','82','0',NULL,1),(118,'0','更新菜单','pig','admin','2019-05-08 09:59:37',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','46','0',NULL,1),(119,'0','更新菜单','pig','admin','2019-05-08 09:59:39',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(120,'0','更新菜单','pig','admin','2019-05-08 09:59:43',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','16','0',NULL,1),(121,'0','更新菜单','pig','admin','2019-05-08 09:59:46',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','9','0',NULL,1),(122,'0','更新菜单','pig','admin','2019-05-08 09:59:49',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','18','0',NULL,1),(123,'0','修改个人信息','pig','usual','2019-05-09 15:34:35',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/user/edit','PUT','','49','0',NULL,1),(124,'0','修改个人信息','pig','admin','2019-05-09 15:35:27',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/user/edit','PUT','','39','0',NULL,1),(125,'0','更新菜单','pig','admin','2019-05-09 16:35:30',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','43','0',NULL,1),(126,'0','更新菜单','pig','admin','2019-05-09 16:35:35',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','18','0',NULL,1),(127,'0','更新菜单','pig','admin','2019-05-09 16:35:39',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','17','0',NULL,1),(128,'0','更新菜单','pig','admin','2019-05-09 16:35:42',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','17','0',NULL,1),(129,'0','更新菜单','pig','admin','2019-05-09 16:35:44',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu','PUT','','18','0',NULL,1),(130,'0','删除菜单','pig','admin','2019-05-09 17:24:39',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu/9200','DELETE','','87','0',NULL,1),(131,'0','删除菜单','pig','admin','2019-05-09 17:24:42',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36','/menu/9300','DELETE','','22','0',NULL,1);
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  `name` varchar(32) NOT NULL COMMENT '菜单名称',
  `permission` varchar(32) DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) DEFAULT NULL COMMENT '前端URL',
  `parent_id` int(11) DEFAULT NULL COMMENT '父菜单ID',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `component` varchar(64) DEFAULT NULL COMMENT 'VUE页面',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `keep_alive` char(1) DEFAULT '0' COMMENT '0-开启，1- 关闭',
  `type` char(1) DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '逻辑删除标记(0--正常 1--删除)',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (2,'主数据管理',NULL,'/mdm',-1,'icon-gtsquanjushiwufuwuGTS','Layout',2,'0','0','2019-04-11 06:49:26','2019-04-11 07:42:01','1'),(1000,'权限管理',NULL,'/upms',-1,'icon-quanxianguanli','Layout',0,'0','0','2018-09-28 00:29:53','2018-09-28 00:53:01','0'),(1100,'用户管理',NULL,'user',1000,'icon-yonghuguanli','views/admin/user/index',1,'0','0','2017-11-02 14:24:37','2018-09-28 01:00:41','0'),(1101,'用户新增','sys_user_add',NULL,1100,NULL,NULL,NULL,'0','1','2017-11-08 01:52:09','2018-09-28 01:06:34','0'),(1102,'用户修改','sys_user_edit',NULL,1100,NULL,NULL,NULL,'0','1','2017-11-08 01:52:48','2018-09-28 01:06:37','0'),(1103,'用户删除','sys_user_del',NULL,1100,NULL,NULL,NULL,'0','1','2017-11-08 01:54:01','2018-09-28 01:06:42','0'),(1200,'菜单管理',NULL,'menu',1000,'icon-caidanguanli','views/admin/menu/index',2,'0','0','2017-11-08 01:57:27','2018-09-28 01:00:45','0'),(1201,'菜单新增','sys_menu_add',NULL,1200,NULL,NULL,NULL,'0','1','2017-11-08 02:15:53','2018-09-28 01:07:16','0'),(1202,'菜单修改','sys_menu_edit',NULL,1200,NULL,NULL,NULL,'0','1','2017-11-08 02:16:23','2018-09-28 01:07:18','0'),(1203,'菜单删除','sys_menu_del',NULL,1200,NULL,NULL,NULL,'0','1','2017-11-08 02:16:43','2018-09-28 01:07:22','0'),(1300,'角色管理',NULL,'role',1000,'icon-jiaoseguanli','views/admin/role/index',3,'0','0','2017-11-08 02:13:37','2018-09-28 01:00:48','0'),(1301,'角色新增','sys_role_add',NULL,1300,NULL,NULL,NULL,'0','1','2017-11-08 02:14:18','2018-09-28 01:07:46','0'),(1302,'角色修改','sys_role_edit',NULL,1300,NULL,NULL,NULL,'0','1','2017-11-08 02:14:41','2018-09-28 01:07:49','0'),(1303,'角色删除','sys_role_del',NULL,1300,NULL,NULL,NULL,'0','1','2017-11-08 02:14:59','2018-09-28 01:07:53','0'),(1304,'分配权限','sys_role_perm',NULL,1300,NULL,NULL,NULL,'0','1','2018-04-19 23:22:55','2018-09-28 01:13:23','0'),(1400,'部门管理',NULL,'dept',1000,'icon-web-icon-','views/admin/dept/index',4,'0','0','2018-01-20 05:17:19','2018-12-09 08:35:12','0'),(1401,'部门新增','sys_dept_add',NULL,1400,NULL,NULL,NULL,'0','1','2018-01-20 06:56:16','2018-09-28 01:08:13','0'),(1402,'部门修改','sys_dept_edit',NULL,1400,NULL,NULL,NULL,'0','1','2018-01-20 06:56:59','2018-09-28 01:08:16','0'),(1403,'部门删除','sys_dept_del',NULL,1400,NULL,NULL,NULL,'0','1','2018-01-20 06:57:28','2018-09-28 01:08:18','0'),(2000,'系统管理',NULL,'/admin',-1,'icon-xitongguanli','Layout',1,'0','0','2017-11-07 12:56:00','2018-09-28 00:53:18','0'),(2100,'日志管理',NULL,'log',2000,'icon-rizhiguanli','views/admin/log/index',5,'0','0','2017-11-20 06:06:22','2018-09-28 01:01:52','0'),(2101,'日志删除','sys_log_del',NULL,2100,NULL,NULL,NULL,'0','1','2017-11-20 12:37:37','2018-09-28 01:08:44','0'),(2200,'字典管理',NULL,'dict',2000,'icon-navicon-zdgl','views/admin/dict/index',6,'0','0','2017-11-29 03:30:52','2018-09-28 01:01:47','0'),(2201,'字典删除','sys_dict_del',NULL,2200,NULL,NULL,NULL,'0','1','2017-11-29 03:30:11','2018-09-28 01:09:10','0'),(2202,'字典新增','sys_dict_add',NULL,2200,NULL,NULL,NULL,'0','1','2018-05-11 14:34:55','2018-09-28 01:09:12','0'),(2203,'字典修改','sys_dict_edit',NULL,2200,NULL,NULL,NULL,'0','1','2018-05-11 14:36:03','2018-09-28 01:09:16','0'),(2300,'代码生成','','gen',2000,'icon-weibiaoti46','views/gen/index',8,'0','0','2018-01-20 05:17:19','2018-11-23 21:21:01','0'),(2400,'终端管理','','client',2000,'icon-shouji','views/admin/client/index',9,'0','0','2018-01-20 05:17:19','2018-09-28 01:01:43','0'),(2401,'客户端新增','sys_client_add',NULL,2400,'1',NULL,NULL,'0','1','2018-05-15 13:35:18','2018-09-28 01:10:25','0'),(2402,'客户端修改','sys_client_edit',NULL,2400,NULL,NULL,NULL,'0','1','2018-05-15 13:37:06','2018-09-28 01:10:27','0'),(2403,'客户端删除','sys_client_del',NULL,2400,NULL,NULL,NULL,'0','1','2018-05-15 13:39:16','2018-09-28 01:10:30','0'),(2500,'密钥管理','','social',2000,'icon-miyue','views/admin/social/index',10,'0','0','2018-01-20 05:17:19','2018-09-28 01:01:41','0'),(2501,'密钥新增','generator_syssocialdetails_add',NULL,2500,'1',NULL,0,'0','1','2018-05-15 13:35:18','2018-09-28 01:11:02','0'),(2502,'密钥修改','generator_syssocialdetails_edit',NULL,2500,'1',NULL,1,'0','1','2018-05-15 13:35:18','2018-09-28 01:11:04','0'),(2503,'密钥删除','generator_syssocialdetails_del',NULL,2500,'1',NULL,2,'0','1','2018-05-15 13:35:18','2018-09-28 01:11:06','0'),(2600,'令牌管理',NULL,'token',2000,'icon-denglvlingpai','views/admin/token/index',11,'0','0','2018-09-03 21:58:41','2018-09-28 01:01:38','0'),(2601,'令牌删除','sys_token_del',NULL,2600,NULL,NULL,1,'0','1','2018-09-03 21:59:50','2018-09-28 01:11:24','0'),(2700,'动态路由',NULL,'route',2000,'icon-luyou','views/admin/route/index',12,'0','0','2018-09-03 21:58:41','2018-09-28 01:01:38','0'),(3000,'系统监控',NULL,'/daemon',-1,'icon-msnui-supervise','Layout',2,'0','0','2018-07-26 17:13:21','2018-09-28 00:53:24','0'),(3100,'服务监控',NULL,'http://127.0.0.1:5001',3000,'icon-server',NULL,0,'0','0','2018-06-26 02:50:32','2018-12-11 09:17:07','0'),(3200,'接口文档',NULL,'http://127.0.0.1:9999/swagger-ui.html',3000,'icon-wendang',NULL,1,'0','0','2018-06-26 02:50:32','2018-09-28 01:05:16','0'),(3300,'事务监控',NULL,'tx',3000,'icon-gtsquanjushiwufuwuGTS','views/tx/index',5,'0','0','2018-08-19 03:02:39','2018-11-23 06:25:08','0'),(3400,'在线事务',NULL,'model',3000,'icon-online','views/tx/model',6,'0','0','2018-08-19 03:32:04','2018-11-23 06:25:14','0'),(3500,'任务监控',NULL,'http://139.224.200.249:8899',3000,'icon-msnui-supervise',NULL,7,'0','0','2018-06-26 02:50:32','2018-09-28 01:03:33','0'),(3600,'任务轨迹','','status-trace-log',3000,'icon-guiji','views/daemon/status-trace-log/index',8,'0','0','2018-01-20 05:17:19','2018-11-23 22:34:52','0'),(3601,'删除任务轨迹','daemon_status_trace_log_del',NULL,3600,'1',NULL,2,'0','1','2018-05-15 13:35:18','2018-11-23 22:37:31','0'),(3700,'调用拓扑',NULL,'http://139.224.200.249:8081',3000,'icon-line',NULL,10,'0','0','2018-01-25 03:08:52','2018-09-28 01:04:29','0'),(3800,'缓存状态',NULL,'http://139.224.200.249:8585',3000,'icon-qingchuhuancun',NULL,12,'0','0','2018-01-23 02:56:11','2018-09-28 01:13:56','0'),(3900,'任务日志','','execution-log',3000,'icon-guiji','views/daemon/execution-log/index',8,'0','0','2018-01-20 05:17:19','2018-11-23 22:34:52','0'),(3901,'删除日志','daemon_execution_log_del',NULL,3900,'1',NULL,2,'0','1','2018-05-15 13:35:18','2018-11-23 22:39:03','0'),(4000,'协同管理',NULL,'/activti',-1,'icon-kuaisugongzuoliu_o','Layout',3,'0','0','2018-09-25 17:38:13','2018-09-28 00:58:24','0'),(4100,'模型管理',NULL,'activiti',4000,'icon-weibiaoti13','views/activiti/index',1,'0','0','2018-09-25 17:39:07','2018-12-09 08:35:16','0'),(4101,'模型管理','act_model_manage',NULL,4100,'1',NULL,0,'0','1','2018-05-15 13:35:18','2018-09-28 01:12:07','0'),(4200,'流程管理',NULL,'process',4000,'icon-liucheng','views/activiti/process',2,'0','0','2018-09-25 22:41:05','2018-11-23 06:25:33','0'),(4201,'流程管理','act_process_manage',NULL,4200,'1',NULL,0,'0','1','2018-05-15 13:35:18','2018-09-28 01:12:07','0'),(4300,'请假管理','','leavebill',4000,'icon-qingjia','views/activiti/leave',3,'0','0','2018-01-20 05:17:19','2018-12-09 08:35:20','0'),(4301,'请假新增','act_leavebill_add',NULL,4300,'1',NULL,0,'0','1','2018-05-15 13:35:18','2018-09-28 01:12:07','0'),(4302,'请假修改','act_leavebill_edit',NULL,4300,'1',NULL,1,'0','1','2018-05-15 13:35:18','2018-09-28 01:12:09','0'),(4303,'请假删除','act_leavebill_del',NULL,4300,'1',NULL,2,'0','1','2018-05-15 13:35:18','2018-09-28 01:12:14','0'),(4400,'待办任务',NULL,'task',4000,'icon-renwu','views/activiti/task',4,'0','0','2018-09-27 01:52:31','2018-12-09 08:35:26','0'),(4401,'流程管理','act_task_manage',NULL,4400,'1',NULL,0,'0','1','2018-05-15 13:35:18','2018-09-28 01:12:07','0'),(5000,'一级菜单',NULL,'/crud',-1,'icon-caidanguanli','',4,'0','0','2018-08-27 17:50:22','2018-09-28 00:58:20','0'),(5001,'一级菜单',NULL,'index',5000,'icon-caidanguanli','views/crud/index',1,'0','0','2018-08-27 17:50:48','2018-11-21 09:48:19','1'),(5002,'二级菜单',NULL,'crud',5001,'icon-caidanguanli','views/crud/index',1,'0','0','2018-08-27 17:51:23','2018-11-21 09:47:40','1'),(5003,'二级菜单',NULL,'',5000,'icon-caidanguanli','',1,'0','0','2018-11-21 09:49:18','2018-11-21 09:53:25','0'),(5004,'二级菜单',NULL,'index',5003,'icon-caidanguanli','views/crud/index',1,'0','0','2018-11-21 09:53:51','2018-12-20 06:26:53','1'),(6000,'系统官网',NULL,'https://pig4cloud.com#',-1,'icon-guanwang','',5,'0','0','2018-09-26 18:26:36','2018-11-17 08:18:50','1'),(7000,'主数据管理',NULL,'/mdm',-1,'icon-gtsquanjushiwufuwuGTS','Layout',3,'0','0','2019-04-11 07:43:57','2019-04-11 07:44:37','0'),(7100,'模型管理',NULL,'model',7000,'icon-server','views/mdm/mdm/model/index',1,'0','0','2019-04-11 07:52:16','2019-04-11 08:23:32','0'),(7200,'实体管理',NULL,'entity',7000,'icon-denglvlingpai','views/mdm/mdm/entity/index',2,'0','0','2019-04-11 08:09:18','2019-04-11 08:23:45','0'),(7300,'属性管理',NULL,'attr',7000,'icon-miyue','views/mdm/mdm/attr/index',3,'0','0','2019-04-11 08:09:49','2019-04-11 08:24:35','0'),(7400,'规则管理',NULL,'rule',7000,'icon-wendang','views/mdm/mdm/rule/index',4,'0','0','2019-04-11 08:10:19','2019-04-11 08:24:50','0'),(7500,'索引管理',NULL,'index',7000,'icon-guiji','views/mdm/mdm/index/index',5,'0','0','2019-04-11 08:10:49','2019-04-11 08:25:04','0'),(7600,'视图管理',NULL,'view',7000,'icon-navicon-zdgl','views/mdm/mdm/view/index',6,'0','0','2019-04-11 08:11:27','2019-04-11 08:25:16','0'),(8000,'资源管理',NULL,'/resource',-1,'icon-weibiaoti46','views/mdm/resource/index',3,'0','0','2019-04-11 07:48:01','2019-04-15 08:22:11','0'),(9000,'同步管理',NULL,'/sync',-1,'icon-web-icon-','views/mdm/sync/index',3,'0','0','2019-04-11 07:48:39','2019-04-15 08:22:29','0'),(9100,'节点管理',NULL,'node',9000,'icon-web-icon-','views/mdm/sync/node/index',1,'0','0','2019-05-06 09:58:35','2019-05-06 09:59:05','0'),(9200,'组管理','','group',9000,'icon-server','views/mdm/sync/group/index',2,'0','0','2019-05-06 09:59:57','2019-05-09 09:24:39','1'),(9300,'路由管理',NULL,'router',9000,'icon-guiji','views/mdm/sync/router/index',3,'0','0','2019-05-06 10:00:48','2019-05-09 09:24:42','1'),(9400,'同步任务',NULL,'sync',9000,'icon-gtsquanjushiwufuwuGTS','views/mdm/sync/sync/index',4,'0','0','2019-05-06 10:03:41','2019-05-06 10:03:53','0'),(9500,'数据转换',NULL,'trans',9000,'icon-navicon-zdgl','views/mdm/sync/trans/index',5,'0','0','2019-05-06 10:04:28','2019-05-06 10:04:45','0'),(9999,'系统官网',NULL,'https://pig4cloud.com',-1,'icon-guanwangfangwen',NULL,9,'0','0','2019-01-17 09:05:19','2019-01-17 09:29:06','0');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oauth_client_details`
--

DROP TABLE IF EXISTS `sys_oauth_client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_oauth_client_details` (
  `client_id` varchar(32) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` varchar(256) DEFAULT NULL,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属租户',
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='终端信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oauth_client_details`
--

LOCK TABLES `sys_oauth_client_details` WRITE;
/*!40000 ALTER TABLE `sys_oauth_client_details` DISABLE KEYS */;
INSERT INTO `sys_oauth_client_details` VALUES ('app',NULL,'app','server','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true',1),('daemon',NULL,'daemon','server','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true',1),('gen',NULL,'gen','server','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true',1),('mdm','','mdm','server','password,refresh_token,authorization_code,client_credentials','','',NULL,NULL,'','true',1),('pig',NULL,'pig','server','password,refresh_token,authorization_code,client_credentials','http://localhost:4040/sso1/login,http://localhost:4041/sso1/login',NULL,NULL,NULL,NULL,'true',1),('test',NULL,'test','server','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true',1);
/*!40000 ALTER TABLE `sys_oauth_client_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `role_code` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `role_desc` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ds_type` char(1) COLLATE utf8mb4_bin NOT NULL DEFAULT '2' COMMENT '数据权限类型',
  `ds_scope` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据权限范围',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  `tenant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE KEY `role_idx1_role_code` (`role_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='系统角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'管理员','ROLE_ADMIN','管理员','0','2','2017-10-29 07:45:51','2018-12-26 06:09:11','0',1),(2,'ROLE_CQQ','ROLE_CQQ','ROLE_CQQ','2',NULL,'2018-11-11 11:42:26','2018-12-26 06:09:07','0',2),(3,'usual','usual','普通用户','1','1,2','2019-04-11 03:07:12',NULL,'0',1);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (1,1000),(1,1100),(1,1101),(1,1102),(1,1103),(1,1200),(1,1201),(1,1202),(1,1203),(1,1300),(1,1301),(1,1302),(1,1303),(1,1304),(1,1400),(1,1401),(1,1402),(1,1403),(1,2000),(1,2100),(1,2101),(1,2200),(1,2201),(1,2202),(1,2203),(1,2300),(1,2400),(1,2401),(1,2402),(1,2403),(1,2500),(1,2501),(1,2502),(1,2503),(1,2600),(1,2601),(1,2700),(1,3000),(1,3100),(1,3200),(1,3300),(1,3400),(1,3500),(1,3600),(1,3601),(1,3700),(1,3800),(1,3900),(1,3901),(1,4000),(1,4100),(1,4101),(1,4200),(1,4201),(1,4300),(1,4301),(1,4302),(1,4303),(1,4400),(1,4401),(1,9999),(2,1000),(2,1100),(2,1101),(2,1102),(2,1103),(2,1200),(2,1201),(2,1202),(2,1203),(2,1300),(2,1301),(2,1302),(2,1303),(2,1304),(2,1400),(2,1401),(2,1402),(2,1403),(3,7000),(3,7100),(3,7200),(3,7300),(3,7400),(3,7500),(3,7600),(3,8000),(3,9000),(3,9100),(3,9400),(3,9500);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_route_conf`
--

DROP TABLE IF EXISTS `sys_route_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_route_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `route_name` varchar(30) DEFAULT NULL COMMENT '路由名称',
  `route_id` varchar(30) NOT NULL DEFAULT '' COMMENT '路由ID',
  `predicates` json DEFAULT NULL COMMENT '断言',
  `filters` json DEFAULT NULL COMMENT '过滤器',
  `uri` varchar(50) DEFAULT NULL,
  `order` int(2) DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='路由配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_route_conf`
--

LOCK TABLES `sys_route_conf` WRITE;
/*!40000 ALTER TABLE `sys_route_conf` DISABLE KEYS */;
INSERT INTO `sys_route_conf` VALUES (1,'工作流管理模块','pigx-activiti','[{\"args\": {\"_genkey_0\": \"/act/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(2,'认证中心','pigx-auth','[{\"args\": {\"_genkey_0\": \"/auth/**\"}, \"name\": \"Path\"}]','[{\"args\": {}, \"name\": \"ValidateCodeGatewayFilter\"}, {\"args\": {}, \"name\": \"PasswordDecoderFilter\"}]','lb://pigx-auth',0,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(3,'代码生成模块','pigx-codegen','[{\"args\": {\"_genkey_0\": \"/gen/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-codegen',0,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(4,'定时任务模块','pigx-daemon','[{\"args\": {\"_genkey_0\": \"/daemon/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-daemon',0,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(5,'分布式事务模块','pigx-tx-manager','[{\"args\": {\"_genkey_0\": \"/tx/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-tx-manager',0,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(6,'通用权限模块','pigx-upms-biz','[{\"args\": {\"_genkey_0\": \"/admin/**\"}, \"name\": \"Path\"}]','[{\"args\": {\"key-resolver\": \"#{@remoteAddrKeyResolver}\", \"redis-rate-limiter.burstCapacity\": \"20\", \"redis-rate-limiter.replenishRate\": \"10\"}, \"name\": \"RequestRateLimiter\"}, {\"args\": {\"name\": \"default\", \"fallbackUri\": \"forward:/fallback\"}, \"name\": \"Hystrix\"}]','lb://pigx-upms-biz',0,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(7,'工作流长链接支持1','pigx-activiti-ws-1','[{\"args\": {\"_genkey_0\": \"/act/ws/info\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(8,'工作流长链接支持2','pigx-activiti-ws-2','[{\"args\": {\"_genkey_0\": \"/act/ws/**\"}, \"name\": \"Path\"}]','[]','lb:ws://pigx-activiti',100,'2019-01-17 16:42:50','2019-04-08 14:52:34','1'),(9,'工作流管理模块','pigx-activiti','[{\"args\": {\"_genkey_0\": \"/act/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(10,'认证中心','pigx-auth','[{\"args\": {\"_genkey_0\": \"/auth/**\"}, \"name\": \"Path\"}]','[{\"args\": {}, \"name\": \"ValidateCodeGatewayFilter\"}, {\"args\": {}, \"name\": \"PasswordDecoderFilter\"}]','lb://pigx-auth',0,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(11,'代码生成模块','pigx-codegen','[{\"args\": {\"_genkey_0\": \"/gen/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-codegen',0,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(12,'定时任务模块','pigx-daemon','[{\"args\": {\"_genkey_0\": \"/daemon/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-daemon',0,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(13,'分布式事务模块','pigx-tx-manager','[{\"args\": {\"_genkey_0\": \"/tx/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-tx-manager',0,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(14,'通用权限模块','pigx-upms-biz','[{\"args\": {\"_genkey_0\": \"/admin/**\"}, \"name\": \"Path\"}]','[{\"args\": {\"key-resolver\": \"#{@remoteAddrKeyResolver}\", \"redis-rate-limiter.burstCapacity\": \"20\", \"redis-rate-limiter.replenishRate\": \"10\"}, \"name\": \"RequestRateLimiter\"}, {\"args\": {\"name\": \"default\", \"fallbackUri\": \"forward:/fallback\"}, \"name\": \"Hystrix\"}]','lb://pigx-upms-biz',0,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(15,'工作流长链接支持1','pigx-activiti-ws-1','[{\"args\": {\"_genkey_0\": \"/act/ws/info\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(16,'工作流长链接支持2','pigx-activiti-ws-2','[{\"args\": {\"_genkey_0\": \"/act/ws/**\"}, \"name\": \"Path\"}]','[]','lb:ws://pigx-activiti',100,'2019-04-08 14:52:34','2019-04-08 14:52:35','1'),(17,'工作流管理模块','pigx-activiti','[{\"args\": {\"_genkey_0\": \"/act/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(18,'认证中心','pigx-auth','[{\"args\": {\"_genkey_0\": \"/auth/**\"}, \"name\": \"Path\"}]','[{\"args\": {}, \"name\": \"ValidateCodeGatewayFilter\"}, {\"args\": {}, \"name\": \"PasswordDecoderFilter\"}]','lb://pigx-auth',0,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(19,'代码生成模块','pigx-codegen','[{\"args\": {\"_genkey_0\": \"/gen/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-codegen',0,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(20,'定时任务模块','pigx-daemon','[{\"args\": {\"_genkey_0\": \"/daemon/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-daemon',0,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(21,'分布式事务模块','pigx-tx-manager','[{\"args\": {\"_genkey_0\": \"/tx/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-tx-manager',0,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(22,'通用权限模块','pigx-upms-biz','[{\"args\": {\"_genkey_0\": \"/admin/**\"}, \"name\": \"Path\"}]','[{\"args\": {\"key-resolver\": \"#{@remoteAddrKeyResolver}\", \"redis-rate-limiter.burstCapacity\": \"20\", \"redis-rate-limiter.replenishRate\": \"10\"}, \"name\": \"RequestRateLimiter\"}, {\"args\": {\"name\": \"default\", \"fallbackUri\": \"forward:/fallback\"}, \"name\": \"Hystrix\"}]','lb://pigx-upms-biz',0,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(23,'工作流长链接支持1','pigx-activiti-ws-1','[{\"args\": {\"_genkey_0\": \"/act/ws/info\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(24,'工作流长链接支持2','pigx-activiti-ws-2','[{\"args\": {\"_genkey_0\": \"/act/ws/**\"}, \"name\": \"Path\"}]','[]','lb:ws://pigx-activiti',100,'2019-04-08 14:52:35','2019-04-11 14:04:28','1'),(25,'工作流管理模块','pigx-activiti','[{\"args\": {\"_genkey_0\": \"/act/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(26,'认证中心','pigx-auth','[{\"args\": {\"_genkey_0\": \"/auth/**\"}, \"name\": \"Path\"}]','[{\"args\": {}, \"name\": \"ValidateCodeGatewayFilter\"}, {\"args\": {}, \"name\": \"PasswordDecoderFilter\"}]','lb://pigx-auth',0,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(27,'代码生成模块','pigx-codegen','[{\"args\": {\"_genkey_0\": \"/gen/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-codegen',0,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(28,'定时任务模块','pigx-daemon','[{\"args\": {\"_genkey_0\": \"/daemon/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-daemon',0,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(29,'分布式事务模块','pigx-tx-manager','[{\"args\": {\"_genkey_0\": \"/tx/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-tx-manager',0,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(30,'通用权限模块','pigx-upms-biz','[{\"args\": {\"_genkey_0\": \"/admin/**\"}, \"name\": \"Path\"}]','[{\"args\": {\"key-resolver\": \"#{@remoteAddrKeyResolver}\", \"redis-rate-limiter.burstCapacity\": \"20\", \"redis-rate-limiter.replenishRate\": \"10\"}, \"name\": \"RequestRateLimiter\"}, {\"args\": {\"name\": \"default\", \"fallbackUri\": \"forward:/fallback\"}, \"name\": \"Hystrix\"}]','lb://pigx-upms-biz',0,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(31,'工作流长链接支持1','pigx-activiti-ws-1','[{\"args\": {\"_genkey_0\": \"/act/ws/info\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(32,'工作流长链接支持2','pigx-activiti-ws-2','[{\"args\": {\"_genkey_0\": \"/act/ws/**\"}, \"name\": \"Path\"}]','[]','lb:ws://pigx-activiti',100,'2019-04-11 14:04:28','2019-04-11 14:33:52','1'),(33,'工作流管理模块','pigx-activiti','[{\"args\": {\"_genkey_0\": \"/act/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(34,'认证中心','pigx-auth','[{\"args\": {\"_genkey_0\": \"/auth/**\"}, \"name\": \"Path\"}]','[{\"args\": {}, \"name\": \"ValidateCodeGatewayFilter\"}, {\"args\": {}, \"name\": \"PasswordDecoderFilter\"}]','lb://pigx-auth',0,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(35,'代码生成模块','pigx-codegen','[{\"args\": {\"_genkey_0\": \"/gen/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-codegen',0,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(36,'定时任务模块','pigx-daemon','[{\"args\": {\"_genkey_0\": \"/daemon/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-daemon',0,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(37,'分布式事务模块','pigx-tx-manager','[{\"args\": {\"_genkey_0\": \"/tx/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-tx-manager',0,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(38,'通用权限模块','pigx-upms-biz','[{\"args\": {\"_genkey_0\": \"/admin/**\"}, \"name\": \"Path\"}]','[{\"args\": {\"key-resolver\": \"#{@remoteAddrKeyResolver}\", \"redis-rate-limiter.burstCapacity\": \"20\", \"redis-rate-limiter.replenishRate\": \"10\"}, \"name\": \"RequestRateLimiter\"}, {\"args\": {\"name\": \"default\", \"fallbackUri\": \"forward:/fallback\"}, \"name\": \"Hystrix\"}]','lb://pigx-upms-biz',0,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(39,'工作流长链接支持1','pigx-activiti-ws-1','[{\"args\": {\"_genkey_0\": \"/act/ws/info\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(40,'工作流长链接支持2','pigx-activiti-ws-2','[{\"args\": {\"_genkey_0\": \"/act/ws/**\"}, \"name\": \"Path\"}]','[]','lb:ws://pigx-activiti',100,'2019-04-11 14:33:52','2019-04-12 10:13:37','1'),(41,'工作流管理模块','pigx-activiti','[{\"args\": {\"_genkey_0\": \"/act/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-12 10:13:37',NULL,'0'),(42,'主数据管理系统','mdm','[{\"args\": {\"_genkey_0\": \"/mdm/**\"}, \"name\": \"Path\"}]','[]','lb://mdm',0,'2019-04-12 10:13:37',NULL,'0'),(43,'认证中心','pigx-auth','[{\"args\": {\"_genkey_0\": \"/auth/**\"}, \"name\": \"Path\"}]','[{\"args\": {}, \"name\": \"ValidateCodeGatewayFilter\"}, {\"args\": {}, \"name\": \"PasswordDecoderFilter\"}]','lb://pigx-auth',0,'2019-04-12 10:13:37',NULL,'0'),(44,'代码生成模块','pigx-codegen','[{\"args\": {\"_genkey_0\": \"/gen/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-codegen',0,'2019-04-12 10:13:37',NULL,'0'),(45,'定时任务模块','pigx-daemon','[{\"args\": {\"_genkey_0\": \"/daemon/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-daemon',0,'2019-04-12 10:13:37',NULL,'0'),(46,'分布式事务模块','pigx-tx-manager','[{\"args\": {\"_genkey_0\": \"/tx/**\"}, \"name\": \"Path\"}]','[]','lb://pigx-tx-manager',0,'2019-04-12 10:13:37',NULL,'0'),(47,'通用权限模块','pigx-upms-biz','[{\"args\": {\"_genkey_0\": \"/admin/**\"}, \"name\": \"Path\"}]','[{\"args\": {\"key-resolver\": \"#{@remoteAddrKeyResolver}\", \"redis-rate-limiter.burstCapacity\": \"20\", \"redis-rate-limiter.replenishRate\": \"10\"}, \"name\": \"RequestRateLimiter\"}, {\"args\": {\"name\": \"default\", \"fallbackUri\": \"forward:/fallback\"}, \"name\": \"Hystrix\"}]','lb://pigx-upms-biz',0,'2019-04-12 10:13:37',NULL,'0'),(48,'工作流长链接支持1','pigx-activiti-ws-1','[{\"args\": {\"_genkey_0\": \"/act/ws/info\"}, \"name\": \"Path\"}]','[]','lb://pigx-activiti',0,'2019-04-12 10:13:37',NULL,'0'),(49,'工作流长链接支持2','pigx-activiti-ws-2','[{\"args\": {\"_genkey_0\": \"/act/ws/**\"}, \"name\": \"Path\"}]','[]','lb:ws://pigx-activiti',100,'2019-04-12 10:13:37',NULL,'0');
/*!40000 ALTER TABLE `sys_route_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_social_details`
--

DROP TABLE IF EXISTS `sys_social_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_social_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `type` varchar(16) NOT NULL COMMENT '类型',
  `remark` varchar(64) DEFAULT NULL COMMENT '描述',
  `app_id` varchar(64) NOT NULL COMMENT 'appid',
  `app_secret` varchar(64) NOT NULL COMMENT 'app_secret',
  `redirect_url` varchar(128) DEFAULT NULL COMMENT '回调地址',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属租户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统社交登录账号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_social_details`
--

LOCK TABLES `sys_social_details` WRITE;
/*!40000 ALTER TABLE `sys_social_details` DISABLE KEYS */;
INSERT INTO `sys_social_details` VALUES (1,'WX','微信互联参数','wxd1678d3f83b1d83a','6ddb043f94da5d2172926abe8533504f','daoweicloud.com','2018-08-16 14:24:25','2018-12-04 11:50:57','0',1);
/*!40000 ALTER TABLE `sys_social_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `salt` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '随机盐',
  `phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '简介',
  `avatar` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
  `dept_id` int(11) DEFAULT NULL COMMENT '部门ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `lock_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，9-锁定',
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `wx_openid` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信openid',
  `qq_openid` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'QQ openid',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属租户',
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `user_wx_openid` (`wx_openid`) USING BTREE,
  KEY `user_qq_openid` (`qq_openid`) USING BTREE,
  KEY `user_idx1_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','$2a$10$QOfWxxFyAMmEEmnuw9UI/..1s4B4eF/u9PzE2ZaGO.ij9YfmcUy.u',NULL,'17034642888','lengleng-a2554edde8ab4102bc167e423725885b.jpg',14,'2018-04-19 23:15:18','2019-05-09 07:35:27','0','0','o_0FT0uyg_H1vVy2H0JpSwlVGhWQ',NULL,1),(2,'admin','$2a$10$RpFJjxYiXdEsAGnWp/8fsOetMuOON96Ntk/Ym2M/RKRyU0GZseaDC',NULL,'17034642887',NULL,10,'2018-04-19 23:15:18','2019-01-09 03:06:24','0','0','o_0FT0uyg_H1vVy2H0JpSwlVGhWQ',NULL,2),(3,'xiang','$2a$10$XxMk3uytbSJESQMQnVRGOuv7olnSL8OChPUcHq9G65N5M0ueyPA1.',NULL,'18301253809',NULL,15,'2019-04-11 03:08:57','2019-04-15 05:41:27','0','0',NULL,NULL,1),(4,'usual','$2a$10$5bmewPaMZB2JnfXIU1FFbOomMTrumaamHSU6iF2ydQuwf6R02r5uK',NULL,'18301253809','lengleng-139abf9d545e43d8a0596e3e197a0c83.jpg',15,'2019-04-11 05:36:34','2019-05-09 07:34:34','0','0',NULL,NULL,1);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2),(3,3),(4,3);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-16 15:54:16
