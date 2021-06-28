#!/usr/bin/python3.9

import sys
from html.parser import HTMLParser
import argparse

class Parser(HTMLParser):
	def __init__(self, turnDebugOn=False):
		self.debugIsOn = turnDebugOn
		HTMLParser.__init__(self)
		self.defaultSeparator = "^" # csv format, but with a character that is not used in the data
		self.dataSeparator = ","
		self.separator = self.defaultSeparator
		self.isH3 = False # see comment at start of def handle_starttag
		self.tagLevel = 0 # marker for when a data set ends
		self.dataLine = ""
	def handle_starttag(self, tag, attrs):
		# the only things we want in tags are the href link in the a tag
		# but we only want that for the h3 encapsulated link
		if tag == "h3":
			self.isH3 = True
			self.debug("isH3 set to True")
		if tag == "a":
			self.debug("parsing link tag")
			isHeaderLink = True
			linkToPrint = ""
			for name, value in attrs:
				if name == "rel" and value == "tag":
					self.debug("rel attribute found")
					self.separator = self.dataSeparator # these need to go into the same csv field, so don't separate them with commas
					isHeaderLink = False
				if name == "href":
					self.debug("href attribute found")
					linkToPrint = "https://linuxsecurity.expert" + value
			if self.isH3 and isHeaderLink: # only one of these is actually needed.  Both are kept for redundancy
				self.handle_data(linkToPrint)
		self.tagLevel += 1
	def handle_endtag(self, tag):
		self.separator = self.defaultSeparator # reset in the case of it being changed
		if(tag == "h3"):
			self.debug("isH3 set to False")
			self.isH3 = False
		self.tagLevel -= 1
		if self.tagLevel == 0: # end of a data set
			self.debug("End of data set")
			print(self.dataLine)
			self.dataLine = ""
	def handle_data(self, data):
		self.dataLine += data+self.separator
	def debug(self, toPrint, newLineAtEndOfPrint=True):
		if self.debugIsOn:
			if newLineAtEndOfPrint:
				print("debug:",toPrint)
			else:
				print("debug:",toPrint, end="")
#end of class definition

#beginning of execution
# add ability to call the program with arguments, automatically enables help
#reference: https://docs.python.org/dev/library/argparse.html
argumentParser = argparse.ArgumentParser()
argumentParser.add_argument("--debug", "-d", dest = "debugMode", action = "store_true", help="enable debug mode")
args = argumentParser.parse_args()

#print("Rank Change^Rank^Link^Name^Blurb^Main Uses^Description^Tags")
parser=Parser(args.debugMode)

# To change from cli input to argument input, use
# parser.feed(sys.argv[1])
for line in sys.stdin:
	parser.feed(line)
