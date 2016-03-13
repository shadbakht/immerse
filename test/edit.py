
import string
from collections import Counter 

text_TBE = open("Abdul-Baha in London.txt", "r")

textLine= text_TBE.readlines ()
text_TBE.close()


'--------------------get rid of empty lines-----------------------'
for i in range(len(textLine)-1,-1, -1):
	if textLine[i]== '\n':
		del textLine [i]		

subSectionNumber = 0
sectionNumber = 0
chapterNumber = 0
parNumber = 0
titleType=""
for i in range(0,3):
	line = textLine[i]
	if line.find('/*') != -1:
		if line.find('faith')!= -1:
			faith =line[9:]
		elif line.find('author')!= -1:
			author =line[10:] 
		elif line.find('title')!= -1:
			bookName =line[9:] 
tag1 = ("%s|%s|%s|"% (faith.strip('\n'), author.strip('\n'), bookName.strip('\n')))
	
	
file = open("Edited_Abdul-Baha in London.txt", "w")
for i in range(3,len(textLine)):
	line = textLine[i]
	if line.find('/*') != -1:
		if line.find('sub-sub-chapter')!= -1:
			text =line[20:]
			titleType="sub-section"
			subSectionNumber +=1
			parNumber = 0
		elif (line.find('sub-chapter')!= -1):
			text =line[15:]
			titleType="section"
			sectionNumber +=1  
			subSectionNumber = 0
			parNumber = 0

		elif (line.find('chapter')!= -1):
			text =line[11:]
			titleType="chapter"
			chapterNumber+=1
			subSectionNumber = 0
			sectionNumber = 0
			parNumber = 0
	else: 
		paragraph =line[0:10]
		text=line
		titleType="paragraph"
		parNumber+=1

	if titleType == "sub-section":
		typeNumber = subSectionNumber
	elif titleType == "section":
		typeNumber = sectionNumber
	elif titleType == "chapter":
		typeNumber = chapterNumber
	else: 
		typeNumber = parNumber
	tag = ("%d|%s|%d|%s"% (typeNumber,titleType, i, text))
	file.write("%s%s"%(tag1,tag))
	

file.close()
