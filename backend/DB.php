<?php
//namespace Video\dao;
namespace TTris\Dao;
use \PDO as PDO;
class DB  {
	private static $pdo = null;
	
	public static function getConnection() {
	
		if (self::$pdo==null) {
			
			try {
			
				self::$pdo = new PDO(SQL_DSN, SQL_USERNAME, SQL_PASSWORD, array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''));
                                self::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			} catch (PDOException $e) {
			
				die($e);
			}
		} 
		return self::$pdo; 
	}
	
}