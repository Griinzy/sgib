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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Калин','Стоянов','kalin@abv.bg','MTIz',2,1,1),(3,'Антони','Василев','antoni@gmail.com','MTIz',2,0,1),(19,'Михаил','Иванов','mihail@gmail.com','MzIx',1,1,1),(40,'Иво','Арбов','ivo@abv.bg','MTIz',4,0,2),(42,'Тест','Учител','test-teacher@gmail.com','dGVhY2hlcg==',1,0,1),(43,'Тест','Админ','test-admin@gmail.com','YWRtaW4=',1,1,1),(44,'Димитър','Аврамов','dimityr.avramov.93@gmail.com','MTIzNDU2Nzg5',1,1,1);
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
  `points` int DEFAULT NULL,
  PRIMARY KEY (`questionCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('1_1_1','Дефинира понятията: програмиране, език за програмиране, среда за разработка (IDE), компилация и интерпретация. Демонстрира употребата на основни функционалности на среда за разработка (създаване и зареждане на проект, стартиране на проект).',1,12),('1_1_2','Описва понятието променлива. Сравнява типове променливи. Разработва програми/програмни фрагменти с аритметични и логически изрази с участието на променливи и числа.',2,12),('1_1_3','Описва условни конструкции – пълна и кратка форма. Описва оператор за многовариантен избор (switch). Сравнява условни конструкции с няколко условия (else if) и оператор за многовариантен избор (switch). ',3,16),('1_1_4','Описва и разработва програми/програмни фрагменти с оператори за цикли. Различава операторите за цикли. Определя и посочва кои фрагменти код се изпълняват, колко пъти и в какъв ред при оператори за цикли.',4,20),('1_1_5','Обяснява същността на подпрограмите (функции/методи). Посочва видове параметри и връщани стойности. Дава пример за предимствата от използването на методи.',5,16),('1_1_6','Анализира фрагмент/и от код и идентифицира и поправя правилно грешките в написания програмен код, така че да реши поставената задача. Допълва кода, ако и когато това е необходимо.',6,24),('1_14_1','Kat.1',1,50),('1_14_2','Kat.2',2,50),('1_17_1','Описание',1,4),('1_17_2','Описание2',2,96),('1_18_1','Описание на кат.1',1,40),('1_18_2','Описание на кат.2',2,60),('1_5_1','Резюме - СГИБ',1,0),('1_9_6','Категория 6 описание',6,12),('2_1_1','Подробно описание на тема как се програмира компютър',1,14),('2_1_2','Кратко описание на тема как НЕ се програмиране компютър',2,12);
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
  `school` int DEFAULT NULL,
  `speciality` varchar(80) NOT NULL,
  `ticket` int NOT NULL,
  `questionCategory` varchar(50) DEFAULT NULL,
  `questionVar` int NOT NULL,
  `questionText` varchar(600) NOT NULL,
  `answerA` varchar(400) DEFAULT NULL,
  `answerB` varchar(400) DEFAULT NULL,
  `answerC` varchar(400) DEFAULT NULL,
  `answerD` varchar(400) DEFAULT NULL,
  `correctAnswer` varchar(400) DEFAULT NULL,
  `points` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,1,'Системно програмиране',1,'1_1_1',1,'Какво е програмиране?',NULL,NULL,NULL,NULL,NULL,6),(2,1,'Системно програмиране',1,'1_1_1',2,'Какво представлява език за програмиране?',NULL,NULL,NULL,NULL,NULL,6),(3,1,'Системно програмиране',2,'1_2_1',1,'7 + 7 = ?','49','47','64','14',NULL,2),(4,1,'Системно програмиране',2,'1_2_1',2,'7 * 7 = ?','14','64','46','49',NULL,2),(5,1,'Системно програмиране',1,'1_1_2',1,'Запишете дефиниция за променлива',NULL,NULL,NULL,NULL,NULL,6),(6,1,'Системно програмиране',1,'1_1_2',2,'Запишете дефиниция за константа',NULL,NULL,NULL,NULL,NULL,6),(7,1,'Системно програмиране',1,'1_1_3',1,'Какво означава условния оператор &&','Побитово или','Логическо и','Логическо или','Логическо дали',NULL,2),(8,1,'Системно програмиране',1,'1_1_3',2,'Какво означава условния оператор ||','Логическо или','Логическо и','Побитово или','Побитово и',NULL,2),(9,1,'Системно програмиране',2,'1_2_2',1,'42 - 42 = ?','0','1','2','4',NULL,2),(10,1,'Системно програмиране',2,'1_2_2',2,'42 + 42 = ?','42','1','0','84',NULL,2),(11,1,'Системно програмиране',1,'1_1_1',1,'Какво представлява средата за разработка (IDE)?','Специализиран софтуер с включен компилатор/интерпретатор, дебъгер и текстов редактор','Текстов редактор','Методолодия за програмиране','Framework, улесняващ процеса на разработка',NULL,2),(12,1,'Системно програмиране',1,'1_1_1',2,'Кое от следните е среда за разработка?','Haskell','Assembly','Visual Studio','GitHub',NULL,2),(27,1,'Системно програмиране',3,'1_3_1',1,'Обяснете същност и действие на оператор for.',NULL,NULL,NULL,NULL,NULL,8),(28,1,'Системно програмиране',3,'1_3_1',2,'Обяснете същност и действие на оператор foreach.',NULL,NULL,NULL,NULL,NULL,8),(29,1,'Системно програмиране',3,'1_3_1',1,'ДНП на C#, която пресмята лице на триъгълник',NULL,NULL,NULL,NULL,NULL,6),(30,1,'Системно програмиране',3,'1_3_1',2,'ДНП на C#, която пресмята лице на окръжност',NULL,NULL,NULL,NULL,NULL,6),(31,1,'Системно програмиране',3,'1_3_2',1,'ДНП на C#, която пресмята лице на триъгълник',NULL,NULL,NULL,NULL,NULL,6),(32,1,'Системно програмиране',3,'1_3_2',2,'ДНП на C#, която пресмята лице на окръжност',NULL,NULL,NULL,NULL,NULL,6),(33,1,'Приложно програмиране',1,'2_1_1',1,'affffarw',NULL,NULL,NULL,NULL,NULL,4),(34,1,'Приложно програмиране',1,'2_1_1',2,'darq3rqr',NULL,NULL,NULL,NULL,NULL,4),(35,1,'Приложно програмиране',2,'2_2_1',1,'Кой е Калин?',NULL,NULL,NULL,NULL,NULL,8),(36,1,'Приложно програмиране',2,'2_2_1',2,'Не знам :)',NULL,NULL,NULL,NULL,NULL,8),(37,1,'Системно програмиране',1,'1_1_1',1,'Кой от следните езици е \"markup\" език?','HTML','C#','JavaScript','Java',NULL,2),(38,1,'Системно програмиране',1,'1_1_1',2,'Кой от следните езици НЕ е \"markup\" език?','XML','HTML','C#','XAML',NULL,2),(39,1,'Приложно програмиране',2,'2_2_2',1,'Здрасти',NULL,NULL,NULL,NULL,NULL,365),(40,1,'Приложно програмиране',2,'2_2_2',2,'Чао',NULL,NULL,NULL,NULL,NULL,365),(41,1,'Приложно програмиране',1,'2_1_1',1,'11111111111111111111111111111111111111',NULL,NULL,NULL,NULL,NULL,4),(42,1,'Приложно програмиране',1,'2_1_1',2,'Отговорче',NULL,NULL,NULL,NULL,NULL,4),(43,1,'Приложно програмиране',1,'2_1_2',1,'Вар1',NULL,NULL,NULL,NULL,NULL,6),(44,1,'Приложно програмиране',1,'2_1_2',2,'Вар2',NULL,NULL,NULL,NULL,NULL,6),(45,1,'Приложно програмиране',1,'2_1_2',1,'ВРР1',NULL,NULL,NULL,NULL,NULL,4),(46,1,'Приложно програмиране',1,'2_1_2',2,'ВРР2',NULL,NULL,NULL,NULL,NULL,4),(47,1,'Приложно програмиране',1,'2_1_2',1,'рар1',NULL,NULL,NULL,NULL,NULL,8),(48,1,'Приложно програмиране',1,'2_1_2',2,'рар2',NULL,NULL,NULL,NULL,NULL,8),(49,1,'Системно програмиране',3,'1_3_2',1,'Да се напише програма',NULL,NULL,NULL,NULL,NULL,8),(50,1,'Системно програмиране',3,'1_3_2',2,'Да се напише програмка',NULL,NULL,NULL,NULL,NULL,8),(51,1,'Системно програмиране',3,'1_3_2',1,'Вар1',NULL,NULL,NULL,NULL,NULL,4),(52,1,'Системно програмиране',3,'1_3_2',2,'Вар2',NULL,NULL,NULL,NULL,NULL,4),(54,1,'Системно програмиране',4,'1_4_1',1,'условие','Език за програмиране','Език за говорене','Рецепта за готвене','сестра',NULL,2),(55,1,'Системно програмиране',4,'1_4_1',2,'Условие на въпроса','Език за програмиране',' Нз','46','Милн',NULL,2),(56,1,'Системно програмиране',4,'1_4_1',1,'fofmJAWr',NULL,NULL,NULL,NULL,NULL,6),(57,1,'Системно програмиране',4,'1_4_1',2,'fasfwrar',NULL,NULL,NULL,NULL,NULL,6),(58,1,'Системно програмиране',4,'1_4_1',1,'1q23125412','rwzz','rw','xf','zfz',NULL,2),(59,1,'Системно програмиране',4,'1_4_1',2,'63467347347347','hf','sfd','t','ee',NULL,2),(60,1,'Системно програмиране',1,'1_1_3',1,'Подробно описание на кратка форма на условен оператор',NULL,NULL,NULL,NULL,NULL,4),(61,1,'Системно програмиране',1,'1_1_3',2,'Подробно описание на пълна форма на условен оператор',NULL,NULL,NULL,NULL,NULL,4),(62,1,'Системно програмиране',1,'1_1_3',1,'Как се записва оператор за многовариантен избор','switch','if','else','switchcase',NULL,2),(63,1,'Системно програмиране',1,'1_1_3',2,'Как се записва оператор за изпълнение по подразбиране в многовариантен избор switch','switch','case','default','always',NULL,2),(66,1,'Приложно програмиране',2,'2_2_1',1,'daadwrhhdg',NULL,NULL,NULL,NULL,NULL,6),(67,1,'Приложно програмиране',2,'2_2_1',2,'zxvvchndfgee',NULL,NULL,NULL,NULL,NULL,6),(68,1,'Системно програмиране',1,'1_1_99',1,'Айпито какво е','10.3.2.35:5194','няма','Хъх?','Моля?',NULL,2),(69,1,'Системно програмиране',18,'1_18_1',1,'Test321',NULL,NULL,NULL,NULL,NULL,20),(70,1,'Системно програмиране',18,'1_18_1',2,'Test123',NULL,NULL,NULL,NULL,NULL,20),(71,1,'Системно програмиране',17,'1_17_1',1,'2+2=?','4','6','43','214',NULL,2),(72,1,'Системно програмиране',17,'1_17_1',2,'4+4=?','6','8','14','142412412',NULL,2),(73,1,'Приложно програмиране',1,'2_1_13',1,'grrrrrrrr','',NULL,NULL,NULL,NULL,6),(74,1,'Приложно програмиране',1,'2_1_13',2,'chao',NULL,NULL,NULL,NULL,NULL,6),(75,1,'Системно програмиране',18,'1_18_1',1,'2Test',NULL,NULL,NULL,NULL,NULL,20),(76,1,'Системно програмиране',18,'1_18_1',2,'Test2',NULL,NULL,NULL,NULL,NULL,20),(77,1,'Системно програмиране',18,'1_18_2',1,'T',NULL,NULL,NULL,NULL,NULL,30),(78,1,'Системно програмиране',18,'1_18_2',2,'R',NULL,NULL,NULL,NULL,NULL,30),(79,1,'Приложно програмиране',1,'2_1_24',1,'547y',NULL,NULL,NULL,NULL,NULL,4),(80,1,'Приложно програмиране',1,'2_1_24',2,'ugfdv v',NULL,NULL,NULL,NULL,NULL,4),(81,1,'Системно програмиране',18,'1_18_2',1,'123',NULL,NULL,NULL,NULL,NULL,30),(82,1,'Системно програмиране',18,'1_18_2',2,'123',NULL,NULL,NULL,NULL,NULL,30),(83,1,'Приложно програмиране',1,'2_1_2',1,'<button>Click me</button>',NULL,NULL,NULL,NULL,NULL,4),(84,1,'Приложно програмиране',1,'2_1_2',2,'<button>Click me</button>',NULL,NULL,NULL,NULL,NULL,4),(85,1,'Приложно програмиране',1,'2_1_1',1,'<input type=\"submit\" />',NULL,NULL,NULL,NULL,NULL,8),(86,1,'Приложно програмиране',1,'2_1_1',2,'<input type=\"submit\" />',NULL,NULL,NULL,NULL,NULL,8),(87,1,'Системно програмиране',4,'1_4_1',1,'sdfghjkl','aa','ddgs','sdg','dsg',NULL,2),(88,1,'Системно програмиране',4,'1_4_1',2,'fghjkl','aa','sdg','sdg','sdg',NULL,2),(89,1,'Системно програмиране',1,'1_1_98',1,'edfsaf',NULL,NULL,NULL,NULL,NULL,4),(90,1,'Системно програмиране',1,'1_1_98',2,'dsfsafds',NULL,NULL,NULL,NULL,NULL,4),(91,1,'Системно програмиране',1,'1_1_1',1,'Запишете стъпките за създаване на конзолно приложение в средата за разработка Visual Studio',NULL,NULL,NULL,NULL,NULL,4),(92,1,'Системно програмиране',1,'1_1_1',2,'Запишете как се инсталират NuGet пакети към проект във Visual Studio',NULL,NULL,NULL,NULL,NULL,4),(93,1,'Системно програмиране',1,'1_1_1',1,'Кои от следните са задачи на интерпретатора?','Превежда машинен код в програмен код','Проверява за грешки след изпълнението на кода','Проверява за грешки преди изпълнението на кода','Превежда програмния код код в машинен код',NULL,2),(94,1,'Системно програмиране',1,'1_1_1',2,'Кои от следните са задачи на компилатора?','Превежда машинен код в програмен код','Проверява за грешки след изпълнението на кода','Проверява за грешки преди изпълнението на кода','Превежда програмния код код в машинен код',NULL,2),(95,1,'Системно програмиране',1,'1_1_1',1,'Запишете 3 основни функционалности на средата за разработка',NULL,NULL,NULL,NULL,NULL,4),(96,1,'Системно програмиране',1,'1_1_1',1,'Опишете стъпките за стартиране на проект',NULL,NULL,NULL,NULL,NULL,4),(97,1,'Приложно програмиране',1,'2_1_1',1,'gjhkl',NULL,NULL,NULL,NULL,NULL,8),(98,1,'Приложно програмиране',1,'2_1_1',2,'/',NULL,NULL,NULL,NULL,NULL,8),(99,1,'Приложно програмиране',1,'2_1_1',1,'dfgfg',NULL,NULL,NULL,NULL,NULL,6),(100,1,'Приложно програмиране',1,'2_1_1',2,';',NULL,NULL,NULL,NULL,NULL,6),(101,1,'Системно програмиране',5,'1_5_15',1,'Blq','wa','vas','gjgf','sdsg',NULL,2),(102,1,'Системно програмиране',5,'1_5_15',2,'wa','gfdg','sdas','sfdfs','jhgfh',NULL,2),(103,1,'Системно програмиране',9,'1_9_6',1,'dfhsgvdhf','kusytd gecv','sdfjhjs','kjdhbfkjbs','kjhdfujh',NULL,2),(104,1,'Системно програмиране',9,'1_9_6',2,'ky db k ljkxhbkjlsd','skdjgfiylkvc','knlflj lk','lknvjlsdnl','kljbj',NULL,2),(105,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(106,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(107,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(108,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(109,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(110,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(111,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(112,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(113,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(114,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(115,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(116,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(117,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(118,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(119,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(120,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(121,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(122,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(123,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(124,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(125,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(126,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(127,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(128,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(129,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(130,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(131,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(132,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(133,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(134,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(135,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(136,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(137,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(138,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(139,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(140,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(141,1,'Системно програмиране',12,'1_12_99',1,'Какво е айпито','10.3.2.35:5194','да','Хъх?','Моля?',NULL,2),(142,1,'Системно програмиране',12,'1_12_99',2,'Какво е айпито','И двете','Няма','Възможно е','Древен Рим е една от основните цивилизации от Античността',NULL,2),(143,1,'Системно програмиране',4,'1_4_2',1,'zx\\zczdvcvzsdgsdf ',NULL,NULL,NULL,NULL,NULL,6),(144,1,'Системно програмиране',4,'1_4_2',2,'dzsz',NULL,NULL,NULL,NULL,NULL,6),(145,1,'Системно програмиране',14,'1_14_1',1,'Зад1',NULL,NULL,NULL,NULL,NULL,50),(146,1,'Системно програмиране',14,'1_14_1',2,'Зад2',NULL,NULL,NULL,NULL,NULL,50),(147,1,'Системно програмиране',14,'1_14_2',1,'Зад2',NULL,NULL,NULL,NULL,NULL,50),(148,1,'Системно програмиране',14,'1_14_2',2,'Зад2',NULL,NULL,NULL,NULL,NULL,50),(149,1,'Системно програмиране',17,'1_17_1',1,'215 - 215 = ?','0','1245','530','1',NULL,2),(150,1,'Системно програмиране',17,'1_17_1',2,'500 + 500 = ?','1000','501','-1000','1',NULL,2),(151,1,'Системно програмиране',17,'1_17_2',1,'cos2 (x) + sin2 (x) = (eix + e-ix )2 /4 + sin2 (x) = (e2ix + e-2ix )/4 + e2ln(sin(x)) + 1/2 = ?','1','sin2(45)','cos90','1000','1,2,3,4',90),(152,1,'Системно програмиране',17,'1_17_2',2,'cos2 (x) + sin2 (x) = (eix + e-ix )2 /4 + sin2 (x) = (e2ix + e-2ix )/4 + e2ln(sin(x)) - 1/2','1/2','sin2(45)','cos90','Древен Рим е една от основните цивилизации от Античността, получила своето название от главния си град Рим (Roma), наречен на свой ред на легендарния си основател – Ромул. Тя заема териториални площи в Европа, Северна Африка и Близкия изток, като първоначално е основана на Апенини','4',90),(153,1,'Системно програмиране',17,'1_17_2',1,'√(4.(sin²(18272819)+cos²(18272819)) + e^π = ?',NULL,NULL,NULL,NULL,'8tyuiofklsacfaqjpo',6),(154,1,'Системно програмиране',17,'1_17_2',2,'Sin(42069)2 + cos(42069)2 = ?',NULL,NULL,NULL,NULL,'as78iyuash',6),(155,1,'Системно програмиране',17,'1_17_3',1,'Дайте определение за Древен Рим',NULL,NULL,NULL,NULL,NULL,0),(156,1,'Системно програмиране',17,'1_17_3',2,'Обяснете историята на древен Рим в 40 изрчения',NULL,NULL,NULL,NULL,NULL,0),(157,1,'Системно програмиране',17,'1_17_4',1,'Имам 5 круши. Давам 5 на петър, колко е 3?',NULL,NULL,NULL,NULL,NULL,0),(158,1,'Системно програмиране',17,'1_17_4',2,'Гошо има 3 тона сапун. Гошо дава 3 милиона грама на Мишо. Колко микрограма сапун му остават?',NULL,NULL,NULL,NULL,NULL,0),(159,1,'Системно програмиране',14,'1_14_1',1,'for(int i = 0; i<a.Lenght; i++)\r\n{\r\n     if(a[i]==b)\r\n        {\r\n            Console.WriteLine(\"a[i]\");\r\n       }\r\n}\r\n\r\n\r\n',NULL,NULL,NULL,NULL,NULL,0),(160,1,'Системно програмиране',14,'1_14_1',2,'for(int i = 0; i<a.Lenght; i++)\r\n{\r\n     if(a[i]==b)\r\n        {\r\n            Console.WriteLine(\"a[i]\");\r\n       }\r\n}\r\n\r\n\r\n',NULL,NULL,NULL,NULL,NULL,0),(161,1,'Системно програмиране',1,'1_1_2',1,'Кой тип променлива се използва само за цели числа?','int','double','decimal','float',NULL,2),(162,1,'Системно програмиране',1,'1_1_2',2,'Кой тип променлива се използва за символен низ?','string','double','symbol','char',NULL,2),(163,1,'Системно програмиране',1,'1_1_2',1,'Кога е уместно да използваме променлива от тип double и кога променлива от тип int',NULL,NULL,NULL,NULL,NULL,4),(164,1,'Системно програмиране',1,'1_1_2',2,'Кога се използва променлива от тип double и кога променлива от тип decimal',NULL,NULL,NULL,NULL,NULL,4),(165,1,'Системно програмиране',1,'1_1_3',1,'Какъв ще бъде изходния резултат от следния код:\r\nint a = 2;\r\nint b = a + 2;\r\nif(a < b) \r\n{\r\n   b -= 2;\r\n}\r\nelse if(a == b)\r\n{\r\n   b = a + 4;\r\n}\r\nConsole.WriteLine(b);',NULL,NULL,NULL,NULL,NULL,8),(166,1,'Системно програмиране',1,'1_1_3',2,'Какъв ще бъде изходния резултат от следния код:\r\nint a = 2;\r\nint b = a + 2;\r\nswitch(b)\r\n{\r\n    case 2: b = 100; break;\r\n    case 3: b = 90; break;\r\n    case 5: b = 110; break;\r\n    default: b = 95; break;\r\n}\r\nConsole.WriteLine(b);',NULL,NULL,NULL,NULL,NULL,8),(167,1,'Системно програмиране',1,'1_1_4',1,'Кой оператор за цикъл задължително се изпълнява поне веднъж?',NULL,NULL,NULL,NULL,NULL,6),(168,1,'Системно програмиране',1,'1_1_4',2,'Запишете пример за оператор, чрез който може да се обходи колекция',NULL,NULL,NULL,NULL,NULL,6),(169,1,'Системно програмиране',1,'1_1_4',1,'Как се записва оператор за броячен цикъл?','for','foreach','count','whilecount',NULL,2),(170,1,'Системно програмиране',1,'1_1_4',2,'Как се записва оператор за цикъл с предусловие?','while','foreach','switch','condition',NULL,2),(171,1,'Системно програмиране',1,'1_1_4',1,'Какъв е изходния резултат от следния код:\r\n\r\nfor(int i = -1; i<2; i++)\r\n{\r\n    Console.WriteLine(i);\r\n}',NULL,NULL,NULL,NULL,NULL,8),(172,1,'Системно програмиране',1,'1_1_4',2,'Какъв е изходния резултат от следния код:\r\nint a = 15;\r\nwhile(a<25)\r\n{\r\n      a+= 5;\r\n     Console.WriteLine(a);\r\n}',NULL,NULL,NULL,NULL,NULL,8),(173,1,'Системно програмиране',1,'1_1_4',1,'Изпишете всички елементи от следната колекция на конзолата, използвайки цикъл foreach:\r\nList<int> numbers = new List<int> { 5, 4, 3, 2, 1 };',NULL,NULL,NULL,NULL,NULL,4),(174,1,'Системно програмиране',1,'1_1_4',2,'Изпишете всички елементи от следния масив на конзолата, използвайки цикъл for като достъпите дължината на масива:\r\nint[] numbers = { 5, 4, 3, 2, 1 };',NULL,NULL,NULL,NULL,NULL,4),(175,1,'Системно програмиране',1,'1_1_5',1,'Да се напише дефиниция за подпрограма и да се дефинира примерна функция.',NULL,NULL,NULL,NULL,NULL,8),(176,1,'Системно програмиране',1,'1_1_5',2,'В кои случаи и защо използваме подпрограми? Да се дефинира примерна функция.',NULL,NULL,NULL,NULL,NULL,8),(177,1,'Системно програмиране',1,'1_1_5',1,'С какъв идентификатор за достъп трябва да е една функция, ако не искаме да се достъпва във външни класове?','public','protected','private','internal',NULL,2),(178,1,'Системно програмиране',1,'1_1_5',2,'В какъв случай пишем функция да е от тип void?','Когато функцията връща стойност','Когато функцията е рекурсивна','Когато функцията не трябва да връща стойност','Когато не искаме да бъде достъпвана от външни класове',NULL,2),(179,1,'Системно програмиране',1,'1_1_5',1,'Каква стойност ще има променливата number след използването на следната функция:\r\n\r\npublic double Calculate(double a, double b) \r\n{\r\n     return Math.Pow(a, b);\r\n}\r\ndouble number = Calculate(2, 3);',NULL,NULL,NULL,NULL,NULL,4),(180,1,'Системно програмиране',1,'1_1_5',2,'Какви стойности ще се изведат на конзолата след използването на следната функция:\r\n\r\npublic void SendMessage(string msg)\r\n{\r\n    Console.WriteLine($\"Sending message: {msg}\");\r\n}\r\nSendMessage(\"Hello world!\");',NULL,NULL,NULL,NULL,NULL,4),(181,1,'Системно програмиране',1,'1_1_5',1,'Какъв вид функции не е нужно да връщат стойност?','double','int','void','notReturn',NULL,2),(182,1,'Системно програмиране',1,'1_1_5',2,'Какъв идентификатор за достъп трябва да има функцията ни ако желаем да я достъпваме от всички класове?','public','private','protected','available',NULL,2),(183,1,'Системно програмиране',1,'1_1_6',1,'Открийте грешката в следния програмен код:\r\n\r\ndouble num1 = 8.5;\r\ndouble num = 4.2;\r\nstring result = Add(num1, num2);\r\nConsole.WriteLine(result);\r\n\r\nstatic void Add(double a, double b)\r\n{\r\n    return a + b;\r\n}',NULL,NULL,NULL,NULL,NULL,8),(184,1,'Системно програмиране',1,'1_1_6',2,'Открийте грешката в следния програмен код:\r\n\r\ndouble radius = 5.0;\r\ndouble area = CalculateArea(radius);\r\nConsole.Writeline(area);\r\nstatic double CalculateArea(int r)\r\n{\r\n   return Math.PI*r*r;\r\n}',NULL,NULL,NULL,NULL,NULL,8),(185,1,'Системно програмиране',1,'1_1_6',1,'Открийте грешката в следния програмен код:\r\nstatic void main[]\r\n{\r\n    Console.WriteLine(\"Hello\");\r\n}',NULL,NULL,NULL,NULL,NULL,8),(186,1,'Системно програмиране',1,'1_1_6',2,'Открийте грешката в следния програмен код:\r\ndouble fahrenheit = 32;\r\ndouble celsius = ConvertToCelsius(fahrenheit);\r\n\r\nstatic double converttoCelsius(double f)\r\n{\r\n    return (f-32)*5/9;\r\n}',NULL,NULL,NULL,NULL,NULL,8),(187,1,'Системно програмиране',1,'1_1_6',1,'Открийте грешката в следния програмен код:\r\n\r\nList<int> numbers = {1, 2, 3, 4, 5};\r\nforeach(var item in numbers)\r\n{\r\n   Console.WriteLine(item);\r\n}',NULL,NULL,NULL,NULL,NULL,8),(188,1,'Системно програмиране',1,'1_1_6',2,'Открийте грешката в следния програмен код:\r\n\r\ndouble num1 = 15;\r\ndouble num2 = 22;\r\ndouble num3 = 41;\r\nCalculate(num1, num2, num3);\r\n\r\nstatic void Calculate(int a, int b)\r\n{\r\n     int result = a + b;\r\n    Console.WriteLine(result);\r\n}',NULL,NULL,NULL,NULL,NULL,8),(189,1,'Приложно програмиране',1,'2_1_1',1,'gbcbvbcb','fd','wewtw','werfwd','twef',NULL,2),(190,1,'Приложно програмиране',1,'2_1_1',2,'hdfgsfv scx','rwefw','rfqe','rqfs','rqwd',NULL,2),(191,1,'Приложно програмиране',1,'2_1_1',1,'we','asdfcas','afafs','fafscs','fasxc',NULL,2),(192,1,'Приложно програмиране',1,'2_1_1',2,'vfasfsa','fazc','vfazsc','fazczs','fvszcvz',NULL,2),(193,1,'Приложно програмиране',1,'2_1_1',1,'gavsfca','afsfcaf','safasfas','fasfasfasfaf','afafa',NULL,2),(194,1,'Приложно програмиране',1,'2_1_1',2,'a\\cscd','affsa','fsfafa','fasfaf','afaf',NULL,2),(196,1,'Приложно програмиране',1,'2_1_1',1,'fhfbs',NULL,NULL,NULL,NULL,'syses',4),(197,1,'Приложно програмиране',1,'2_1_1',2,'gsye',NULL,NULL,NULL,NULL,'tgetwtg',4),(198,1,'Приложно програмиране',1,'2_1_1',1,'gvsdacf','casca','scascsaca','cacascsa','ascasc','1,3',2),(199,1,'Приложно програмиране',1,'2_1_1',2,'fascas','cg','ewfewf','wegtewfwe','fef','2,3,4',2),(200,1,'Приложно програмиране',1,'2_1_1',1,'dasgv','casca','fasff','fsafas','ffas','',2),(201,1,'Приложно програмиране',1,'2_1_1',2,'afasc','dasa','adsasa','sffasfas','fasfaf','4',2),(202,1,'Приложно програмиране',1,'2_1_1',1,'gvfcwaec','iofcjk','iokfcjhilkju','efiwojcajiuo','iojckajuoikjuh','',2),(203,1,'Приложно програмиране',1,'2_1_1',2,'ikfchaioqh','iokcajikoj','icujuaohlju','ikocjwasiojui','fcaiojlikj','4',2),(204,1,'Системно програмиране',1,'1_1_1',1,'test',NULL,NULL,NULL,NULL,'',4),(205,1,'Системно програмиране',1,'1_1_1',2,'test',NULL,NULL,NULL,NULL,'',4),(206,1,'Системно програмиране',5,'1_5_1',1,'Системата за генериране на изпитни билети (СГИБ) представлява ','уеб приложение ','уеб приложение ','уеб приложение ','уеб приложение ','2',2),(207,1,'Системно програмиране',5,'1_5_1',2,'Системата за генериране на изпитни билети (СГИБ) представлява ','уеб приложение ','уеб приложение ','уеб приложение ','Древен риМ','4',2),(208,1,'Системно програмиране',5,'1_5_1',1,'предназначено за учители, което изработва изпитни билети за държавния изпит за придобиване на','професионална квалификация','професионална квалификация','древен рИм','(ДИППК)','3',2),(209,1,'Системно програмиране',5,'1_5_1',2,'предназначено за учители, което изработва изпитни билети за държавния изпит за придобиване на','(ДИППК)','професионална квалификация','професионална квалификация','професионална квалификация','2',2),(210,1,'Системно програмиране',5,'1_5_1',1,'Сайтът предоставя три основни функции','генериране на билет','добавяне на нов въпрос към базата данни','генериране на билет','преглед на всички въпроси','2',2),(211,1,'Системно програмиране',5,'1_5_1',2,'Сайтът предоставя три основни функции','добавяне на нов въпрос към базата данни','генериране на билет','генериране на билет','преглед на всички въпроси','3',2),(212,1,'Системно програмиране',5,'1_5_1',1,' Генерирането на билет става по следния начин ',' учителите избират кой билет да генерират ','(от 1 до 18)','избират кои въпроси и варианти да прибавят към него ','когато достигнат точно 100 точки изтеглят билета','',2),(213,1,'Системно програмиране',5,'1_5_1',2,' Генерирането на билет става по следния начин ',' учителите избират кой билет да генерират ','(от 1 до 18)','избират кои въпроси и варианти да прибавят към него ','когато достигнат точно 100 точки изтеглят билета','',2),(214,1,'Системно програмиране',5,'1_5_1',1,'При добавянето на нов въпрос към системата',' учителите трябва да изберат вид на въпроса','отворен, затоврен отговор)','брой точки,',' към кой изпитен билет и коя категория принадлежи.','',2),(215,1,'Системно програмиране',5,'1_5_1',2,'При добавянето на нов въпрос към системата',' учителите трябва да изберат вид на въпроса','брой точки,','отворен, затоврен отговор)',' към кой изпитен билет и коя категория принадлежи.','',2),(216,1,'Системно програмиране',5,'1_5_1',1,'Системата се съобразява с националната изпитна програма ','(НИП)','изискванията на МОН ','за изработка на изпитен билет,',' брой задачи по равнища и брой точки на задача.','3',2),(217,1,'Системно програмиране',5,'1_5_1',2,'Системата се съобразява с националната изпитна програма ','(НИП)','изискванията на МОН ','за изработка на изпитен билет,',' брой задачи по равнища и брой точки на задача.','2',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialities`
--

LOCK TABLES `specialities` WRITE;
/*!40000 ALTER TABLE `specialities` DISABLE KEYS */;
INSERT INTO `specialities` VALUES (1,'Системно програмиране'),(2,'Приложно програмиране'),(3,'Компютърни мрежи'),(4,'Изкуствен интелект'),(5,'Фрпов2нра');
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

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `ticketid` varchar(50) NOT NULL,
  `ticketDescription` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`ticketid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES ('1_1','Изчисления, линейни, разклонени и циклични алгоритми'),('1_18',' Мрежови протоколи и технологии'),('1_2','Обработка на колекции от данни'),('1_3','Представяне на обекти от реалния свят с програмен код');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-03 13:47:10
