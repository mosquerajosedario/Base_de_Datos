from json import dump
from json import loads
from pathlib import Path

def centerForm(toplevel):
	toplevel.update_idletasks()
	
	width = toplevel.winfo_screenwidth()
	heigth = toplevel.winfo_screenheight()
	
	size = tuple(int(_) for _ in toplevel.geometry().split('+')[0].split('x'))
	
	x = width/2 - size[0]/2
	y = heigth/2 - size[1]/2
	
	toplevel.geometry("%dx%d+%d+%d" % (size + (x, y)))

def saveData(contacts):
	with open("outfile.json", "w") as fout:
		dump(contacts, fout)

def loadData():
	contacts = []

	outfile = Path("./outfile.json")
	
	if outfile.is_file():
		contacts = loads(open("outfile.json").read())
		
	return contacts
