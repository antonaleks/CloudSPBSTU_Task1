source env.sh
curl -X PUT -H 'Content-Type: application/json' -d '{"value":"new_data"}' http://$A_IP:5000 