php receive_events.php | mysql -u 2k6 --password=2k6 2k6
echo 'SELECT event_id FROM `events` WHERE event_status=1;' | mysql -u 2k6 --password=2k6 2k6
curl -X PUT http://2k6.esy.es/dbsync/send.php/ack-event/:eid