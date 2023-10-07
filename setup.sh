#!/usr/bin/env bash

# Download, extract
fetchUrl() {
dir="$1"
url="$2"
full="${url##*/}"
file="${full%%.*}"
dest="$dir/$file.mtx"
if [ ! -f "$dest" ]; then
  echo "Fetching $url ..."
  wget "$url"
  tar -xzf "$full"
  cp -r "$file"/* "$dir"/
  rm -rf "$file"
  rm -rf "$full"
fi
}

# Fetch from SuiteSparse Matrix collection
fetch() {
fetchUrl "$1" "https://suitesparse-collection-website.herokuapp.com/MM/$2.tar.gz"
}


# Create directories
gra="$HOME/Graphs"
dat="$HOME/Data"
log="$HOME/Logs"
mkdir -p "$gra"
mkdir -p "$dat"
mkdir -p "$log"


# Download graphs
if [ !  -d "$gra/GAP" ]; then
  mkdir -p "$gra/GAP"
fi
if [ !  -d "$gra/LAW" ]; then
  mkdir -p "$gra/LAW"
  fetch "$gra/LAW" LAW/it-2004
  fetch "$gra/LAW" LAW/sk-2005
fi
if [ !  -d "$gra/SNAP" ]; then
  mkdir -p "$gra/SNAP"
  fetch "$gra/SNAP" SNAP/com-LiveJournal
  fetch "$gra/SNAP" SNAP/com-Orkut
fi
if [ !  -d "$gra/DIMACS10" ]; then
  mkdir -p "$gra/DIMACS10"
  fetch "$gra/DIMACS10" DIMACS10/asia_osm
  fetch "$gra/DIMACS10" DIMACS10/europe_osm
fi
if [ !  -d "$gra/GenBank" ]; then
  mkdir -p "$gra/GenBank"
  fetch $gra/GenBank GenBank/kmer_V1r
  fetch $gra/GenBank GenBank/kmer_A2a
fi


# Link in Data/ directory
ln -s -f "$gra/GAP"/*      "$dat"/
ln -s -f "$gra/LAW"/*      "$dat"/
ln -s -f "$gra/SNAP"/*     "$dat"/
ln -s -f "$gra/DIMACS10"/* "$dat"/
ln -s -f "$gra/GenBank"/*  "$dat"/
