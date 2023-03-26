-- sdcs.tab_department definition

CREATE TABLE `tab_department` (
  `id` varchar(16) NOT NULL,
  `name_th` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `createAt` datetime NOT NULL,
  `updateAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- sdcs.tab_student definition

CREATE TABLE `tab_student` (
  `id` varchar(16) NOT NULL COMMENT 'PK',
  `username` varchar(13) NOT NULL,
  `password` varchar(13) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `branchId` varchar(16) NOT NULL COMMENT 'FK',
  `email` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `createAt` datetime NOT NULL,
  `updateAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- sdcs.tab_subject definition

CREATE TABLE `tab_subject` (
  `id` varchar(16) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name_th` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `createAt` datetime NOT NULL,
  `updateAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- sdcs.tab_teacher definition

CREATE TABLE `tab_teacher` (
  `id` varchar(16) NOT NULL,
  `username` varchar(13) NOT NULL,
  `password` varchar(13) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `branchId` varchar(16) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `createAt` datetime NOT NULL,
  `updateAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teacher_FK` (`branchId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- sdcs.tab_branch definition

CREATE TABLE `tab_branch` (
  `id` varchar(16) NOT NULL,
  `departmentId` varchar(16) NOT NULL,
  `name_th` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `createAt` datetime NOT NULL,
  `updateAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tab_branch_FK` (`departmentId`),
  CONSTRAINT `tab_branch_FK` FOREIGN KEY (`departmentId`) REFERENCES `tab_department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- sdcs.tab_class definition

CREATE TABLE `tab_class` (
  `id` varchar(16) NOT NULL,
  `sjId` varchar(16) NOT NULL COMMENT 'FK table subject',
  `tcId` varchar(16) NOT NULL COMMENT 'FK table teacher',
  `date` enum('MON','TUE','WED','THU','FRI','SAT','SUN') NOT NULL,
  `timeStart` time NOT NULL,
  `timeEnd` time NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `quantity` int(2) NOT NULL DEFAULT 10,
  `createAt` datetime NOT NULL,
  `updateAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tab_class_FK` (`sjId`),
  KEY `tab_class_FK_1` (`tcId`),
  CONSTRAINT `tab_class_FK` FOREIGN KEY (`sjId`) REFERENCES `tab_subject` (`id`),
  CONSTRAINT `tab_class_FK_1` FOREIGN KEY (`tcId`) REFERENCES `tab_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- sdcs.tab_class_regis definition

CREATE TABLE `tab_class_regis` (
  `id` varchar(16) NOT NULL,
  `cId` varchar(16) NOT NULL,
  `stuId` varchar(16) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `point` decimal(10,0) NOT NULL,
  `createAt` datetime NOT NULL,
  `updateAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tab_class_regis_FK` (`cId`),
  KEY `tab_class_regis_FK_1` (`stuId`),
  CONSTRAINT `tab_class_regis_FK` FOREIGN KEY (`cId`) REFERENCES `tab_class` (`id`),
  CONSTRAINT `tab_class_regis_FK_1` FOREIGN KEY (`stuId`) REFERENCES `tab_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- sdcs.tab_class_check definition

CREATE TABLE `tab_class_check` (
  `id` varchar(16) NOT NULL,
  `crId` varchar(16) NOT NULL,
  `checkTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tab_class_check_FK` (`crId`),
  CONSTRAINT `tab_class_check_FK` FOREIGN KEY (`crId`) REFERENCES `tab_class_regis` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;