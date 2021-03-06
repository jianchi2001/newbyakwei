create database if not exists test0;
create database if not exists test1;

DROP TABLE IF EXISTS test0.member;
CREATE TABLE  test0.member (
  userid bigint(20) unsigned NOT NULL auto_increment,
  nick varchar(45) NOT NULL,
  groupid bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (userid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS test0.member0;
CREATE TABLE  test0.member0 (
  memberuserid bigint(20) unsigned NOT NULL auto_increment,
  nick varchar(45) NOT NULL,
  groupid bigint(20) unsigned NOT NULL,
  PRIMARY KEY  USING BTREE (memberuserid)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS test0.testuser0;
CREATE TABLE  test0.testuser0 (
  userid bigint(20) unsigned NOT NULL auto_increment,
  nick varchar(45) NOT NULL,
  createtime datetime NOT NULL,
  money double NOT NULL,
  purchase double NOT NULL,
  gender tinyint(1) unsigned NOT NULL,
  PRIMARY KEY  (userid)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS test1.member1;
CREATE TABLE  test1.member1 (
  memberuserid bigint(20) unsigned NOT NULL auto_increment,
  nick varchar(45) NOT NULL,
  groupid bigint(20) unsigned NOT NULL,
  PRIMARY KEY  USING BTREE (memberuserid)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS test1.testuser1;
CREATE TABLE  test1.testuser1 (
  userid bigint(20) unsigned NOT NULL auto_increment,
  nick varchar(45) NOT NULL,
  createtime datetime NOT NULL,
  money double NOT NULL,
  purchase double NOT NULL,
  gender tinyint(1) unsigned NOT NULL,
  PRIMARY KEY  (userid)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


drop table if exists test0.user;
CREATE TABLE test0.user (
  userid bigint(20) unsigned NOT NULL auto_increment ,
  nick varchar(45) NOT NULL ,
  addr varchar(300) NOT NULL ,
  intro varchar(300) NOT NULL ,
  sex integer unsigned NOT NULL ,
  createtime datetime NOT NULL ,
  PRIMARY KEY(userid)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS test0.user;
CREATE TABLE  test0.user (
  userid bigint(20) unsigned NOT NULL auto_increment,
  nick varchar(45) NOT NULL,
  sex int(10) unsigned NOT NULL,
  addr varchar(300) NOT NULL,
  intro varchar(300) NOT NULL,
  createtime datetime NOT NULL,
  PRIMARY KEY  (userid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;