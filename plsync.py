#!/usr/bin/env python
import argparse

parser = argparse.ArgumentParser(description='Copy playlist to folder')
parser.add_argument('-s', dest='sourcedir', help="Set the source directory of the playlist", default="/")
parser.add_argument('-p', dest='playlist', help='Set the playlist file, must be in m3u format')
parser.add_argument('-d', dest='destination', help='Set the destination directory')

args = parser.parse_args()
print(args.sourcedir)
print(args.playlist)
print(args.destination)
