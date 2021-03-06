ALTER TABLE tuxiazi_feed.notice ADD COLUMN senderid BIGINT UNSIGNED NOT NULL  AFTER refoid ;
ALTER TABLE tuxiazi.photo DROP COLUMN privacy_flg ;
ALTER TABLE tuxiazi.user_photo DROP COLUMN privacy_flg ;
ALTER TABLE tuxiazi.photo_userlike ADD COLUMN createtime DATETIME NOT NULL  AFTER oid ;
ALTER TABLE tuxiazi.photo DROP COLUMN recentcmtdata;
update tuxiazi.photo_userlike set createtime=sysdate();

CREATE TABLE photolikelog (
  oid bigint(20) NOT NULL,
  userid bigint(20) NOT NULL,
  photoid bigint(20) NOT NULL,
  createtime datetime NOT NULL,
  PRIMARY KEY  (oid),
  KEY idx_0 (createtime,photoid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

delete from tuxiazi_feed.notice where senderid=0;
#end