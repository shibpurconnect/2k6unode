<?php

require 'Slim/Slim.php';

$app = new Slim();
$app->get('/new-events', 'listNewEvents');
$app->put('/ack-event/:id', 'acknowledgeEvent');
$app->run();

function listNewEvents() {
	$sql = "SELECT event_id, user_id, wf_id, event_msg FROM events WHERE event_status=0 ORDER BY event_id";
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

function acknowledgeEvent($id) {
	//$eid = $request->params('eid');
	$sql = "UPDATE `events` SET event_status=2 WHERE event_id=:id";
	try {
		//$dbT = getConnection();
		$dbT = getConnt();
		$stmt = $dbT->prepare($sql);  
		//$stmt->bindParam("id", $eid)
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$dbT = null;
		$response = "UPDATE `events` SET event_status=3 WHERE event_id=".$id.';';
		echo json_encode($response); 
	} catch(PDOException $e) {
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

