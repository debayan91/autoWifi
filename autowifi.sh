#!/bin/bash

curl -s -X POST "http://phc.prontonetworks.com/cgi-bin/authlogin" \
-d "userId=YOUR_ID" \
-d "password=YOUR_PASSWORD" \
-d "serviceName=ProntoAuthentication"