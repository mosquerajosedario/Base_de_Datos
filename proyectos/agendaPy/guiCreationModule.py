import tkinter as tk
from tkinter import messagebox
from helpers import *

topLabelText = lambda x: x + 20
topNextItem = lambda x: x + 40

def addPerson(contacts, surnameEntry, nameEntry, dniEntry, ageEntry, addressEntry, phoneEntry, mailEntry):
	person = {"surname": surnameEntry.get(), "name":nameEntry.get(), "dni":int(dniEntry.get()), "age":int(ageEntry.get()), \
	  "address":addressEntry.get(), "phone":phoneEntry.get(), "mail":mailEntry.get()}
	
	contacts.append(person)
	
	surnameEntry.delete(0, 'end')
	nameEntry.delete(0, 'end')
	dniEntry.delete(0, 'end')
	ageEntry.delete(0, 'end')
	addressEntry.delete(0, 'end')
	phoneEntry.delete(0, 'end')
	mailEntry.delete(0, 'end')
	
	surnameEntry.focus_set()

def createPerson(root, contacts):
	_LEFT = 10
	_TOP = 10

	createPersonForm = tk.Toplevel(root)
	createPersonForm.geometry("430x470")
	createPersonForm.title("Alta de Persona")
	centerForm(createPersonForm)
	createPersonForm.grab_set()
	
	surnameLabel = tk.Label(createPersonForm, text = "Apellido:")
	surnameLabel.place(x = _LEFT, y = _TOP)
	_TOP = topLabelText(_TOP)
	surnameEntry = tk.Entry(createPersonForm, width = 50)
	surnameEntry.place(x = _LEFT, y = _TOP)
	
	_TOP = topNextItem(_TOP)
	
	nameLabel = tk.Label(createPersonForm, text = "Nombre:")
	nameLabel.place(x = _LEFT, y = _TOP)
	_TOP = topLabelText(_TOP)
	nameEntry = tk.Entry(createPersonForm, width = 50)
	nameEntry.place(x = _LEFT, y = _TOP)
	
	_TOP = topNextItem(_TOP)
	
	dniLabel = tk.Label(createPersonForm, text = "DNI:")
	dniLabel.place(x = _LEFT, y = _TOP)
	_TOP = topLabelText(_TOP)
	dniEntry = tk.Entry(createPersonForm, width = 25)
	dniEntry.place(x = _LEFT, y = _TOP)
	
	_TOP = topNextItem(_TOP)
	
	ageLabel = tk.Label(createPersonForm, text = "Edad:")
	ageLabel.place(x = _LEFT, y = _TOP)
	_TOP = topLabelText(_TOP)
	ageEntry = tk.Entry(createPersonForm, width = 25)
	ageEntry.place(x = _LEFT, y = _TOP)
	
	_TOP = topNextItem(_TOP)
	
	addressLabel = tk.Label(createPersonForm, text = "Dirección:")
	addressLabel.place(x = _LEFT, y = _TOP)
	_TOP = topLabelText(_TOP)
	addressEntry = tk.Entry(createPersonForm, width = 50)
	addressEntry.place(x = _LEFT, y = _TOP)
	
	_TOP = topNextItem(_TOP)
	
	phoneLabel = tk.Label(createPersonForm, text = "Teléfono:")
	phoneLabel.place(x = _LEFT, y = _TOP)
	_TOP = topLabelText(_TOP)
	phoneEntry = tk.Entry(createPersonForm, width = 25)
	phoneEntry.place(x = _LEFT, y = _TOP)
	
	_TOP = topNextItem(_TOP)
	
	mailLabel = tk.Label(createPersonForm, text = "Correo Electrónico:")
	mailLabel.place(x = _LEFT, y = _TOP)
	_TOP = topLabelText(_TOP)
	mailEntry = tk.Entry(createPersonForm, width = 50)
	mailEntry.place(x = _LEFT, y = _TOP)
	
	_TOP = topNextItem(_TOP)
	
	cancelButton = tk.Button(createPersonForm, text = "Cancelar", width = 20, command = lambda: createPersonForm.destroy())
	cancelButton.place(x = _LEFT, y = _TOP)
	
	saveButton = tk.Button(createPersonForm, text = "Guardar", width = 20, command = lambda: \
	  addPerson(contacts, surnameEntry, nameEntry, dniEntry, ageEntry, addressEntry, phoneEntry, mailEntry))
	saveButton.place(x = 200, y = _TOP)
	
	surnameEntry.focus_set()
