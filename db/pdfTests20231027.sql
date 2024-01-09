-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pdftests
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `speciality` int NOT NULL,
  `isadmin` tinyint(1) DEFAULT '0',
  `school` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `school` (`school`),
  KEY `speciality` (`speciality`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`school`) REFERENCES `schools` (`id`),
  CONSTRAINT `accounts_ibfk_2` FOREIGN KEY (`speciality`) REFERENCES `specialities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Калин','Стоянов','kalin@abv.bg','MTIz',2,1,1),(3,'Антони','Василев','antoni@gmail.com','123',2,0,1),(19,'Михаил','Иванов','mihail@gmail.com','MzIx',1,1,1),(38,'Цветомир','Цонев','AndRotate@hotmale.us','aHVpcGl0aXU=',1,0,1);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `questionCategory` varchar(50) NOT NULL,
  `categoryText` varchar(500) DEFAULT NULL,
  `categoryNum` int DEFAULT NULL,
  PRIMARY KEY (`questionCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('1_1_1','Дефинира понятията: програмиране, език за програмиране, среда за разработка (IDE), компилация и интерпретация. Демонстрира употребата на основни функционалности на среда за разработка (създаване и зареждане на проект, стартиране на проект).',1),('1_1_2','Описва понятието променлива. Сравнява типове променливи. Разработва програми/програмни фрагменти с аритметични и логически изрази с участието на променливи и числа.',2);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `speciality` varchar(80) NOT NULL,
  `ticket` int NOT NULL,
  `questionCategory` varchar(50) DEFAULT NULL,
  `questionVar` int NOT NULL,
  `questionText` varchar(600) NOT NULL,
  `answerA` varchar(150) DEFAULT NULL,
  `answerB` varchar(150) DEFAULT NULL,
  `answerC` varchar(150) DEFAULT NULL,
  `answerD` varchar(150) DEFAULT NULL,
  `points` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Системно програмиране',1,'1_1_1',1,'2 + 2 = ?',NULL,NULL,NULL,NULL,4),(2,'Системно програмиране',1,'1_1_1',2,'3 + 2 = ?',NULL,NULL,NULL,NULL,4),(3,'Системно програмиране',2,'1_2_1',1,'7 + 7 = ?','49','47','64','14',2),(4,'Системно програмиране',2,'1_2_1',2,'7 * 7 = ?','14','64','46','49',2),(5,'Системно програмиране',1,'1_1_2',1,'14 + 4 = ?',NULL,NULL,NULL,NULL,6),(6,'Системно програмиране',1,'1_1_2',2,'14 - 4 = ?',NULL,NULL,NULL,NULL,6),(7,'Системно програмиране',1,'1_1_3',1,'18 * 18 = ?',NULL,NULL,NULL,NULL,8),(8,'Системно програмиране',1,'1_1_3',2,'359 + 424 = ?',NULL,NULL,NULL,NULL,8),(9,'Системно програмиране',2,'1_2_2',1,'42 - 42 = ?','0','1','2','4',2),(10,'Системно програмиране',2,'1_2_2',2,'42 + 42 = ?','42','1','0','84',2),(11,'Системно програмиране',1,'1_1_1',1,'585 - 585',NULL,NULL,NULL,NULL,6),(12,'Системно програмиране',1,'1_1_1',2,'585 + 585',NULL,NULL,NULL,NULL,6),(27,'Системно програмиране',3,'1_3_1',1,'Обяснете същност и действие на оператор for.',NULL,NULL,NULL,NULL,8),(28,'Системно програмиране',3,'1_3_1',2,'Обяснете същност и действие на оператор foreach.',NULL,NULL,NULL,NULL,8),(29,'Системно програмиране',3,'1_3_1',1,'ДНП на C#, която пресмята лице на триъгълник',NULL,NULL,NULL,NULL,6),(30,'Системно програмиране',3,'1_3_1',2,'ДНП на C#, която пресмята лице на окръжност',NULL,NULL,NULL,NULL,6),(31,'Системно програмиране',3,'1_3_2',1,'ДНП на C#, която пресмята лице на триъгълник',NULL,NULL,NULL,NULL,6),(32,'Системно програмиране',3,'1_3_2',2,'ДНП на C#, която пресмята лице на окръжност',NULL,NULL,NULL,NULL,6),(33,'Приложно програмиране',1,'2_1_1',1,'affffarw',NULL,NULL,NULL,NULL,4),(34,'Приложно програмиране',1,'2_1_1',2,'darq3rqr',NULL,NULL,NULL,NULL,4),(35,'Приложно програмиране',2,'2_2_1',1,'Кой е Калин?',NULL,NULL,NULL,NULL,8),(36,'Приложно програмиране',2,'2_2_1',2,'Не знам :)',NULL,NULL,NULL,NULL,8),(37,'Системно програмиране',1,'1_1_1',1,'-5 + 5 = ?',NULL,NULL,NULL,NULL,2),(38,'Системно програмиране',1,'1_1_1',2,'-956 + 5032 = ?',NULL,NULL,NULL,NULL,2),(39,'Приложно програмиране',2,'2_2_2',1,'Здрасти',NULL,NULL,NULL,NULL,365),(40,'Приложно програмиране',2,'2_2_2',2,'Чао',NULL,NULL,NULL,NULL,365),(41,'Приложно програмиране',1,'2_1_1',1,'Въпросче',NULL,NULL,NULL,NULL,4),(42,'Приложно програмиране',1,'2_1_1',2,'Отговорче',NULL,NULL,NULL,NULL,4),(43,'Приложно програмиране',1,'2_1_2',1,'Вар1',NULL,NULL,NULL,NULL,6),(44,'Приложно програмиране',1,'2_1_2',2,'Вар2',NULL,NULL,NULL,NULL,6),(45,'Приложно програмиране',1,'2_1_2',1,'ВРР1',NULL,NULL,NULL,NULL,4),(46,'Приложно програмиране',1,'2_1_2',2,'ВРР2',NULL,NULL,NULL,NULL,4),(47,'Приложно програмиране',1,'2_1_2',1,'рар1',NULL,NULL,NULL,NULL,8),(48,'Приложно програмиране',1,'2_1_2',2,'рар2',NULL,NULL,NULL,NULL,8),(49,'Системно програмиране',3,'1_3_2',1,'Да се напише програма',NULL,NULL,NULL,NULL,8),(50,'Системно програмиране',3,'1_3_2',2,'Да се напише програмка',NULL,NULL,NULL,NULL,8),(51,'Системно програмиране',3,'1_3_2',1,'Вар1',NULL,NULL,NULL,NULL,4),(52,'Системно програмиране',3,'1_3_2',2,'Вар2',NULL,NULL,NULL,NULL,4),(54,'Системно програмиране',4,'1_4_1',1,'условие','Език за програмиране','Език за говорене','Рецепта за готвене','сестра',2),(55,'Системно програмиране',4,'1_4_1',2,'Условие на въпроса','Език за програмиране',' Нз','46','Милн',2),(56,'Системно програмиране',4,'1_4_1',1,'fofmJAWr',NULL,NULL,NULL,NULL,6),(57,'Системно програмиране',4,'1_4_1',2,'fasfwrar',NULL,NULL,NULL,NULL,6),(58,'Системно програмиране',4,'1_4_1',1,'1q23125412','rwzz','rw','xf','zfz',2),(59,'Системно програмиране',4,'1_4_1',2,'63467347347347','hf','sfd','t','ee',2);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schools` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schoolName` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES (1,'ПГЕ'),(2,'ПТГ'),(3,'Пета езиока гимназия');
/*!40000 ALTER TABLE `schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialities`
--

DROP TABLE IF EXISTS `specialities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `specialityName` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialities`
--

LOCK TABLES `specialities` WRITE;
/*!40000 ALTER TABLE `specialities` DISABLE KEYS */;
INSERT INTO `specialities` VALUES (1,'Системно програмиране'),(2,'Приложно програмиране');
/*!40000 ALTER TABLE `specialities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teststatistics`
--

DROP TABLE IF EXISTS `teststatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teststatistics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `generatedTests` int DEFAULT NULL,
  `questionsCount` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teststatistics`
--

LOCK TABLES `teststatistics` WRITE;
/*!40000 ALTER TABLE `teststatistics` DISABLE KEYS */;
INSERT INTO `teststatistics` VALUES (1,4,12);
/*!40000 ALTER TABLE `teststatistics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-27 14:10:01
