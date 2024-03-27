#!/bin/bash
curl -s http://api.openweathermap.org/data/2.5/weather\?q\=$1\&appid\=$2\&units=metric
