-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: pigxx_ac
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
-- Table structure for table `act_evt_log`
--
use pigxx_ac;
DROP TABLE IF EXISTS `act_evt_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_evt_log`
--

LOCK TABLES `act_evt_log` WRITE;
/*!40000 ALTER TABLE `act_evt_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_evt_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_bytearray`
--

DROP TABLE IF EXISTS `act_ge_bytearray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_bytearray`
--

LOCK TABLES `act_ge_bytearray` WRITE;
/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
INSERT INTO `act_ge_bytearray` VALUES ('12510',1,'请教流程.bpmn20.xml','12509','<?xml version=\'1.0\' encoding=\'UTF-8\'?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.activiti.org/processdef\">\n  <process id=\"LeaveBill\" name=\"LeaveBill\" isExecutable=\"true\">\n    <startEvent id=\"sid-3AC5E563-E6E3-4777-B446-0476D884C11D\" name=\"提交\"/>\n    <userTask id=\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\" name=\"用户提交\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\"/>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\" name=\"组长审批\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\"/>\n      </extensionElements>\n    </userTask>\n    <endEvent id=\"sid-055910DB-1DE6-4BC4-B527-23FA719DE265\" name=\"结束\"/>\n    <sequenceFlow id=\"sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\" sourceRef=\"sid-3AC5E563-E6E3-4777-B446-0476D884C11D\" targetRef=\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\"/>\n    <sequenceFlow id=\"sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\" name=\"审批\" sourceRef=\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\" targetRef=\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\"/>\n    <sequenceFlow id=\"sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\" name=\"驳回\" sourceRef=\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\" targetRef=\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${flag.equals(\'驳回\')}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-69806265-B660-4B92-B7D9-8DE2A55C5079\" name=\"审批\" sourceRef=\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\" targetRef=\"sid-055910DB-1DE6-4BC4-B527-23FA719DE265\"/>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_LeaveBill\">\n    <bpmndi:BPMNPlane bpmnElement=\"LeaveBill\" id=\"BPMNPlane_LeaveBill\">\n      <bpmndi:BPMNShape bpmnElement=\"sid-3AC5E563-E6E3-4777-B446-0476D884C11D\" id=\"BPMNShape_sid-3AC5E563-E6E3-4777-B446-0476D884C11D\">\n        <omgdc:Bounds height=\"30.0\" width=\"30.0\" x=\"142.5\" y=\"142.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\" id=\"BPMNShape_sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"217.5\" y=\"117.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\" id=\"BPMNShape_sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"362.5\" y=\"116.99999999999997\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"sid-055910DB-1DE6-4BC4-B527-23FA719DE265\" id=\"BPMNShape_sid-055910DB-1DE6-4BC4-B527-23FA719DE265\">\n        <omgdc:Bounds height=\"28.0\" width=\"28.0\" x=\"533.8916946501957\" y=\"142.99999999999997\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-69806265-B660-4B92-B7D9-8DE2A55C5079\" id=\"BPMNEdge_sid-69806265-B660-4B92-B7D9-8DE2A55C5079\">\n        <omgdi:waypoint x=\"462.5\" y=\"156.99999999999997\"/>\n        <omgdi:waypoint x=\"533.8916946501957\" y=\"156.99999999999997\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\" id=\"BPMNEdge_sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\">\n        <omgdi:waypoint x=\"172.5\" y=\"157.0\"/>\n        <omgdi:waypoint x=\"217.5\" y=\"157.0\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\" id=\"BPMNEdge_sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\">\n        <omgdi:waypoint x=\"317.5\" y=\"157.0\"/>\n        <omgdi:waypoint x=\"362.5\" y=\"157.0\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\" id=\"BPMNEdge_sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\">\n        <omgdi:waypoint x=\"412.5\" y=\"196.99999999999997\"/>\n        <omgdi:waypoint x=\"412.5\" y=\"248.52429051146214\"/>\n        <omgdi:waypoint x=\"267.5\" y=\"248.52429051146214\"/>\n        <omgdi:waypoint x=\"267.5\" y=\"197.0\"/>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('12511',1,'请教流程.LeaveBill.png','12509','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0;\0\0\0\0\0K�\0\0�IDATx\�\�\��\�e\��.Vvw�ZYQZ\�M�\�r꭬�\�Q�^�E�X�AaR|Q^���L�/Z�Y\�$\Z�܄���b�Њ\\Zn\n������ٳ\�\�9\�\�3�\�\�9{\��\���\�y����\�U\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�`)�#jjj\�^�`��\�ӧ�x�h\�1mڴ4{�\�\r\�\�\"4*���E�̙3\'�[�.m߾\�h��~���\��>�\�\�9��hT\ZU���~J���gz��l\0\Z�FՂbF\�\�W:#����eШ4�Kq^����\�/�F�Q�C\rm\�\\�j�5=1mx>\�r|\�뮆\04*��\�kh˦\�i��C\�?\��ǈ�\�m^{a@�Ҩʺ�V>q\�^�S���\�v\04*���kh\�̑M\�P\�\�v\04*���kh�Ú���\�k/\�\0hT\Z�\Z2�\0�J�*\�\Z�M\�M\�P\�\�v\04*���kh\�ܱM\�P\�\�v\04*���k\�Տ�\�S�\�{f0�Z\�\�v\04*���k(\�3߶W\r\�׼\�j@�Ҩʿ��mKK\�ݰ�\�`���\�k/\�\0hT\ZU\�\�P�x�\�\�7�\Z�99���QiT\�WCY�]:#=>eH��Sq����,\�\0hT\ZUY\�ЁB��\04*���k�9!y\�Y-;\0\Z�FU\�5t��SjA\�Ш4���!C\rhT��c�!\0�J�RC���QiTj\�v\04*�J\r�!\�i\�ԩ�=nܸꫯ�����;���vw\�\�5}��\�O}��}y��\�\�Ǝ{ߌ3Nv�J\r������򘊊�~Y/�;K��%�B6\��Lv[u�\�Aq?\�%m�\�у��i��i���i��i�\�թ��.��\�u\�\�\����4a��\�+^9r\�pa\�ШԐ\Z\�x\�=�\�\�\�x�>Ԥf��\��t�\�QRF�\Zu\�\�_�zРA�#\�\�ܹ35עE�Ґ!CR��믹暓�C�RCj��e��S6&D�\�טӥK�\�<��Bй�O�>�&M�tP!��)S��x�,��v�J\r���UQQ�售닃Keee�\�O�f̘�V�X�^x\��o��/���\0̝;7]{\��v�\�\�\�֭ۋfyhW\�ƍ�\�~��\�~�\�SKX�|y�\�=z�a\�vԐ\Z*ˠsVR^.9��\�\��-ͱiӦ���}š\'<xvisC��$&��[�\���;lذ˄C\��ک���\�i:�\\rI>�s(\��\�8�\�\��\�\��\�/�pGK\�\�\�k�\'?�E9Q\�1�C\r���=:\rKWW]uU\�Rա�%�#F4^\�:޳M�0`�ӱG�5\�����/va\�PC�������\�\r:Ł�\�\�\�6�. ��^z\�\�;v�֖�\�\�\�]$\���J:\�t.ޣs�KW�[\�*\�\�c9�V�%�eqxy[x\�\�\�\�_�B\�1�C\r�ǬNl.n\rw\�y�\�\�F�\��.\�~8���8s��\�/v6�K�ҨԐ\Zz%��\�j�¦\�}y\�\�Z�\�QZ�K\�+\�*��\�;䦛nڕ\�P�K\�\���\��P4��@EE\�)\Z�F��\�PGu�Z����>?��\�[�\�yx�\�\� ]�Vq�\�Ϗ��hK�dֿ��K�hLn�\�G�ҨԐ\Z\�Ha��Z������Y�f�j?��;&\�ʴ��\�?mmmm���8\�NUU\�\��\�ox\�S�#�QiTjH\ruа�G�\��g���ޘ\�X�i�\�߰RW�Ut\�\�}{\�C=\�J��nݺ�\\��\�\�|4*��\\k(\�`�\�\�GC������}͚5\�\�G\�/oذ!?���\�ںu�\Z*�Z\�Y�\�R��\�\�0���[�+\�jE\��\�\�e�S؉2mڴ&o��\�\�۶m;�\�]�vm�<lٲ�$\Z:�x饗\��\���t뭷\�\�\�:\�t\�I\'5�\�|\�;{\�\�ȑ\�N\�\�k+W�L}��M7n̯?�\�S\���E�\�\"Ʒ��\�t\�G�ѣG7|-n�\�\'��\�Q7����˟�\�\�ү�\���\��\��׿�U\r��h\�~�+\�Z3;\�\�ifgG��\�y(>\�\�SO=�=\Z\�W\\�>�\�O�\�|\�3�\�|C*O<�Dz\�ߘ\��\�}>\�\�ٳ\�G�_4hP�\�\�>�>��7�.]�\�\�Q\�>�l��\�qb\�\�\�JK�.m�Z�����\�)\�\Z�0aB:\�c\�\�͛�\��\�\'�\�\�u\�]\�\�+�L�:u\�\��T>��O5���A�o�\�\�)������\�S�NM��\�c\�#\��_�\�B��7�!M�<9\�\�\�\�!(�\r�/\�\�\�o\�\'B\��\�\��\��\�\�F�f�\�bf�\��Ϋm�=;=z�\�P\��\r\r�p��hT?�\�\�׾��t\�w\�#ʏ�\��r4�\�?�|C�9�\�3\�w��\�|}�\��;��_?~|~�*q9�U|O�>}\�W���ň�~\�[\�\�\�{�\�7\�?\�@��\�\�Ni\�P,E��\�\�\��\��Af̘1)>\Z&����|d��;f��:\��O|\"����\�\�>q��^�z�e˖��\�_�V\�A|\�\�\�^xaZ�hQ\�\�򖷤׼\�5\�_�jv�^��F؉\�$j.B��S\Z�j\�NUUդ��\�\�l˰��;�D�\�ǙC�T{���\�\�\�NK>�`>^��\�\�\".\�~�\�{���ŉ0���8\�\����\�\��wٯ~��ӱ\����h@?�я�?�vb6 \�i��\�j�\�\�~uuu\Z0`@~9n/\�\Z;�UC�^zi�:\�lݛ\��\��\��3;tc\�/f_\na\'\�G�\�.\�\�\�g�{c,.ǈ\�K��\��\�{\���娨\�\�q=��\��¿\��C�\�G?�_�Z���|�\�y؉�K[\�ׯvJ�V�E�\�S;v\�smv~�\�l*��)\�\�]x)��xwKVbD��\�?�_�Ї>�G؉%�h^�z��*����p\��\�??oZ�.>F4\�\�y\�c\�G\�\��@Z�jU��h�\�z׻\�|I\��\�N\�\�P\�\�~\��\�����m��\'NlX�*���1l\�,\�O~����_~y�~�\��\�?�9�\�o�[~=\�r\�^�wĞ�w���\�a�����}@v��\�/\�ˡj�tj\�yv\�p\�L��z�\�ԖgP\�\Z�s\�x�\��;qvј\�)\\�w\��\�\�\�/\���\��?�)�����\�^#fp�\�\�}�ݗ/+Ļ\�h@Ç\�cħ\�\�Q,G|�_\�blP�e���[n�%>�#]�ߧp��FUZ5�\�#�\�:��\�g�:��;vz�\�o ��Z;1Ca�ꫯΗ�\��̙3�:�\�_��_�%��\�+��0^N<�Ćٚ�_/��Q1\�KY�Iz_{v�Uz}��\�p�w\�>s\�ϷE\�Y�hі\�\�-(\�\�=\�N\�Ν�0Q\���\'\�M\�\�\�\�Pv\�|4���\�#fa�\�p�M|\�k_�\�|\�F\��Mʱo\'�\\\\8p`\�\�Q\\�w\�\r7������ף�\�rZl��w�\�1�#\�x\��Q���\�;1��п���7�g�p=�}ͯ7^f�0�o|#?\�/f���\"D\��x\�B؉�5R��\�8\�\��5��^\r���EG,\�\�}���m�ٝ���*\�O�m����\�>?\�%��cD@\�߿~9BIq؉w\�X��8\�H\�ϟ�_����&MjXƊ#i.�\�4lذ| flb��a\�q��3\�\����}�\�γS&5TX\��կ~�\��\�&���v�,Y�\� \�Q_�җ\��\�\�\�7x�\��\���7_����Z��\�\���\�7�g\'6#\�s\�=\ragĈ���\Z*��\�S\�鈅=+���5�Nuu�\�\�\�\�\�ߞ�j\�s\�\�^�h\n\�YƊ}6T��؅=;�o{\�\�\�����|�\�_�B\Z;vl�\�Qvb\�N4�\�?31\�\r�pr8a�4k(BMa�p,eŬ\�;\���\�:h\�H�x�c֮�=dc�0\�Il����\�_KUq\�\�\��\r\�q9)��3�q=�@\���K��T\ZK��b�1B{��\�!\'��\"���Ғ����02p\��]-uzlt�0\\<�S�}��+\�NY\�^�\�Oni���\�3ϼ����\�\��9j\�F\�Mv�7oF�FM#fbb/D�@0�TD�C�����8\�IG؉Ç\�{4�7�\�M�Q1�\�qW�#%N\n�,\�Q6\�4c:�pHz4\�h~\�sN�1U�*�\Z��˛V\���\�_�\�F�)���)|O\�׊\0\�\�)^��:5jTC�i�7(�6��\�\�u\���\�<8\�Ϲ\�k�\�\�q-�u�޽{\�ɫ�\�\�\�X_%Yh\�}��\'�N��)\n:[ʹ/P�***�VUU�Y�v�:�x\�\�-�iʶnT \"\��\�\�c	+�$bE�1�;NלǍ#gbo\�y睗O#ǹP\�c�\�\\�\��~�\�y����;bN\�&�ub�F�;❽FU�\�X��s8}��Y�~�g��.i\��5�ѱ|E�%��=z��]�dɆ�:555\��_�\�\���Ѩ4*5��^�}�8�t\�\�mw\��\��\�u����\�\�\�}�2O�Y\�\�0aGg\��ĉ���R��_���hT\Z�\ZRC�侐�M\�a%\�K쵊ƬMa�+��\�\�ȱ70�\�\�T�\�ؼ���\�?\�w�C����͛7o�����>իW�ű\�#�\�jT\Z�\ZRC�\�I?\�1\�J��ω\�\�޽�\�aÆ͛9s\�#�2uuu[\�?\�skmm\�\�,�\�g?�ٜ=z��b�\�\�\�v\�kT\Z�\ZRC��//m5\'\�tľ@g\�̊{@�g�<�N[��\����L�8\�wG>�F�Q�!5��\0�F�Q�!5 \�\Z�\ZRC\0!\�j@�2�C\rhT\Z�\Z2�\0�J�RC���QiTjH\r;\Z�F��\���chTjH\r;��c�!\0�\�v5�QiTj\�v\04*�J\r\��F�Q�!5 \�hT\Z�\ZRC\0�Q�!5 \���\04*C\�1\��F�Q�!C\�Ш4*5d;\0\Z�F\���O�\�+�Q�\�\�\���hT\ZU�={v\�u\�~%0V�^=1��%��hT\ZU�1c\�ٳf\�ڼv\�ڗ��\���~�M��l6\��\r@�ҨZX�\�>+j\�\�T,ŕ㨮�N\��o�ޗ:\0�Q\�y睩k׮\Z�,��3f̘��N�\r\0JN֠&E\�9�\�S��lp�RJGnܸqS&�\�\��^\�\0%���\�,\�a\�\�s\�=\�3\��Z�r\�\�޼y�Vgu\�ٳ@)��\�:�\�!\�c\�֭\'\�ڵkw*2bĈ�={�<ʳ@�\�\�\�I�Y�\�\�\�\�Y��k͚55��͛7�����γ@)��I\�A�0�c\�ͱbŊ��	\�\�\�k\"L{�\0hϠ�׬Na\�s��dy\�\�m۶\�h*\�\�޽{����hϰ3y_A�~\���?�V������fe�x�\0h��\�䬎�;4\�ܹs�uR]]ݬ���={\���\�Τ�Gfq W^ye\��-cE\�2d\�]fv\0(�\0�<��\'>\�T\�Y�lٸX�g\0a��եK�\�PS��\�ɋ+++;\Z\0a��7jԨ\�p��8\�\�|�ͷTTT\\\�\�@ء\�\�2Ք)S\��P�����:�2\0\�F�~���iӦm�:\�y�\0v\�pƏ?y̘1qʂj\�\0\�N,[E\rŦe\�\0\�j\04*\�\0hT�!\0ШPC\0�Q��\0Ш@\r�Q��\0@�B\r�F�\Z\0�\n5\0\Zj\04*\�\0\Z�!\04*\�\0hT�!\0ШPC\0�Q��\0@�B\r�QiT�!\04*PC\0hT�!\0ШPC\0�Q��\0@�B\r�F�\Z@�ҨPC\0hT��\0ШPC\0�Q��\0@�B\r�F�\Z\0�\n5�F�Q��\0Ш@\rP��\�0w�M\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\��\�1\�D�\n�\0\0\0\0IEND�B`�',1),('2',11,'source',NULL,'{\"resourceId\":\"1\",\"properties\":{\"process_id\":\"LeaveBill\",\"name\":\"LeaveBill\",\"documentation\":\"\",\"process_author\":\"made by pigx\",\"process_version\":\"\",\"process_namespace\":\"http://www.activiti.org/processdef\",\"executionlisteners\":\"\",\"eventlisteners\":\"\",\"signaldefinitions\":\"\",\"messagedefinitions\":\"\"},\"stencil\":{\"id\":\"BPMNDiagram\"},\"childShapes\":[{\"resourceId\":\"sid-3AC5E563-E6E3-4777-B446-0476D884C11D\",\"properties\":{\"overrideid\":\"start\",\"name\":\"开始\",\"documentation\":\"\",\"executionlisteners\":\"\",\"initiator\":\"\",\"formkeydefinition\":\"\",\"formproperties\":\"\"},\"stencil\":{\"id\":\"StartNoneEvent\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\"}],\"bounds\":{\"lowerRight\":{\"x\":75,\"y\":115.00000000000003},\"upperLeft\":{\"x\":45,\"y\":85.00000000000003}},\"dockers\":[]},{\"resourceId\":\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\",\"properties\":{\"overrideid\":\"user\",\"name\":\"用户提交\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"executionlisteners\":null,\"multiinstance_type\":\"None\",\"multiinstance_cardinality\":\"\",\"multiinstance_collection\":\"\",\"multiinstance_variable\":\"\",\"multiinstance_condition\":\"\",\"isforcompensation\":\"false\",\"usertaskassignment\":\"\",\"formkeydefinition\":\"\",\"duedatedefinition\":\"\",\"prioritydefinition\":\"\",\"formproperties\":\"\",\"tasklisteners\":{\"taskListeners\":[{\"event\":\"create\",\"implementation\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"className\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"expression\":\"\",\"delegateExpression\":\"\"}]}},\"stencil\":{\"id\":\"UserTask\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\"}],\"bounds\":{\"lowerRight\":{\"x\":220,\"y\":140.00000000000003},\"upperLeft\":{\"x\":120,\"y\":60.00000000000003}},\"dockers\":[]},{\"resourceId\":\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\",\"properties\":{\"overrideid\":\"pm\",\"name\":\"组长审批\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"executionlisteners\":null,\"multiinstance_type\":\"None\",\"multiinstance_cardinality\":\"\",\"multiinstance_collection\":\"\",\"multiinstance_variable\":\"\",\"multiinstance_condition\":\"\",\"isforcompensation\":\"false\",\"usertaskassignment\":\"\",\"formkeydefinition\":\"\",\"duedatedefinition\":\"\",\"prioritydefinition\":\"\",\"formproperties\":\"\",\"tasklisteners\":{\"taskListeners\":[{\"event\":\"create\",\"implementation\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"className\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"expression\":\"\",\"delegateExpression\":\"\"}]}},\"stencil\":{\"id\":\"UserTask\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\"},{\"resourceId\":\"sid-54B35C23-018B-4FBA-96C2-7EF45D014DDD\"}],\"bounds\":{\"lowerRight\":{\"x\":365,\"y\":140.00000000000003},\"upperLeft\":{\"x\":265,\"y\":60}},\"dockers\":[]},{\"resourceId\":\"sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":null,\"defaultflow\":\"false\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\"}],\"bounds\":{\"lowerRight\":{\"x\":119.15625,\"y\":100.00000000000003},\"upperLeft\":{\"x\":75.609375,\"y\":100.00000000000003}},\"dockers\":[{\"x\":15,\"y\":15},{\"x\":50,\"y\":40}],\"target\":{\"resourceId\":\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\"}},{\"resourceId\":\"sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\",\"properties\":{\"overrideid\":\"\",\"name\":\"审批\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":null,\"defaultflow\":\"false\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\"}],\"bounds\":{\"lowerRight\":{\"x\":264.15625,\"y\":100.00000000000003},\"upperLeft\":{\"x\":220.84375,\"y\":100.00000000000003}},\"dockers\":[{\"x\":50,\"y\":40},{\"x\":50,\"y\":40.000000000000014}],\"target\":{\"resourceId\":\"sid-35ADF006-57C0-47E0-9B5B-AF424E0A7E4E\"}},{\"resourceId\":\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"sequencefloworder\":\"\"},\"stencil\":{\"id\":\"ExclusiveGateway\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-B0AD2E8E-6641-4472-9D13-F882DA3AF9D5\"},{\"resourceId\":\"sid-AD927630-75ED-4D77-87CF-ED033073EAC6\"}],\"bounds\":{\"lowerRight\":{\"x\":450,\"y\":120.00000000000003},\"upperLeft\":{\"x\":410,\"y\":80.00000000000003}},\"dockers\":[]},{\"resourceId\":\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\",\"properties\":{\"overrideid\":\"\",\"name\":\"经理审批\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"executionlisteners\":\"\",\"multiinstance_type\":\"None\",\"multiinstance_cardinality\":\"\",\"multiinstance_collection\":\"\",\"multiinstance_variable\":\"\",\"multiinstance_condition\":\"\",\"isforcompensation\":\"false\",\"usertaskassignment\":\"\",\"formkeydefinition\":\"\",\"duedatedefinition\":\"\",\"prioritydefinition\":\"\",\"formproperties\":\"\",\"tasklisteners\":{\"taskListeners\":[{\"event\":\"create\",\"implementation\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"className\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"expression\":\"\",\"delegateExpression\":\"\"}]}},\"stencil\":{\"id\":\"UserTask\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-03D60074-0783-4C3B-8CE0-73B43EFC5180\"},{\"resourceId\":\"sid-61F782E2-0A2E-41D2-80B7-8160A92DAC99\"}],\"bounds\":{\"lowerRight\":{\"x\":595,\"y\":140.00000000000003},\"upperLeft\":{\"x\":495,\"y\":60}},\"dockers\":[]},{\"resourceId\":\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\",\"properties\":{\"overrideid\":\"\",\"name\":\"人力报备\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"executionlisteners\":\"\",\"multiinstance_type\":\"None\",\"multiinstance_cardinality\":\"\",\"multiinstance_collection\":\"\",\"multiinstance_variable\":\"\",\"multiinstance_condition\":\"\",\"isforcompensation\":\"false\",\"usertaskassignment\":\"\",\"formkeydefinition\":\"\",\"duedatedefinition\":\"\",\"prioritydefinition\":\"\",\"formproperties\":\"\",\"tasklisteners\":{\"taskListeners\":[{\"event\":\"create\",\"implementation\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"className\":\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\",\"expression\":\"\",\"delegateExpression\":\"\"}]}},\"stencil\":{\"id\":\"UserTask\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-B00A2A82-3A15-4945-B401-8DE4DD872A88\"}],\"bounds\":{\"lowerRight\":{\"x\":740,\"y\":140.00000000000003},\"upperLeft\":{\"x\":640,\"y\":60}},\"dockers\":[]},{\"resourceId\":\"sid-BA76EC1F-B75E-4F28-B898-FE0666B681BF\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"executionlisteners\":\"\"},\"stencil\":{\"id\":\"EndNoneEvent\"},\"childShapes\":[],\"outgoing\":[],\"bounds\":{\"lowerRight\":{\"x\":813,\"y\":114},\"upperLeft\":{\"x\":785,\"y\":86}},\"dockers\":[]},{\"resourceId\":\"sid-B00A2A82-3A15-4945-B401-8DE4DD872A88\",\"properties\":{\"overrideid\":\"\",\"name\":\"审批\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":\"\",\"defaultflow\":\"false\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-BA76EC1F-B75E-4F28-B898-FE0666B681BF\"}],\"bounds\":{\"lowerRight\":{\"x\":784.375,\"y\":100},\"upperLeft\":{\"x\":740.390625,\"y\":100}},\"dockers\":[{\"x\":50,\"y\":40.000000000000014},{\"x\":14,\"y\":14.000000000000002}],\"target\":{\"resourceId\":\"sid-BA76EC1F-B75E-4F28-B898-FE0666B681BF\"}},{\"resourceId\":\"sid-AD927630-75ED-4D77-87CF-ED033073EAC6\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"${days<=10}\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"showdiamondmarker\":false},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\"}],\"bounds\":{\"lowerRight\":{\"x\":690,\"y\":192.00000000000003},\"upperLeft\":{\"x\":430.5,\"y\":120.08593750000003}},\"dockers\":[{\"x\":20.5,\"y\":20.5},{\"x\":430.5,\"y\":192.00000000000003},{\"x\":690,\"y\":192.00000000000003},{\"x\":50,\"y\":79.00000000000006}],\"target\":{\"resourceId\":\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\"}},{\"resourceId\":\"sid-B0AD2E8E-6641-4472-9D13-F882DA3AF9D5\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"${days>10}\",\"executionlisteners\":\"\",\"defaultflow\":\"false\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\"}],\"bounds\":{\"lowerRight\":{\"x\":494.80079078438814,\"y\":100.41360197940784},\"upperLeft\":{\"x\":450.28514671561186,\"y\":100.21921052059221}},\"dockers\":[{\"x\":20.5,\"y\":20.5},{\"x\":50,\"y\":40.000000000000014}],\"target\":{\"resourceId\":\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\"}},{\"resourceId\":\"sid-61F782E2-0A2E-41D2-80B7-8160A92DAC99\",\"properties\":{\"overrideid\":\"\",\"name\":\"驳回\",\"documentation\":\"\",\"conditionsequenceflow\":\"${flag.equals(\'驳回\')}\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"showdiamondmarker\":false},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\"}],\"bounds\":{\"lowerRight\":{\"x\":545,\"y\":60.00000000000003},\"upperLeft\":{\"x\":170,\"y\":29}},\"dockers\":[{\"x\":50,\"y\":1},{\"x\":545,\"y\":29},{\"x\":170,\"y\":29},{\"x\":50,\"y\":1}],\"target\":{\"resourceId\":\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\"}},{\"resourceId\":\"sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\",\"properties\":{\"overrideid\":\"\",\"name\":\"驳回\",\"documentation\":\"\",\"conditionsequenceflow\":\"${flag.equals(\'驳回\')}\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"showdiamondmarker\":false},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\"}],\"bounds\":{\"lowerRight\":{\"x\":315,\"y\":191.52429051146217},\"upperLeft\":{\"x\":170,\"y\":140.3268435791439}},\"dockers\":[{\"x\":50,\"y\":40.000000000000014},{\"x\":315,\"y\":191.52429051146217},{\"x\":170,\"y\":191.52429051146217},{\"x\":50,\"y\":79}],\"target\":{\"resourceId\":\"sid-8C8E72BC-5302-40A7-A017-04EB9FA916DA\"}},{\"resourceId\":\"sid-54B35C23-018B-4FBA-96C2-7EF45D014DDD\",\"properties\":{\"overrideid\":\"\",\"name\":\"审批\",\"documentation\":\"\",\"conditionsequenceflow\":\"${flag.equals(\'审批\')}\",\"executionlisteners\":\"\",\"defaultflow\":\"false\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\"}],\"bounds\":{\"lowerRight\":{\"x\":409.64844687000755,\"y\":100.40973353623383},\"upperLeft\":{\"x\":365.62889687999245,\"y\":100.21917271376623}},\"dockers\":[{\"x\":50,\"y\":40.000000000000014},{\"x\":20.5,\"y\":20.5}],\"target\":{\"resourceId\":\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\"}},{\"resourceId\":\"sid-03D60074-0783-4C3B-8CE0-73B43EFC5180\",\"properties\":{\"overrideid\":\"\",\"name\":\"审批\",\"documentation\":\"\",\"conditionsequenceflow\":\"${flag.equals(\'审批\')}\",\"executionlisteners\":\"\",\"defaultflow\":\"false\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\"}],\"bounds\":{\"lowerRight\":{\"x\":639.15625,\"y\":100.00000000000001},\"upperLeft\":{\"x\":595.84375,\"y\":100.00000000000001}},\"dockers\":[{\"x\":50,\"y\":40.000000000000014},{\"x\":50,\"y\":40.000000000000014}],\"target\":{\"resourceId\":\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\"}}],\"bounds\":{\"lowerRight\":{\"x\":1200,\"y\":1050},\"upperLeft\":{\"x\":0,\"y\":0}},\"stencilset\":{\"url\":\"stencilsets/bpmn2.0/bpmn2.0.json\",\"namespace\":\"http://b3mn.org/stencilset/bpmn2.0#\"},\"ssextensions\":[]}',NULL),('3',1,'source-extra',NULL,'',NULL),('30102',1,'请假流程.bpmn20.xml','30101','<?xml version=\'1.0\' encoding=\'UTF-8\'?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.activiti.org/processdef\">\n  <process id=\"LeaveBill\" name=\"LeaveBill\" isExecutable=\"true\">\n    <startEvent id=\"start\" name=\"开始\"/>\n    <userTask id=\"user\" name=\"用户提交\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\"/>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"pm\" name=\"组长审批\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\"/>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\" sourceRef=\"start\" targetRef=\"user\"/>\n    <sequenceFlow id=\"sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\" name=\"审批\" sourceRef=\"user\" targetRef=\"pm\"/>\n    <exclusiveGateway id=\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\"/>\n    <userTask id=\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\" name=\"经理审批\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\"/>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\" name=\"人力报备\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"com.pig4cloud.pigx.act.listener.LeaveProcessTaskListener\"/>\n      </extensionElements>\n    </userTask>\n    <endEvent id=\"sid-BA76EC1F-B75E-4F28-B898-FE0666B681BF\"/>\n    <sequenceFlow id=\"sid-B00A2A82-3A15-4945-B401-8DE4DD872A88\" name=\"审批\" sourceRef=\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\" targetRef=\"sid-BA76EC1F-B75E-4F28-B898-FE0666B681BF\"/>\n    <sequenceFlow id=\"sid-AD927630-75ED-4D77-87CF-ED033073EAC6\" sourceRef=\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\" targetRef=\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${days<=10}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-B0AD2E8E-6641-4472-9D13-F882DA3AF9D5\" sourceRef=\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\" targetRef=\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${days>10}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-61F782E2-0A2E-41D2-80B7-8160A92DAC99\" name=\"驳回\" sourceRef=\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\" targetRef=\"user\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${flag.equals(\'驳回\')}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\" name=\"驳回\" sourceRef=\"pm\" targetRef=\"user\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${flag.equals(\'驳回\')}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-54B35C23-018B-4FBA-96C2-7EF45D014DDD\" name=\"审批\" sourceRef=\"pm\" targetRef=\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${flag.equals(\'审批\')}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-03D60074-0783-4C3B-8CE0-73B43EFC5180\" name=\"审批\" sourceRef=\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\" targetRef=\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${flag.equals(\'审批\')}]]></conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_LeaveBill\">\n    <bpmndi:BPMNPlane bpmnElement=\"LeaveBill\" id=\"BPMNPlane_LeaveBill\">\n      <bpmndi:BPMNShape bpmnElement=\"start\" id=\"BPMNShape_start\">\n        <omgdc:Bounds height=\"30.0\" width=\"30.0\" x=\"45.0\" y=\"85.00000000000003\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"user\" id=\"BPMNShape_user\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"120.0\" y=\"60.00000000000003\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"pm\" id=\"BPMNShape_pm\">\n        <omgdc:Bounds height=\"80.00000000000003\" width=\"100.0\" x=\"265.0\" y=\"60.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\" id=\"BPMNShape_sid-7D3BA0CC-0E14-401A-997B-E5B57798D600\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"410.0\" y=\"80.00000000000003\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"sid-D191DB7D-10B8-4AE7-8284-E0931287237C\" id=\"BPMNShape_sid-D191DB7D-10B8-4AE7-8284-E0931287237C\">\n        <omgdc:Bounds height=\"80.00000000000003\" width=\"100.0\" x=\"495.0\" y=\"60.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\" id=\"BPMNShape_sid-A13A9AA8-CC8F-4B33-8166-EF7757F6ABDB\">\n        <omgdc:Bounds height=\"80.00000000000003\" width=\"100.0\" x=\"640.0\" y=\"60.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"sid-BA76EC1F-B75E-4F28-B898-FE0666B681BF\" id=\"BPMNShape_sid-BA76EC1F-B75E-4F28-B898-FE0666B681BF\">\n        <omgdc:Bounds height=\"28.0\" width=\"28.0\" x=\"785.0\" y=\"86.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-B00A2A82-3A15-4945-B401-8DE4DD872A88\" id=\"BPMNEdge_sid-B00A2A82-3A15-4945-B401-8DE4DD872A88\">\n        <omgdi:waypoint x=\"740.0\" y=\"100.0\"/>\n        <omgdi:waypoint x=\"785.0\" y=\"100.0\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\" id=\"BPMNEdge_sid-2BCFC616-7D8A-4141-AF3F-8AC18EA100DF\">\n        <omgdi:waypoint x=\"75.0\" y=\"100.00000000000003\"/>\n        <omgdi:waypoint x=\"120.0\" y=\"100.00000000000003\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-54B35C23-018B-4FBA-96C2-7EF45D014DDD\" id=\"BPMNEdge_sid-54B35C23-018B-4FBA-96C2-7EF45D014DDD\">\n        <omgdi:waypoint x=\"365.0\" y=\"100.21645021645023\"/>\n        <omgdi:waypoint x=\"410.4130434782609\" y=\"100.4130434782609\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\" id=\"BPMNEdge_sid-EFC485F1-AEC9-4569-B401-D16DE58F6737\">\n        <omgdi:waypoint x=\"220.0\" y=\"100.00000000000003\"/>\n        <omgdi:waypoint x=\"265.0\" y=\"100.00000000000003\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-B0AD2E8E-6641-4472-9D13-F882DA3AF9D5\" id=\"BPMNEdge_sid-B0AD2E8E-6641-4472-9D13-F882DA3AF9D5\">\n        <omgdi:waypoint x=\"449.5833333333333\" y=\"100.41666666666669\"/>\n        <omgdi:waypoint x=\"495.0\" y=\"100.21834061135374\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\" id=\"BPMNEdge_sid-84BB2405-8E02-4DB9-8F29-E9BBB032C0D9\">\n        <omgdi:waypoint x=\"315.0\" y=\"140.00000000000003\"/>\n        <omgdi:waypoint x=\"315.0\" y=\"191.52429051146217\"/>\n        <omgdi:waypoint x=\"170.0\" y=\"191.52429051146217\"/>\n        <omgdi:waypoint x=\"170.0\" y=\"140.00000000000003\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-AD927630-75ED-4D77-87CF-ED033073EAC6\" id=\"BPMNEdge_sid-AD927630-75ED-4D77-87CF-ED033073EAC6\">\n        <omgdi:waypoint x=\"430.5\" y=\"119.50000000000003\"/>\n        <omgdi:waypoint x=\"430.5\" y=\"192.00000000000003\"/>\n        <omgdi:waypoint x=\"690.0\" y=\"192.00000000000003\"/>\n        <omgdi:waypoint x=\"690.0\" y=\"140.00000000000003\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-61F782E2-0A2E-41D2-80B7-8160A92DAC99\" id=\"BPMNEdge_sid-61F782E2-0A2E-41D2-80B7-8160A92DAC99\">\n        <omgdi:waypoint x=\"545.0\" y=\"60.0\"/>\n        <omgdi:waypoint x=\"545.0\" y=\"29.0\"/>\n        <omgdi:waypoint x=\"170.0\" y=\"29.0\"/>\n        <omgdi:waypoint x=\"170.0\" y=\"60.00000000000003\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-03D60074-0783-4C3B-8CE0-73B43EFC5180\" id=\"BPMNEdge_sid-03D60074-0783-4C3B-8CE0-73B43EFC5180\">\n        <omgdi:waypoint x=\"595.0\" y=\"100.00000000000001\"/>\n        <omgdi:waypoint x=\"640.0\" y=\"100.00000000000001\"/>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('30103',1,'请假流程.LeaveBill.png','30101','�PNG\r\n\Z\n\0\0\0\rIHDR\0\07\0\0\0\�\0\0\0�5��\0\0#`IDATx\�\�\�	�Uu�\�q*+\�}\����l\�l\�\�\�FEe!\�D�f��d\�fiVVJie�RFdh�\�hZ���bh,�X�I�)�����\�sg`�e\�\�;���|ν�̝\�\�\���}\�2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0څ]wݵB\�~��\0\�\�\�U\0\0\�\0�\n\0�\�\0P\0x;\0\0*@\0\0o\0@\0�\0\0 \0��\0�\0�v\0\0T�\0\0\�\0�\n\0x;\0\0*@\0\0o\0@\0\�\�\0\0�\0\0�\0\0 \0�v\0\0T�\0\0\�\0�\n\00p\�q\��4iRQ����\0@r\0hI��\����\�ZZR�;�LW\0 �\0�$,8�X\�\�ٳ�9rW\0 �\0�˗/\�\�ի\�\ru\�Q:;;�su\0\0�\0@˰x�\�yE�-[����\�{�\0@r\0h	\�ϟH\�ӦM[\\z�N�\0�\��\�If6W�R\0\�:��\�SW�Z�����5k\�\�;~��9;\��6�\0�����ʸoC\�͈#��R\0\�:,\\���b#̛7o�ȑ#�s�\0\0\�\����\�\�r={\0\�Z\\v\�e\�m��+W^�\�\�\�\�\�\0�Sr�SOɍ-C��8�\�C�\�д�\�6&L���\0@�&8ݭ��ʨ\r\0�&S�L���\�\�\�o>�\�<\0�������\�\0Z�\�Ç\�P&1+�\�Lຎ��\�\�\0hk\�df�Q\0h�=�\�\�\�dfucrs\�\'�T��DW\0\�\�\�\�\�\�uE\0��I\'Ռ3�4<��\�\�\�\�vvvn\�\�\0\0ڞz\�Q\0h�\�g��[�t\�2��c\�βQ\0`0%7\�\�i�\0��\'O>{ҤIYK9\�\�\0\0�(��7o\�\�W\\q\�\��\�;��9sfKF��V�\�g͚U\\|�\��*c4\r���!(�\�\�Yg�Uy�ԩS�K\Z\�\�\0zG�\�K.)�,YR\�{\�b�\�\�;\�,.�袻K#�\r���!(�=ŢE��K\Z\�\�\�=\�a\\Mc`�Μ9�\Z�MCP.�K\Z�\�\"d��q4O�\�u\r���!(�\�%\r	\�l2��i4�y4$���\\*�4$x;Я\�|\�\�ż�~Z\\?\�*r���!\Z�r)x;\r\�\�2\�u\�\�E\�u\�R\\{ց\�E\�\�gLGHC4\�R�v\Z�!�%\�k����qձ��\�LGHC4\�R�v\Z�!�5\�\��\�Ѽ�\�Q\�\rA����hh	�n\�\�=�W>c:*@\Z�!(���\�\r\�K�\0iH\�R��!�ہ�2�\�~ғy\�3���!\Z�r)x;\r\�\�\�5��\��h^��\�\0i���\\\n\�NC4��y�{ќ\�s{\��s�^>c:*@\Z�!(���\�\r-a^�[����W\�c8̋�hʥ\�\�4DC@\�תU\�\�\�\�?pȹ|/�1 \r\��K�\�i����7�<a��ˎ\�qNm>�b \r\��K�\�i���\�5�U��\�\�_�uƄ�����s�Ҩ\0i���\\\n\�NC44�ym�7F/\r�!\Z�r)x;\r\�\�\�՛ޘ\r�\�0! \r\�\�\0�oW.�K\Z�!@XŦ\ZWLHHC44�-�X�/oW.�K\Z�!`�W��y\�\r�(\�.ci\��;��咆hP\n\�EC4Ԫ�Ͱ��;k��\\*�4DC�\�F0/\Z���Hl6�>o\�%\r\��̋�h�\�����|(o\�%\r\�ږ�(��3gθ�O>����>�\�}�\���\�\�\�b\�]w-F��f�����+_�ʼc�9\�e�H(�\r\�P\�&6K\\\��r�\\\�\r�\�1b\�>e���2\�qO\�\�e�,\��i\�\�<\�\����S���\�#��o���+&O�\\\\q\�ŢE���+W!�.Y�����\\�\�O�/|a\���\�o;v\�*@��h����w�qD��\��v�\�\�;\Z\�J�9r�2f�q\�\�d�7qAy�h\�Le3\�k_�ڪ<�J\\\�����\\s\�5\�At��q\�n>|�*@��h��<��	?w\�`Hp�K咆h�)�\�\�eF�\�\�vj�o\�h\�6g�q\��{\�g1}��>%5]�1cF1f̘\�2�ü�\r\�\� Il�\�\�+���\Z\�F��\�Q�\�jLT:::�o|\�\��\�_̟?��\��S����\��V��.�\�b\�ĉŧ>���	\�=�v\'�ͅ^x\�\�?��⦛n*��\�zkQ&J+�\�c��U�BHC4\�oll���\�R�vAC�Kl��\�\���I\�/~�jHoX�tiu~~�1\�)�s�!���\�$�\�\�\�\�-���cǶ|\�ȼ�\r\�P�%6[jJY[�\�(�\�%\r\�P3�\�4&6_�\��Q�M!?�\�%]��3��56����Fl��\�m�ݖ�uG�P\n\Z\�jt\�\�Ae\��߾\��\�\�v�\�R��!\Zj�Ʀq*\�a��n\�٦�)kGuT\�)j;iw�+\�Gqo\�\�lM\�:\���\0�\nP\�\�VMl�5$(\'\�\�\��\�\����k\�G�T.i����2��\�8b���Mc�\�e璶On�M��\�������[�\�}\�s�[uH�y1/\Z��Jl��y)\Z�7	NcbS\�n\r��\�\Z\�R��!\Z\Zh�\�s\�\Z�M����)j�kp\�zzZFm��l�\�\\{\���\�\�\r�b^44�4��\�;o\�\"\�\�)\�\�.Q\�P�\�\��\'vs~[��Q.�K\Z\�>h�\�ff�xd3���i��68Fo\�̙3.�lΖ\�}e̘1�3���U\�[��!\ZZ\�\��ԅ^�m5>�\����1\�[\rm �ڇ������͐V���\\*�4DC�\�CϬ7\�\�ʿ��\�\��\�.j]��\�~H;r�\�\'_t\�\'�\�ĉ�)/\�\�r\r\Z�\�f�1\�̋y\�\�\�\�\����Y�r\�}�_�Z�\�S�L���\�{��4��	\�\���&6���\�f�Q.�K\Z��V���}\���\�on\�6xcrs��v\�裏���+�\�\�\�f�\�ٷ�tz�	�!\�\�.\�f^̋�\�WC˗/\�w\�qkO�u\�-��,��\�\�\�mRC�15��\����\�llJ�r)M��!\�\�\�P�\�\��\�^x\�Vm�g\�\�o�>�\�w\�}\���\��5�Y�x��.hb\�˲ȼ�\r����\�p����^�z\�Ƽk͚5�g̘��\�\�h�4���͆�7#�\�ܿG�mQ.iH�`s4T��[���7\�ʢE�\Z��Cڑ\�\�\�b\�ʕ��\�\���te��1\�\�P\"�b^4\�^q\�W˖-�{\�-�:��\�\�++�\'�����HIw	\�\�$6}�\"�\\��+�4�}�9\Z*cE�zKm���m�~�ʶLn�zq��.Zɼ�/_^̚5�\�\����UC��V�\�\��\�q\�\�u�\�{��HC��%K�l\�\�OO\�9\�\�\�\�/.�򗿬\�^̻���Ձ�&齚4iR��rSe\�g�[?�\�\�\�$d\�fZ�����q\���\�D\���E\�\�e\�\�fh\�~\�~�ằs���?U\�\�\���3f�I�����rJ��@\�\�jE���\�\�m�\�\��\�k�{\�fŊ�[d\�\�#F�wd��\�W�R���/-^���u;\�cq\�]w=\�箿��\��xDq\�gv��_|q�\�6\�T\�p@���x\�_�.�����\�?�YV\"���\�ܹs׽C\�ڕt�\���\��V<�\�O/~�ӟV��\rV\�\�N\�\�\�}\�z\�s\�1\�+^��\�[�`A��\�{�\�ڍ7\�X|\�;ߩ&&\���\�n�m�\�o{\�{��\��{u~��|\�s�S�\�U�*~�\�V\�Ozғ�?�\�V�\�w�+Ǝ{\�\�ٳo_�fM���\\�l٩\�ƍ����Ӷ\�N3�\�А�9#7}y\�g+�\�x�L��\�g>�8�䓫\�{\�\�zI\��\�\��\���\�СC�|\�Ż\���j���\�W��\�\"uDʤr9p\�r���K/��*\�\��\�\����?\\|�\�\���$�����\�o\�W��\�\�\�#�\�z\�׾�\�?X�)�\�k�b���+�\�\�g�m䦗\Z*�\�1r�)xo���\�\�nl�57]6��s��\\�����8�\�S��y|\�k_��Saŀ\��\�u	K\�C�PO}\�S�\�k���\�ɓ��\��a{X�3e�P�\�-o)=�\�*r\�\��\�\�\�\�\�C#h����y5��\�xJ#*P^��\�/��|��_���\�\�o��z\�����d]r��o|�x\�\�W��o,��׿V\�{~F�YE������x�\�^Un�\�ͫ���\�뮫�\�G?�Q�=I�\�;\�jD�7=�[KCyxZY�/X�t\�\r\�뿮\���37:\���\Z�{�Қ�MIpZe\�MӔ\�\����\�\���j\�$��=�\�\��\�/���/Ue+\rļ\�%��\�o�<�*7�\���߿�\��P���\�:��o7\�t�r9�\�r���\�����j�n�\�\�\��\��̨\\4m\�8��\��$�ӧO��+��\�$ə	��\�g?[��\�\\�\�I�\�\��\�?�Jz~��F��\�*yV�\�w\Z�\�fs\�!�\�\�\�\�\�\�9\�?4\�ni�\�{\�; \�+\������袋�x\�CZ%9\�pcr�Q�J�\�\�;\�P�\�\�}\�{U���=�x��_%7�\�R�&��\�\�&\r\�\��v\�m�*J�wڴiU\�\�|^7��Wsi(\�N����\�?/�\�g���\�%�Hc(\�?��\�}@r��\�L[\�n�\��\�E\�/�\��Ι3gN�\�|���曋�\�\�ԗh1\�뼟J�k��t�\�G?���\����UZ��\�;�FT�I\�$Q��\�Ç?���\�{S�N]�z�\��\�\��\�	\�gו\�\�\�\�\�\�RC�1R\�\�v\�\�\�֗�vKk�r\�\�5�)����W�D�eM\�3寞\"V�ddt=\�ih�\�\ro(^��\�U\�瓟�du\�R\�\��\�>\�\�۹\�\�MC̈�\�:(\���7U\���ų���\�$ԙ\�1z�\�jG:\��\�tPu\�-�\�R�!�ӎ|\�ӞVu\�>�O\�\�tH\�j\�ni[�c�=�\��~\�\�a�vV�=\�fC=�j^��\�k�\�$É�\��\�\�~�z\�M���W��\�\�\�\�M\"\�\�3fL5�-\r\�ģ����\�Mk\�9\�x\�3��V\�e�:�!\�Z\�d\�Ք\ZJo�\�L5\�}\�}Kr�\�\�\��h�NnҨI/m=r�޾����9N\���~\���\�2�%Z\�ha^g*L>���L�y\��W��s\�\�Y~W�\�\�y\�M���^\�4~��9�\�\�[T�\�/�0a¯R)\��f\�\�&��l\�96�}\�gWrM��97MY.3\�,\�8=\������NR_\�#Y|������\�d\�\�	OxBq\�q\�U\�MFm2M���}\�\�T\'7\�\�\�j4F:�r�2�)�\�X��枧=�\�D��w�c��;���\�׼\�\��\�_�\�?(~�\�W]uպuZ\��ַ�U���o��\�]v٥\�o�\�\'	�\�o~S�DhlXC�s��9�\���_�\��\�\�6+G�\Z��V|*\�@�W\�W�g�~�F\�\�ٳ�\�Ucr3u\�\�\��\�~�����4&7�ʐ�Td��t\�G�eZ�\�S��L��?餓�\n6IVz\�E��ռ�UC��iIb~���U\�\�2eʔu\�\�\�\�&\�{31�\�9�\�_�r5ʗ��\�y\�g���\��\�\��ߑ��i�EkiDe:L\���\�7�y�����TBe�r��\�y�\�\'�o9\�\�:��\�\�S\�vi�z��\�ez�\�C�d#��N��|��!\r\�$4iL^p�U��)liDf\�MFZ2�8]�\���ii\�\�\�j4&//�˫HR��s3\�\"3<\Z\�Te���\����F���L?\�\�M4�N�\�I�3��\�@ m�$59/ZN��&�(\�u�}�a:::�Y^��r\�\�\�jV\�\� �m�\�\�k\Z��퇴+��oNQ?MI�Ey1/Q�.\��䡞/��$W�3e�1�I#�\�9\�\Ze�0aº\����<\�!մ��\�ɦ�,3)\�\�\��7!Ǚ��\�8C\�y?f�)\�Ncw Fo$7�����\Z�I��$9\�oRAe���e\�Nn2�0��#�<�\�A�Ӱ�\�\�8\�\�uzࢅ��Q�E�u�o^\�����)�i��M\r��\�߬S�<�\�\�No��&8�\�ۥ\���\�tH{��_]u:%	��\'��#��\�]��%!I\�k�����Ϋ�\�4H�\���\�d#�\�\�QI2�\�\�\�$$9�q\�\��\�B�+�\�\�K\������LiOԣ<\�϶\�9��ژ\�$\�y�\�LW\�3;zK�{S\'Y��5�4$6�ig>�\�\���\�\�ћ��F������U���\�\�\�\�S&b:م$\�IB\Z��TVIP����ǹ��˫\���e�`=--cbY̚�pFd\�\�Mt^gǞ�\�t\�-�y5��2\�$�!%Nr��$7�|\�ӖJ��57�\�Tly\�uzJ\ZI\�\�\�\"ӌ\nE�\�\�|o݈\�\�L\�8��k#*?\�\�\�~4ԧ��S\�v\��\�\�t�\�\�և�\"޾��\'Y\�H\�رc��g?ꨣ�\�}\�	\'TS\�\�N�$7�Z���~��$Fy/\��\��\\�\�&�M!\�,�z�\�ܿ��\�zn:�2�<\�g\��\�\'>Q�ժ�O�\�8--u@��h%#C��V�\�\�^[��iG\��\���:\�\�VH��A���]\�\�#�7[zc�|_\�_\��\�\�Cڝq\�\�\�I�wk��=\�[�7t@\�+���\�қiiY\'�Ĥ7\�]��\�\�>������)�����*\��6&7\�I�7�\�\�X\�N�6.ze^\�[��8S\\N?����u�\�\�p\�\r�β6 ��o��\�u\�x\��Ղ\�4ВT\�\���\�O~r�yOs���\�nD�Q��e4�E�\�M\Z��<����k�\�[�\\��Q���diL\�g�Q}N��d\�K���=�tF\�?�\�OW\�\�8ILݘU.��\�F\�}\�A�\�vۺ���J��\�YcY��]Rө���>��$\�IHzZs�\�&��I��v��oLn\�~ȹ9�\��}���S��/���tfl�m��^v�����qԦU\�\�}��ۏ3fEz��s\�\�9�����\�*�\�E��%�i�����Y��jFZ2� F�a\�\�d���}o/�V���֤њg�d`*\�|wv\�\�v�1�,TLa��\�\�1����\�(�>�\�ͼ�OCIb\�Eř��)��o�\��\�6ṇ�rX�Lz�3U%��\�-S\�2?S\\rnݓ�\�\�=/\�\�J6���F�\��g\�V\������2E2Z\�\�O/b\ZO�6�\�H\Z\�\"t�����#/}\�޹\�\�m\��u�ˆiDIVRf�Hd=cFd2���r�����\�Ư�}k6�Ɏ�\�!ϳo�\�1\�y/Ӎ�\������l�{��\��A�\�Jgd4ݤ~Ͻ�����CZ�\�h�\�DM� �\�\�گ$,���\�K�Y\0�R/\�#�973L��@��ͼ\��JCݷ\�˸�NB��ys�$6��4�����\�\�}�\�\�;ƍ�\�\�\�ܒ,\\��\�Q�F��Շ��ۼ�0$�i\\4�)i\�OOJ\Z��\�\�Tf\��{�|�\��N\�_�>�-h�;=�{\�G5�s\�sP�\�ۓ�5uٸ�dz�wt5W\�\�\ZJ&k���\�uv[J\�)=ku\�uΩ&f��M\�\�T�$\�yGW\�k{2��k�`\��\�0�\'��h9�\�]��`�QW�����\�l���\��\�\�e|5�˺\\����e�\��\�\�(|�Et�\���\�\�\�f�\�r�h(#uY�\�\�Nd��S�g�=�\��z\��3E\�C��\�\�\�Ѥ.OғGD\�\��ܚ\�~\�QFe\�Q��\�NҔ]��F�\�:���\�3bĈ]\�\�\��M����\�2b38��u�l\�)\r\�-5���$6\�\�:H(T�4DC-�\�4\�:�K咆D�z{��t6&8\�N�\�\�\�\�\Z\�\�$ڡ-�YY\�\�ѣ\��\�\�~�|36X�\�o�������̋�h�\�\�ܩdm;M�T.i����-^\�\�\�\�$IN��\�A�����eD-\���:\�\nw\�}�Ս?��h\�\�\�ܬq�2\�;oܸq����\�}y�͹\�{Z�]�K\�4��y1/\Z��Np�:�Җ�(�\�%\r\�P+�\���\�ĸdP��\�\��D��\�\�\�%G}���^z\�?\�\����\�+V�X|\�m�\�8k֬3?��ˬr^.d2\�vۉ�y1/\Z����S\�\�~*�r�\\\�\r�R[|m�s__��vl�oQ��ԵO>��[\�X��\�\�\�eL/\�v~\�)�b^4DC� �٩�{��\�:�K咆hH[`^̋�h�=�6q��\�\�L��r�\\\�\r���h��\�ogPMES.�K\Z�!@rü�\r\�P{&8�6�Q.�K\Z�!@r#�\r\�P�$8sb�\\*�4DC�\�F0/\Z���`h�\�=+�\�%\r\�\0\�żh��ڜ�\�\roW�K\Z�!@(�\rѐ䆷\�NC4�\0�\nPА\�F��]\����\nP�\0%7ʥrIC��̋yѐPJn�K咆hP2\r\�EC4$�\�\�B��!\ZT�BHC4$�Q.o40/�4$�Q.�K\Z�`^̋��\nPr�\\*�4DC\0��!\Z�\��v�\\\�\r*@��h��$7ʥ\�킆\0\�%T���$7ʥrIC��̋yѐPJn�K咆h\0�b^4DC�\�.�K\Z�!@(�\rѐ\�F��]\����\nPА\�F�T.iH�v�8\��F�\�\�Ҽ\�!1\�4$�Q.�K\Z�\�\"\\|�ŷ/Y��q4A,Z�hJi^7Аl\Z�\�(�\�%\r	\�l\�?���\\x\�\�\�\�d\�zdb\\�f\��g����<hHr\�ۅrIC4�:e�6s\�̫2\�9����vZ�\�L+�\�k#\���V6�V\�ЕW^YL�4��6m\Z\rInx�P.i��\0hCfz\Z3;\��6��JQ\�\�u\�]KK��cǞ\�Hn\0h\0��0bĈ7�\�u_\�k\�ȑC]���R�e�\�ًJ\�\�Hn\0h\0�@�״\�ڸ\�A_X�|�+W�^��hਣ�Z\�\�ٹ��#��}\0\0�ـ٩�4�a�z\�\�ŋ\�]X�l\�⎎�\�:�\0\�\0П\�5�Ѹ\�\�sk\�\�ϟH\�ӦM[�\�\�U�\�\0\�>\0��0��\�\�a\�6F��<uժU�\�)�Y�fͽ\�Ǐ��\"�\�\0\�>\0��0���3��q�+�\r�p\�\�ˋ�0o޼eE���%��}\0\0[Ӹz\�1��\�\�.\�XnS�\\��\�h���s[WLr@�\0\0��yMߐq\�\�\�C\�{C\�Ғ\�L�0\�WFn$7\0�\0@cMϔ)Sn\�)���\�O\��kn�\0~\0\0\�M\��\�\�w(���\�l&p]GG\�uvK\�\0�\00/�\�{\�qe2��1�9�\�O\Z1b\�DW�\0\�\0��\�2d\�ٌ3�4<��\�RKs;;;�su�\0~\0\0\�-\�>�\��K�.]UF1v\�\�Y���\0�\0`^hY&O�|��I��E\�4W�\0\�\0��вd\ZZ4�M\\\r~\0�\0\0�\r���\0�y��\�^\�\0��@Cp/�\0\��!�\0?\0\0\�\Z�{	�\0\0�\r���\0�y��\�^\�\0�@C\�%\0~\0\0\�4�\0?\0\0\�\Z�{	�\0\0�\r���\00/��\�K\0�\0\0�h\�%\0~\0\0\�4�\0?\0\0\�\Z�{	�\0`^\0\r��\0�\00/\�\�K\0�\0\0�h\�%\0~\0\0\�4�\0?\0���h\�%\0~\0�y4\�^\�\0��@Cp/�\0`^�!��\0�\00/\�\�K\0�\0\0�hȽ�\0�y��\�^\�\0��@Cp/�\0`^�!��\0�\0\�А{	�\0\0�\r���\0�y��\�^\�\0��@Cp/�\0\��!�\0?\0\0\�\Z�{	�\0�\0���J�\�\0~\0\0\0��C�\�\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��vha\��\0\0\0\0IEND�B`�',1);
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_property`
--

DROP TABLE IF EXISTS `act_ge_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_property`
--

LOCK TABLES `act_ge_property` WRITE;
/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
INSERT INTO `act_ge_property` VALUES ('next.dbid','32501',14),('schema.history','create(5.22.0.0)',1),('schema.version','5.22.0.0',1);
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_actinst`
--

DROP TABLE IF EXISTS `act_hi_actinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_actinst`
--

LOCK TABLES `act_hi_actinst` WRITE;
/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
INSERT INTO `act_hi_actinst` VALUES ('30106','LeaveBill:1:30104','30105','30105','start',NULL,NULL,'开始','startEvent',NULL,'2018-12-18 22:51:52.599','2018-12-18 22:51:52.600',1,'1'),('30107','LeaveBill:1:30104','30105','30105','user','30108',NULL,'用户提交','userTask',NULL,'2018-12-18 22:51:52.600','2018-12-18 22:52:05.817',13217,'1'),('30114','LeaveBill:1:30104','30105','30105','pm','30115',NULL,'组长审批','userTask',NULL,'2018-12-18 22:52:05.817','2018-12-18 22:52:11.607',5790,'1'),('30118','LeaveBill:1:30104','30105','30105','user','30119',NULL,'用户提交','userTask',NULL,'2018-12-18 22:52:11.607',NULL,NULL,'1');
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_attachment`
--

DROP TABLE IF EXISTS `act_hi_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_attachment`
--

LOCK TABLES `act_hi_attachment` WRITE;
/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_comment`
--

DROP TABLE IF EXISTS `act_hi_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_comment`
--

LOCK TABLES `act_hi_comment` WRITE;
/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
INSERT INTO `act_hi_comment` VALUES ('30111','comment','2018-12-18 22:52:05.805','admin','30108','30105','AddComment','1','1'),('30117','comment','2018-12-18 22:52:11.589','admin','30115','30105','AddComment','2','2');
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_detail`
--

DROP TABLE IF EXISTS `act_hi_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_detail`
--

LOCK TABLES `act_hi_detail` WRITE;
/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_identitylink`
--

DROP TABLE IF EXISTS `act_hi_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_identitylink`
--

LOCK TABLES `act_hi_identitylink` WRITE;
/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
INSERT INTO `act_hi_identitylink` VALUES ('30109',NULL,'candidate','admin','30108',NULL),('30110',NULL,'participant','admin',NULL,'30105'),('30116',NULL,'candidate','admin','30115',NULL),('30120',NULL,'candidate','admin','30119',NULL);
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_procinst`
--

DROP TABLE IF EXISTS `act_hi_procinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_procinst`
--

LOCK TABLES `act_hi_procinst` WRITE;
/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
INSERT INTO `act_hi_procinst` VALUES ('30105','30105','LeaveBill_6','LeaveBill:1:30104','2018-12-18 22:51:52.599',NULL,NULL,NULL,'start',NULL,NULL,NULL,'1',NULL);
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_taskinst`
--

DROP TABLE IF EXISTS `act_hi_taskinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_taskinst`
--

LOCK TABLES `act_hi_taskinst` WRITE;
/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
INSERT INTO `act_hi_taskinst` VALUES ('30108','LeaveBill:1:30104','user','30105','30105','用户提交',NULL,NULL,NULL,NULL,'2018-12-18 22:51:52.601',NULL,'2018-12-18 22:52:05.815',13214,'completed',50,NULL,NULL,NULL,'1'),('30115','LeaveBill:1:30104','pm','30105','30105','组长审批',NULL,NULL,NULL,NULL,'2018-12-18 22:52:05.817',NULL,'2018-12-18 22:52:11.603',5786,'completed',50,NULL,NULL,NULL,'1'),('30119','LeaveBill:1:30104','user','30105','30105','用户提交',NULL,NULL,NULL,NULL,'2018-12-18 22:52:11.607',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,'1');
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_varinst`
--

DROP TABLE IF EXISTS `act_hi_varinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_varinst`
--

LOCK TABLES `act_hi_varinst` WRITE;
/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
INSERT INTO `act_hi_varinst` VALUES ('30112','30105','30105',NULL,'days','integer',1,NULL,NULL,11,'11',NULL,'2018-12-18 22:52:05.813','2018-12-18 22:52:11.598'),('30113','30105','30105',NULL,'flag','string',1,NULL,NULL,NULL,'驳回',NULL,'2018-12-18 22:52:05.813','2018-12-18 22:52:11.600');
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_group`
--

DROP TABLE IF EXISTS `act_id_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_group`
--

LOCK TABLES `act_id_group` WRITE;
/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_info`
--

DROP TABLE IF EXISTS `act_id_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_info`
--

LOCK TABLES `act_id_info` WRITE;
/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_membership`
--

DROP TABLE IF EXISTS `act_id_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_membership`
--

LOCK TABLES `act_id_membership` WRITE;
/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_user`
--

DROP TABLE IF EXISTS `act_id_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_user`
--

LOCK TABLES `act_id_user` WRITE;
/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_procdef_info`
--

DROP TABLE IF EXISTS `act_procdef_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_procdef_info`
--

LOCK TABLES `act_procdef_info` WRITE;
/*!40000 ALTER TABLE `act_procdef_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_procdef_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_deployment`
--

DROP TABLE IF EXISTS `act_re_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_deployment`
--

LOCK TABLES `act_re_deployment` WRITE;
/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
INSERT INTO `act_re_deployment` VALUES ('12509','请教流程',NULL,'1','2018-11-10 17:47:50.296'),('30101','请假流程',NULL,'1','2018-12-18 14:50:23.963');
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_model`
--

DROP TABLE IF EXISTS `act_re_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_model`
--

LOCK TABLES `act_re_model` WRITE;
/*!40000 ALTER TABLE `act_re_model` DISABLE KEYS */;
INSERT INTO `act_re_model` VALUES ('1',13,'请假流程','LeaveBill','LeaveBill','2018-11-10 14:52:35.569','2018-12-18 14:47:07.638',1,'{\"name\":\"请假流程\",\"revision\":1,\"description\":\"内置请假流程。\"}',NULL,'2','3','1');
/*!40000 ALTER TABLE `act_re_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_procdef`
--

DROP TABLE IF EXISTS `act_re_procdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_procdef`
--

LOCK TABLES `act_re_procdef` WRITE;
/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
INSERT INTO `act_re_procdef` VALUES ('LeaveBill:1:30104',2,'LeaveBill','LeaveBill','LeaveBill',1,'30101','请假流程.bpmn20.xml','请假流程.LeaveBill.png',NULL,0,1,1,'1');
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_event_subscr`
--

DROP TABLE IF EXISTS `act_ru_event_subscr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_event_subscr`
--

LOCK TABLES `act_ru_event_subscr` WRITE;
/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_execution`
--

DROP TABLE IF EXISTS `act_ru_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_execution`
--

LOCK TABLES `act_ru_execution` WRITE;
/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
INSERT INTO `act_ru_execution` VALUES ('30105',3,'30105','LeaveBill_6',NULL,'LeaveBill:1:30104',NULL,'user',1,0,1,0,1,2,'1',NULL,NULL);
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_identitylink`
--

DROP TABLE IF EXISTS `act_ru_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_identitylink`
--

LOCK TABLES `act_ru_identitylink` WRITE;
/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
INSERT INTO `act_ru_identitylink` VALUES ('30110',1,NULL,'participant','admin',NULL,'30105',NULL),('30120',1,NULL,'candidate','admin','30119',NULL,NULL);
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_job`
--

DROP TABLE IF EXISTS `act_ru_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_job`
--

LOCK TABLES `act_ru_job` WRITE;
/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_task`
--

DROP TABLE IF EXISTS `act_ru_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_task`
--

LOCK TABLES `act_ru_task` WRITE;
/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
INSERT INTO `act_ru_task` VALUES ('30119',1,'30105','30105','LeaveBill:1:30104','用户提交',NULL,NULL,'user',NULL,NULL,NULL,50,'2018-12-18 14:52:11.607',NULL,NULL,1,'1',NULL);
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_variable`
--

DROP TABLE IF EXISTS `act_ru_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_variable`
--

LOCK TABLES `act_ru_variable` WRITE;
/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
INSERT INTO `act_ru_variable` VALUES ('30112',1,'integer','days','30105','30105',NULL,NULL,NULL,11,'11',NULL),('30113',2,'string','flag','30105','30105',NULL,NULL,NULL,NULL,'驳回',NULL);
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oa_leave_bill`
--

DROP TABLE IF EXISTS `oa_leave_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_leave_bill` (
  `leave_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(40) DEFAULT NULL COMMENT '用户名',
  `days` int(4) DEFAULT NULL COMMENT '请假天数',
  `content` varchar(255) DEFAULT NULL COMMENT '备注',
  `state` char(1) DEFAULT '0' COMMENT '状态',
  `leave_time` datetime DEFAULT NULL COMMENT '请假时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标识',
  `tenant_id` int(11) NOT NULL COMMENT '所属租户',
  PRIMARY KEY (`leave_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_leave_bill`
--

LOCK TABLES `oa_leave_bill` WRITE;
/*!40000 ALTER TABLE `oa_leave_bill` DISABLE KEYS */;
INSERT INTO `oa_leave_bill` VALUES (2,'admin',16,'2018-12-19 12:00','1','2018-12-19 12:00:00','2018-12-18 22:35:45','2018-12-18 22:37:13','0',1),(3,'admin',20,'2018-12-22 12:00','1','2018-12-22 12:00:00','2018-12-18 22:41:11','2018-12-18 22:41:27','0',1),(4,'admin',22,'111','1','2018-12-03 12:00:00','2018-12-18 22:42:45','2018-12-18 22:42:50','0',1),(5,'admin',20,'11111','1','2018-12-12 12:00:00','2018-12-18 22:45:30','2018-12-18 22:45:34','0',1),(6,'admin',11,'12','1','2018-12-04 12:00:00','2018-12-18 22:51:19','2018-12-18 22:51:52','0',1);
/*!40000 ALTER TABLE `oa_leave_bill` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-16 15:53:28
