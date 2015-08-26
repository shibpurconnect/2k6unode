<?php

require 'Slim/Slim.php';

$app = new Slim();
$app->get('/new-events', 'listNewEvents');
$app->post('/notifications', 'pushNotifications');
$app->run();

function listNewEvents() {
	$sql = "SELECT notice_msg FROM events WHERE event_status=0 ORDER BY event_id";
	try {
		$dbT = getConnt();
		$stmt = $dbT->query($sql);  
		$wines = $stmt->fetchAll(PDO::FETCH_OBJ);
		$dbT = null;
		echo json_encode($wines);
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function pushNotifications() {
	$request = Slim::getInstance()->request();
	$uid = $request->params('uid');
	$wfid = $request->params('wfid');
	$msg = $request->params('msg');
	$wine = json_decode($request->getBody());
	$sql = "INSERT INTO `events` (user_id, wf_id, event_msg) VALUES (:uid, :wfid, :msg)";
	try {
		$dbT = getConnt();
		$stmt = $dbT->prepare($sql); 
		$stmt->bindParam("uid", $uid);
		$stmt->bindParam("wfid", $wfid);
		$stmt->bindParam("msg", $msg);
		$stmt->execute();
		$event_id = $dbT->lastInsertId();
		$response = 'Event-'.$event_id.' has been created with workflow-'.$wfid;
		echo json_encode($response);
		$dbT = null;
	} catch(PDOException $e) {
		error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":'. $e->getMessage() .'}}';
	}

}
	
function getConnt() {
	$dbhost="mysql.hostinger.in";
	$dbuser="u833845488_2k6t";
	$dbpass="12345678912345";
	$dbname="u833845488_2k6t";
	$dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);	
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbh;
}

?>

