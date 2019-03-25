CREATE TABLE `score` (
  `id` int(11) NOT NULL,
  `score` smallint(6) NOT NULL,
  `name` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `env` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
