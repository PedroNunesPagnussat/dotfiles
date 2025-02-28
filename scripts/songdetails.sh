#!/bin/bash

song_name=$(playerctl metadata --format '{{title}}')
song_artist=$(playerctl metadata --format '{{artist}}')

echo "$song_name      $song_artist"
